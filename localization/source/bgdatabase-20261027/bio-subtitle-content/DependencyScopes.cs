// Resolve only direct PixelCrushers/TMP method operands in this phase's selections.
// Cecil reads original metadata; no original assembly is executed.
using Mono.Cecil;
using System.Text.Json;
using System.Security.Cryptography;
var managed = Path.GetFullPath(args[0]);
var rows = JsonDocument.Parse(File.ReadAllText(args[1])).RootElement;
var resolver = new DefaultAssemblyResolver(); resolver.AddSearchDirectory(managed);
var results = new List<object>();
foreach (var row in rows.EnumerateArray()) {
    var file = Path.Combine(managed, row.GetProperty("assembly").GetString()!);
    using var assembly = AssemblyDefinition.ReadAssembly(file, new ReaderParameters { AssemblyResolver = resolver });
    var type = assembly.MainModule.GetType(row.GetProperty("type").GetString());
    var selected = row.GetProperty("selection").GetString()!.Split(',');
    foreach (var method in type.Methods.Where(m => selected.Contains(m.Name) && m.HasBody))
        foreach (var instruction in method.Body.Instructions)
            if (instruction.Operand is MethodReference operand &&
                (operand.DeclaringType.FullName.StartsWith("PixelCrushers.") || operand.DeclaringType.FullName.StartsWith("TMPro."))) {
                var resolved = operand.Resolve();
                var path = Path.GetFullPath(resolved.Module.FileName);
                if (Path.GetDirectoryName(path) != managed) throw new Exception("Resolved outside pinned original Managed directory");
                results.Add(new { caller = method.FullName, offset = instruction.Offset,
                    operand = operand.FullName, scope = operand.DeclaringType.Scope.ToString(),
                    resolved = resolved.FullName, module = Path.GetFileName(path),
                    sha256 = Convert.ToHexString(SHA256.HashData(File.ReadAllBytes(path))).ToLowerInvariant() });
            }
}
// The original resource pins TextMeshProUGUI; distinguish operand resolution from virtual dispatch.
using var tmp = AssemblyDefinition.ReadAssembly(Path.Combine(managed, "Unity.TextMeshPro.dll"), new ReaderParameters { AssemblyResolver = resolver });
var chain = new List<object>();
var current = tmp.MainModule.GetType("TMPro.TextMeshProUGUI");
while (current != null) {
    var declarations = current.Methods.Where(m => m.Name == "get_text" || m.Name == "set_text")
        .Select(m => new { signature = m.FullName, attributes = m.Attributes.ToString() }).ToArray();
    chain.Add(new { type = current.FullName, module = Path.GetFileName(current.Module.FileName), declarations });
    if (declarations.Length > 0) break;
    current = current.BaseType?.Resolve();
}
Console.WriteLine(JsonSerializer.Serialize(new { directMethodOperands = results, storedRendererPropertyDispatch = chain }, new JsonSerializerOptions { WriteIndented = true }));
