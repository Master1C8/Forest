// Read only the six direct component type chains/interfaces. Never execute game code.
using Mono.Cecil;
using System.Text.Json;
if (args.Length != 1) throw new ArgumentException("original Managed directory required");
using var resolver = new DefaultAssemblyResolver();
resolver.AddSearchDirectory(args[0]);
var selected = new[] {
    ("UnityEngine.CoreModule.dll", "UnityEngine.RectTransform"),
    ("UnityEngine.UIModule.dll", "UnityEngine.Canvas"),
    ("UnityEngine.UI.dll", "UnityEngine.UI.CanvasScaler"),
    ("Assembly-CSharp.dll", "TheForestOfLove.FollowUICamera"),
    ("Assembly-CSharp.dll", "TheForestOfLove.UI.AutomaticDepthSortUI"),
    ("Assembly-CSharp.dll", "TheForestOfLove.DialogueSkipProgressIndicator")
};
var rows = new List<object>();
foreach (var (file, name) in selected) {
    using var assembly = AssemblyDefinition.ReadAssembly(Path.Combine(args[0], file),
        new ReaderParameters { AssemblyResolver = resolver });
    var t = assembly.MainModule.Types.Single(t => t.FullName == name);
    var chain = new List<object>();
    var interfaces = new HashSet<string>();
    var visited = new HashSet<string>();
    void AddInterfaces(TypeDefinition type) {
        foreach (var i in type.Interfaces) {
            if (interfaces.Add(i.InterfaceType.FullName)) AddInterfaces(i.InterfaceType.Resolve());
        }
    }
    for (TypeDefinition? current = t; current != null; current = current.BaseType?.Resolve()) {
        if (!visited.Add(current.FullName)) throw new InvalidOperationException("cyclic base chain");
        AddInterfaces(current);
        chain.Add(new { type = current.FullName, assembly = current.Module.Assembly.Name.Name,
            baseType = current.BaseType?.FullName,
            declaredInterfaces = current.Interfaces.Select(i => i.InterfaceType.FullName).ToArray() });
    }
    rows.Add(new { selectedAssembly = file, selectedType = name, chain,
        allInterfaces = interfaces.Order().ToArray(),
        implementsIDialogueUI = interfaces.Contains("PixelCrushers.DialogueSystem.IDialogueUI") });
}
Console.WriteLine(JsonSerializer.Serialize(rows, new JsonSerializerOptions { WriteIndented = true }));
