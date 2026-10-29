using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;

// Internal backend: normal accepted-input loading is owned by the Python adapter.
// Draft mode is explicitly labeled and can never emit editorial/runtime acceptance.
if (args.Length != 6) throw new Exception("source.dll request.json output.dll receipt.json source.jsonl protected.jsonl");
string Hash(byte[] b) => Convert.ToHexString(SHA256.HashData(b)).ToLowerInvariant();
void Need(bool ok, string why) { if (!ok) throw new Exception(why); }
const string SupportedBefore = "13f1febb9cc2adb45ebed2227efbd6eb41f82632d5e199502df96c997fff348d";
const string SourceHash = "0f4cf89d7e3f4ffb78d82fd286f46cea82c5f853259199dfee6afa73a4bdd4e7";
const string ProtectedHash = "88f0dd1868e9b395c7bff93b32b49e89dac910643aec28bd5f882e2497427c79";
var sourceHash = Hash(File.ReadAllBytes(args[0]));
var request = JsonDocument.Parse(File.ReadAllBytes(args[1])).RootElement;
Need(request.GetProperty("locale").GetString() == "ru" && request.GetProperty("caseId").GetString() == "chapter-titles-and-gallery-hints", "explicit-case-locale-required");
var mode = request.GetProperty("mode").GetString();
Need(mode == "editorial-accepted" || mode == "draft-static-preflight-only", "explicit-input-mode-required");
Need(sourceHash == SupportedBefore && sourceHash == request.GetProperty("expectedBeforeSha256").GetString(), "managed-supported-before-hash");
Need(!File.Exists(args[2]) && !File.Exists(args[3]), "new-output-required");
Need(Hash(File.ReadAllBytes(args[4])) == SourceHash && Hash(File.ReadAllBytes(args[5])) == ProtectedHash, "source-packet-hash");
var sourceRows = File.ReadAllLines(args[4]).Select(l => JsonDocument.Parse(l).RootElement).Where(r => r.GetProperty("id").GetString()!.StartsWith("il:")).ToArray();
var protectedRows = File.ReadAllLines(args[5]).Select(l => JsonDocument.Parse(l).RootElement).ToArray();
var targetRows = request.GetProperty("targets").EnumerateArray().ToArray();
Need(sourceRows.Length == 3 && protectedRows.Length == 10 && targetRows.Length == 3 && targetRows.Select(r => r.GetProperty("id").GetString()).Distinct().Count() == 3, "exact3-unique-targets-required");
var targets = targetRows.ToDictionary(r => r.GetProperty("id").GetString()!);
Need(targets.Keys.ToHashSet().SetEquals(sourceRows.Select(r => r.GetProperty("id").GetString()!)), "exact3-target-id-set");
using var module = ModuleDefinition.ReadModule(args[0]);
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> types) { foreach (var t in types) { yield return t; foreach (var n in Types(t.NestedTypes)) yield return n; } }
string Body(MethodDefinition m) {
    if (!m.HasBody) return "<none>";
    var list = m.Body.Instructions;
    string Index(Instruction? i) => i == null ? "end" : "@" + list.IndexOf(i);
    string Operand(object? value) => value switch {
        null => "", string s => "str:" + JsonSerializer.Serialize(s),
        Instruction i => Index(i), Instruction[] a => string.Join(",", a.Select(Index)),
        IFormattable f => f.ToString(null, System.Globalization.CultureInfo.InvariantCulture) ?? "",
        _ => value.ToString() ?? ""
    };
    return "locals=" + m.Body.InitLocals + ":" + string.Join(",", m.Body.Variables.Select(v => v.VariableType.FullName)) + "\n" +
        string.Join("\n", list.Select(i => i.OpCode + " " + Operand(i.Operand))) + "\n" +
        string.Join("\n", m.Body.ExceptionHandlers.Select(h => h.HandlerType + " " + h.CatchType + " " + Index(h.TryStart) + " " + Index(h.TryEnd) + " " + Index(h.HandlerStart) + " " + Index(h.HandlerEnd) + " " + Index(h.FilterStart)));
}
string Definition(MethodDefinition m) => m.FullName + "|" + m.Attributes + "|" + m.ImplAttributes + "|" + m.CallingConvention + "|" +
    string.Join(";", m.Parameters.Select(p => p.Name + ":" + p.Attributes + ":" + p.ParameterType.FullName)) + "|" +
    string.Join(";", m.GenericParameters.Select(p => p.Name + ":" + p.Attributes));
