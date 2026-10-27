// Read exact original metadata only. Never load or invoke game assemblies.
using Mono.Cecil;
using System.Text.Json;
using System.Security.Cryptography;
var managed = Path.GetFullPath(args[0]);
var resolver = new DefaultAssemblyResolver(); resolver.AddSearchDirectory(managed);
string Hash(string p) => Convert.ToHexString(SHA256.HashData(File.ReadAllBytes(p))).ToLowerInvariant();
object Identity(MethodDefinition m) {
    var p = Path.GetFullPath(m.Module.FileName);
    if (Path.GetDirectoryName(p) != managed) throw new Exception("Resolution outside original Managed");
    return new { signature = m.FullName, module = Path.GetFileName(p), sha256 = Hash(p),
        attributes = m.Attributes.ToString(), implementation = m.ImplAttributes.ToString(),
        hasBody = m.HasBody, isVirtual = m.IsVirtual, isNewSlot = m.IsNewSlot,
        isFinal = m.IsFinal, explicitOverrides = m.Overrides.Select(o => o.FullName).ToArray() };
}
var methods = new List<object>(); var operands = new List<object>(); var handlers = new List<object>();
foreach (var row in JsonDocument.Parse(File.ReadAllText(args[1])).RootElement.EnumerateArray()) {
    using var asm = AssemblyDefinition.ReadAssembly(Path.Combine(managed, row.GetProperty("assembly").GetString()!), new ReaderParameters { AssemblyResolver = resolver });
    var t = asm.MainModule.GetType(row.GetProperty("type").GetString());
    var signatures = row.GetProperty("signatures").EnumerateArray().Select(s => s.GetString()).ToArray();
    if (t == null || signatures.Any(s => t.Methods.Count(m => m.FullName == s) != 1)) throw new Exception("Missing/ambiguous exact method");
    foreach (var m in t.Methods.Where(m => signatures.Contains(m.FullName))) {
        methods.Add(Identity(m));
        if (!m.HasBody) continue;
        handlers.Add(new { caller = m.FullName, handlers = m.Body.ExceptionHandlers.Select(e => new {
            kind = e.HandlerType.ToString(), catchType = e.CatchType?.FullName,
            tryStart = e.TryStart.Offset, tryEnd = e.TryEnd?.Offset,
            handlerStart = e.HandlerStart.Offset, handlerEnd = e.HandlerEnd?.Offset }).ToArray() });
        foreach (var i in m.Body.Instructions)
            if (i.Operand is MethodReference op && (op.DeclaringType.FullName.StartsWith("TMPro.") || op.DeclaringType.FullName.StartsWith("UnityEngine.")))
                operands.Add(new { caller = m.FullName, offset = i.Offset, opcode = i.OpCode.ToString(),
                    operand = op.FullName, scope = op.DeclaringType.Scope.ToString(), definition = Identity(op.Resolve()) });
    }
}
using var tmp = AssemblyDefinition.ReadAssembly(Path.Combine(managed, "Unity.TextMeshPro.dll"), new ReaderParameters { AssemblyResolver = resolver });
var chain = new List<object>(); var concrete = tmp.MainModule.GetType("TMPro.TextMeshProUGUI");
while (concrete != null) {
    var found = concrete.Methods.Where(m => m.Name == "SetArraySizes" && m.Parameters.Count == 1 && m.Parameters[0].ParameterType.FullName == "TMPro.TMP_Text/UnicodeChar[]").ToArray();
    chain.Add(new { type = concrete.FullName, module = Path.GetFileName(concrete.Module.FileName), declarations = found.Select(Identity).ToArray() });
    if (found.Length > 0) break;
    concrete = concrete.BaseType?.Resolve();
}
var sources = tmp.MainModule.GetType("TMPro.TMP_Text/TextInputSources").Fields.Where(f => f.HasConstant).Select(f => new { name = f.Name, value = f.Constant }).ToArray();
Console.WriteLine(JsonSerializer.Serialize(new { selectedMethods = methods, directMethodOperands = operands, exceptionHandlers = handlers, concreteSetArraySizes = chain, textInputSources = sources }, new JsonSerializerOptions { WriteIndented = true }));
