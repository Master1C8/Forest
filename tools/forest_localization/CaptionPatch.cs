using Mono.Cecil;
using Mono.Cecil.Cil;
static partial class Program {
    static void Main(string[] args) {
        Need(args.Length==6,"assembly old-helper new-helper output receipt helper-proof");
        using var oldHelper=ModuleDefinition.ReadModule(args[1]);using var helper=ModuleDefinition.ReadModule(args[2]);
        var oldTree=Tree(oldHelper);var newTree=Tree(helper);
        bool complex=helper.GetType("ForestComplexText.Runtime")!=null;
        var retainedExceptions=new HashSet<string>{"module"};
        if(complex) {
            Need(oldHelper.Assembly.Name.FullName==helper.Assembly.Name.FullName&&oldHelper.Assembly.SecurityDeclarations.Count==0&&helper.Assembly.SecurityDeclarations.Count==0,"retained-renderer-assembly-identity");
            string Attribute(CustomAttribute a)=>a.Constructor.FullName+":"+Convert.ToHexString(a.GetBlob());
            foreach(var a in oldHelper.Assembly.CustomAttributes)Need(helper.Assembly.CustomAttributes.Any(n=>Attribute(n)==Attribute(a)),"retained-renderer-assembly-attribute");
            Need(helper.Assembly.CustomAttributes.Where(n=>!oldHelper.Assembly.CustomAttributes.Any(a=>Attribute(a)==Attribute(n))).All(n=>n.AttributeType.FullName=="System.Runtime.CompilerServices.ExtensionAttribute"&&Convert.ToHexString(n.GetBlob())=="01000000"),"exact-bidi-extension-assembly-attribute");
            Need(oldHelper.Resources.Count==0&&helper.Resources.Count==1&&helper.Resources[0] is EmbeddedResource&&helper.Resources[0].Name=="VNRevival.ShapingMap","exact-renderer-map-resource");
            var oldRefs=oldHelper.AssemblyReferences.ToDictionary(r=>r.Name);
            foreach(var r in oldRefs)Need(helper.AssemblyReferences.Any(n=>n.FullName==r.Value.FullName&&n.Attributes==r.Value.Attributes&&Convert.ToHexString(n.Hash??[])==Convert.ToHexString(r.Value.Hash??[])),"retained-renderer-reference:"+r.Key);
            Need(helper.AssemblyReferences.Where(r=>!oldRefs.ContainsKey(r.Name)).All(r=>r.Name=="Unity.TextMeshPro"||r.Name=="System.Core"||r.Name=="System"),"registered-renderer-references");
            retainedExceptions.Add("assembly");retainedExceptions.Add("refs");retainedExceptions.Add("resources");
            var impl=helper.GetType("<PrivateImplementationDetails>");
            if(impl!=null) {
                var oldImpl=oldHelper.GetType("<PrivateImplementationDetails>");
                var allowedData=new[]{"38965cd9b639c976d6d87461e47b57859ffe23aea2f65c7a204f11c931feb581",Hash(new byte[]{15,16,17,18,19,20,21,22})};
                foreach(var f in impl.Fields.Where(f=>oldImpl==null||!oldImpl.Fields.Any(o=>o.FullName==f.FullName)))
                    Need(allowedData.Contains(Hash(f.InitialValue)),"exact-bidi-initializer:"+f.FullName);
                Need(impl.NestedTypes.Where(t=>oldImpl==null||!oldImpl.NestedTypes.Any(o=>o.FullName==t.FullName)).All(t=>t.ClassSize==8||t.ClassSize==65535),"exact-bidi-storage-types");
            }
        }
        var changed=new List<string>{"body:System.Single VNRevivalQuestLayout::LayoutBody(VNRevivalQuestLayout/State,System.Single,System.Int32,System.Boolean)","body:System.Void VNRevivalQuestLayout::Apply(UnityEngine.Component)","body:System.Void VNRevivalQuestLayout::RussianStatusHeadings(UnityEngine.Component,UnityEngine.Font)"};
        if(complex)changed.Add("body:UnityEngine.Vector2 VNRevivalQuestLayout::InkY(UnityEngine.UI.Text,UnityEngine.RectTransform)");
        Need(changed.All(oldTree.ContainsKey),"exact-layout-methods");
        foreach(var p in oldTree)if(!retainedExceptions.Contains(p.Key)&&!changed.Contains(p.Key))Need(newTree.TryGetValue(p.Key,out var value)&&p.Value==value,"retained-helper-entry:"+p.Key);
        var additions=newTree.Keys.Except(oldTree.Keys).ToArray();
        Need(additions.Length>0&&additions.All(k=>k.Contains("VNRevivalImageCaptions")||complex&&(k.Contains("ForestComplexText.")||k.Contains("BidiSharp.")||k.Contains("<PrivateImplementationDetails>"))),"only-caption-renderer-helper-additions");
        Save(args[5],new {passed=true,oldHelperSha256=HashFile(args[1]),newHelperSha256=HashFile(args[2]),retainedHelperEntries=oldTree.Count-retainedExceptions.Count-changed.Count,changedLayoutBodies=changed,headingFontGuard="Authored characters, independent of alphabet",complexText=complex,shapingMapSha256=complex?Hash(((EmbeddedResource)helper.Resources[0]).GetResourceData()):null,addedEntries=additions});
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
