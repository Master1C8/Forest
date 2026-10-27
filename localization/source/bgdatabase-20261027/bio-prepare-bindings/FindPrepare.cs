// Metadata only. Scan exact preparation message definitions; never resolve or execute game code.
using Mono.Cecil;
using System.Text.Json;
if (args.Length != 1) throw new ArgumentException("original Managed directory required");
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> types) {
    foreach (var t in types) { yield return t; foreach (var n in Types(t.NestedTypes)) yield return n; }
}
var rows = new List<object>();
var assemblies = Directory.GetFiles(args[0], "*.dll").OrderBy(p => p, StringComparer.Ordinal).ToArray();
foreach (var path in assemblies) {
    using var assembly = AssemblyDefinition.ReadAssembly(path);
    foreach (var t in Types(assembly.MainModule.Types))
        foreach (var m in t.Methods.Where(m => m.Name == "OnPrepareConversationLine"))
            rows.Add(new { assembly = Path.GetFileName(path), type = t.FullName, baseType = t.BaseType?.FullName, method = m.FullName, attributes = m.Attributes.ToString() });
}
Console.WriteLine(JsonSerializer.Serialize(new { boundary = "Exact metadata method-name scan; not object selection, loaded assembly set, callback delivery or execution", assemblies = assemblies.Select(Path.GetFileName), definitions = rows }, new JsonSerializerOptions { WriteIndented = true }));
