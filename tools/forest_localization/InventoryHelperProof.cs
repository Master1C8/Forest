using Mono.Cecil;
static partial class Program {
    static void Main(string[] args) {
        Need(args.Length==3,"old helper new helper receipt");
        using var old=ModuleDefinition.ReadModule(args[0]);using var current=ModuleDefinition.ReadModule(args[1]);
        var before=Tree(old);var after=Tree(current);
        string Ref(Mono.Cecil.AssemblyNameReference r)=>r.FullName+":"+r.Attributes+":"+Convert.ToHexString(r.Hash??[]);
        Need(old.AssemblyReferences.All(r=>current.AssemblyReferences.Any(n=>Ref(n)==Ref(r))),"retained-inventory-references");
        var added=current.AssemblyReferences.Where(r=>!old.AssemblyReferences.Any(o=>o.Name==r.Name)).ToArray();
        Need(added.All(r=>r.Name=="UnityEngine.TextRenderingModule"),"registered-inventory-measurement-reference");
        Need(!old.ModuleReferences.Any()&&!current.ModuleReferences.Any(),"inventory-no-native-imports");
        string changed="body:System.Void VNRevivalInventoryLayout::Apply(System.Object)";
        Need(before.ContainsKey(changed),"original-inventory-apply");
        foreach(var row in before)if(row.Key!="module"&&row.Key!="refs"&&row.Key!=changed)
            Need(after.TryGetValue(row.Key,out var value)&&value==row.Value,"retained-inventory-helper:"+row.Key);
        var additions=after.Keys.Except(before.Keys).ToArray();
        Need(additions.All(k=>k.Contains("VNRevivalInventoryLayout")),"only-inventory-helper-additions");
        Save(args[2],new {passed=true,sourceSha256=HashFile(args[0]),outputSha256=HashFile(args[1]),changedBody=changed,
            retainedEntries=before.Count-3,addedReferences=added.Select(r=>r.FullName),addedEntries=additions,boundary="Original FormatGlitch, Fit, fields and method definitions retained; Apply adapts only validated pane heights60..160"});
    }
}
