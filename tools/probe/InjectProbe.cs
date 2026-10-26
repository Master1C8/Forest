using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
var flags=args.Skip(3).ToArray();
if(args.Length<3 || flags.Distinct().Count()!=flags.Length || flags.Any(x=>x!="--inventory-sample" && x!="--startup-markers"))
    throw new Exception("source Managed, bridge DLL, new patched assembly path [--inventory-sample] [--startup-markers]");
var dir=Path.GetFullPath(args[0]);
var source=Path.Combine(dir,"Assembly-CSharp.dll");
if(Convert.ToHexString(SHA256.HashData(File.ReadAllBytes(source))).ToLowerInvariant()!="46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf")throw new Exception("Wrong game build");
if(File.Exists(args[2]))throw new Exception("Output exists");
using var module=ModuleDefinition.ReadModule(source);
using var bridge=ModuleDefinition.ReadModule(args[1]);
string Body(MethodDefinition method,int prefix=0) {
    if(!method.HasBody)return "<none>";
    var instructions=method.Body.Instructions;
    string Index(Instruction? i)=>i==null?"end":"@"+(instructions.IndexOf(i)-prefix);
    string Operand(object? value)=>value switch {
        null=>"",Instruction i=>Index(i),
        Instruction[] list=>string.Join(",",list.Select(Index)),_=>value.ToString()??""
    };
    return "locals="+method.Body.InitLocals+":"+string.Join(",",method.Body.Variables.Select(v=>v.VariableType.FullName))+"\n"+
        string.Join("\n",instructions.Skip(prefix).Select(i=>i.OpCode+" "+Operand(i.Operand)))+"\n"+
        string.Join("\n",method.Body.ExceptionHandlers.Select(h=>h.HandlerType+" "+h.CatchType+" "+
            Index(h.TryStart)+" "+Index(h.TryEnd)+" "+Index(h.HandlerStart)+" "+Index(h.HandlerEnd)+" "+Index(h.FilterStart)));
}
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> types) {
    foreach(var type in types){yield return type;foreach(var nested in Types(type.NestedTypes))yield return nested;}
}
var originals=Types(module.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName,m=>Body(m));
var method=module.GetType("TheForestOfLove.MainMenuController").Methods.Single(x=>x.Name=="Start");
var call=Instruction.Create(OpCodes.Call,module.ImportReference(bridge.GetType("ForestProbe").Methods.Single(x=>x.Name=="Install")));
method.Body.GetILProcessor().InsertBefore(method.Body.Instructions[0],call);
var intended=new HashSet<string>{method.FullName};
var prefixes=new Dictionary<string,int>{{method.FullName,1}};
if(flags.Contains("--startup-markers")) {
    // Only original Unity logger calls; these early methods have no bridge reference.
    // Entry markers do not prove their original body completed or that Start was JITted.
    using var unity=ModuleDefinition.ReadModule(Path.Combine(dir,"UnityEngine.CoreModule.dll"));
    var log=module.ImportReference(unity.GetType("UnityEngine.Debug").Methods.Single(m=>m.Name=="Log" && m.Parameters.Count==1 && m.Parameters[0].ParameterType.FullName=="System.Object"));
    void Mark(MethodDefinition target,string label) {
        var first=target.Body.Instructions[0]; var il=target.Body.GetILProcessor();
        il.InsertBefore(first,Instruction.Create(OpCodes.Ldstr,"FOREST_STARTUP "+label));
        il.InsertBefore(first,Instruction.Create(OpCodes.Call,log));
        intended.Add(target.FullName); prefixes[target.FullName]=prefixes.GetValueOrDefault(target.FullName)+2;
    }
    Mark(module.GetType("TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged").Methods.Single(m=>m.Name=="Awake"),"ROOT_AWAKE_ENTER");
    Mark(module.GetType("TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged").Methods.Single(m=>m.Name=="OnLevelFinishedLoading"),"ROOT_SCENE_CHANGED_ENTER");
    Mark(module.GetType("TheForestOfLove.Core.SceneSetup.PrefabDropper").Methods.Single(m=>m.Name=="Awake"),"PREFAB_AWAKE_ENTER");
    Mark(method,"MENU_START_ENTER");
}
if(flags.Contains("--inventory-sample")) {
    // Synthetic empty-cell path only. Keep branch operands, item identities,
    // quantities and all non-display literals bytecode-equivalent.
    var ticker=module.GetType("TheForestOfLove.InventoryInfoTicker").Methods.Single(x=>x.Name=="OnCellSelected");
    var samples=new Dictionary<string,string>{
        ["Nothin’"]="Ёж Йй 123 — Latin!",
        ["You’ve got a whole lot of it."]="Е\u0308 и\u0306; Ё й. Щъ Ыь Эю Яя; 123 — Latin!"
    };
    foreach(var pair in samples) {
        var matches=ticker.Body.Instructions.Where(i=>i.OpCode==OpCodes.Ldstr && (string)i.Operand==pair.Key).ToArray();
        if(matches.Length!=1)throw new Exception("Synthetic inventory source literal missing or ambiguous: "+pair.Key);
        matches[0].Operand=pair.Value;
    }
    intended.Add(ticker.FullName);
}
var expected=Types(module.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName,m=>Body(m));
module.Write(args[2]);
using var readback=ModuleDefinition.ReadModule(args[2]);
var methods=Types(readback.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName);
var current=methods.ToDictionary(p=>p.Key,p=>Body(p.Value));
if(!originals.Keys.Order().SequenceEqual(current.Keys.Order()))throw new Exception("Method inventory changed");
var changed=originals.Keys.Where(k=>originals[k]!=current[k]).ToArray();
if(!intended.SetEquals(changed) || expected.Any(pair=>current[pair.Key]!=pair.Value))throw new Exception("Unexpected method/instruction changes");
foreach(var pair in prefixes)
    if(Body(methods[pair.Key],pair.Value)!=originals[pair.Key])throw new Exception("Original body/branches/locals/handlers changed: "+pair.Key);
Console.WriteLine("Exact probe readback verified; changed methods: "+string.Join(", ",changed)+"; all other methods bytecode-equivalent.");
