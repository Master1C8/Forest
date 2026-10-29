using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
using System.Text.Json;
using System.Reflection;

const string InputHash = "94b5d36e5e6f8a1a0a12280754ae5c87c3f13338f40b085864d32df13c0ce750";
const string Consumer = "System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)";
const string Helper = "VNRevivalRussianSpeakerDisplay";
string Hash(byte[] bytes) => Convert.ToHexString(SHA256.HashData(bytes)).ToLowerInvariant();
var json = new JsonSerializerOptions { WriteIndented = true, Encoder = System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping };
if (args.Length != 6 || args[0] != "patch") throw new Exception("patch source.dll targets.json output.dll receipt.json probe.dll");
if (args.Skip(3).Any(File.Exists)) throw new Exception("Outputs already exist");
if (Hash(File.ReadAllBytes(args[1])) != InputHash) throw new Exception("Unexpected source assembly");
using var module = ModuleDefinition.ReadModule(args[1]);
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> source) { foreach (var t in source) { yield return t; foreach (var n in Types(t.NestedTypes)) yield return n; } }
Dictionary<string, MethodDefinition> Methods(ModuleDefinition m) => Types(m.Types).SelectMany(t => t.Methods).ToDictionary(m => m.FullName);
string Body(MethodDefinition m) {
    if (!m.HasBody) return "<none>";
    var xs = m.Body.Instructions;
    string I(Instruction? i) => i == null ? "end" : "@" + xs.IndexOf(i);
    string O(object? o) => o switch { null => "", Instruction i => I(i), Instruction[] a => string.Join(",", a.Select(I)), _ => o.ToString() ?? "" };
    return m.Body.InitLocals + ":" + string.Join(",", m.Body.Variables.Select(v => v.VariableType.FullName)) + "\n" + string.Join("\n", xs.Select(i => i.OpCode + " " + O(i.Operand))) + "\n" + string.Join("\n", m.Body.ExceptionHandlers.Select(h => h.HandlerType + " " + h.CatchType + " " + I(h.TryStart) + " " + I(h.TryEnd) + " " + I(h.HandlerStart) + " " + I(h.HandlerEnd) + " " + I(h.FilterStart)));
}
string Metadata(ModuleDefinition m) => JsonSerializer.Serialize(new {
    assembly = m.Assembly.FullName, module = m.Name, m.Mvid, references = m.AssemblyReferences.Select(r => r.FullName),
    resources = m.Resources.Select(r => new { r.Name, r.Attributes, r.ResourceType, bytes = r is EmbeddedResource e ? Hash(e.GetResourceData()) : r.ToString() }),
    types = Types(m.Types).Select(t => new { t.FullName, t.Attributes, baseType = t.BaseType?.FullName,
        fields = t.Fields.Select(f => new { f.FullName, f.Attributes, f.Constant, bytes = Hash(f.InitialValue) }),
        methods = t.Methods.Select(x => new { x.FullName, x.Attributes, x.ImplAttributes, x.CallingConvention, parameters = x.Parameters.Select(p => new { p.Name, p.Attributes, p.Constant }), returns = x.ReturnType.FullName }),
        properties = t.Properties.Select(p => p.FullName), events = t.Events.Select(e => e.FullName) })
});
var rows = JsonDocument.Parse(File.ReadAllText(args[2])).RootElement.EnumerateArray().ToArray();
var map = rows.Select(r => (source: r.GetProperty("source").GetString()!, target: r.GetProperty("target").GetString()!)).ToArray();
if (map.Length != 24 || map.Select(r => r.source).Distinct().Count() != 24 || map.Any(r => string.IsNullOrWhiteSpace(r.source) || string.IsNullOrWhiteSpace(r.target) || r.source == r.target)) throw new Exception("Complete24 display map required");
var protectedKeys = new[] { "actor_a", "actor_b", "actor_c", "actor_d", "actor_e", "actor_f" };
if (map.Any(r => protectedKeys.Contains(r.source) || map.Any(x => x.source == r.target))) throw new Exception("Identity key or overlapping map state");
var methods = Methods(module);
var before = methods.ToDictionary(p => p.Key, p => Body(p.Value));
var metadata = Metadata(module);
var method = methods[Consumer];
if (method.IsStatic || method.Parameters.Count != 2 || method.Parameters[1].ParameterType.FullName != "System.String" || method.DeclaringType.Methods.Any(m => m.Name == Helper)) throw new Exception("Consumer signature mismatch");
var setters = method.Body.Instructions.Where(i => i.Operand is MethodReference r && r.FullName == "System.Void TMPro.TMP_Text::set_text(System.String)").ToArray();
if (setters.Length != 1 || setters[0].Offset != 0x14 || setters[0].Previous.OpCode != OpCodes.Ldarg_2) throw new Exception("Original display sink mismatch");
var equality = methods.Values.Where(m => m.HasBody).SelectMany(m => m.Body.Instructions).Select(i => i.Operand).OfType<MethodReference>().First(r => r.FullName == "System.Boolean System.String::op_Equality(System.String,System.String)");
var mapper = new MethodDefinition(Helper, Mono.Cecil.MethodAttributes.Private | Mono.Cecil.MethodAttributes.Static | Mono.Cecil.MethodAttributes.HideBySig, module.TypeSystem.String);
mapper.Parameters.Add(new ParameterDefinition("value", Mono.Cecil.ParameterAttributes.None, module.TypeSystem.String));
method.DeclaringType.Methods.Add(mapper);
var il = mapper.Body.GetILProcessor();
foreach (var row in map) {
    var next = Instruction.Create(OpCodes.Nop);
    il.Emit(OpCodes.Ldarg_0); il.Emit(OpCodes.Ldstr, row.source); il.Emit(OpCodes.Call, equality); il.Emit(OpCodes.Brfalse, next); il.Emit(OpCodes.Ldstr, row.target); il.Emit(OpCodes.Ret); il.Append(next);
}
il.Emit(OpCodes.Ldarg_0); il.Emit(OpCodes.Ret);
var entry = method.Body.Instructions[0]; var editor = method.Body.GetILProcessor();
editor.InsertBefore(entry, Instruction.Create(OpCodes.Ldarg_2));
editor.InsertBefore(entry, Instruction.Create(OpCodes.Call, mapper));
editor.InsertBefore(entry, Instruction.Create(OpCodes.Starg, method.Parameters[1]));
var expected = Methods(module).ToDictionary(p => p.Key, p => Body(p.Value));
var patchedMetadata = Metadata(module);
module.Write(args[3]);
using var readback = ModuleDefinition.ReadModule(args[3]);
var after = Methods(readback);
if (!expected.Keys.ToHashSet().SetEquals(after.Keys) || expected.Any(p => Body(after[p.Key]) != p.Value) || Metadata(readback) != patchedMetadata) throw new Exception("Whole method/checked metadata readback mismatch");
var changed = before.Keys.Where(k => before[k] != Body(after[k])).ToArray();
if (changed.Length != 1 || changed[0] != Consumer || after.Count != before.Count + 1) throw new Exception("Unexpected changed methods");
var savedMapper = after.Values.Single(m => m.Name == Helper);
// Copy the exact saved pure method into a Unity-free assembly, then execute its IL on CLR.
using var probe = ModuleDefinition.CreateModule("SpeakerProjectionProbe", ModuleKind.Dll);
var probeType = new TypeDefinition("VNRevival", "SpeakerProjectionProbe", Mono.Cecil.TypeAttributes.Public | Mono.Cecil.TypeAttributes.Class, probe.TypeSystem.Object);
probe.Types.Add(probeType);
var probeMethod = new MethodDefinition(Helper, Mono.Cecil.MethodAttributes.Public | Mono.Cecil.MethodAttributes.Static, probe.TypeSystem.String);
probeMethod.Parameters.Add(new ParameterDefinition("value", Mono.Cecil.ParameterAttributes.None, probe.TypeSystem.String)); probeType.Methods.Add(probeMethod);
var clones = savedMapper.Body.Instructions.ToDictionary(i => i, i => Instruction.Create(OpCodes.Nop));
foreach (var old in savedMapper.Body.Instructions) { var copy = clones[old]; copy.OpCode = old.OpCode; copy.Operand = old.Operand switch { Instruction target => clones[target], MethodReference mr => probe.ImportReference(mr), _ => old.Operand }; probeMethod.Body.Instructions.Add(copy); }
if (Body(probeMethod) != Body(savedMapper)) throw new Exception("Probe must execute the exact saved mapper IL");
probe.Write(args[5]);
var executable = Assembly.LoadFile(Path.GetFullPath(args[5])).GetType("VNRevival.SpeakerProjectionProbe")!.GetMethod(Helper)!;
string? Run(string? value) => (string?)executable.Invoke(null, new object?[] { value });
foreach (var row in map) { if (Run(row.source) != row.target || Run(row.target) != row.target) throw new Exception("Mapping/idempotence execution mismatch"); }
string?[] controls = { null, "", " ", "actor_a", "actor_b", "Bear 10", "Bear1", "bear 1", "Bear 1 ", "I met Bear 1 today.", "<b>Bear 1</b>", "Unknown speaker" };
foreach (var value in controls) if (Run(value) != value) throw new Exception("Unknown/exact-match passthrough mismatch");
// Remove only the injected prefix/helper and compare all original methods and checked metadata.
var restored = after[Consumer];
for (int n = 0; n < 3; n++) restored.Body.Instructions.RemoveAt(0);
savedMapper.DeclaringType.Methods.Remove(savedMapper);
var restoredMethods = Methods(readback);
if (!before.Keys.ToHashSet().SetEquals(restoredMethods.Keys) || before.Any(p => Body(restoredMethods[p.Key]) != p.Value) || Metadata(readback) != metadata) throw new Exception("Original IL/checked metadata restoration mismatch");
File.WriteAllText(args[4], JsonSerializer.Serialize(new {
    schemaVersion = 1, sourceSha256 = InputHash, targetSha256 = Hash(File.ReadAllBytes(args[3])), targetsSha256 = Hash(File.ReadAllBytes(args[2])),
    consumer = Consumer, changedOriginalMethods = changed, addedPureMethods = 1, originalMethods = before.Count, resultingMethods = after.Count,
    allSavedMethodBodiesReadback = true, originalBodiesAndCheckedMetadataRestored = true, checkedMetadataProjection = "assembly identity/references, type/field/method signatures+attributes, resources, properties/events; not a claim of byte-exact DLL reversal",
    savedMapperIlExecutedOnClr = true, positiveMappingAndIdempotenceControls = map.Length, negativePassthroughControls = controls.Length,
    sourceCommandsDictionariesActorKeysAndPitchUnchanged = true, saveSchemaChanged = false, runtimeVisualAccepted = false,
    runtimeBoundary = "Exact saved pure mapper IL executed in Unity-free CLR fixture. Actual Unity method/native rendering not executed."
}, json) + "\n");
