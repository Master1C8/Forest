// Read-only bounded consumer tracing; no game launch or assembly mutation.
using Mono.Cecil;

if (args.Length != 3) throw new ArgumentException("assembly-path exact-type-name comma-separated-method-names|--list");
using var assembly = AssemblyDefinition.ReadAssembly(args[0]);
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> types) {
        foreach (var item in types) {
            yield return item;
            foreach (var nested in Types(item.NestedTypes)) yield return nested;
        }
}
var types = Types(assembly.MainModule.Types).ToArray();
if (args[1] == "--types") {
    foreach (var item in types.Where(t => t.FullName.Contains(args[2], StringComparison.OrdinalIgnoreCase)))
        Console.WriteLine(item.FullName);
    return;
}
if (args[1] == "--find-native") {
    foreach (var method in types.SelectMany(t => t.Methods))
        if (method.HasPInvokeInfo && (method.Name.Contains(args[2], StringComparison.OrdinalIgnoreCase) ||
            method.PInvokeInfo.EntryPoint.Contains(args[2], StringComparison.OrdinalIgnoreCase)))
            Console.WriteLine(method.FullName + " | " + method.PInvokeInfo.Module.Name + "!" + method.PInvokeInfo.EntryPoint);
    return;
}
if (args[1] == "--find-literal" || args[1] == "--find-calls" || args[1] == "--find-call-fragment") {
    foreach (var method in types.SelectMany(t => t.Methods))
        if (method.HasBody)
            foreach (var instruction in method.Body.Instructions)
                if ((args[1] == "--find-literal" && instruction.OpCode == Mono.Cecil.Cil.OpCodes.Ldstr && (string)instruction.Operand == args[2]) ||
                    (args[1] == "--find-calls" && instruction.Operand is MethodReference called && called.FullName == args[2]) ||
                    (args[1] == "--find-call-fragment" && instruction.Operand is MethodReference fragment && fragment.FullName.Contains(args[2], StringComparison.Ordinal)))
                    Console.WriteLine(method.FullName + " | " + instruction);
    return;
}
var type = types.Single(t => t.FullName == args[1]);
if (args[2] == "--fields") {
    Console.WriteLine("TYPE " + type.FullName + " BASE " + type.BaseType);
    foreach (var field in type.Fields) Console.WriteLine("FIELD " + field.FullName + (field.HasConstant ? " = " + field.Constant : ""));
    foreach (var property in type.Properties) Console.WriteLine("PROPERTY " + property.FullName);
    return;
}
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
