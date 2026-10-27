// Bounded phase94 declaration/operand resolution only. Never execute original game code.
using Mono.Cecil;
using System.Text.Json;
using System.Security.Cryptography;
var managed = Path.GetFullPath(args[0]);
var resolver = new DefaultAssemblyResolver(); resolver.AddSearchDirectory(managed);
string Hash(string p) => Convert.ToHexString(SHA256.HashData(File.ReadAllBytes(p))).ToLowerInvariant();
object Identity(MethodDefinition m) {
    var path = Path.GetFullPath(m.Module.FileName);
    if (Path.GetDirectoryName(path) != managed) throw new Exception("Resolved outside original Managed directory");
    return new { signature = m.FullName, module = Path.GetFileName(path), sha256 = Hash(path),
        attributes = m.Attributes.ToString(), implementation = m.ImplAttributes.ToString(), hasBody = m.HasBody };
}
using var tmp = AssemblyDefinition.ReadAssembly(Path.Combine(managed, "Unity.TextMeshPro.dll"), new ReaderParameters { AssemblyResolver = resolver });
var dispatch = new List<object>();
foreach (var name in new [] { "SetVerticesDirty", "SetLayoutDirty", "IsActive" }) {
    var chain = new List<object>(); var t = tmp.MainModule.GetType("TMPro.TextMeshProUGUI");
    while (t != null) {
        var declared = t.Methods.Where(m => m.Name == name && m.Parameters.Count == 0).ToArray();
        chain.Add(new { type = t.FullName, module = Path.GetFileName(t.Module.FileName), declarations = declared.Select(Identity).ToArray() });
        if (declared.Length > 0) break;
        t = t.BaseType?.Resolve();
    }
    dispatch.Add(new { method = name, chain });
}
var operands = new List<object>();
var rows = JsonDocument.Parse(File.ReadAllText(args[1])).RootElement;
foreach (var row in rows.EnumerateArray()) {
    using var asm = AssemblyDefinition.ReadAssembly(Path.Combine(managed, row.GetProperty("assembly").GetString()!), new ReaderParameters { AssemblyResolver = resolver });
    var type = asm.MainModule.GetType(row.GetProperty("type").GetString());
    var selected = row.GetProperty("selection").GetString()!.Split(',');
    if (type == null || selected.Any(n => !type.Methods.Any(m => m.Name == n))) throw new Exception("Missing exact selection");
    foreach (var method in type.Methods.Where(m => selected.Contains(m.Name) && m.HasBody))
        foreach (var ins in method.Body.Instructions)
            if (ins.Operand is MethodReference op &&
                (op.DeclaringType.FullName.StartsWith("PixelCrushers.") || op.DeclaringType.FullName.StartsWith("TMPro.") || op.DeclaringType.FullName.StartsWith("UnityEngine.")))
                operands.Add(new { caller = method.FullName, offset = ins.Offset, opcode = ins.OpCode.ToString(),
                    operand = op.FullName, scope = op.DeclaringType.Scope.ToString(), definition = Identity(op.Resolve()) });
}
Console.WriteLine(JsonSerializer.Serialize(new { concreteRendererDirtyDispatch = dispatch, directMethodOperands = operands }, new JsonSerializerOptions { WriteIndented = true }));
