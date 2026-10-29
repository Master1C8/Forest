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
    static string Body(MethodDefinition m) {
        if (!m.HasBody) return "<none>";
        var ins=m.Body.Instructions;
        string Id(Instruction? i)=>i==null?"end":"@"+ins.IndexOf(i);
        string Op(object? o)=>o switch {
            null=>"",string s=>"str:"+JsonSerializer.Serialize(s),Instruction i=>Id(i),Instruction[] a=>string.Join(",",a.Select(Id)),
            VariableDefinition v=>"local:"+v.Index+":"+v.VariableType.FullName,ParameterDefinition p=>"param:"+p.Index+":"+p.ParameterType.FullName,
            MethodReference r=>"method:"+r.FullName,FieldReference r=>"field:"+r.FullName,TypeReference r=>"type:"+r.FullName,
            IFormattable f=>f.ToString(null,CultureInfo.InvariantCulture)??"",_=>o.ToString()??""};
        return m.Body.InitLocals+"|"+m.Body.MaxStackSize+"|"+string.Join(",",m.Body.Variables.Select(v=>v.VariableType.FullName))+"\n"+
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
    static JsonElement[] Mapping(string p) {
        Need(HashFile(p)==MapHash,"accepted-map-hash");
        var map=JsonDocument.Parse(File.ReadAllBytes(p)).RootElement;
        Need(map.GetProperty("locale").GetString()=="ru","explicit-ru-locale-required");
        var rows=map.GetProperty("rows").EnumerateArray().Where(r=>r.GetProperty("id").GetString()!.StartsWith("il:")).Select(r=>r.Clone()).ToArray();
        Need(rows.Length==34 && rows.Count(r=>r.GetProperty("alreadyApplied").GetBoolean())==3,"exact31-new3-retained");
        Need(rows.Select(r=>r.GetProperty("id").GetString()).Distinct().Count()==34,"distinct-managed-selectors");
        return rows;
    }
    static Instruction Select(ModuleDefinition m,JsonElement r) {
        var method=Methods(m)[r.GetProperty("method").GetString()!];
        var i=At(method,r.GetProperty("offset").GetInt32());
        Need(i.OpCode==OpCodes.Ldstr && method.Body.Instructions.IndexOf(i)==r.GetProperty("instructionIndex").GetInt32(),"exact-original-offset-index-opcode");
        Need(r.GetProperty("id").GetString()=="il:Assembly-CSharp.dll/"+method.FullName+"/IL_"+i.Offset.ToString("x4"),"selector-id");
        return i;
    }
    static void Guard(ModuleDefinition m,ModuleDefinition original,JsonElement[] rows) {
        Need(Methods(m).Count==14099,"whole-prior-method-count");
        foreach(var r in rows) {
            Need((string)Select(original,r).Operand==r.GetProperty("source").GetString(),"original-source-operand");
            var expected=r.GetProperty(r.GetProperty("alreadyApplied").GetBoolean()?"target":"source").GetString();
            Need((string)Select(m,r).Operand==expected,"prior-operand-or-partial-double-application");
        }
        // Full original selected-method contract, applying only the three prior chapter operands.
        foreach(var r in rows.Where(r=>r.GetProperty("alreadyApplied").GetBoolean())) Select(original,r).Operand=r.GetProperty("target").GetString()!;
        foreach(var name in rows.Select(r=>r.GetProperty("method").GetString()!).Distinct()) {
            Need(Def(Methods(m)[name])==Def(Methods(original)[name]),"full-original-method-definition:"+name);
            Need(Body(Methods(m)[name])==Body(Methods(original)[name]),"full-original-producer-contract:"+name);
        }
        foreach(var r in rows.Where(r=>r.GetProperty("alreadyApplied").GetBoolean())) Select(original,r).Operand=r.GetProperty("source").GetString()!;
    }
    static void Exclusive(string path,byte[] bytes) {using var f=new FileStream(path,FileMode.CreateNew);f.Write(bytes);}
    static object Patch(string input,string mapping,string output,string receipt,bool failAfterFirst=false) {
        var rows=Mapping(mapping);var hash=HashFile(input);
        var paths=new[]{output,receipt,output+".before.dll",output+".reversed.dll",output+".methods.jsonl"};
        Need(paths.All(p=>!File.Exists(p)),"new-output-required");
        var originalPath=Path.Combine(AppContext.BaseDirectory,"original/Assembly-CSharp.dll");
        Need(HashFile(originalPath)==Original,"frozen-original-dependency-hash");
        using var original=ModuleDefinition.ReadModule(originalPath);using var m=ModuleDefinition.ReadModule(input);
        Guard(m,original,rows);Need(hash==Prior,"supported-prior-haiku-assembly-hash");
        var before=Tree(m);
        foreach(var r in rows.Where(r=>!r.GetProperty("alreadyApplied").GetBoolean())) Select(m,r).Operand=r.GetProperty("target").GetString()!;
        var expected=Tree(m);byte[] bytes=Serialize(m);
        using var rb=ModuleDefinition.ReadModule(new MemoryStream(bytes));var after=Tree(rb);
        Need(Equal(expected,after),"whole-assembly-readback-including-metadata-maxstack");
        Need(Methods(rb).Count==14099,"unchanged-14099-method-inventory");
        var changed=before.Keys.Where(k=>before[k]!=after[k]).ToArray();
        var wanted=rows.Where(r=>!r.GetProperty("alreadyApplied").GetBoolean()).Select(r=>"body:"+r.GetProperty("method").GetString()!).Distinct().OrderBy(x=>x).ToArray();
        Need(changed.OrderBy(x=>x).SequenceEqual(wanted),"exact-selected-methods-only");
        foreach(var r in rows)Need((string)Select(rb,r).Operand==r.GetProperty("target").GetString(),"exact-target-readback");
        // Readback reversal retains every method definition/body, metadata, controls,
        // stack size and the four independently accepted Haiku helper bodies.
        foreach(var r in rows.Where(r=>!r.GetProperty("alreadyApplied").GetBoolean()))Select(rb,r).Operand=r.GetProperty("source").GetString()!;
        Need(Equal(before,Tree(rb)),"whole-prior-structural-reversal");
        var reversed=Serialize(rb);using var reverseRead=ModuleDefinition.ReadModule(new MemoryStream(reversed));
        Need(Equal(before,Tree(reverseRead)),"serialized-whole-prior-reversal");
        Need(Hash(reversed)==hash,"serialized-reversal-byte-exact");
        var ledger=Methods(m).Keys.OrderBy(x=>x).Select(n=>JsonSerializer.Serialize(new {method=n,
            definitionBefore=Hash(Encoding.UTF8.GetBytes(before["method:"+n])),definitionAfter=Hash(Encoding.UTF8.GetBytes(after["method:"+n])),
            bodyBefore=Hash(Encoding.UTF8.GetBytes(before["body:"+n])),bodyAfter=Hash(Encoding.UTF8.GetBytes(after["body:"+n])),changed=before["body:"+n]!=after["body:"+n]}));
        byte[] prior=File.ReadAllBytes(input);Need(Hash(prior)==hash,"input-unchanged-before-write");
        // Failure injection exercises the genuine between-write boundary.
        Exclusive(output+".before.dll",prior);
        Exclusive(output,bytes);
        if(failAfterFirst)throw new InvalidOperationException("injected-between-output-writes");
        Exclusive(output+".reversed.dll",reversed);
        Exclusive(output+".methods.jsonl",Encoding.UTF8.GetBytes(string.Join("\n",ledger)+"\n"));
        var result=new {inputSha256=hash,outputSha256=Hash(bytes),mappingSha256=MapHash,
            existingMethods=14099,originalMethods=14095,retainedHaikuHelpers=4,selectedNewOperands=31,retainedChapterOperands=3,
            changedMethods=wanted,wholeAssemblyReadback=true,wholePriorStructuralReversal=true,serializedReversalByteExact=true,
            reversedSha256=Hash(reversed),rollbackSha256=HashFile(output+".before.dll"),allDefinitionsMetadataControlsMaxStackPreserved=true,
            wholeMethodLedgerSha256=HashFile(output+".methods.jsonl"),runtime="not-run",sourceGateAccepted=false,wholeGameAccepted=false,
            commitBoundary="Exclusive independent rollback, DLL, reversal, ledger, receipt writes. A failure leaves partial evidence; occupied retry rejects; reconcile exact existing paths before a new attempt."};
        Exclusive(receipt,Encoding.UTF8.GetBytes(JsonSerializer.Serialize(result,Json)+"\n"));return result;
    }
    static void Test(string input,string mapping,string report) {
        var rows=Mapping(mapping);var originalPath=Path.Combine(AppContext.BaseDirectory,"original/Assembly-CSharp.dll");
        var results=new List<object>();
        void Check(string name,Action<ModuleDefinition> mutate,string reason) {
            using var m=ModuleDefinition.ReadModule(input);using var original=ModuleDefinition.ReadModule(originalPath);
            Guard(m,original,rows); // matching positive satisfies all unrelated earlier guards
            mutate(m);bool rejected=false;
            try{Guard(m,original,rows);}catch(InvalidOperationException e)when(e.Message==reason){rejected=true;}
            Need(rejected,"intended-negative:"+name);results.Add(new{name,passed=true,reason,positive="same pinned prior module with single condition unchanged"});
            using var positive=ModuleDefinition.ReadModule(input);using var orig2=ModuleDefinition.ReadModule(originalPath);Guard(positive,orig2,rows);
        }
        var first=rows.First(r=>!r.GetProperty("alreadyApplied").GetBoolean());
        Check("partial-application",m=>Select(m,first).Operand=first.GetProperty("target").GetString()!,"prior-operand-or-partial-double-application");
        Check("double-application",m=>{foreach(var r in rows)Select(m,r).Operand=r.GetProperty("target").GetString()!;},"prior-operand-or-partial-double-application");
        Check("changed-retained-chapter",m=>Select(m,rows.First(r=>r.GetProperty("alreadyApplied").GetBoolean())).Operand="wrong-retained","prior-operand-or-partial-double-application");
        var name=first.GetProperty("method").GetString()!;
        Check("unselected-producer-instruction",m=>Methods(m)[name].Body.Instructions[0].OpCode=OpCodes.Nop,"full-original-producer-contract:"+name);
        Check("stack-size",m=>Methods(m)[name].Body.MaxStackSize++,"full-original-producer-contract:"+name);
        Check("method-definition",m=>Methods(m)[name].ImplAttributes^=Mono.Cecil.MethodImplAttributes.NoInlining,"full-original-method-definition:"+name);
        var adventure=rows.First(r=>r.GetProperty("method").GetString()!.Contains("RegenerateAdventures" )).GetProperty("method").GetString()!;
        Check("protected-adventure-identity",m=>At(Methods(m)[adventure],0x37).Operand="wrong-gateway","full-original-producer-contract:"+adventure);
        Save(report,new{passed=true,tests=results,count=results.Count,boundary="In-memory Cecil module guards, same exact supported prior and full original contracts; no game/CLR execution."});
    }
    static int Main(string[] args) {
        try {
            if(args.Length==5&&args[0]=="patch")Patch(args[1],args[2],args[3],args[4]);
            else if(args.Length==5&&args[0]=="fail-write")Patch(args[1],args[2],args[3],args[4],true);
            else if(args.Length==4&&args[0]=="test")Test(args[1],args[2],args[3]);
            else if(args.Length==3&&args[0]=="dump"){using var m=ModuleDefinition.ReadModule(args[1]);Save(args[2],Tree(m));}
            else throw new InvalidOperationException("usage: patch input map output receipt | dump input output");
            return 0;
        }catch(Exception e){Console.Error.WriteLine(e.GetType().Name+": "+e.Message);return 2;}
    }
}
