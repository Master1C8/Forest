using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Globalization;
using MA = Mono.Cecil.MethodAttributes;
using FA = Mono.Cecil.FieldAttributes;
using TA = Mono.Cecil.TypeAttributes;
static class Program {
    static readonly JsonSerializerOptions Json = new(){WriteIndented=true,Encoder=System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping};
    static string Hash(byte[] b) => Convert.ToHexString(SHA256.HashData(b)).ToLowerInvariant();
    static string HashFile(string p) => Hash(File.ReadAllBytes(p));
    static void Need(bool b, string s) { if (!b) throw new InvalidOperationException(s); }
    static void Save(string p, object o) => File.WriteAllText(p, JsonSerializer.Serialize(o,Json)+"\n");
    static IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> ts) { foreach (var t in ts) { yield return t; foreach(var n in Types(t.NestedTypes)) yield return n; } }
    static Dictionary<string,MethodDefinition> Methods(ModuleDefinition m) => Types(m.Types).SelectMany(t=>t.Methods).ToDictionary(t=>t.FullName);
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
        Need(args.Length>=3,"inspect input output | patch input request output receipt");
        using var m=ModuleDefinition.ReadModule(args[1]);
        var methods=Methods(m);
        if(args[0]=="inspect") {
            Need(!File.Exists(args[2]),"fresh-output");
            Save(args[2],new { sha256=HashFile(args[1]), methods=methods.Values.Where(x=>x.HasBody).Select(x=>new {
                method=x.FullName, instructions=x.Body.Instructions.Select((i,n)=>new {index=n,opcode=i.OpCode.ToString(),
                operand=i.Operand is string s?s:i.Operand is Instruction ?"<branch>":i.Operand is Instruction[]?"<branches>":i.Operand?.ToString()})}) });
            return;
        }
        Need(args[0]=="patch" && args.Length==5,"patch input request output receipt");
        Need(!File.Exists(args[3])&&!File.Exists(args[4]),"fresh-output");
        var request=JsonDocument.Parse(File.ReadAllText(args[2])).RootElement;
        Need(HashFile(args[1])==request.GetProperty("sourceSha256").GetString(),"source-hash");
        var before=Tree(m);var edits=new List<(Instruction Instruction,string Before,string After)>();
        var seen=new HashSet<string>();
        foreach(var r in request.GetProperty("rows").EnumerateArray()) {
            string name=r.GetProperty("method").GetString()!;int index=r.GetProperty("index").GetInt32();
            Need(seen.Add(name+"@"+index),"duplicate-selector");
            var f=methods[name];var i=f.Body.Instructions[index];
            string source=r.GetProperty("source").GetString()!,target=r.GetProperty("target").GetString()!;
            Need(i.OpCode==OpCodes.Ldstr && (string)i.Operand==source,"exact-literal-selector");
            edits.Add((i,source,target));i.Operand=target;
        }
        var expected=Tree(m);byte[] bytes=Serialize(m);
        using(var saved=ModuleDefinition.ReadModule(new MemoryStream(bytes))) {
            Need(Equal(expected,Tree(saved)),"whole-saved-semantic-tree");
            var sm=Methods(saved);
            foreach(var r in request.GetProperty("rows").EnumerateArray()) {
                var i=sm[r.GetProperty("method").GetString()!].Body.Instructions[r.GetProperty("index").GetInt32()];
                Need((string)i.Operand==r.GetProperty("target").GetString(),"actual-saved-literal");
                i.Operand=r.GetProperty("source").GetString()!;
            }
            Need(Equal(before,Tree(saved)),"whole-original-semantic-tree-restored");
        }
        File.WriteAllBytes(args[3],bytes);
        Save(args[4],new {passed=true,sourceSha256=HashFile(args[1]),outputSha256=Hash(bytes),selectedStrings=edits.Count,
            completeTreeReadback=true,completeOriginalSemanticTreeRestored=true});
    }
}
