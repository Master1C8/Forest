// Read-only bounded consumer tracing; no game launch or assembly mutation.
using Mono.Cecil;

if (args.Length != 3) throw new ArgumentException("assembly-path exact-type-name comma-separated-method-names|--list");
using var assembly = AssemblyDefinition.ReadAssembly(args[0]);
if (args[1] == "--find-literal") {
    IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> types) {
        foreach (var item in types) {
            yield return item;
            foreach (var nested in Types(item.NestedTypes)) yield return nested;
        }
    }
    foreach (var method in Types(assembly.MainModule.Types).SelectMany(t => t.Methods))
        if (method.HasBody)
            foreach (var instruction in method.Body.Instructions)
                if (instruction.OpCode == Mono.Cecil.Cil.OpCodes.Ldstr && (string)instruction.Operand == args[2])
                    Console.WriteLine(method.FullName + " | " + instruction);
    return;
}
var type = assembly.MainModule.Types.Single(t => t.FullName == args[1]);
if (args[2] == "--list") {
    foreach (var method in type.Methods) Console.WriteLine(method.FullName);
    return;
}
var names = args[2].Split(',').ToHashSet();
if (names.Any(n => !type.Methods.Any(m => m.Name == n))) throw new ArgumentException("Unknown method");
Console.WriteLine("TYPE " + type.FullName);
foreach (var method in type.Methods.Where(m => names.Contains(m.Name))) {
    Console.WriteLine("METHOD " + method.FullName);
    if (method.HasBody)
        foreach (var instruction in method.Body.Instructions)
            Console.WriteLine(instruction);
}
