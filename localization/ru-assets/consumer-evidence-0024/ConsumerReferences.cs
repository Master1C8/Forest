using Mono.Cecil;
using Mono.Cecil.Cil;
// Static operand-reference evidence only; no game/assembly mutation.
if (args.Length < 2) throw new ArgumentException("assembly-path operand-fragment...");
using var assembly = AssemblyDefinition.ReadAssembly(args[0]);
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> ts) {
 foreach (var t in ts) { yield return t; foreach (var n in Types(t.NestedTypes)) yield return n; }
}
foreach (var m in Types(assembly.MainModule.Types).SelectMany(t => t.Methods)) {
 if (!m.HasBody) continue;
 var matches = m.Body.Instructions.Where(i => args.Skip(1).Any(q => (i.Operand?.ToString() ?? "").Contains(q, StringComparison.Ordinal))).ToArray();
 if (matches.Length == 0 && !args.Skip(1).Any(q => m.Name.Contains(q, StringComparison.Ordinal))) continue;
 Console.WriteLine("METHOD " + m.FullName);
 foreach (var i in m.Body.Instructions) Console.WriteLine(i);
}
