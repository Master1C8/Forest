using Mono.Cecil;
using Mono.Cecil.Cil;
static partial class Program {
    static void Main(string[] args) {
        Need(args.Length==3||args.Length==4&&args[3]=="thai-wrap","original TMP output receipt [thai-wrap]");
        using var module=ModuleDefinition.ReadModule(args[0]);var before=Tree(module);
        Need(HashFile(args[0])=="775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483","exact-shared-TMP-source");
        var type=module.GetType("TMPro.TMP_Text");
        var parse=type.Methods.Single(m=>m.Name=="ParseInputText");
        var action=new TypeReference("System","Action`1",module,module.TypeSystem.CoreLibrary);
        action.GenericParameters.Add(new GenericParameter("!0",action));
        var closed=new GenericInstanceType(action);closed.GenericArguments.Add(type);
        var hook=new FieldDefinition("ForestPrepareText",Mono.Cecil.FieldAttributes.Public|Mono.Cecil.FieldAttributes.Static,closed);type.Fields.Add(hook);
        var invoke=new MethodReference("Invoke",module.TypeSystem.Void,closed){HasThis=true};invoke.Parameters.Add(new ParameterDefinition(action.GenericParameters[0]));
        void Hook(MethodDefinition target) {
            var first=target.Body.Instructions[0];var il=target.Body.GetILProcessor();
            foreach(var i in new[]{Instruction.Create(OpCodes.Ldsfld,hook),Instruction.Create(OpCodes.Brfalse,first),Instruction.Create(OpCodes.Ldsfld,hook),Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Callvirt,invoke)})il.InsertBefore(first,i);
        }
        var method=type.Methods.Single(m=>m.Name=="SetText"&&m.Parameters.Count==2&&m.Parameters[0].ParameterType.FullName=="System.String"&&m.Parameters[1].ParameterType.FullName=="System.Boolean");
        bool originalInitLocals=method.Body.InitLocals;
        var old=method.Body.Instructions.ToArray();
        Need(old.Length==28&&old[0].OpCode==OpCodes.Ldarg_1&&old[8].OpCode==OpCodes.Ldarg_1&&old[13].OpCode==OpCodes.Ldarg_1,"exact-SetText-string-boundary");
        Need(old[11].Operand is MethodReference call&&call.Name=="PopulateTextBackingArray","exact-display-array-call");
        var processor=type.Fields.Single(f=>f.Name=="m_TextPreprocessor");
        var preprocess=module.GetType("TMPro.ITextPreprocessor").Methods.Single(m=>m.Name=="PreprocessText");
        var local=new VariableDefinition(module.TypeSystem.String);method.Body.Variables.Add(local);method.Body.InitLocals=true;
        var il=method.Body.GetILProcessor();var first=old[0];var raw=Instruction.Create(OpCodes.Ldarg_1);var store=Instruction.Create(OpCodes.Stloc,local);
        foreach(var i in new[]{Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldfld,processor),Instruction.Create(OpCodes.Brfalse,raw),
            Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldfld,processor),Instruction.Create(OpCodes.Ldarg_1),
            Instruction.Create(OpCodes.Callvirt,preprocess),Instruction.Create(OpCodes.Br,store),raw,store})il.InsertBefore(first,i);
        // Change only display-array input and its length. The original m_text
        // store still receives arg1, preserving the logical getter and callers.
        foreach(var index in new[]{0,2,8}){old[index].OpCode=OpCodes.Ldloc;old[index].Operand=local;}
        var dirty=type.Fields.Single(f=>f.Name=="m_IsTextBackingStringDirty");
        foreach(var i in new[]{Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldfld,processor),Instruction.Create(OpCodes.Brfalse,old[15]),Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldc_I4_0),Instruction.Create(OpCodes.Stfld,dirty)})il.InsertBefore(old[15],i);
        Hook(method);Hook(parse);
        var wrapMethods=new List<MethodDefinition>();
        FieldDefinition? wrapHook=null;
        if(args.Length==4) {
            var func=new TypeReference("System","Func`3",module,module.TypeSystem.CoreLibrary);
            for(int i=0;i<3;i++)func.GenericParameters.Add(new GenericParameter("!"+i,func));
            var closedFunc=new GenericInstanceType(func);closedFunc.GenericArguments.Add(type);closedFunc.GenericArguments.Add(module.TypeSystem.Int32);closedFunc.GenericArguments.Add(module.TypeSystem.Int32);
            wrapHook=new FieldDefinition("ForestWordWrap",Mono.Cecil.FieldAttributes.Public|Mono.Cecil.FieldAttributes.Static,closedFunc);type.Fields.Add(wrapHook);
            var wrapInvoke=new MethodReference("Invoke",func.GenericParameters[2],closedFunc){HasThis=true};
            wrapInvoke.Parameters.Add(new ParameterDefinition(func.GenericParameters[0]));wrapInvoke.Parameters.Add(new ParameterDefinition(func.GenericParameters[1]));
            var count=type.Fields.Single(f=>f.Name=="m_characterCount");
            foreach(string name in new[]{"TMPro.TextMeshProUGUI","TMPro.TextMeshPro"}) {
                var mesh=module.GetType(name).Methods.Single(m=>m.Name=="GenerateTextMesh");var code=mesh.Body.Instructions.ToArray();
                int shift=name.EndsWith("UGUI")?0:1;
                Need(code.Length>5156+shift&&code[5003+shift].Operand is MethodReference save&&save.Name=="SaveWordWrappingState"&&code[5011+shift].Operand is FieldReference noBreak&&noBreak.Name=="m_isNonBreakingSpace"&&code[5151+shift].Operand is FieldReference last&&last.Name=="m_SavedLastValidState","exact-Thai-wrap-candidate-boundary:"+name);
                var anchor=code[5010+shift];var saveWord=code[4998+shift];var lastValid=code[5150+shift];var firstWord=code[5129+shift];
                var choice=new VariableDefinition(module.TypeSystem.Int32);mesh.Body.Variables.Add(choice);mesh.Body.InitLocals=true;
                var prefix=new[]{Instruction.Create(OpCodes.Ldsfld,wrapHook),Instruction.Create(OpCodes.Brfalse,anchor),
                    Instruction.Create(OpCodes.Ldsfld,wrapHook),Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldfld,count),Instruction.Create(OpCodes.Callvirt,wrapInvoke),Instruction.Create(OpCodes.Stloc,choice),
                    Instruction.Create(OpCodes.Ldloc,choice),Instruction.Create(OpCodes.Ldc_I4_0),Instruction.Create(OpCodes.Blt,anchor),
                    Instruction.Create(OpCodes.Ldloc,choice),Instruction.Create(OpCodes.Ldc_I4_1),Instruction.Create(OpCodes.Beq,saveWord),
                    Instruction.Create(OpCodes.Ldloc,choice),Instruction.Create(OpCodes.Ldc_I4_2),Instruction.Create(OpCodes.Beq,firstWord),Instruction.Create(OpCodes.Br,lastValid)};
                // Existing branches targeting the old candidate block must pass
                // through the optional hook, including the failed-space test.
                foreach(var instruction in code) {
                    if(ReferenceEquals(instruction.Operand,anchor))instruction.Operand=prefix[0];
                    if(instruction.Operand is Instruction[] targets)for(int i=0;i<targets.Length;i++)if(ReferenceEquals(targets[i],anchor))targets[i]=prefix[0];
                }
                foreach(var instruction in prefix)mesh.Body.GetILProcessor().InsertBefore(anchor,instruction);
                // Expanding IL can overflow short branch distances. Preserve
                // targets and use equivalent long encodings in this method.
                foreach(var instruction in mesh.Body.Instructions)if(instruction.OpCode.OperandType==OperandType.ShortInlineBrTarget)instruction.OpCode=LongBranch(instruction.OpCode);
                wrapMethods.Add(mesh);
            }
        }
        var bytes=Serialize(module);var expected=Tree(module);using var saved=ModuleDefinition.ReadModule(new MemoryStream(bytes));
        var readback=Tree(saved);
        Need(Equal(expected,readback),"complete-TMP-saved-readback:"+string.Join(";",expected.Where(p=>!readback.TryGetValue(p.Key,out var value)||value!=p.Value).Take(4).Select(p=>p.Key+" BEFORE="+p.Value.Substring(0,Math.Min(180,p.Value.Length))+" AFTER="+(readback.TryGetValue(p.Key,out var v)?v.Substring(0,Math.Min(180,v.Length)):"missing"))));
        string key="body:"+method.FullName;
        var changed=new[]{key,"body:"+parse.FullName}.Concat(wrapMethods.Select(m=>"body:"+m.FullName)).ToArray();
        Need(before.Where(r=>r.Key!="module"&&!changed.Contains(r.Key)).All(r=>expected.TryGetValue(r.Key,out var value)&&value==r.Value),"only-text-input-body-changes");
        Need(expected.Keys.Except(before.Keys).ToHashSet().SetEquals(new[]{"field:"+hook.FullName}.Concat(wrapHook==null?Array.Empty<string>():new[]{"field:"+wrapHook.FullName})),"only-static-render-hooks-added");
        var restoredType=saved.GetType("TMPro.TMP_Text");var restoredSet=restoredType.Methods.Single(m=>m.FullName==method.FullName);var restoredParse=restoredType.Methods.Single(m=>m.FullName==parse.FullName);
        for(int i=0;i<5;i++){restoredSet.Body.Instructions.RemoveAt(0);restoredParse.Body.Instructions.RemoveAt(0);}
        for(int i=0;i<6;i++)restoredSet.Body.Instructions.RemoveAt(25);
        for(int i=0;i<10;i++)restoredSet.Body.Instructions.RemoveAt(0);
        foreach(int index in new[]{0,2,8}){restoredSet.Body.Instructions[index].OpCode=OpCodes.Ldarg_1;restoredSet.Body.Instructions[index].Operand=null;}
        restoredSet.Body.Variables.RemoveAt(restoredSet.Body.Variables.Count-1);restoredSet.Body.InitLocals=originalInitLocals;
        restoredType.Fields.Remove(restoredType.Fields.Single(f=>f.Name=="ForestPrepareText"));
        if(wrapHook!=null) {
            restoredType.Fields.Remove(restoredType.Fields.Single(f=>f.Name=="ForestWordWrap"));
            // Reverse the saved bytes themselves. No body is replaced with an
            // original or exempted from the final complete-tree comparison.
            using var source=ModuleDefinition.ReadModule(args[0]);
            foreach(var changedMesh in wrapMethods) {
                var mesh=saved.GetType(changedMesh.DeclaringType.FullName).Methods.Single(m=>m.Name==changedMesh.Name);var code=mesh.Body.Instructions;
                int start=code.ToList().FindIndex(i=>i.OpCode==OpCodes.Ldsfld&&i.Operand is FieldReference f&&f.Name=="ForestWordWrap");
                Need(start>=0,"saved-wrap-prefix");var prefixStart=code[start];var anchor=code[start+18];
                foreach(var instruction in code.ToArray()) {
                    if(ReferenceEquals(instruction.Operand,prefixStart))instruction.Operand=anchor;
                    if(instruction.Operand is Instruction[] targets)for(int i=0;i<targets.Length;i++)if(ReferenceEquals(targets[i],prefixStart))targets[i]=anchor;
                }
                for(int i=0;i<18;i++)code.RemoveAt(start);
                var original=source.GetType(mesh.DeclaringType.FullName).Methods.Single(m=>m.Name==mesh.Name);
                Need(mesh.Body.Variables.Count==original.Body.Variables.Count+1,"saved-wrap-local-count");
                mesh.Body.Variables.RemoveAt(mesh.Body.Variables.Count-1);mesh.Body.InitLocals=original.Body.InitLocals;
                Need(code.Count==original.Body.Instructions.Count,"reversed-wrap-instruction-count");
                for(int i=0;i<code.Count;i++)if(original.Body.Instructions[i].OpCode.OperandType==OperandType.ShortInlineBrTarget) {
                    Need(code[i].OpCode==LongBranch(original.Body.Instructions[i].OpCode),"equivalent-saved-branch-encoding");
                    code[i].OpCode=original.Body.Instructions[i].OpCode;
                }
            }
        }
        var originalAgain=Serialize(saved);using var reversed=ModuleDefinition.ReadModule(new MemoryStream(originalAgain));
        Need(Equal(before,Tree(reversed)),"complete-original-TMP-tree-restored");
        File.WriteAllBytes(args[1],bytes);Save(args[2],new {passed=true,sourceSha256=HashFile(args[0]),outputSha256=Hash(bytes),changedBodies=new[]{method.FullName,parse.FullName},completeOriginalTreeRestored=true,
            completeOtherEntriesRetained=true,addedField=hook.FullName,wordWrap=wrapHook!=null,wordWrapBodies=wrapMethods.Select(m=>m.FullName),logicalStore="Original arg1 -> m_text unchanged; prepared backing data never replaces its getter",displayRoute="Existing ITextPreprocessor -> PopulateTextBackingArray, including GetTextInfo and Febucci"});
    }
    static OpCode LongBranch(OpCode op) => op.Code switch {
        Code.Br_S=>OpCodes.Br,Code.Brfalse_S=>OpCodes.Brfalse,Code.Brtrue_S=>OpCodes.Brtrue,
        Code.Beq_S=>OpCodes.Beq,Code.Bge_S=>OpCodes.Bge,Code.Bge_Un_S=>OpCodes.Bge_Un,
        Code.Bgt_S=>OpCodes.Bgt,Code.Bgt_Un_S=>OpCodes.Bgt_Un,Code.Ble_S=>OpCodes.Ble,
        Code.Ble_Un_S=>OpCodes.Ble_Un,Code.Blt_S=>OpCodes.Blt,Code.Blt_Un_S=>OpCodes.Blt_Un,
        Code.Bne_Un_S=>OpCodes.Bne_Un,Code.Leave_S=>OpCodes.Leave,_=>throw new InvalidOperationException("Unknown short branch "+op)
    };
}
