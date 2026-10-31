using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Reflection;
using System.Globalization;
using MA = Mono.Cecil.MethodAttributes;
using FA = Mono.Cecil.FieldAttributes;
using TA = Mono.Cecil.TypeAttributes;

static class Program {
    const string Original = "46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf";
    static string Candidate = "";
    static string MapHash = "";
    static string Locale = "";
    static string Culture = "";
    const string HandlerType = "TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates";
    const string Context = "oliver_coyotes_date2_haiku_finish";
    static string Prefix = "";
    static readonly int[] Loads = [0x274,0x28a,0x2a0,0x2c6,0x2dc,0x2f2,0x315,0x32b,0x341];
    static readonly string[] Words = ["molded","raging","friends","lovely","high","gone","bug","important","work"];
    static readonly JsonSerializerOptions Json = new() { WriteIndented=true };
    static string Hash(byte[] b) => Convert.ToHexString(SHA256.HashData(b)).ToLowerInvariant();
    static string HashFile(string p) => Hash(File.ReadAllBytes(p));
    static void Need(bool b, string s) { if (!b) throw new InvalidOperationException(s); }
    static void Save(string p, object o) => File.WriteAllText(p, JsonSerializer.Serialize(o,Json)+"\n");
    static IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> ts) { foreach (var t in ts) { yield return t; foreach(var n in Types(t.NestedTypes)) yield return n; } }
    static Dictionary<string,MethodDefinition> Methods(ModuleDefinition m) => Types(m.Types).SelectMany(t=>t.Methods).ToDictionary(t=>t.FullName);
    static TypeDefinition Handler(ModuleDefinition m) => m.Types.Single(t=>t.FullName==HandlerType);
    static MethodDefinition Execute(ModuleDefinition m) => Handler(m).Methods.Single(t=>t.Name=="ExecuteTrigger");
    static Instruction At(MethodDefinition m,int off) => m.Body.Instructions.Single(i=>i.Offset==off);
    static string Attrs(Mono.Cecil.ICustomAttributeProvider p) => string.Join(";", p.CustomAttributes.Select(a=>a.Constructor.FullName+":"+Convert.ToHexString(a.GetBlob())));
    static string Generic(IGenericParameterProvider p) => string.Join(";",p.GenericParameters.Select(g=>g.Name+":"+g.Attributes+":"+Attrs(g)+":"+string.Join(",",g.Constraints.Select(c=>c.ConstraintType.FullName+":"+Attrs(c)))));
    static string Constant(object? x) => x==null?"null":x.GetType().FullName+":"+(x is IFormattable f?f.ToString(null,CultureInfo.InvariantCulture):JsonSerializer.Serialize(x));
    static string Def(MethodDefinition m) => string.Join("|",m.FullName,m.Attributes,m.ImplAttributes,m.CallingConvention,m.SemanticsAttributes,Generic(m),Attrs(m),
        string.Join(";",m.Parameters.Select(p=>p.Name+":"+p.Attributes+":"+p.ParameterType.FullName+":"+Constant(p.HasConstant?p.Constant:null)+":"+Attrs(p))),
        m.MethodReturnType.Attributes+":"+Attrs(m.MethodReturnType),string.Join(";",m.Overrides.Select(o=>o.FullName)),m.HasPInvokeInfo?m.PInvokeInfo.Attributes+":"+m.PInvokeInfo.Module.Name+":"+m.PInvokeInfo.EntryPoint:"");
    static string Body(MethodDefinition m) {
        if (!m.HasBody) return "<none>";
        var ins=m.Body.Instructions;
        string Id(Instruction? i)=>i==null?"end":"@"+ins.IndexOf(i);
        string Op(object? o)=>o switch {
            null=>"",string s=>"str:"+JsonSerializer.Serialize(s),Instruction i=>Id(i),Instruction[] a=>string.Join(",",a.Select(Id)),
            VariableDefinition v=>"local:"+v.Index+":"+v.VariableType.FullName,ParameterDefinition p=>"param:"+p.Index+":"+p.ParameterType.FullName,
            MethodReference r=>"method:"+r.FullName,FieldReference r=>"field:"+r.FullName,TypeReference r=>"type:"+r.FullName,
            IFormattable f=>f.ToString(null,CultureInfo.InvariantCulture)??"",_=>o.ToString()??""};
        return m.Body.InitLocals+"|"+m.Body.MaxStackSize+"|"+string.Join(",",m.Body.Variables.Select(v=>v.VariableType.FullName))+"\n"+
            string.Join("\n",ins.Select(i=>i.Offset.ToString("x4")+":"+i.OpCode+" "+Op(i.Operand)))+"\n"+
            string.Join(";",m.Body.ExceptionHandlers.Select(h=>h.HandlerType+":"+h.CatchType+":"+Id(h.TryStart)+":"+Id(h.TryEnd)+":"+Id(h.HandlerStart)+":"+Id(h.HandlerEnd)+":"+Id(h.FilterStart)));
    }
    static SortedDictionary<string,string> Tree(ModuleDefinition m) {
        var d=new SortedDictionary<string,string>();
        d["module"]=m.Name+"|"+m.Kind+"|"+m.RuntimeVersion+"|"+m.Architecture+"|"+m.Attributes+"|"+m.Characteristics+"|"+m.Mvid+"|"+Attrs(m);
        d["assembly"]=m.Assembly.Name.FullName+"|"+Attrs(m.Assembly)+"|"+string.Join(";",m.Assembly.SecurityDeclarations.Select(s=>s.Action+":"+Convert.ToHexString(s.GetBlob())));
        d["refs"]=string.Join(";",m.AssemblyReferences.Select(r=>r.FullName+":"+r.Attributes+":"+Convert.ToHexString(r.Hash??[])))+"|"+string.Join(";",m.ModuleReferences.Select(r=>r.Name));
        d["resources"]=string.Join(";",m.Resources.Select(r=>r.Name+":"+r.Attributes+":"+(r is EmbeddedResource e?Hash(e.GetResourceData()):r is LinkedResource l?l.File+":"+Convert.ToHexString(l.Hash):((AssemblyLinkedResource)r).Assembly.FullName)));
        foreach(var t in Types(m.Types)) {
            d["type:"+t.FullName]=t.Attributes+"|"+t.BaseType?.FullName+"|"+t.PackingSize+"|"+t.ClassSize+"|"+Generic(t)+"|"+Attrs(t)+"|"+string.Join(";",t.Interfaces.Select(i=>i.InterfaceType.FullName+":"+Attrs(i)));
            foreach(var f in t.Fields) d["field:"+f.FullName]=f.Attributes+"|"+f.Offset+"|"+Constant(f.HasConstant?f.Constant:null)+"|"+Hash(f.InitialValue??[])+"|"+Attrs(f);
            foreach(var p in t.Properties) d["property:"+p.FullName]=p.Attributes+"|"+p.GetMethod?.FullName+"|"+p.SetMethod?.FullName+"|"+string.Join(";",p.OtherMethods.Select(x=>x.FullName))+"|"+Attrs(p);
            foreach(var e in t.Events) d["event:"+e.FullName]=e.Attributes+"|"+e.AddMethod?.FullName+"|"+e.RemoveMethod?.FullName+"|"+e.InvokeMethod?.FullName+"|"+Attrs(e);
            foreach(var f in t.Methods) {d["method:"+f.FullName]=Def(f);d["body:"+f.FullName]=Body(f);}
        }
        return d;
    }
    static bool Equal(SortedDictionary<string,string> a,SortedDictionary<string,string> b) => a.Count==b.Count && a.All(p=>b.TryGetValue(p.Key,out var s)&&s==p.Value);
    static byte[] Serialize(ModuleDefinition m) { using var s=new MemoryStream();m.Write(s);return s.ToArray(); }
    static JsonElement Map(string p) {
        Need(HashFile(p)==MapHash,"accepted-map-hash");var j=JsonDocument.Parse(File.ReadAllBytes(p)).RootElement.Clone();
        Need(j.GetProperty("locale").GetString()==Locale && j.GetProperty("context").GetString()==Context,"accepted-map-locale-context");return j;
    }
    static void Guard(ModuleDefinition m,ModuleDefinition original) {
        Need(!Handler(m).Methods.Any(x=>x.Name.StartsWith(Prefix)) && !Execute(m).Body.Instructions.Any(i=>i.Operand is MethodReference r&&r.Name.StartsWith(Prefix)),"patch-state-not-pristine");
        Need(Body(Execute(m))==Body(Execute(original)) && Def(Execute(m))==Def(Execute(original)),"whole-handler-source-contract");
        var e=Execute(m);
        for(int k=0;k<9;k++) {
            var i=At(e,Loads[k]); Need(i.OpCode==OpCodes.Ldsfld && ((FieldReference)i.Operand).Name=="haikuLine"+(k%3+1),"named-line-load");
            Need(i.Next.OpCode==OpCodes.Callvirt && ((MethodReference)i.Next.Operand).FullName=="System.String System.String::ToLower()","current-culture-case-boundary");
            Need(i.Next.Next.OpCode==OpCodes.Ldstr && (string)i.Next.Next.Operand==Words[k],"protected-nine-comparisons");
        }
    }
    static MethodReference StringEqual(ModuleDefinition m) => (MethodReference)Execute(m).Body.Instructions.First(i=>i.Operand is MethodReference r&&r.FullName=="System.Boolean System.String::op_Equality(System.String,System.String)").Operand;
    static void AddHelpers(ModuleDefinition m,JsonElement map) {
        var t=Handler(m);var eq=StringEqual(m);
        var resolve=new MethodDefinition(Prefix+"Resolve",MA.Private|MA.Static|MA.HideBySig,m.TypeSystem.String);
        resolve.Parameters.Add(new ParameterDefinition("display",Mono.Cecil.ParameterAttributes.None,m.TypeSystem.String));
        resolve.Parameters.Add(new ParameterDefinition("slot",Mono.Cecil.ParameterAttributes.None,m.TypeSystem.Int32));
        resolve.Parameters.Add(new ParameterDefinition("context",Mono.Cecil.ParameterAttributes.None,m.TypeSystem.String));t.Methods.Add(resolve);
        var exceptionType=new TypeReference("System","InvalidOperationException",m,m.TypeSystem.CoreLibrary);
        var ctor=new MethodReference(".ctor",m.TypeSystem.Void,exceptionType){HasThis=true};ctor.Parameters.Add(new ParameterDefinition(m.TypeSystem.String));
        var il=resolve.Body.GetILProcessor();var valid=Instruction.Create(OpCodes.Nop);
        il.Emit(OpCodes.Ldarg_2);il.Emit(OpCodes.Ldstr,Context);il.Emit(OpCodes.Call,eq);il.Emit(OpCodes.Brtrue,valid);
        il.Emit(OpCodes.Ldstr,"haiku-identity:wrong-context");il.Emit(OpCodes.Newobj,ctor);il.Emit(OpCodes.Throw);il.Append(valid);
        foreach(var row in map.GetProperty("choices").EnumerateArray()) {
            var next=Instruction.Create(OpCodes.Nop);
            il.Emit(OpCodes.Ldarg_1);il.Emit(OpCodes.Ldc_I4,row.GetProperty("slot").GetInt32());il.Emit(OpCodes.Bne_Un,next);
            il.Emit(OpCodes.Ldarg_0);il.Emit(OpCodes.Ldstr,row.GetProperty("target").GetString()!);il.Emit(OpCodes.Call,eq);il.Emit(OpCodes.Brfalse,next);
            il.Emit(OpCodes.Ldstr,row.GetProperty("source").GetString()!);il.Emit(OpCodes.Ret);il.Append(next);
        }
        il.Emit(OpCodes.Ldstr,"haiku-identity:unknown-label-or-slot");il.Emit(OpCodes.Newobj,ctor);il.Emit(OpCodes.Throw);
        for(int slot=1;slot<=3;slot++) {
            var getter=new MethodDefinition(Prefix+"Line"+slot,MA.Private|MA.Static|MA.HideBySig,m.TypeSystem.String);t.Methods.Add(getter);
            var g=getter.Body.GetILProcessor();
            // The first evaluation read validates all three fields, including short-circuited slots.
            // Producer storage/display is never overwritten. Context is pinned to the sole call boundary.
            foreach(int s in slot==1?new[]{1,2,3}:new[]{slot}) {
                g.Emit(OpCodes.Ldsfld,t.Fields.Single(f=>f.Name=="haikuLine"+s));g.Emit(OpCodes.Ldc_I4,s);g.Emit(OpCodes.Ldstr,Context);g.Emit(OpCodes.Call,resolve);
                if(slot==1)g.Emit(OpCodes.Pop);
            }
            if(slot==1) {g.Emit(OpCodes.Ldsfld,t.Fields.Single(f=>f.Name=="haikuLine1"));g.Emit(OpCodes.Ldc_I4,1);g.Emit(OpCodes.Ldstr,Context);g.Emit(OpCodes.Call,resolve);}
            g.Emit(OpCodes.Ret);
        }
    }
    static object Patch(string input,string mapping,string output,string receipt) {
        var map=Map(mapping);var hash=HashFile(input);
        Need(!File.Exists(output)&&!File.Exists(receipt)&&!File.Exists(output+".before.dll")&&
             !File.Exists(output+".reversed.dll")&&!File.Exists(output+".methods.jsonl"),"new-output-required");
        string originalPath=Path.Combine(AppContext.BaseDirectory,"original/Assembly-CSharp.dll");
        Need(HashFile(originalPath)==Original,"frozen-original-dependency-hash");
        using var original=ModuleDefinition.ReadModule(originalPath);using var m=ModuleDefinition.ReadModule(input);
        Guard(m,original);Need(hash==Candidate,"supported-input-assembly-hash");
        var before=Tree(m);var count=Methods(m).Count;var e=Execute(m);var full=e.FullName;
        var saved=Loads.Select(off=>(off,At(e,off).OpCode,At(e,off).Operand)).ToArray();
        AddHelpers(m,map);
        for(int k=0;k<9;k++){var i=At(e,Loads[k]);i.OpCode=OpCodes.Call;i.Operand=Handler(m).Methods.Single(x=>x.Name==Prefix+"Line"+(k%3+1));}
        byte[] bytes=Serialize(m);using var rb=ModuleDefinition.ReadModule(new MemoryStream(bytes));
        // Cecil recomputes MaxStack only for new methods. Compare the fully staged readback for all original methods.
        var after=Tree(rb);var added=Methods(rb).Keys.Except(Methods(original).Keys).Where(n=>n.Contains(Prefix)).ToArray();
        Need(added.Length==4&&Methods(rb).Count==count+4,"exact-four-private-helpers");
        var changed=before.Keys.Where(k=>!after.TryGetValue(k,out var v)||v!=before[k]).ToArray();
        Need(changed.SequenceEqual(new[]{"body:"+full}),"exact-one-existing-method-changed:"+string.Join(",",changed));
        foreach(var k in before.Keys.Where(k=>k!="body:"+full))Need(after[k]==before[k],"whole-existing-assembly-preserved:"+k);
        for(int k=0;k<9;k++) {
            var i=At(Execute(rb),Loads[k]);Need(i.OpCode==OpCodes.Call&&((MethodReference)i.Operand).Name==Prefix+"Line"+(k%3+1),"evaluation-load-readback");
            Need((string)i.Next.Next.Operand==Words[k],"protected-comparison-readback");
        }
        // Reverse actual saved readback, not the pre-write in-memory module.
        foreach(var s in saved){var i=At(Execute(rb),s.off);i.OpCode=s.OpCode;i.Operand=Handler(rb).Fields.Single(f=>f.FullName==((FieldReference)s.Operand).FullName);}
        foreach(var helper in Handler(rb).Methods.Where(x=>x.Name.StartsWith(Prefix)).ToArray())Handler(rb).Methods.Remove(helper);
        var reversed=Serialize(rb);using var reverseRead=ModuleDefinition.ReadModule(new MemoryStream(reversed));
        Need(Equal(before,Tree(reverseRead)),"whole-assembly-structural-reversal");
        // A saved original is the exact-byte rollback boundary; reserialization may reorder metadata/heaps.
        var prior=File.ReadAllBytes(input);Need(Hash(prior)==hash,"input-unchanged-before-write");
        File.WriteAllBytes(output+".before.dll",prior);File.WriteAllBytes(output,bytes);File.WriteAllBytes(output+".reversed.dll",reversed);
        Need(HashFile(output+".before.dll")==hash&&HashFile(input)==hash,"exact-prior-payload-preservation");
        File.WriteAllLines(output+".methods.jsonl",Methods(m).Values.Where(x=>!x.Name.StartsWith(Prefix)).Select(x=>JsonSerializer.Serialize(new {
            method=x.FullName,definitionBefore=Hash(Encoding.UTF8.GetBytes(before["method:"+x.FullName])),definitionAfter=Hash(Encoding.UTF8.GetBytes(after["method:"+x.FullName])),
            bodyBefore=Hash(Encoding.UTF8.GetBytes(before["body:"+x.FullName])),bodyAfter=Hash(Encoding.UTF8.GetBytes(after["body:"+x.FullName])),changed=before["body:"+x.FullName]!=after["body:"+x.FullName]})));
        var result=new {inputSha256=hash,outputSha256=Hash(bytes),mappingSha256=MapHash,existingMethods=count,modifiedExistingMethods=1,addedPrivateMethods=4,
            totalMethods=count+4,modifiedMethod=full,changedInstructionOffsets=Loads,existingMethodDefinitionsPreserved=true,wholeAssemblyReadback=true,structuralReversal=true,
            normalizedReversalSha256=Hash(reversed),reversalByteIdentical=Hash(reversed)==hash,exactByteRollbackFile=Path.GetFileName(output)+".before.dll",exactRollbackSha256=hash,
            existingMethodsReadbackFile=Path.GetFileName(output)+".methods.jsonl",existingMethodsReadbackSha256=HashFile(output+".methods.jsonl"),
            structuralBeforeSha256=Hash(Encoding.UTF8.GetBytes(JsonSerializer.Serialize(before))),structuralAfterSha256=Hash(Encoding.UTF8.GetBytes(JsonSerializer.Serialize(after))),
            serializedReversalFile=Path.GetFileName(output)+".reversed.dll",serializedReversalFileSha256=HashFile(output+".reversed.dll"),
            protectedComparisonOperands=Words,originalBranchOffsetsAndTargetsPreserved=true,originalFieldsLocalsHandlersPreserved=true,
            runtime="not-run",sourceGateAccepted=false,ordinaryTranslationEntryAllowed=false,wholeGameAccepted=false,
            writeBoundary="All validation precedes writes. before.dll, output.dll, receipt are separate writes, not one transaction. Existing files reject; failed partial output must be reconciled."};
        Save(receipt,result);return result;
    }
    static ModuleDefinition Fixture(ModuleDefinition source,string name) {
        var m=ModuleDefinition.CreateModule(name,ModuleKind.Dll);var t=new TypeDefinition("", "HaikuFixture",TA.Public|TA.Abstract|TA.Sealed,m.TypeSystem.Object);m.Types.Add(t);
        for(int s=1;s<=3;s++)t.Fields.Add(new FieldDefinition("haikuLine"+s,FA.Public|FA.Static,m.TypeSystem.String));
        var methods=new Dictionary<string,MethodDefinition>();
        foreach(var src in Handler(source).Methods.Where(x=>x.Name.StartsWith(Prefix))) {
            var dest=new MethodDefinition(src.Name,MA.Public|MA.Static,m.TypeSystem.String);
            foreach(var p in src.Parameters)dest.Parameters.Add(new ParameterDefinition(p.Name,p.Attributes,m.ImportReference(p.ParameterType)));
            t.Methods.Add(dest);methods[src.Name]=dest;
        }
        object? Operand(object? o,Dictionary<Instruction,Instruction> imap,MethodDefinition dest) => o switch {
            Instruction i=>imap[i],Instruction[] a=>a.Select(i=>imap[i]).ToArray(),
            FieldReference f when f.DeclaringType.FullName==HandlerType=>t.Fields.Single(x=>x.Name==f.Name),
            MethodReference r when r.DeclaringType.FullName==HandlerType&&r.Name.StartsWith(Prefix)=>methods[r.Name],
            MethodReference r=>m.ImportReference(r),TypeReference r=>m.ImportReference(r),
            ParameterDefinition p=>dest.Parameters[p.Index],_=>o};
        foreach(var src in Handler(source).Methods.Where(x=>x.Name.StartsWith(Prefix))) {
            var dest=methods[src.Name];var imap=src.Body.Instructions.ToDictionary(i=>i,i=>Instruction.Create(OpCodes.Nop));
            foreach(var i in src.Body.Instructions){var j=imap[i];j.OpCode=i.OpCode;j.Operand=Operand(i.Operand,imap,dest);dest.Body.Instructions.Add(j);}
        }
        // Extract the real predicate IL. Replace only display-class arc storage with a string local;
        // Unity, services, GUI, timer and callback execution stay outside this CLR fixture.
        var eval=new MethodDefinition("Evaluate",MA.Public|MA.Static,m.TypeSystem.String);t.Methods.Add(eval);eval.Body.InitLocals=true;eval.Body.Variables.Add(new VariableDefinition(m.TypeSystem.String));
        var selected=Execute(source).Body.Instructions.Where(i=>i.Offset>=0x274&&i.Offset<=0x36f).ToArray();
        var clones=selected.ToDictionary(i=>i,i=>Instruction.Create(OpCodes.Nop));
        foreach(var i in selected) {
            var j=clones[i];j.OpCode=i.OpCode;j.Operand=Operand(i.Operand,clones,eval);
            if(i.Offset==0x36f){j.OpCode=OpCodes.Ldloc_0;j.Operand=null;}
            else if(i.OpCode==OpCodes.Ldloc_0){j.OpCode=OpCodes.Nop;j.Operand=null;}
            else if(i.OpCode==OpCodes.Stfld){j.OpCode=OpCodes.Stloc_0;j.Operand=null;}
            eval.Body.Instructions.Add(j);
        }
        eval.Body.GetILProcessor().Emit(OpCodes.Ret);return m;
    }
    static object Test(string originalPath,string patchedPath,string mapping,string report,string fixtureDir) {
        var map=Map(mapping);Need(HashFile(originalPath)==Original,"test-original-hash");
        using var source=ModuleDefinition.ReadModule(originalPath);using var patched=ModuleDefinition.ReadModule(patchedPath);
        Directory.CreateDirectory(fixtureDir);
        Type LoadFixture(ModuleDefinition input,string name) {
            using var fixture=Fixture(input,name);var bytes=Serialize(fixture);File.WriteAllBytes(Path.Combine(fixtureDir,name+".dll"),bytes);
            return System.Reflection.Assembly.Load(bytes).GetType("HaikuFixture")!;
        }
        var a=LoadFixture(source,"HaikuOriginalPredicate");var b=LoadFixture(patched,"HaikuPatchedPredicate");
        void Set(Type t,string?[] lines){for(int s=1;s<=3;s++)t.GetField("haikuLine"+s)!.SetValue(null,lines[s-1]);}
        string Eval(Type t)=>(string)t.GetMethod("Evaluate")!.Invoke(null,null)!;
        var choices=map.GetProperty("choices").EnumerateArray().ToArray();var fixtures=new List<object>();var negative=new List<object>();
        int changedDisplayOnly=0;var cultureResults=new Dictionary<string,int>();
        var originalCulture=CultureInfo.CurrentCulture;
        foreach(string culture in new[]{"en-US",Culture,"tr-TR"}) {
            CultureInfo.CurrentCulture=CultureInfo.GetCultureInfo(culture);int tested=0;
            foreach(var x in choices.Where(x=>x.GetProperty("slot").GetInt32()==1))
            foreach(var y in choices.Where(x=>x.GetProperty("slot").GetInt32()==2))
            foreach(var z in choices.Where(x=>x.GetProperty("slot").GetInt32()==3)) {
                var tuple=new[]{x,y,z};var src=tuple.Select(x=>x.GetProperty("source").GetString()!).ToArray();var ru=tuple.Select(x=>x.GetProperty("target").GetString()!).ToArray();
                Set(a,src);var expected=Eval(a);Set(a,ru);var broken=Eval(a);Set(b,ru);var actual=Eval(b);
                Need(expected==actual,"actual-clr-27-predicate-equivalence");
                Need(Enumerable.Range(1,3).All(s=>(string)b.GetField("haikuLine"+s)!.GetValue(null)! == ru[s-1]),"display-fields-preserved");
                tested++;
                if(culture=="en-US") {if(broken!=expected)changedDisplayOnly++;fixtures.Add(new{ids=tuple.Select(x=>x.GetProperty("id").GetString()).ToArray(),source=string.Join("\n",src),display=string.Join("\n",ru),expected,actual,displayOnly=broken,fieldsUnchanged=true});}
            }
            cultureResults[culture]=tested;
        }
        CultureInfo.CurrentCulture=originalCulture;Need(changedDisplayOnly==3,"exact-three-display-only-failures");
        void Reject(string name,Action action,string expectedReason) {
            bool rejected=false;try{action();}catch(TargetInvocationException e)when(e.InnerException is InvalidOperationException v&&v.Message==expectedReason){rejected=true;}
            Need(rejected,"negative-boundary:"+name);negative.Add(new{name,expectedReason,passed=true});
        }
        string[] good=choices.Where(x=>x.GetProperty("slot").GetInt32()==1).Take(1).Select(x=>x.GetProperty("target").GetString()!).Concat(
            choices.Where(x=>x.GetProperty("slot").GetInt32()==2).Take(1).Select(x=>x.GetProperty("target").GetString()!)).Concat(
            choices.Where(x=>x.GetProperty("slot").GetInt32()==3).Take(1).Select(x=>x.GetProperty("target").GetString()!)).ToArray();
        Set(b,good);Need(Eval(b)=="bridge_ending","matching-positive-before-runtime-negatives");
        var resolve=b.GetMethod(Prefix+"Resolve")!;
        var resolverResults=new List<object>();
        foreach(var choice in choices) {
            var label=choice.GetProperty("target").GetString()!;var slot=choice.GetProperty("slot").GetInt32();
            var actual=(string)resolve.Invoke(null,new object[]{label,slot,Context})!;
            Need(actual==choice.GetProperty("source").GetString(),"exact-full-source-evaluation-value");
            resolverResults.Add(new{id=choice.GetProperty("id").GetString(),slot,display=label,evaluation=actual,passed=true});
        }
        Need((string)resolve.Invoke(null,new object[]{good[0],1,Context})! == choices[0].GetProperty("source").GetString(),"matching-exact-resolver-positive");
        Reject("wrong-context",()=>resolve.Invoke(null,new object[]{good[0],1,"any-other-question"}),"haiku-identity:wrong-context");
        Reject("wrong-step",()=>resolve.Invoke(null,new object[]{good[0],2,Context}),"haiku-identity:unknown-label-or-slot");
        Reject("missing-step",()=>resolve.Invoke(null,new object[]{good[0],0,Context}),"haiku-identity:unknown-label-or-slot");
        Reject("English-key-in-display-label",()=>resolve.Invoke(null,new object[]{good[0]+" molded",1,Context}),"haiku-identity:unknown-label-or-slot");
        Reject("case-not-normalized",()=>resolve.Invoke(null,new object[]{good[0].ToUpperInvariant(),1,Context}),"haiku-identity:unknown-label-or-slot");
        Reject("whitespace-not-trimmed",()=>resolve.Invoke(null,new object[]{good[0]+" ",1,Context}),"haiku-identity:unknown-label-or-slot");
        var missing=good.Cast<string?>().ToArray();missing[2]=null;Set(b,missing);Reject("missing-third-line-before-short-circuit",()=>Eval(b),"haiku-identity:unknown-label-or-slot");
        Set(b,good);Need(Eval(b)=="bridge_ending","matching-positive-after-runtime-negatives");
        Reject("null-context",()=>resolve.Invoke(null,new object?[]{good[0],1,null}),"haiku-identity:wrong-context");
        Reject("context-case",()=>resolve.Invoke(null,new object[]{good[0],1,Context.ToUpperInvariant()}),"haiku-identity:wrong-context");
        Reject("context-whitespace",()=>resolve.Invoke(null,new object[]{good[0],1,Context+" "}),"haiku-identity:wrong-context");
        Reject("unknown-label",()=>resolve.Invoke(null,new object[]{"unmapped",1,Context}),"haiku-identity:unknown-label-or-slot");
        Reject("null-label",()=>resolve.Invoke(null,new object?[]{null,1,Context}),"haiku-identity:unknown-label-or-slot");
        Reject("slot-four",()=>resolve.Invoke(null,new object[]{good[0],4,Context}),"haiku-identity:unknown-label-or-slot");
        Reject("source-display-fallback",()=>resolve.Invoke(null,new object[]{choices[0].GetProperty("source").GetString()!,1,Context}),"haiku-identity:unknown-label-or-slot");
        // Bug in slot one short-circuits the first two named branches before slot three.
        // Validate missing slot three before that short circuit, with an otherwise valid tuple.
        var bug=choices.Where(x=>new[]{410,411,412}.Contains(int.Parse(x.GetProperty("id").GetString()!.Split(':')[2]))).Select(x=>x.GetProperty("target").GetString()!).ToArray();
        Set(b,bug);Need(Eval(b)=="bug_ending","matching-bug-positive-before-short-circuit-negative");
        var incomplete=bug.Cast<string?>().ToArray();incomplete[2]=null;Set(b,incomplete);
        Reject("missing-third-after-first-branch-short-circuit",()=>Eval(b),"haiku-identity:unknown-label-or-slot");
        Set(b,bug);Need(Eval(b)=="bug_ending","matching-bug-positive-after-short-circuit-negative");
        var structuralNegative=new List<object>();
        using var clean=ModuleDefinition.ReadModule(originalPath);Guard(clean,source);
        foreach(var item in new[]{("changed-comparison",0x27e,(object)"changed"),("changed-control-trigger",0x142,(object)"wrong-trigger"),("changed-timing",0x379,(object)2f),("changed-branch",0x288,(object)At(Execute(clean),0x364))}) {
            var i=At(Execute(clean),item.Item2);var previous=i.Operand;i.Operand=item.Item3;bool rejected=false;
            try{Guard(clean,source);}catch(InvalidOperationException e)when(e.Message=="whole-handler-source-contract"){rejected=true;}
            i.Operand=previous;Need(rejected,"structural-negative:"+item.Item1);Guard(clean,source);structuralNegative.Add(new{name=item.Item1,passed=true,reason="whole-handler-source-contract",positiveControl="unchanged pinned original before and after single mutation"});
        }
        bool repeatRejected=false;try{Guard(patched,source);}catch(InvalidOperationException e)when(e.Message=="patch-state-not-pristine"){repeatRejected=true;}
        Need(repeatRejected,"fully-patched-structural-repeat-rejection");structuralNegative.Add(new{name="fully-patched-repeat",passed=true,reason="patch-state-not-pristine",positiveControl="pristine original"});
        var partial=At(Execute(clean),0x274);var oldOp=partial.OpCode;var oldOperand=partial.Operand;
        partial.OpCode=OpCodes.Call;partial.Operand=Handler(patched).Methods.Single(x=>x.Name==Prefix+"Line1");
        bool partialRejected=false;try{Guard(clean,source);}catch(InvalidOperationException e)when(e.Message=="patch-state-not-pristine"){partialRejected=true;}
        partial.OpCode=oldOp;partial.Operand=oldOperand;Need(partialRejected,"partial-patch-structural-rejection");Guard(clean,source);
        structuralNegative.Add(new{name="partial-call-without-helpers",passed=true,reason="patch-state-not-pristine",positiveControl="pristine original"});
        var result=new {passed=true,mechanism="CLR executes helper bodies cloned from actual patched readback and predicate IL extracted from original/patched ExecuteTrigger",fixtures,cultureResults,negative,changedDisplayOnly,
            structuralNegative,resolverResults,actualPatchedSha256=HashFile(patchedPath),locale=Locale,culture=Culture,
            boundary="Native Unity/service/trigger scheduling/UI/callbacks are not executed; actual game 27-fixture acceptance remains not-run."};
        Save(report,result);return result;
    }
    static int Main(string[] args) {
        try {
            Need(args.Length>=2,"explicit-settings-required");
            var settings=JsonDocument.Parse(File.ReadAllBytes(args[0])).RootElement;
            Locale=settings.GetProperty("locale").GetString()!;Culture=settings.GetProperty("culture").GetString()!;
            Candidate=settings.GetProperty("candidateSha256").GetString()!;MapHash=settings.GetProperty("mappingSha256").GetString()!;
            Prefix=settings.GetProperty("helperPrefix").GetString()!;
            Need(!string.IsNullOrWhiteSpace(Locale)&&CultureInfo.GetCultureInfo(Culture).TwoLetterISOLanguageName==Locale&&
                 Prefix=="VNRevival"+Locale.ToUpperInvariant()+"Haiku_"&&Candidate.Length==64&&MapHash.Length==64,"explicit-locale-settings");
            args=args.Skip(1).ToArray();
            if(args.Length==5&&args[0]=="patch")Patch(args[1],args[2],args[3],args[4]);
            else if(args.Length==6&&args[0]=="test")Test(args[1],args[2],args[3],args[4],args[5]);
            else if(args.Length==3&&args[0]=="dump") {using var m=ModuleDefinition.ReadModule(args[1]);Save(args[2],Tree(m));}
            else throw new InvalidOperationException("usage: patch input map output receipt | test original patched map report fixtures | dump input report");
            return 0;
        } catch(Exception e) {Console.Error.WriteLine(e.GetType().Name+": "+e.Message);return 2;}
    }
}
