// Original metadata only; never load or invoke original game assemblies.
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
        attributes = m.Attributes.ToString(), implementation = m.ImplAttributes.ToString(), hasBody = m.HasBody,
        isVirtual = m.IsVirtual, isNewSlot = m.IsNewSlot, isFinal = m.IsFinal,
        explicitOverrides = m.Overrides.Select(o => o.FullName).ToArray() };
}
using var tmp = AssemblyDefinition.ReadAssembly(Path.Combine(managed, "Unity.TextMeshPro.dll"), new ReaderParameters { AssemblyResolver = resolver });
var dispatch = new List<object>();
foreach (var name in args.Length > 2 ? args[2].Split(',') : new [] { "Rebuild", "LayoutComplete", "GraphicUpdateComplete" }) {
    var chain = new List<object>(); var t = tmp.MainModule.GetType("TMPro.TextMeshProUGUI");
    while (t != null) {
        var declared = t.Methods.Where(m => m.Name == name &&
            (name == "Rebuild" ? m.Parameters.Count == 1 && m.Parameters[0].ParameterType.FullName == "UnityEngine.UI.CanvasUpdate" : m.Parameters.Count == 0)).ToArray();
        chain.Add(new { type = t.FullName, module = Path.GetFileName(t.Module.FileName), declarations = declared.Select(Identity).ToArray() });
        if (declared.Length > 0) break;
        t = t.BaseType?.Resolve();
    }
    dispatch.Add(new { method = name, chain });
}
var operands = new List<object>(); var handlers = new List<object>();
foreach (var row in JsonDocument.Parse(File.ReadAllText(args[1])).RootElement.EnumerateArray()) {
    using var asm = AssemblyDefinition.ReadAssembly(Path.Combine(managed, row.GetProperty("assembly").GetString()!), new ReaderParameters { AssemblyResolver = resolver });
    var type = asm.MainModule.GetType(row.GetProperty("type").GetString());
    var selected = row.GetProperty("selection").GetString()!.Split(',');
    if (type == null || selected.Any(n => !type.Methods.Any(m => m.Name == n))) throw new Exception("Missing exact selection");
    var signatures = row.TryGetProperty("signatures", out var exact) ? exact.EnumerateArray().Select(s => s.GetString()).ToArray() : null;
    if (signatures != null && signatures.Any(s => !type.Methods.Any(m => m.FullName == s))) throw new Exception("Missing exact signature");
    foreach (var method in type.Methods.Where(m => selected.Contains(m.Name) && m.HasBody && (signatures == null || signatures.Contains(m.FullName)))) {
        handlers.Add(new { caller = method.FullName, handlers = method.Body.ExceptionHandlers.Select(e => new {
            kind = e.HandlerType.ToString(), catchType = e.CatchType?.FullName,
            tryStart = e.TryStart.Offset, tryEnd = e.TryEnd?.Offset,
            handlerStart = e.HandlerStart.Offset, handlerEnd = e.HandlerEnd?.Offset,
            filterStart = e.FilterStart?.Offset }).ToArray() });
        foreach (var ins in method.Body.Instructions)
            if (ins.Operand is MethodReference op &&
                (op.DeclaringType.FullName.StartsWith("TMPro.") || op.DeclaringType.FullName.StartsWith("UnityEngine.")))
                operands.Add(new { caller = method.FullName, offset = ins.Offset, opcode = ins.OpCode.ToString(),
                    operand = op.FullName, scope = op.DeclaringType.Scope.ToString(), definition = Identity(op.Resolve()) });
    }
}
using var ui = AssemblyDefinition.ReadAssembly(Path.Combine(managed, "UnityEngine.UI.dll"));
var stages = ui.MainModule.GetType("UnityEngine.UI.CanvasUpdate").Fields.Where(f => f.HasConstant).Select(f => new { name = f.Name, value = f.Constant }).ToArray();
Console.WriteLine(JsonSerializer.Serialize(new { concreteRendererDispatch = dispatch, canvasUpdateValues = stages, directMethodOperands = operands, exceptionHandlers = handlers }, new JsonSerializerOptions { WriteIndented = true }));
