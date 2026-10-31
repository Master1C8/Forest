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
        Need(args.Length==3 && args[0]=="inspect", "inspect assembly.dll fresh.json");
        Need(!File.Exists(args[2]),"fresh-output");
        using var m=ModuleDefinition.ReadModule(args[1]);
        var methods=Methods(m).Values.Where(x=>x.HasBody && (x.DeclaringType.FullName=="TheForestOfLove.QuestLogDetailsPane" && x.Name=="UpdateSelectedQuest" || x.DeclaringType.FullName=="TheForestOfLove.QuestLog" && new[]{"OnQuestLogUpdated","GenerateLogTextHistory","VNRevivalPhotoCounterSlot"}.Contains(x.Name) || x.DeclaringType.FullName.StartsWith("VNRevivalDeferredLiteralDisplay") || x.DeclaringType.FullName.StartsWith("VNRevivalSpecialKeyDisplay") || x.DeclaringType.FullName.StartsWith("viperOSK.") && new[]{"Assign","Relabel","Awake","Generate","VNRevivalSetDisplayDefault"}.Contains(x.Name)));
        Save(args[2],new{sha256=HashFile(args[1]),methods=methods.Select(x=>new{method=x.FullName,body=Body(x),instructions=x.Body.Instructions.Select(i=>new{offset=i.Offset,index=x.Body.Instructions.IndexOf(i),opcode=i.OpCode.ToString(),operand=i.Operand?.ToString()})})});
    }
}