var methods = Types(module.Types).SelectMany(t => t.Methods).ToDictionary(m => m.FullName);
var before = methods.ToDictionary(p => p.Key, p => Body(p.Value));
var definitions = methods.ToDictionary(p => p.Key, p => Definition(p.Value));
Instruction Select(JsonElement row, Dictionary<string, MethodDefinition> inventory, bool originalOffset) {
    var sel = row.GetProperty("physicalSelector");
    var name = sel.GetProperty("method").GetString()!;
    Need(sel.GetProperty("assemblySha256").GetString() == "46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf" && sel.GetProperty("opcode").GetString() == "ldstr", "selector-source-version");
    Need(inventory.ContainsKey(name), "selected-method-missing");
    var m = inventory[name];
    int index = sel.GetProperty("instructionIndex").GetInt32(), offset = sel.GetProperty("offset").GetInt32();
    Need(m.HasBody && index >= 0 && index < m.Body.Instructions.Count, "selected-instruction-missing");
    var i = m.Body.Instructions[index];
    Need(i.OpCode == OpCodes.Ldstr && (!originalOffset || i.Offset == offset), "exact-literal-selector");
    Need(row.GetProperty("id").GetString() == "il:Assembly-CSharp.dll/" + name + "/IL_" + offset.ToString("x4"), "literal-id-selector");
    return i;
}
foreach (var r in sourceRows.Concat(protectedRows)) Need((string)Select(r, methods, true).Operand == r.GetProperty("source").GetString(), "managed-source-before");
var restores = new List<(JsonElement row, string value)>();
foreach (var row in sourceRows) {
    var id = row.GetProperty("id").GetString()!;
    var t = targets[id];
    var source = row.GetProperty("source").GetString()!;
    var target = t.GetProperty("target").GetString()!;
    Need(t.GetProperty("locale").GetString() == "ru" && t.GetProperty("source").GetString() == source, "target-source-locale");
    Need(Hash(Encoding.UTF8.GetBytes(source)) == t.GetProperty("sourceSha256").GetString() && Hash(Encoding.UTF8.GetBytes(target)) == t.GetProperty("targetSha256").GetString(), "target-text-hash");
    Need(!string.IsNullOrWhiteSpace(target) && !target.Contains('\0'), "invalid-target");
    if (source.Contains("{0}")) Need(target.EndsWith(" {0}") && target.Count(c => c == '{') == 1 && target.Count(c => c == '}') == 1, "identifier-template");
    else Need(!target.Contains('{') && !target.Contains('}'), "fallback-template");
    restores.Add((row, source)); Select(row, methods, true).Operand = target;
}
var expected = methods.ToDictionary(p => p.Key, p => Body(p.Value));
// Validate staged bytes in memory FIRST, including exact expected operand readback.
using var staged = new MemoryStream();
module.Write(staged);
byte[] stagedBytes = staged.ToArray();
using var readback = ModuleDefinition.ReadModule(new MemoryStream(stagedBytes));
var after = Types(readback.Types).SelectMany(t => t.Methods).ToDictionary(m => m.FullName);
Need(before.Keys.ToHashSet().SetEquals(after.Keys), "whole-method-inventory");
Need(expected.All(p => Body(after[p.Key]) == p.Value) && definitions.All(p => Definition(after[p.Key]) == p.Value), "whole-method-readback");
var changed = before.Keys.Where(k => before[k] != Body(after[k])).ToArray();
Need(changed.ToHashSet().SetEquals(sourceRows.Select(r => r.GetProperty("physicalSelector").GetProperty("method").GetString()!)), "exact-two-changed-methods");
foreach (var r in sourceRows) Need((string)Select(r, after, true).Operand == targets[r.GetProperty("id").GetString()!].GetProperty("target").GetString(), "literal-target-readback");
foreach (var r in protectedRows) Need((string)Select(r, after, true).Operand == r.GetProperty("source").GetString(), "protected-literal-readback");
var inventory = before.Keys.OrderBy(k => k).Select(k => new { method = k, beforeBodySha256 = Hash(Encoding.UTF8.GetBytes(before[k])), targetBodySha256 = Hash(Encoding.UTF8.GetBytes(Body(after[k]))), definitionSha256 = Hash(Encoding.UTF8.GetBytes(definitions[k])) }).ToArray();
foreach (var (row, value) in restores) Select(row, after, true).Operand = value;
Need(before.All(p => Body(after[p.Key]) == p.Value), "all-original-bodies-restored");
// Exercise a second Cecil serialization/readback after reversal. Semantic method
// equivalence is proved; no byte-identical PE rewrite is claimed.
using var reversedStream = new MemoryStream(); readback.Write(reversedStream);
using var reversed = ModuleDefinition.ReadModule(new MemoryStream(reversedStream.ToArray()));
var reversedMethods = Types(reversed.Types).SelectMany(t => t.Methods).ToDictionary(m => m.FullName);
Need(before.Keys.ToHashSet().SetEquals(reversedMethods.Keys) && before.All(p => Body(reversedMethods[p.Key]) == p.Value), "serialized-reversal-readback");
var receipt = new { mode, sourceSha256 = sourceHash, targetSha256 = Hash(stagedBytes), selectedStrings = 3, protectedStrings = 10, changedMethods = changed,
    methodCount = before.Count, wholeMethodInventoryReadback = true, allOriginalBodiesRestored = true, serializedReversalReadback = true,
    otherMethodsEquivalent = true, allBranchesLocalsHandlersEquivalent = true, managedMetadataDefinitionsEquivalent = true,
    targetEditorialAccepted = false, wholeGameAccepted = false, runtime = "not-run", inventory,
    reversedSemanticAssemblySha256 = Hash(reversedStream.ToArray()), commitBoundary = "Validated in memory before exclusive output write; DLL and receipt are separate writes, not a transaction." };
using (var output = new FileStream(args[2], FileMode.CreateNew)) output.Write(stagedBytes);
using (var output = new FileStream(args[3], FileMode.CreateNew)) output.Write(Encoding.UTF8.GetBytes(JsonSerializer.Serialize(receipt, new JsonSerializerOptions { WriteIndented = true }) + "\n"));
