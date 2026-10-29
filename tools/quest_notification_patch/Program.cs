using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
using System.Text.Json;

const string InputHash = "6bb930ea1fa5befcd1f8a13f13d140347a7dc96419ce2c81aa95682c7625861d";
const string Caller = "System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::ExecuteTrigger(System.String)";
const string Receiver = "System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)";
string Hash(byte[] bytes) => Convert.ToHexString(SHA256.HashData(bytes)).ToLowerInvariant();
var json = new JsonSerializerOptions { WriteIndented = true, Encoder = System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping };
if (args.Length != 5 || args[0] != "patch") throw new Exception("patch source.dll targets.json output.dll receipt.json");
if (File.Exists(args[3]) || File.Exists(args[4])) throw new Exception("Outputs already exist");
if (Hash(File.ReadAllBytes(args[1])) != InputHash) throw new Exception("Unexpected final Russian assembly");
using var module = ModuleDefinition.ReadModule(args[1]);
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> source) { foreach (var t in source) { yield return t; foreach (var n in Types(t.NestedTypes)) yield return n; } }
Dictionary<string, MethodDefinition> Methods(ModuleDefinition m) => Types(m.Types).SelectMany(t => t.Methods).ToDictionary(m => m.FullName);
string Body(MethodDefinition m) {
    if (!m.HasBody) return "<none>";
    var xs = m.Body.Instructions;
    string I(Instruction? i) => i == null ? "end" : "@" + xs.IndexOf(i);
    string O(object? o) => o switch { null => "", Instruction i => I(i), Instruction[] a => string.Join(",", a.Select(I)), _ => o.ToString() ?? "" };
    return m.Body.InitLocals + ":" + string.Join(",", m.Body.Variables.Select(v => v.VariableType.FullName)) + "\n" +
        string.Join("\n", xs.Select(i => i.OpCode + " " + O(i.Operand))) + "\n" +
        string.Join("\n", m.Body.ExceptionHandlers.Select(h => h.HandlerType + " " + h.CatchType + " " + I(h.TryStart) + " " + I(h.TryEnd) + " " + I(h.HandlerStart) + " " + I(h.HandlerEnd) + " " + I(h.FilterStart)));
}
string Metadata(ModuleDefinition m) => JsonSerializer.Serialize(new {
    assembly = m.Assembly.FullName, module = m.Name, m.Mvid,
    references = m.AssemblyReferences.Select(r => r.FullName),
    resources = m.Resources.Select(r => new { r.Name, r.Attributes, r.ResourceType, bytes = r is EmbeddedResource e ? Hash(e.GetResourceData()) : r.ToString() }),
    types = Types(m.Types).Select(t => new { t.FullName, t.Attributes, baseType = t.BaseType?.FullName,
        fields = t.Fields.Select(f => new { f.FullName, f.Attributes, f.Constant, bytes = Hash(f.InitialValue) }),
        methods = t.Methods.Select(x => new { x.FullName, x.Attributes, x.ImplAttributes, x.CallingConvention, parameters = x.Parameters.Select(p => new { p.Name, p.Attributes, p.Constant }), returns = x.ReturnType.FullName }),
        properties = t.Properties.Select(p => p.FullName), events = t.Events.Select(e => e.FullName) })
});
object[] CallSites(Dictionary<string, MethodDefinition> methods) => methods.Values.Where(m => m.HasBody).SelectMany(m => m.Body.Instructions.Where(i => i.Operand is MethodReference r && r.FullName == Receiver).Select(i => (object)new {
    method = m.FullName, instructionIndex = m.Body.Instructions.IndexOf(i), offset = i.Offset,
    preceding = m.Body.Instructions.Take(m.Body.Instructions.IndexOf(i)).TakeLast(7).Select(x => new { opcode = x.OpCode.ToString(), operand = x.Operand?.ToString() }).ToArray()
})).ToArray();
var methods = Methods(module);
var before = methods.ToDictionary(p => p.Key, p => Body(p.Value));
var metadata = Metadata(module);
var sitesBefore = CallSites(methods);
if (sitesBefore.Length != 13) throw new Exception("Expected complete 13-callsite notification family");
var method = methods[Caller];
var specs = new[] { (offset: 0x0646, source: "Check in with Scarlett."), (offset: 0x064b, source: "Say hi to four more critters.") };
var targets = JsonDocument.Parse(File.ReadAllText(args[2])).RootElement.EnumerateArray().ToDictionary(r => r.GetProperty("id").GetString()!);
var ids = specs.Select(s => "il:Assembly-CSharp.dll/" + Caller + "/IL_" + s.offset.ToString("x4")).ToArray();
if (!targets.Keys.ToHashSet().SetEquals(ids)) throw new Exception("Exact two-ID target set required");
var indices = new List<int>();
for (int n = 0; n < specs.Length; n++) {
    var spec = specs[n]; var row = targets[ids[n]];
    var i = method.Body.Instructions.Single(i => i.Offset == spec.offset);
    if (i.OpCode != OpCodes.Ldstr || (string)i.Operand != spec.source || row.GetProperty("source").GetString() != spec.source) throw new Exception("Exact source display operand mismatch");
    var target = row.GetProperty("target").GetString();
    if (string.IsNullOrWhiteSpace(target) || target == spec.source) throw new Exception("Missing target");
    indices.Add(method.Body.Instructions.IndexOf(i)); i.Operand = target;
}
if (indices[1] != indices[0] + 1 || method.Body.Instructions[indices[1] + 1].Operand is not MethodReference receiver || receiver.FullName != Receiver) throw new Exception("Display consumer boundary mismatch");
var expected = methods.ToDictionary(p => p.Key, p => Body(p.Value));
module.Write(args[3]);
using var readback = ModuleDefinition.ReadModule(args[3]);
var after = Methods(readback);
if (!expected.Keys.ToHashSet().SetEquals(after.Keys) || expected.Any(p => Body(after[p.Key]) != p.Value)) throw new Exception("Whole-method IL readback mismatch");
if (Metadata(readback) != metadata) throw new Exception("Metadata changed");
var changed = before.Keys.Where(k => before[k] != Body(after[k])).ToArray();
if (changed.Length != 1 || changed[0] != Caller) throw new Exception("Unexpected changed methods");
var sitesAfter = CallSites(after);
if (sitesAfter.Length != 13) throw new Exception("Notification calls changed");
for (int n = 0; n < specs.Length; n++) after[Caller].Body.Instructions[indices[n]].Operand = specs[n].source;
if (before.Any(p => Body(after[p.Key]) != p.Value) || JsonSerializer.Serialize(CallSites(after)) != JsonSerializer.Serialize(sitesBefore)) throw new Exception("Original instruction/consumer inventory restoration failed");
File.WriteAllText(args[4], JsonSerializer.Serialize(new {
    schemaVersion = 1, sourceSha256 = InputHash, targetSha256 = Hash(File.ReadAllBytes(args[3])),
    targetsSha256 = Hash(File.ReadAllBytes(args[2])), displayOperands = 2, changedMethods = changed,
    allMethodBodiesReadback = true, allOriginalMethodBodiesRestored = true, allOtherInstructionsPreservedExactly = true,
    metadataPreserved = true, metadataFingerprint = Hash(System.Text.Encoding.UTF8.GetBytes(metadata)),
    methodCount = before.Count, notificationCallsites = 13, sitesBefore, sitesAfter,
    saveSchemaChanged = false, runtimeAndVisualAcceptance = false
}, json) + "\n");
