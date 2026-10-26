// Read-only bounded consumer tracing; no game launch or assembly mutation.
using Mono.Cecil;

if (args.Length != 3) throw new ArgumentException("assembly-path exact-type-name comma-separated-method-names");
using var assembly = AssemblyDefinition.ReadAssembly(args[0]);
var type = assembly.MainModule.Types.Single(t => t.FullName == args[1]);
var names = args[2].Split(',').ToHashSet();
if (names.Any(n => !type.Methods.Any(m => m.Name == n))) throw new ArgumentException("Unknown method");
Console.WriteLine("TYPE " + type.FullName);
foreach (var method in type.Methods.Where(m => names.Contains(m.Name))) {
    Console.WriteLine("METHOD " + method.FullName);
    if (method.HasBody)
        foreach (var instruction in method.Body.Instructions)
            Console.WriteLine(instruction);
}
