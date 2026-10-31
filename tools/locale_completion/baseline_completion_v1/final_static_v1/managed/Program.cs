using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Reflection;
using System.Globalization;
using MA = Mono.Cecil.MethodAttributes;
using FA = Mono.Cecil.FieldAttributes;
using TA = Mono.Cecil.TypeAttributes;

static class Program {
    const string Original = "46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf";
    const string Prior = "74a2f0e8a4851e128ba853837c31fc8d9c17fa7cdefae57505ae5c763ce0a9de";
    const string MapHash = "96ce2c8983eac73940ea86af512d67c21153c21185dadd24c89763bcc4609de1";
    const string HandlerType = "TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates";
    const string Context = "oliver_coyotes_date2_haiku_finish";
    const string Prefix = "VNRevivalRuHaiku_";
    static readonly int[] Loads = [0x274,0x28a,0x2a0,0x2c6,0x2dc,0x2f2,0x315,0x32b,0x341];
    static readonly string[] Words = ["molded","raging","friends","lovely","high","gone","bug","important","work"];
    static readonly JsonSerializerOptions Json = new() { WriteIndented=true };
    static string Hash(byte[] b) => Convert.ToHexString(SHA256.HashData(b)).ToLowerInvariant();
    static string HashFile(string p) => Hash(File.ReadAllBytes(p));
    static void Need(bool b, string s) { if (!b) throw new InvalidOperationException(s); }
    static void Save(string p, object o) => File.WriteAllText(p, JsonSerializer.Serialize(o,Json)+"\n");
    static IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> ts) { foreach (var t in ts) { yield return t; foreach(var n in Types(t.NestedTypes)) yield return n; } }
    static Dictionary<string,MethodDefinition> Methods(ModuleDefinition m) => Types(m.Types).SelectMany(t=>t.Methods).ToDictionary(t=>t.FullName);
    static TypeDefinition Handler(ModuleDefinition m) => m.Types.Single(t=>t.FullName==HandlerType);
    static MethodDefinition Execute(ModuleDefinition m) => Handler(m).Methods.Single(t=>t.Name=="ExecuteTrigger");
    static Instruction At(MethodDefinition m,int off) => m.Body.Instructions.Single(i=>i.Offset==off);
    static string Attrs(Mono.Cecil.ICustomAttributeProvider p) => string.Join(";", p.CustomAttributes.Select(a=>a.Constructor.FullName+":"+Convert.ToHexString(a.GetBlob())));
    static string Generic(IGenericParameterProvider p) => string.Join(";",p.GenericParameters.Select(g=>g.Name+":"+g.Attributes+":"+Attrs(g)+":"+string.Join(",",g.Constraints.Select(c=>c.ConstraintType.FullName+":"+Attrs(c)))));
    static string Constant(object? x) => x==null?"null":x.GetType().FullName+":"+(x is IFormattable f?f.ToString(null,CultureInfo.InvariantCulture):JsonSerializer.Serialize(x));
    static string Def(MethodDefinition m) => string.Join("|",m.FullName,m.Attributes,m.ImplAttributes,m.CallingConvention,m.SemanticsAttributes,Generic(m),Attrs(m),
        string.Join(";",m.Parameters.Select(p=>p.Name+":"+p.Attributes+":"+p.ParameterType.FullName+":"+Constant(p.HasConstant?p.Constant:null)+":"+Attrs(p))),
        m.MethodReturnType.Attributes+":"+Attrs(m.MethodReturnType),string.Join(";",m.Overrides.Select(o=>o.FullName)),m.HasPInvokeInfo?m.PInvokeInfo.Attributes+":"+m.PInvokeInfo.Module.Name+":"+m.PInvokeInfo.EntryPoint:"");
    static string Body(MethodDefinition m, bool skeleton=false) {
        if (!m.HasBody) return "<none>";
        var ins=m.Body.Instructions;
        string Id(Instruction? i)=>i==null?"end":"@"+ins.IndexOf(i);
        string Op(object? o)=>o switch {
            null=>"",string s=>skeleton?"str:<slot>":"str:"+JsonSerializer.Serialize(s),Instruction i=>Id(i),Instruction[] a=>string.Join(",",a.Select(Id)),
            VariableDefinition v=>"local:"+v.Index+":"+v.VariableType.FullName,ParameterDefinition p=>"param:"+p.Index+":"+p.ParameterType.FullName,
            MethodReference r=>"method:"+r.FullName,FieldReference r=>"field:"+r.FullName,TypeReference r=>"type:"+r.FullName,
            IFormattable f=>f.ToString(null,CultureInfo.InvariantCulture)??"",_=>o.ToString()??""};
        // ECMA tiny headers encode an implicit maxstack8. Cecil's in-memory
        // writer stores the calculated depth (often1); normalize that exact
        // representation difference, retaining stack values on fat bodies.
        int stack=m.Body.CodeSize<64&&!m.Body.InitLocals&&m.Body.Variables.Count==0&&m.Body.ExceptionHandlers.Count==0&&m.Body.MaxStackSize<=8?8:m.Body.MaxStackSize;
        return m.Body.InitLocals+"|"+stack+"|"+string.Join(",",m.Body.Variables.Select(v=>v.VariableType.FullName))+"\n"+
            string.Join("\n",ins.Select(i=>i.Offset.ToString("x4")+":"+i.OpCode+" "+Op(i.Operand)))+"\n"+
            string.Join(";",m.Body.ExceptionHandlers.Select(h=>h.HandlerType+":"+h.CatchType+":"+Id(h.TryStart)+":"+Id(h.TryEnd)+":"+Id(h.HandlerStart)+":"+Id(h.HandlerEnd)+":"+Id(h.FilterStart)));
    }
    static SortedDictionary<string,string> Tree(ModuleDefinition m) {
        var d=new SortedDictionary<string,string>();
        d["module"]=m.Name+"|"+m.Kind+"|"+m.RuntimeVersion+"|"+m.Architecture+"|"+m.Attributes+"|"+m.Characteristics+"|"+m.Mvid+"|"+Attrs(m);
        d["assembly"]=m.Assembly.Name.FullName+"|"+Attrs(m.Assembly)+"|"+string.Join(";",m.Assembly.SecurityDeclarations.Select(s=>s.Action+":"+Convert.ToHexString(s.GetBlob())));
        d["refs"]=string.Join(";",m.AssemblyReferences.Select(r=>r.FullName+":"+r.Attributes+":"+Convert.ToHexString(r.Hash??[])))+"|"+string.Join(";",m.ModuleReferences.Select(r=>r.Name));
        d["resources"]=string.Join(";",m.Resources.Select(r=>r.Name+":"+r.Attributes+":"+(r is EmbeddedResource e?Hash(e.GetResourceData()):r is LinkedResource l?l.File+":"+Convert.ToHexString(l.Hash):((AssemblyLinkedResource)r).Assembly.FullName)));
        foreach(var t in Types(m.Types)) {
            d["type:"+t.FullName]=t.Attributes+"|"+t.BaseType?.FullName+"|"+t.PackingSize+"|"+t.ClassSize+"|"+Generic(t)+"|"+Attrs(t)+"|"+string.Join(";",t.Interfaces.Select(i=>i.InterfaceType.FullName+":"+Attrs(i)));
            foreach(var f in t.Fields) d["field:"+f.FullName]=f.Attributes+"|"+f.Offset+"|"+Constant(f.HasConstant?f.Constant:null)+"|"+Hash(f.InitialValue??[])+"|"+Attrs(f);
            foreach(var p in t.Properties) d["property:"+p.FullName]=p.Attributes+"|"+p.GetMethod?.FullName+"|"+p.SetMethod?.FullName+"|"+string.Join(";",p.OtherMethods.Select(x=>x.FullName))+"|"+Attrs(p);
            foreach(var e in t.Events) d["event:"+e.FullName]=e.Attributes+"|"+e.AddMethod?.FullName+"|"+e.RemoveMethod?.FullName+"|"+e.InvokeMethod?.FullName+"|"+Attrs(e);
            foreach(var f in t.Methods) {d["method:"+f.FullName]=Def(f);d["body:"+f.FullName]=Body(f);}
        }
        return d;
    }
    static bool Equal(SortedDictionary<string,string> a,SortedDictionary<string,string> b) => a.Count==b.Count && a.All(p=>b.TryGetValue(p.Key,out var s)&&s==p.Value);
    static byte[] Serialize(ModuleDefinition m) { using var s=new MemoryStream();m.Write(s);return s.ToArray(); }
    static void Main(string[] args) {
        Need(args.Length >= 3,"inspect input.dll output.json OR patch input.dll request.json output.dll receipt.json helper.dll");
        using var m=ModuleDefinition.ReadModule(args[1]); var methods=Methods(m);
        if(args[0]=="inspect") {
            Need(!File.Exists(args[2]),"fresh-inspection");
            Save(args[2], new {sha256=HashFile(args[1]), methods=methods.Values.Where(x=>x.HasBody).Select(x=>new {
                method=x.FullName, skeletonSha256=Hash(Encoding.UTF8.GetBytes(Body(x,true))),
                literals=x.Body.Instructions.Where(i=>i.OpCode==OpCodes.Ldstr).Select(i=>new {offset=i.Offset,instructionIndex=x.Body.Instructions.IndexOf(i),source=(string)i.Operand})})});return;
        }
        Need(args[0]=="patch" && args.Length==6,"patch-arguments");
        var request=JsonDocument.Parse(File.ReadAllBytes(args[2])).RootElement;
        Need(request.GetProperty("locale").GetString() is "pt-BR" or "zh" or "es" or "es-419" or "de" or "ja","explicit-supported-locale");
        Need(HashFile(args[1])==request.GetProperty("sourceSha256").GetString(),"original-assembly-pin");
        Need(!File.Exists(args[3])&&!File.Exists(args[4]),"fresh-managed-outputs");
        var original=Tree(m);var originalRefs=m.AssemblyReferences.Select(x=>x.FullName).ToHashSet();
        using var noopSource=ModuleDefinition.ReadModule(args[1]);
        // Materialize the same complete bodies as the edited module. Otherwise
        // Cecil can copy unparsed raw bodies and the no-op tests another path.
        _=Tree(noopSource);byte[] noopBytes=Serialize(noopSource);
        using var noop=ModuleDefinition.ReadModule(new MemoryStream(noopBytes));var before=Tree(noop);
        var normalization=original.Keys.Where(k=>original[k]!=before[k]).ToArray();
        string WithoutStack(string body) {int a=body.IndexOf('|'),b=body.IndexOf('|',a+1);return body[..(a+1)]+"<calculated-stack>"+body[b..];}
        Need(original.Keys.SequenceEqual(before.Keys)&&normalization.All(k=>k.StartsWith("body:")&&WithoutStack(original[k])==WithoutStack(before[k])),"source-noop-only-stack-header-normalization");
        var restores=new List<(string,int,string)>();var selectors=new HashSet<string>();
        foreach(var r in request.GetProperty("rows").EnumerateArray()) {
            string name=r.GetProperty("method").GetString()!;int off=r.GetProperty("offset").GetInt32();
            var method=methods[name];var i=At(method,off);string source=r.GetProperty("source").GetString()!, target=r.GetProperty("target").GetString()!;
            Need(selectors.Add(name+":"+off),"duplicate-managed-selector");
            Need(i.OpCode==OpCodes.Ldstr && method.Body.Instructions.IndexOf(i)==r.GetProperty("instructionIndex").GetInt32() && (string)i.Operand==source,"exact-managed-source");
            Need(Hash(Encoding.UTF8.GetBytes(source))==r.GetProperty("sourceSha256").GetString() && Hash(Encoding.UTF8.GetBytes(target))==r.GetProperty("targetSha256").GetString(),"managed-wording-hash");
            restores.Add((name,method.Body.Instructions.IndexOf(i),source));i.Operand=target;
        }
        string glitch="System.Void TheForestOfLove.InventoryInfoTicker::RandomizeGlitchItemInfoTickerText()";
        bool hook=request.GetProperty("glitchHook").GetBoolean();int hookIndex=-1;
        if(hook) {
            Need(HashFile(args[5])==request.GetProperty("helperSha256").GetString(),"helper-pin");
            using var helper=ModuleDefinition.ReadModule(args[5]);
            string helperType=request.TryGetProperty("helperType",out var ht)?ht.GetString()!:"VNRevivalInventoryLayout";
            var format=helper.GetType(helperType).Methods.Single(x=>x.Name=="FormatGlitch"&&x.IsStatic&&x.Parameters.Count==1&&x.Parameters[0].ParameterType.FullName=="System.String"&&x.ReturnType.FullName=="System.String");
            var method=methods[glitch];var setter=method.Body.Instructions.Single(x=>x.OpCode==OpCodes.Callvirt&&x.Operand.ToString()=="System.Void TMPro.TMP_Text::set_text(System.String)");
            Need(restores.Any(x=>x.Item1==glitch),"hook-needs-exact-reviewed-suffix");
            var suffix=method.Body.Instructions.Single(x=>x.OpCode==OpCodes.Ldstr&&x.Offset==0x54);
            string text=(string)suffix.Operand;
            Need((text.StartsWith(" <color=\"purple\">(")&&text.EndsWith(")</color>")) ||
                 (text.StartsWith(" <color=\"purple\">（")&&text.EndsWith("）</color>")),"protected-glitch-suffix");
            hookIndex=method.Body.Instructions.IndexOf(setter);method.Body.GetILProcessor().InsertBefore(setter,Instruction.Create(OpCodes.Call,m.ImportReference(format)));
        }
        byte[] bytes=Serialize(m);var expected=Tree(m);
        using var got=ModuleDefinition.ReadModule(new MemoryStream(bytes));
        var observed=Tree(got);
        foreach(var k in expected.Keys.Union(observed.Keys).Where(k=>!expected.ContainsKey(k)||!observed.ContainsKey(k)||expected[k]!=observed[k]).Take(3))
            Console.Error.WriteLine("Readback mismatch "+k+" expected="+expected.GetValueOrDefault(k)+" observed="+observed.GetValueOrDefault(k));
        Need(Equal(expected,observed),"complete-assembly-readback");
        var gm=Methods(got);if(hook)gm[glitch].Body.Instructions.RemoveAt(hookIndex);
        foreach(var (name,index,value) in restores)gm[name].Body.Instructions[index].Operand=value;
        // Recompute offsets before comparison after removing the sole new instruction.
        byte[] reversedBytes=Serialize(got);using var reversed=ModuleDefinition.ReadModule(new MemoryStream(reversedBytes));
        var rt=Tree(reversed);
        if(hook) {
            // Cecil retains the imported helper AssemblyRef after reversing a call.
            foreach(var ar in reversed.AssemblyReferences.Where(x=>!originalRefs.Contains(x.FullName)).ToArray())reversed.AssemblyReferences.Remove(ar);rt=Tree(reversed);
        }
        foreach(var k in before.Keys.Union(rt.Keys).Where(k=>!before.ContainsKey(k)||!rt.ContainsKey(k)||before[k]!=rt[k]).Take(3))
            Console.Error.WriteLine("Reversal mismatch "+k+" expected="+before.GetValueOrDefault(k)+" observed="+rt.GetValueOrDefault(k));
        Need(Equal(before,rt),"complete-original-assembly-restored");
        File.WriteAllBytes(args[3],bytes);
        Need(HashFile(args[3])==Hash(bytes),"saved-assembly-byte-readback");
        Save(args[4],new {passed=true,locale=request.GetProperty("locale").GetString(),sourceSha256=HashFile(args[1]),outputSha256=Hash(bytes),selectedStrings=restores.Count,glitchHook=hook,
            completeTreeReadback=true,completeOriginalSemanticTreeRestored=true,sourceNoopSha256=Hash(noopBytes),sourceStackHeaderNormalizations=normalization,
            methodCount=methods.Count,helperSha256=hook?HashFile(args[5]):null,runtime="not-run"});
    }
}
