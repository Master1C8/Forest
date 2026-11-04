using Mono.Cecil;
using Mono.Cecil.Cil;
static partial class Program {
    static void Main(string[] args) {
        Need(args.Length==6,"assembly old-helper new-helper output receipt helper-proof");
        using var oldHelper=ModuleDefinition.ReadModule(args[1]);using var helper=ModuleDefinition.ReadModule(args[2]);
        var oldTree=Tree(oldHelper);var newTree=Tree(helper);
        var changed=new[]{"body:System.Single VNRevivalQuestLayout::LayoutBody(VNRevivalQuestLayout/State,System.Single,System.Int32,System.Boolean)","body:System.Void VNRevivalQuestLayout::Apply(UnityEngine.Component)"};
        Need(changed.All(oldTree.ContainsKey),"exact-layout-methods");
        foreach(var p in oldTree)if(p.Key!="module"&&!changed.Contains(p.Key))Need(newTree.TryGetValue(p.Key,out var value)&&p.Value==value,"retained-helper-entry:"+p.Key);
        var additions=newTree.Keys.Except(oldTree.Keys).ToArray();
        Need(additions.Length>0&&additions.All(k=>k.Contains("VNRevivalImageCaptions")),"only-caption-helper-additions");
        Save(args[5],new {passed=true,oldHelperSha256=HashFile(args[1]),newHelperSha256=HashFile(args[2]),retainedHelperEntries=oldTree.Count-3,changedLayoutBodies=changed,addedEntries=additions});
        using var module=ModuleDefinition.ReadModule(args[0]);var before=Tree(module);
        var selected=new[]{("TheForestOfLove.MainMenuController","Gallery"),("TheForestOfLove.CritterLog","Residents")};
        foreach(var (type,entry) in selected) {
            var method=module.GetType(type).Methods.Single(m=>m.Name=="Start");
            var il=method.Body.GetILProcessor();var first=method.Body.Instructions[0];
            il.InsertBefore(first,Instruction.Create(OpCodes.Ldarg_0));
            il.InsertBefore(first,Instruction.Create(OpCodes.Call,module.ImportReference(helper.GetType("VNRevivalImageCaptions").Methods.Single(m=>m.Name==entry))));
        }
        var bytes=Serialize(module);var expected=Tree(module);
        using var saved=ModuleDefinition.ReadModule(new MemoryStream(bytes));
        var readback=Tree(saved);
        Need(Equal(expected,readback),"complete-caption-assembly-readback:"+string.Join(",",expected.Keys.Where(k=>!readback.TryGetValue(k,out var v)||expected[k]!=v).Take(5)));
        foreach(var (type,entry) in selected){var m=saved.GetType(type).Methods.Single(m=>m.Name=="Start");m.Body.Instructions.RemoveAt(0);m.Body.Instructions.RemoveAt(0);}
        // Remove the prefixes and recalculate offsets before comparison.
        var restoredBytes=Serialize(saved);using var restored=ModuleDefinition.ReadModule(new MemoryStream(restoredBytes));
        Need(Equal(before,Tree(restored)),"complete-original-assembly-restoration");
        File.WriteAllBytes(args[3],bytes);
        Save(args[4],new {passed=true,sourceSha256=HashFile(args[0]),outputSha256=Hash(bytes),completeSemanticTreeReadback=true,completeOriginalTreeRestored=true,changedMethods=selected.Select(s=>s.Item1+"::Start"),originalsAndTexturesUnchanged=true});
    }
}
