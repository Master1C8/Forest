using Mono.Cecil;
using System.Security.Cryptography;
using System.Text.Json;

// Read-only, finite font-consumer probe. Metadata tokens distinguish otherwise
// duplicate method signatures; this tool cannot patch or write an assembly.
class ConsumerProbe {
    static IEnumerable<TypeDefinition> Types(TypeDefinition type) {
        yield return type;
        foreach (var nested in type.NestedTypes)
            foreach (var child in Types(nested)) yield return child;
    }
    static void Main(string[] args) {
        if (args.Length != 2 || File.Exists(args[1])) throw new Exception("fresh input/output required");
        using var module = ModuleDefinition.ReadModule(args[0]);
        var selected = module.Types.SelectMany(Types).SelectMany(t => t.Methods)
            .Where(m => m.HasBody && m.DeclaringType.FullName.StartsWith("SickDev.DevConsole.") &&
                m.Body.Instructions.Any(i => (i.Operand?.ToString() ?? "").Contains("font", StringComparison.OrdinalIgnoreCase)))
            .Select(m => new { method=m.FullName, metadataToken=m.MetadataToken.ToInt32(),
                instructions=m.Body.Instructions.Select((i,n) => new {
                    index=n, offset=i.Offset, opcode=i.OpCode.ToString(), operand=i.Operand?.ToString() }) }).ToArray();
        File.WriteAllText(args[1], JsonSerializer.Serialize(new {
            input=Path.GetFullPath(args[0]), sha256=Convert.ToHexString(SHA256.HashData(File.ReadAllBytes(args[0]))).ToLowerInvariant(),
            predicate="SickDev.DevConsole methods directly referring to font members", methods=selected,
            boundary="Read-only IL and font selection evidence; no runtime loading, shaping or readability acceptance"
        }, new JsonSerializerOptions { WriteIndented=true }));
        Console.WriteLine($"Exact font consumer bodies: {selected.Length}");
    }
}
