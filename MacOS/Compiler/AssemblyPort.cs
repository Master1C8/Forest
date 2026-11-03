using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Text.Json;
// Reuses the shared compiler's complete semantic-tree implementation.
static partial class Program {
    static void Main(string[] args) {
        Need(args.Length>=4,"compare original-windows original-macos receipt | port original-windows original-macos target output receipt");
        using var windows=ModuleDefinition.ReadModule(args[1]);
        using var mac=ModuleDefinition.ReadModule(args[2]);
        windows.Mvid=mac.Mvid;
        var w=Tree(windows);var nativeTree=Tree(mac);
        var keys=w.Keys.Union(nativeTree.Keys).OrderBy(x=>x).ToArray();
        var differences=keys.Where(k=>!w.TryGetValue(k,out var a)||!nativeTree.TryGetValue(k,out var b)||a!=b).ToArray();
        if(args[0]=="compare") {
            Save(args[3],new {originalWindowsSha256=HashFile(args[1]),originalMacSha256=HashFile(args[2]),ignoredDifference="module MVID only",differences});
            Console.WriteLine(JsonSerializer.Serialize(new {differenceCount=differences.Length,first=differences.Take(25)}));return;
        }
        if(args[0]=="delta") {
            using var baseline=ModuleDefinition.ReadModule(args[3]);baseline.Mvid=mac.Mvid;
            var b=Tree(baseline);var changed=w.Keys.Union(b.Keys).Where(k=>!w.TryGetValue(k,out var x)||!b.TryGetValue(k,out var y)||x!=y).OrderBy(k=>k).ToArray();
            var overlap=changed.Intersect(differences).ToArray();
            Save(args[4],new {changed,overlap});
            Console.WriteLine(JsonSerializer.Serialize(new {changedCount=changed.Length,overlap}));return;
        }
        Need(args[0]=="port"&&args.Length==6,"unknown assembly port command");
        using var target=ModuleDefinition.ReadModule(args[3]);target.Mvid=mac.Mvid;
        var targetTree=Tree(target);var originalMac=Tree(mac);
        var delta=w.Keys.Union(targetTree.Keys).Where(k=>k!="refs"&&(!w.TryGetValue(k,out var a)||!targetTree.TryGetValue(k,out var b)||a!=b)).ToArray();
        Need(delta.All(k=>k.StartsWith("body:")||k.StartsWith("method:")||k.StartsWith("field:")),"unsupported-managed-delta-kind");
        var types=Types(mac.Types).ToDictionary(t=>t.FullName);var fields=types.Values.SelectMany(t=>t.Fields).ToDictionary(f=>f.FullName);var methods=Methods(mac);
        var originalMethods=Methods(windows);var targetMethods=Methods(target);
        TypeReference T(TypeReference t) {
            if(types.TryGetValue(t.FullName,out var local))return local;
            if(t is GenericInstanceType g) {var n=new GenericInstanceType(T(g.ElementType));foreach(var argument in g.GenericArguments)n.GenericArguments.Add(T(argument));return n;}
            if(t is ArrayType array)return new ArrayType(T(array.ElementType),array.Rank);
            if(t is ByReferenceType b)return new ByReferenceType(T(b.ElementType));
            return mac.ImportReference(t);
        }
        foreach(var reference in target.AssemblyReferences.Where(r=>!windows.AssemblyReferences.Any(w=>w.FullName==r.FullName)))
            if(!mac.AssemblyReferences.Any(r=>r.FullName==reference.FullName))mac.AssemblyReferences.Add(AssemblyNameReference.Parse(reference.FullName));
        foreach(var field in Types(target.Types).SelectMany(t=>t.Fields).Where(f=>delta.Contains("field:"+f.FullName))) {
            Need(!fields.ContainsKey(field.FullName)&&!field.HasCustomAttributes&&!field.HasConstant&&!field.HasMarshalInfo,"only-new-simple-fields");
            var clone=new FieldDefinition(field.Name,field.Attributes,T(field.FieldType));types[field.DeclaringType.FullName].Fields.Add(clone);fields.Add(field.FullName,clone);
        }
        foreach(var method in targetMethods.Values.Where(m=>delta.Contains("method:"+m.FullName))) {
            Need(!methods.ContainsKey(method.FullName)&&!method.HasGenericParameters&&!method.HasCustomAttributes&&!method.HasPInvokeInfo,"only-new-simple-method-definitions");
            var clone=new MethodDefinition(method.Name,method.Attributes,T(method.ReturnType)){ImplAttributes=method.ImplAttributes,CallingConvention=method.CallingConvention,SemanticsAttributes=method.SemanticsAttributes};
            foreach(var p in method.Parameters){Need(!p.HasCustomAttributes&&!p.HasConstant&&!p.HasMarshalInfo,"simple-new-parameters");clone.Parameters.Add(new ParameterDefinition(p.Name,p.Attributes,T(p.ParameterType)));}
            types[method.DeclaringType.FullName].Methods.Add(clone);methods.Add(method.FullName,clone);
        }
        MethodReference M(MethodReference r) {
            if(methods.TryGetValue(r.FullName,out var own))return own;
            if(r is GenericInstanceMethod g){var n=new GenericInstanceMethod(M(g.ElementMethod));foreach(var a in g.GenericArguments)n.GenericArguments.Add(T(a));return n;}
            var copy=mac.ImportReference(r);copy.DeclaringType=T(copy.DeclaringType);copy.ReturnType=T(copy.ReturnType);foreach(var p in copy.Parameters)p.ParameterType=T(p.ParameterType);return copy;
        }
        FieldReference F(FieldReference r) {
            if(fields.TryGetValue(r.FullName,out var own))return own;
            var copy=mac.ImportReference(r);copy.DeclaringType=T(copy.DeclaringType);copy.FieldType=T(copy.FieldType);return copy;
        }
        var mergedPlatformMethods=new List<string>();
        foreach(var key in delta.Where(k=>k.StartsWith("body:"))) {
            string name=key[5..];var src=targetMethods[name];var dest=methods[name];
            if(differences.Contains(key)) {
                // A new translation may touch a string in an OS-specific method.
                // Merge exact literal changes only; retain every native opcode.
                var before=originalMethods[name];Need(before.Body.Instructions.Count==src.Body.Instructions.Count,"platform-overlap-instruction-count");
                var changes=new List<(int Index,string Before,string After)>();
                for(int i=0;i<src.Body.Instructions.Count;++i){var a=before.Body.Instructions[i];var b=src.Body.Instructions[i];
                    if(a.OpCode==OpCodes.Ldstr&&b.OpCode==OpCodes.Ldstr&&(string)a.Operand!=(string)b.Operand)changes.Add((i,(string)a.Operand,(string)b.Operand));
                }
                Need(changes.Count>0,"platform-overlap-without-literal-delta");
                foreach(var c in changes)src.Body.Instructions[c.Index].Operand=c.Before;
                Need(Body(before)==Body(src),"nonliteral-platform-overlap");
                foreach(var c in changes){src.Body.Instructions[c.Index].Operand=c.After;var i=dest.Body.Instructions[c.Index];Need(i.OpCode==OpCodes.Ldstr&&(string)i.Operand==c.Before,"exact-mac-platform-literal-selector");i.Operand=c.After;}
                mergedPlatformMethods.Add(name);continue;
            }
            Need(!originalMethods.ContainsKey(name)||Body(originalMethods[name])==Body(dest),"native-method-before-image");
            var body=new Mono.Cecil.Cil.MethodBody(dest){InitLocals=src.Body.InitLocals,MaxStackSize=src.Body.MaxStackSize};dest.Body=body;
            foreach(var v in src.Body.Variables)body.Variables.Add(new VariableDefinition(T(v.VariableType)));
            var map=src.Body.Instructions.ToDictionary(i=>i,i=>Instruction.Create(OpCodes.Nop));
            foreach(var i in src.Body.Instructions){var n=map[i];n.OpCode=i.OpCode;n.Offset=i.Offset;body.Instructions.Add(n);}
            object? Operand(object? o)=>o switch {
                Instruction i=>map[i],Instruction[] list=>list.Select(i=>map[i]).ToArray(),VariableDefinition v=>body.Variables[v.Index],
                ParameterDefinition p=>p.Index<0?body.ThisParameter:dest.Parameters[p.Index],MethodReference m=>M(m),FieldReference f=>F(f),TypeReference t=>T(t),
                CallSite=>throw new InvalidOperationException("unsupported-callsite"),_=>o};
            foreach(var i in src.Body.Instructions)map[i].Operand=Operand(i.Operand);
            Instruction? I(Instruction? i)=>i==null?null:map[i];
            foreach(var h in src.Body.ExceptionHandlers)body.ExceptionHandlers.Add(new ExceptionHandler(h.HandlerType){CatchType=h.CatchType==null?null:T(h.CatchType),TryStart=I(h.TryStart),TryEnd=I(h.TryEnd),HandlerStart=I(h.HandlerStart),HandlerEnd=I(h.HandlerEnd),FilterStart=I(h.FilterStart)});
        }
        // Do not retain accidental self-assembly references from Cecil imports.
        foreach(var reference in mac.AssemblyReferences.Where(r=>r.Name==mac.Assembly.Name.Name).ToArray())mac.AssemblyReferences.Remove(reference);
        var expected=Tree(mac);
        foreach(var k in expected.Keys.Union(originalMac.Keys).Where(k=>k!="refs"&&!delta.Contains(k)))
            Need(originalMac.TryGetValue(k,out var a)&&expected.TryGetValue(k,out var b)&&a==b,"unselected-native-tree-changed:"+k);
        foreach(var k in delta.Where(k=>!mergedPlatformMethods.Any(m=>k=="body:"+m)))Need(expected[k]==targetTree[k],"selected-native-delta-mismatch:"+k);
        byte[] data=Serialize(mac);
        using var saved=ModuleDefinition.ReadModule(new MemoryStream(data));
        Need(Equal(expected,Tree(saved)),"complete-native-managed-tree-readback");
        File.WriteAllBytes(args[4],data);
        Save(args[5],new {passed=true,originalMacSha256=HashFile(args[2]),windowsTargetSha256=HashFile(args[3]),outputSha256=Hash(data),macMvidPreserved=true,completeSemanticTreeReadback=true,platformSpecificOriginalEntries=differences.Length,selectedDeltaEntries=delta.Length,mergedPlatformMethods});
    }
}
