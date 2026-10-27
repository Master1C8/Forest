// Cecil metadata only; never load or invoke original managed/native game code.
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
        isFinal = m.IsFinal, genericArity = m.GenericParameters.Count,
        explicitOverrides = m.Overrides.Select(o => o.FullName).ToArray() };
}
var methods = new List<object>(); var operands = new List<object>(); var handlers = new List<object>();
var fields = new List<object>(); var opaque = new List<object>();
foreach (var row in JsonDocument.Parse(File.ReadAllText(args[1])).RootElement.EnumerateArray()) {
    using var asm = AssemblyDefinition.ReadAssembly(Path.Combine(managed, row.GetProperty("assembly").GetString()!), new ReaderParameters { AssemblyResolver = resolver });
    var t = asm.MainModule.GetType(row.GetProperty("type").GetString());
    var signatures = row.GetProperty("signatures").EnumerateArray().Select(s => s.GetString()).ToArray();
    if (t == null || signatures.Distinct().Count() != signatures.Length || signatures.Any(s => t.Methods.Count(m => m.FullName == s) != 1)) throw new Exception("Missing/ambiguous exact method");
    foreach (var m in t.Methods.Where(m => signatures.Contains(m.FullName))) {
        methods.Add(Identity(m));
        if (!m.HasBody) continue;
        handlers.Add(new { caller = m.FullName, handlers = m.Body.ExceptionHandlers.Select(e => new {
            kind = e.HandlerType.ToString(), catchType = e.CatchType?.FullName,
            tryStart = e.TryStart.Offset, tryEnd = e.TryEnd?.Offset,
            handlerStart = e.HandlerStart.Offset, handlerEnd = e.HandlerEnd?.Offset }).ToArray() });
        foreach (var i in m.Body.Instructions) {
            if (i.Operand is MethodReference op) {
                if (op.DeclaringType.FullName.StartsWith("TMPro.") || op.DeclaringType.FullName.StartsWith("UnityEngine."))
                    operands.Add(new { caller = m.FullName, offset = i.Offset, opcode = i.OpCode.ToString(),
                        operand = op.FullName, scope = op.DeclaringType.Scope.ToString(), definition = Identity(op.Resolve()) });
                else opaque.Add(new { caller = m.FullName, offset = i.Offset, operand = op.FullName, scope = op.DeclaringType.Scope.ToString(), boundary = "BCL/runtime semantics not executed" });
            }
            if (i.Operand is FieldReference f && (f.DeclaringType.FullName.StartsWith("TMPro.") || f.DeclaringType.FullName.StartsWith("UnityEngine."))) {
                var d = f.Resolve(); var p = Path.GetFullPath(d.Module.FileName);
                if (Path.GetDirectoryName(p) != managed) throw new Exception("Field resolution outside original Managed");
                fields.Add(new { caller = m.FullName, offset = i.Offset, opcode = i.OpCode.ToString(), operand = f.FullName,
                    definition = new { signature = d.FullName, module = Path.GetFileName(p), sha256 = Hash(p), attributes = d.Attributes.ToString() } });
            }
        }
    }
}
using var tmp = AssemblyDefinition.ReadAssembly(Path.Combine(managed, "Unity.TextMeshPro.dll"), new ReaderParameters { AssemblyResolver = resolver });
using var core = AssemblyDefinition.ReadAssembly(Path.Combine(managed, "UnityEngine.CoreModule.dll"), new ReaderParameters { AssemblyResolver = resolver });
var next = new List<object>();
var priorNext = JsonDocument.Parse(File.ReadAllText(Path.Combine(Path.GetDirectoryName(args[1])!, "../bio-tmp-input-parsing/next-consumer.json")));
foreach (var m in priorNext.RootElement.GetProperty("otherUnreadManaged").EnumerateArray()
    .Concat(priorNext.RootElement.GetProperty("concreteArrayConsumer").EnumerateArray())) {
    var signature = m.GetProperty("signature").GetString();
    if (signature!.Contains("SetDefault") || signature.Contains("get_hashCode")) continue;
    var declaration = tmp.MainModule.Types.SelectMany(t => t.Methods).Single(m => m.FullName == signature);
    next.Add(Identity(declaration));
}
foreach (var name in new[] { ".cctor", ".ctor" })
    next.Add(Identity(core.MainModule.GetType("UnityEngine.ResourcesAPI").Methods.Single(m => m.Name == name)));
var typeIdentities = new[] { "TMPro.TMP_Style", "TMPro.TMP_StyleSheet", "TMPro.TMP_Settings" }.Select(n => {
    var t = tmp.MainModule.GetType(n); return new { name = t.FullName, baseType = t.BaseType.FullName,
        attributes = t.Attributes.ToString(), module = Path.GetFileName(t.Module.FileName), sha256 = Hash(t.Module.FileName) };
}).ToArray();
Console.WriteLine(JsonSerializer.Serialize(new { selectedMethods = methods, directMethodOperands = operands,
    fieldOperands = fields, opaqueRuntimeOperands = opaque, exceptionHandlers = handlers,
    nextDeclarations = next, typeIdentities }, new JsonSerializerOptions { WriteIndented = true }));
