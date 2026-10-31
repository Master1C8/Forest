// Finite quest-display patch; identity-based photo counter provenance stays independent of wording.
using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Text.Json;
using System.Globalization;
using System.Text;
using System.Security.Cryptography;
string Hash(byte[] b)=>Convert.ToHexString(SHA256.HashData(b)).ToLowerInvariant();
var options=new JsonSerializerOptions{WriteIndented=true,Encoder=System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping};
if(args.Length<3)throw new Exception("inspect source.dll inventory.json | patch source.dll targets.json output.dll receipt.json");
var inputHash=Hash(File.ReadAllBytes(args[1]));
var config=JsonDocument.Parse(File.ReadAllText(args[2])).RootElement;
if(inputHash!=config.GetProperty("sourceSha256").GetString())throw new Exception("Exact candidate assembly pin");
string locale=config.GetProperty("locale").GetString()!,culture=config.GetProperty("culture").GetString()!;
if(string.IsNullOrWhiteSpace(locale)||string.IsNullOrWhiteSpace(culture))throw new Exception("Explicit locale and culture required");
using var module=ModuleDefinition.ReadModule(args[1]);
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> ts){foreach(var t in ts){yield return t;foreach(var n in Types(t.NestedTypes))yield return n;}}
string Body(MethodDefinition m){if(!m.HasBody)return "<none>";var xs=m.Body.Instructions;string I(Instruction? x)=>x==null?"end":"@"+xs.IndexOf(x);string O(object? x)=>x switch{null=>"",Instruction a=>I(a),Instruction[] a=>string.Join(",",a.Select(I)),_=>x.ToString()??""};return "locals="+m.Body.InitLocals+":"+string.Join(",",m.Body.Variables.Select(v=>v.VariableType.FullName))+"\n"+string.Join("\n",xs.Select(i=>i.OpCode+" "+O(i.Operand)))+"\n"+string.Join("\n",m.Body.ExceptionHandlers.Select(h=>h.HandlerType+" "+h.CatchType+" "+I(h.TryStart)+" "+I(h.TryEnd)+" "+I(h.HandlerStart)+" "+I(h.HandlerEnd)+" "+I(h.FilterStart)));}
var all=Types(module.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName);var before=all.ToDictionary(p=>p.Key,p=>Body(p.Value));
var originalTree=Proof.Tree(module);
using var noopSource=ModuleDefinition.ReadModule(args[1]);_=Proof.Tree(noopSource);var noopBytes=Proof.Serialize(noopSource);using var noop=ModuleDefinition.ReadModule(new MemoryStream(noopBytes));var beforeTree=Proof.Tree(noop);
string WithoutStack(string body){int a=body.IndexOf('|'),b=body.IndexOf('|',a+1);return body[..(a+1)]+"<calculated-stack>"+body[b..];}
var normalizations=originalTree.Keys.Where(k=>originalTree[k]!=beforeTree[k]).ToArray();
if(!originalTree.Keys.SequenceEqual(beforeTree.Keys)||normalizations.Any(k=>!k.StartsWith("body:")||WithoutStack(originalTree[k])!=WithoutStack(beforeTree[k])))throw new Exception("No-op changed non-stack semantics");
var pane=module.GetType("TheForestOfLove.QuestLogDetailsPane").Methods.Single(m=>m.Name=="UpdateSelectedQuest");var owner=module.GetType("TheForestOfLove.QuestLog");var notify=owner.Methods.Single(m=>m.Name=="OnQuestLogUpdated");var history=owner.Methods.Single(m=>m.Name=="GenerateLogTextHistory");
// These are the complete source-backed visible literal occurrences; identity/control literals excluded.
int[] paneOffsets={0x01fe,0x020e,0x0220,0x0232,0x0244,0x0257,0x02a9,0x041d,0x04a0,0x04ba,0x04d4,0x0506,0x0662,0x067a,0x0692,0x06aa,0x06c2,0x070d,0x08c8};
int[] notifyOffsets={0x00bb,0x00c2,0x00d9,0x00f5,0x0111,0x012d,0x01bc,0x0300,0x033a};
var units=new[]{(pane,paneOffsets),(notify,notifyOffsets)}.SelectMany(pair=>pair.Item2.Select(offset=>{var i=pair.Item1.Body.Instructions.Single(i=>i.Offset==offset);if(i.OpCode!=OpCodes.Ldstr)throw new Exception("Display source opcode");return new{ id="il:Assembly-CSharp.dll/"+pair.Item1.FullName+"/IL_"+offset.ToString("x4"),method=pair.Item1.FullName,offset,instructionIndex=pair.Item1.Body.Instructions.IndexOf(i),source=(string)i.Operand};})).ToArray();
if(units.Length!=28)throw new Exception("Quest literal coverage");
if(args[0]=="inspect"){if(File.Exists(args[2]))throw new Exception("Existing inventory");File.WriteAllText(args[2],JsonSerializer.Serialize(new{schemaVersion=1,sourceSha256=inputHash,units},options)+"\n");return;}
if(args[0]!="patch"||(args.Length!=5&&args.Length!=6)||File.Exists(args[3])||File.Exists(args[4]))throw new Exception("Output arguments");
var targets=config.GetProperty("rows").EnumerateArray().ToDictionary(r=>r.GetProperty("id").GetString()!);if(!units.Select(u=>u.id).ToHashSet().SetEquals(targets.Keys))throw new Exception("Exact quest targets required");
var hudMethod=module.GetType("TheForestOfLove.QuestUpdatedUI").Methods.Single(m=>m.Name=="TryShowNextQueuedNotification");var keyboard=module.GetType("viperOSK.OSK_Keyboard_TFOL").Methods.Single(m=>m.Name=="Generate");
var awake=module.GetType("viperOSK.OSK_Key_TFOL").Methods.Single(m=>m.Name=="Awake");
var modified=args.Length==6?new[]{pane,notify,history,hudMethod,keyboard,awake}:new[]{pane,notify,history,keyboard,awake};var originalInstructions=modified.ToDictionary(m=>m.FullName,m=>m.Body.Instructions.ToArray());var originals=modified.ToDictionary(m=>m.FullName,m=>m.Body.Instructions.Select(i=>(i.OpCode,i.Operand)).ToArray());
// Exact display-only adapters keep every original ldstr operand unchanged.
var literalDisplay=new TypeDefinition("", "VNRevivalDeferredLiteralDisplay", TypeAttributes.Public|TypeAttributes.Abstract|TypeAttributes.Sealed|TypeAttributes.BeforeFieldInit,module.TypeSystem.Object);
if(module.Types.Any(t=>t.Name==literalDisplay.Name))throw new Exception("Quest display already adapted");module.Types.Add(literalDisplay);
foreach(var u in units){var r=targets[u.id];if(r.GetProperty("source").GetString()!=u.source||string.IsNullOrWhiteSpace(r.GetProperty("target").GetString()))throw new Exception("Quest display source/target mismatch");
 var display=new MethodDefinition("Literal_"+literalDisplay.Methods.Count.ToString("D2"),MethodAttributes.Public|MethodAttributes.Static|MethodAttributes.HideBySig,module.TypeSystem.String);
 display.Parameters.Add(new ParameterDefinition("sourceDisplay",ParameterAttributes.None,module.TypeSystem.String));literalDisplay.Methods.Add(display);
 display.Body.GetILProcessor().Append(Instruction.Create(OpCodes.Ldstr,r.GetProperty("target").GetString()!));display.Body.GetILProcessor().Append(Instruction.Create(OpCodes.Ret));
 var method=all[u.method];var originalLoad=originalInstructions[u.method].Single(i=>i.Offset==u.offset);method.Body.GetILProcessor().InsertAfter(originalLoad,Instruction.Create(OpCodes.Call,display));
}
// Expand branches without changing their targets before the exact bounded insertions.
var longs=new Dictionary<OpCode,OpCode>{{OpCodes.Br_S,OpCodes.Br},{OpCodes.Brfalse_S,OpCodes.Brfalse},{OpCodes.Brtrue_S,OpCodes.Brtrue},{OpCodes.Beq_S,OpCodes.Beq},{OpCodes.Bge_S,OpCodes.Bge},{OpCodes.Bgt_S,OpCodes.Bgt},{OpCodes.Ble_S,OpCodes.Ble},{OpCodes.Blt_S,OpCodes.Blt},{OpCodes.Bne_Un_S,OpCodes.Bne_Un},{OpCodes.Bge_Un_S,OpCodes.Bge_Un},{OpCodes.Bgt_Un_S,OpCodes.Bgt_Un},{OpCodes.Ble_Un_S,OpCodes.Ble_Un},{OpCodes.Blt_Un_S,OpCodes.Blt_Un},{OpCodes.Leave_S,OpCodes.Leave}};
foreach(var m in modified)foreach(var i in m.Body.Instructions)if(longs.TryGetValue(i.OpCode,out var op))i.OpCode=op;
var flags=Enumerable.Range(0,3).Select(i=>new FieldDefinition("VNRevivalPhotoHistory"+i,FieldAttributes.Public|FieldAttributes.Static,module.TypeSystem.Boolean)).ToArray();foreach(var f in flags){if(owner.Fields.Any(x=>x.Name==f.Name))throw new Exception("Counter already patched");owner.Fields.Add(f);}
var hp=history.Body.GetILProcessor();void After(ILProcessor il,Instruction at,IEnumerable<Instruction> added){foreach(var i in added){il.InsertAfter(at,i);at=i;}}
var first=history.Body.Instructions[0];foreach(var f in flags){hp.InsertBefore(first,Instruction.Create(OpCodes.Ldc_I4_0));hp.InsertBefore(first,Instruction.Create(OpCodes.Stsfld,f));}
var old=originalInstructions[history.FullName];var dict=(FieldReference)old.Single(i=>i.Offset==0x005c).Operand;var sorted=(FieldReference)old.Single(i=>i.Offset==0x0051).Operand;var getDict=(MethodReference)old.Single(i=>i.Offset==0x0131).Operand;var index=history.Body.Variables[4];
var listType=(GenericInstanceType)sorted.FieldType;var listGet=new MethodReference("get_Item",listType.ElementType.GenericParameters[0],listType){HasThis=true};listGet.Parameters.Add(new ParameterDefinition(module.TypeSystem.Int32));
var entry=module.GetType("TheForestOfLove.Narrative.QuestProgressLogEntry");var dbName=entry.Fields.Single(f=>f.Name=="dbName");var entryQuest=entry.Fields.Single(f=>f.Name=="quest");var qName=module.GetType("TheForestOfLove.Narrative.Quest").Fields.Single(f=>f.Name=="dbName");var eq=(MethodReference)pane.Body.Instructions.First(i=>i.Operand is MethodReference r&&r.FullName=="System.Boolean System.String::op_Equality(System.String,System.String)").Operand;
foreach(var spec in new[]{(0x019c,0),(0x01bc,1),(0x01dc,2)}){
 var at=old.Single(i=>i.Offset==spec.Item1);if(at.OpCode!=OpCodes.Stind_Ref)throw new Exception("History slot boundary");
 // Use the exact root/dictionary/index chosen by the original algorithm, not a second sort or text lookup.
 var seq=new List<Instruction>();void Selected(){seq.Add(Instruction.Create(OpCodes.Ldsfld,dict));seq.Add(Instruction.Create(OpCodes.Ldsfld,sorted));seq.Add(Instruction.Create(OpCodes.Ldloc,index));seq.Add(Instruction.Create(OpCodes.Callvirt,listGet));seq.Add(Instruction.Create(OpCodes.Callvirt,getDict));}
 Selected();seq.Add(Instruction.Create(OpCodes.Ldfld,dbName));seq.Add(Instruction.Create(OpCodes.Ldstr,"MelodyFlipbookQuest_2"));seq.Add(Instruction.Create(OpCodes.Call,eq));Selected();seq.Add(Instruction.Create(OpCodes.Ldfld,entryQuest));seq.Add(Instruction.Create(OpCodes.Ldarg_0));seq.Add(Instruction.Create(OpCodes.Ceq));seq.Add(Instruction.Create(OpCodes.And));seq.Add(Instruction.Create(OpCodes.Ldarg_0));seq.Add(Instruction.Create(OpCodes.Ldfld,qName));seq.Add(Instruction.Create(OpCodes.Ldstr,"MelodyFlipbookQuest"));seq.Add(Instruction.Create(OpCodes.Call,eq));seq.Add(Instruction.Create(OpCodes.And));seq.Add(Instruction.Create(OpCodes.Stsfld,flags[spec.Item2]));After(hp,at,seq);
}
var helper=new MethodDefinition("VNRevivalPhotoCounterSlot",MethodAttributes.Public|MethodAttributes.Static|MethodAttributes.HideBySig,module.TypeSystem.Boolean);helper.Parameters.Add(new ParameterDefinition("slot",ParameterAttributes.None,module.TypeSystem.Int32));helper.Parameters.Add(new ParameterDefinition("completed",ParameterAttributes.None,module.TypeSystem.Boolean));owner.Methods.Add(helper);var hi=helper.Body.GetILProcessor();var choose=Instruction.Create(OpCodes.Ldarg_0);var cases=flags.Select(f=>Instruction.Create(OpCodes.Ldsfld,f)).ToArray();
foreach(var i in new[]{Instruction.Create(OpCodes.Ldarg_1),Instruction.Create(OpCodes.Brfalse,choose),Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldc_I4_1),Instruction.Create(OpCodes.Sub),Instruction.Create(OpCodes.Starg,helper.Parameters[0]),choose,Instruction.Create(OpCodes.Switch,cases),Instruction.Create(OpCodes.Ldc_I4_0),Instruction.Create(OpCodes.Ret)})hi.Append(i);foreach(var i in cases){hi.Append(i);hi.Append(Instruction.Create(OpCodes.Ret));}
var pp=pane.Body.GetILProcessor();var getStatus=(MethodReference)pane.Body.Instructions.First(i=>i.Operand is MethodReference r&&r.Name=="get_status").Operand;
foreach(var spec in new[]{(0x0999,0),(0x09f0,1),(0x0a47,2)}){var at=originalInstructions[pane.FullName].Single(i=>i.Offset==spec.Item1);var contains=at.Next;if(at.OpCode!=OpCodes.Ldstr||(string)at.Operand!="lost photos"||contains.Operand is not MethodReference r||r.Name!="Contains")throw new Exception("Photo predicate source");at.OpCode=OpCodes.Pop;at.Operand=null;contains.OpCode=OpCodes.Ldc_I4;contains.Operand=spec.Item2;After(pp,contains,new[]{Instruction.Create(OpCodes.Ldarg_1),Instruction.Create(OpCodes.Callvirt,getStatus),Instruction.Create(OpCodes.Ldc_I4,200),Instruction.Create(OpCodes.Ceq),Instruction.Create(OpCodes.Call,helper)});}
// Preserve the original Assign receiver and all arguments. Only its resulting caption changes.
var specialType=module.GetType("viperOSK.OSK_SpecialKeys");
var keyType=module.GetType("viperOSK.OSK_Key_TFOL");
var keyBase=module.GetType("viperOSK.OSK_Key");
var displayType=new TypeDefinition("", "VNRevivalSpecialKeyDisplay", TypeAttributes.Public|TypeAttributes.Abstract|TypeAttributes.Sealed|TypeAttributes.BeforeFieldInit,module.TypeSystem.Object);
if(module.Types.Any(t=>t.Name==displayType.Name))throw new Exception("OSK already adapted");module.Types.Add(displayType);
var caption=new MethodDefinition("Caption",MethodAttributes.Public|MethodAttributes.Static|MethodAttributes.HideBySig,module.TypeSystem.String);
caption.Parameters.Add(new ParameterDefinition("name",ParameterAttributes.None,module.TypeSystem.String));caption.Parameters.Add(new ParameterDefinition("key",ParameterAttributes.None,module.TypeSystem.Int32));displayType.Methods.Add(caption);
var ci=caption.Body.GetILProcessor();var captions=config.GetProperty("captions").EnumerateArray().ToArray();
if(captions.Length==0)throw new Exception("OSK caption rows required");var seenCaptions=new HashSet<string>();
foreach(var r in captions){string source=r.GetProperty("source").GetString()!,target=r.GetProperty("target").GetString()!;int code=r.GetProperty("keycode").GetInt32();
 if(!seenCaptions.Add(code+":"+source)||string.IsNullOrEmpty(source)||string.IsNullOrEmpty(target))throw new Exception("Unique nonempty OSK mapping");
 var next=Instruction.Create(OpCodes.Nop);
 foreach(var i in new[]{Instruction.Create(OpCodes.Ldarg_1),Instruction.Create(OpCodes.Ldc_I4,code),Instruction.Create(OpCodes.Bne_Un,next),Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldstr,source),Instruction.Create(OpCodes.Call,eq),Instruction.Create(OpCodes.Brfalse,next),Instruction.Create(OpCodes.Ldstr,target),Instruction.Create(OpCodes.Ret),next})ci.Append(i);
}
ci.Append(Instruction.Create(OpCodes.Ldarg_0));ci.Append(Instruction.Create(OpCodes.Ret));
var apply=new MethodDefinition("Apply",MethodAttributes.Public|MethodAttributes.Static|MethodAttributes.HideBySig,module.TypeSystem.Void);
apply.Parameters.Add(new ParameterDefinition("key",ParameterAttributes.None,keyType));apply.Parameters.Add(new ParameterDefinition("spec",ParameterAttributes.None,specialType));displayType.Methods.Add(apply);
var ai=apply.Body.GetILProcessor();var keyName=keyBase.Fields.Single(f=>f.Name=="keyName");
var setText=(MethodReference)keyBase.Methods.Single(m=>m.Name=="Assign").Body.Instructions.First(i=>i.Operand is MethodReference r&&r.FullName=="System.Void TMPro.TMP_Text::set_text(System.String)").Operand;
// The original private cache is written from an injected method owned by its declaring type.
var cacheField=keyType.Fields.Single(f=>f.Name=="defaultLabelText");var codeField=keyBase.Fields.Single(f=>f.Name=="key");
var setDefault=new MethodDefinition("VNRevivalSetDisplayDefault",MethodAttributes.Public|MethodAttributes.HideBySig,module.TypeSystem.Void);
setDefault.Parameters.Add(new ParameterDefinition("caption",ParameterAttributes.None,module.TypeSystem.String));keyType.Methods.Add(setDefault);
var di=setDefault.Body.GetILProcessor();foreach(var i in new[]{Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldarg_1),Instruction.Create(OpCodes.Stfld,cacheField),Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldfld,keyName),Instruction.Create(OpCodes.Ldarg_1),Instruction.Create(OpCodes.Callvirt,setText),Instruction.Create(OpCodes.Ret)})di.Append(i);
// Awake retains its original read/cache assignment and converts that exact display value.
var oldAwake=originalInstructions[awake.FullName];var cacheRead=oldAwake.Single(i=>i.Offset==0x0045);var cacheWrite=oldAwake.Single(i=>i.Offset==0x004a);
if(cacheRead.Operand is not MethodReference cacheGet||cacheGet.FullName!="System.String TMPro.TMP_Text::get_text()"||cacheWrite.Operand is not FieldReference cf||cf.FullName!=cacheField.FullName)throw new Exception("Awake cache boundary changed");
After(awake.Body.GetILProcessor(),cacheRead,new[]{Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldfld,codeField),Instruction.Create(OpCodes.Call,caption)});
After(awake.Body.GetILProcessor(),cacheWrite,new[]{Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldfld,cacheField),Instruction.Create(OpCodes.Call,setDefault)});
var noChange=Instruction.Create(OpCodes.Ret);var targetLocal=new VariableDefinition(module.TypeSystem.String);apply.Body.Variables.Add(targetLocal);apply.Body.InitLocals=true;
foreach(var i in new[]{Instruction.Create(OpCodes.Ldarg_1),Instruction.Create(OpCodes.Ldfld,specialType.Fields.Single(f=>f.Name=="name")),Instruction.Create(OpCodes.Ldarg_1),Instruction.Create(OpCodes.Ldfld,specialType.Fields.Single(f=>f.Name=="keycode")),Instruction.Create(OpCodes.Call,caption),Instruction.Create(OpCodes.Stloc,targetLocal),Instruction.Create(OpCodes.Ldloc,targetLocal),Instruction.Create(OpCodes.Ldarg_1),Instruction.Create(OpCodes.Ldfld,specialType.Fields.Single(f=>f.Name=="name")),Instruction.Create(OpCodes.Call,eq),Instruction.Create(OpCodes.Brtrue,noChange),Instruction.Create(OpCodes.Ldarg_0),Instruction.Create(OpCodes.Ldloc,targetLocal),Instruction.Create(OpCodes.Call,setDefault),noChange})ai.Append(i);
var assignAt=originalInstructions[keyboard.FullName].Single(i=>i.Offset==0x032a);
if(assignAt.Operand is not MethodReference assign || assign.FullName!="System.Void viperOSK.OSK_Key::Assign(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES,System.String)")throw new Exception("OSK Assign consumer changed");
var keyLocal=keyboard.Body.Variables[11];var specialLocal=keyboard.Body.Variables[13];if(keyLocal.VariableType.FullName!=keyType.FullName||specialLocal.VariableType.FullName!=specialType.FullName)throw new Exception("OSK local identity");
After(keyboard.Body.GetILProcessor(),assignAt,new[]{Instruction.Create(OpCodes.Ldloc,keyLocal),Instruction.Create(OpCodes.Ldloc,specialLocal),Instruction.Create(OpCodes.Call,apply)});
int hudLayoutHookCount=0;int layoutHookRetCount=0;string? layoutAssemblySha256=null;
if(args.Length==6){using var layout=ModuleDefinition.ReadModule(args[5]);var layoutApply=layout.GetType("VNRevivalQuestLayout").Methods.Single(m=>m.Name=="Apply");var reference=module.ImportReference(layoutApply);layoutAssemblySha256=Hash(File.ReadAllBytes(args[5]));foreach(var ret in pane.Body.Instructions.Where(i=>i.OpCode==OpCodes.Ret).ToArray()){ret.OpCode=OpCodes.Ldarg_0;After(pp,ret,new[]{Instruction.Create(OpCodes.Call,reference),Instruction.Create(OpCodes.Ret)});layoutHookRetCount++;}if(layoutHookRetCount!=1)throw new Exception("Unexpected Quest pane return count");
var hudApply=module.ImportReference(layout.GetType("VNRevivalQuestLayout").Methods.Single(m=>m.Name=="ApplyHud"));var at=originalInstructions[hudMethod.FullName].Single(i=>i.Offset==0x008e);if(at.OpCode!=OpCodes.Ldarg_0||at.Next.Operand is not MethodReference reset||reset.Name!="ResetAnimatorTriggers")throw new Exception("Unexpected HUD renderer boundary");After(hudMethod.Body.GetILProcessor(),at,new[]{Instruction.Create(OpCodes.Call,hudApply),Instruction.Create(OpCodes.Ldarg_0)});hudLayoutHookCount++;}
var originalPositions=modified.ToDictionary(m=>m.FullName,m=>originalInstructions[m.FullName].Select(i=>m.Body.Instructions.IndexOf(i)).ToArray());var expected=Types(module.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName,m=>Body(m));module.Write(args[3]);var expectedTree=Proof.Tree(module);
using var back=ModuleDefinition.ReadModule(args[3]);if(!Proof.Equal(expectedTree,Proof.Tree(back)))throw new Exception("Complete semantic tree readback");var after=Types(back.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName);if(!expected.Keys.ToHashSet().SetEquals(after.Keys)||expected.Any(p=>Body(after[p.Key])!=p.Value))throw new Exception("Complete IL readback mismatch");var changed=before.Keys.Where(k=>before[k]!=Body(after[k])).ToArray();if(!changed.ToHashSet().SetEquals(modified.Select(m=>m.FullName)))throw new Exception("Unexpected changed methods");
// Reverse exact inserted instructions and original opcodes/operands; all original bodies must restore.
foreach(var m in modified){var rb=after[m.FullName];var keep=originalPositions[m.FullName].Select(i=>rb.Body.Instructions[i]).ToArray();object? Restore(object? operand,int pos)=>operand switch{Instruction i=>keep[Array.IndexOf(originalInstructions[m.FullName],i)],Instruction[] xs=>xs.Select(i=>keep[Array.IndexOf(originalInstructions[m.FullName],i)]).ToArray(),MethodReference r=>keep[pos].Operand is MethodReference current&&current.FullName==r.FullName?current:back.GetMemberReferences().OfType<MethodReference>().First(x=>x.FullName==r.FullName),FieldReference f=>keep[pos].Operand is FieldReference currentField&&currentField.FullName==f.FullName?currentField:back.GetMemberReferences().OfType<FieldReference>().First(x=>x.FullName==f.FullName),TypeReference t=>keep[pos].Operand is TypeReference currentType&&currentType.FullName==t.FullName?currentType:back.GetTypeReferences().First(x=>x.FullName==t.FullName),_=>operand};for(int i=0;i<keep.Length;i++){keep[i].OpCode=originals[m.FullName][i].OpCode;keep[i].Operand=Restore(originals[m.FullName][i].Operand,i);}rb.Body.Instructions.Clear();foreach(var i in keep)rb.Body.Instructions.Add(i);}
if(before.Any(p=>Body(after[p.Key])!=p.Value))throw new Exception("Original method restoration failed");
var backOwner=back.GetType(owner.FullName);foreach(var f in flags)backOwner.Fields.Remove(backOwner.Fields.Single(x=>x.Name==f.Name));backOwner.Methods.Remove(backOwner.Methods.Single(x=>x.Name==helper.Name));var backKey=back.GetType(keyType.FullName);backKey.Methods.Remove(backKey.Methods.Single(x=>x.Name==setDefault.Name));back.Types.Remove(back.GetType(displayType.FullName));back.Types.Remove(back.GetType(literalDisplay.FullName));
var reversedBytes=Proof.Serialize(back);using var reversed=ModuleDefinition.ReadModule(new MemoryStream(reversedBytes));var reversedTree=Proof.Tree(reversed);if(!Proof.Equal(beforeTree,reversedTree)){File.WriteAllText(args[4]+".failure.json",JsonSerializer.Serialize(beforeTree.Keys.Union(reversedTree.Keys).Where(k=>beforeTree.GetValueOrDefault(k)!=reversedTree.GetValueOrDefault(k)).Select(k=>new{key=k,before=beforeTree.GetValueOrDefault(k),after=reversedTree.GetValueOrDefault(k)}),options));throw new Exception("Complete original semantic tree restoration");}
File.WriteAllText(args[4],JsonSerializer.Serialize(new{sourceSha256=inputHash,targetSha256=Hash(File.ReadAllBytes(args[3])),locale,culture,displayOperands=28,injectedLiteralAdapters=28,original28DisplayLdstrOperandsPreserved=true,oskSelectorCount=config.GetProperty("oskSelectors").GetArrayLength(),oskHookCount=1,oskAwakeCacheHookCount=1,oskGeneratedCacheAndCaptionUpdatedTogether=true,oskFunctionalArgumentsPreserved=true,completeTreeReadback=true,completeOriginalSemanticTreeRestored=true,sourceStackHeaderNormalizations=normalizations,hudLayoutHookCount,layoutHookRetCount,layoutAssemblySha256,changedMethods=changed,addedMethod=helper.FullName,addedRuntimeOnlyBooleanFields=flags.Select(f=>f.FullName),counter="Original history selection provenance,3 slots,completion shift;independent of localized wording",wholeMethodInventoryReadback=true,publicationBoundary="One DLL then receipt; shared Python publisher commits candidate manifest last. Not a transaction",allOriginalBodiesRestored=true,sourceControlOperandsPreservedExceptExplicitThreePhotoPredicates=true,saveSchemaChanged=false},options)+"\n");

static class Proof {
    static readonly JsonSerializerOptions Json = new(){WriteIndented=true};
    public static string Hash(byte[] b) => Convert.ToHexString(SHA256.HashData(b)).ToLowerInvariant();
    public static string HashFile(string p) => Hash(File.ReadAllBytes(p));
    public static void Need(bool b, string s) { if (!b) throw new InvalidOperationException(s); }
    public static void Save(string p, object o) => File.WriteAllText(p, JsonSerializer.Serialize(o,Json)+"\n");
    public static IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> ts) { foreach (var t in ts) { yield return t; foreach(var n in Types(t.NestedTypes)) yield return n; } }
    public static Dictionary<string,MethodDefinition> Methods(ModuleDefinition m) => Types(m.Types).SelectMany(t=>t.Methods).ToDictionary(t=>t.FullName);
    public static Instruction At(MethodDefinition m,int off) => m.Body.Instructions.Single(i=>i.Offset==off);
    public static string Attrs(Mono.Cecil.ICustomAttributeProvider p) => string.Join(";", p.CustomAttributes.Select(a=>a.Constructor.FullName+":"+Convert.ToHexString(a.GetBlob())));
    public static string Generic(IGenericParameterProvider p) => string.Join(";",p.GenericParameters.Select(g=>g.Name+":"+g.Attributes+":"+Attrs(g)+":"+string.Join(",",g.Constraints.Select(c=>c.ConstraintType.FullName+":"+Attrs(c)))));
    public static string Constant(object? x) => x==null?"null":x.GetType().FullName+":"+(x is IFormattable f?f.ToString(null,CultureInfo.InvariantCulture):JsonSerializer.Serialize(x));
    public static string Def(MethodDefinition m) => string.Join("|",m.FullName,m.Attributes,m.ImplAttributes,m.CallingConvention,m.SemanticsAttributes,Generic(m),Attrs(m),
        string.Join(";",m.Parameters.Select(p=>p.Name+":"+p.Attributes+":"+p.ParameterType.FullName+":"+Constant(p.HasConstant?p.Constant:null)+":"+Attrs(p))),
        m.MethodReturnType.Attributes+":"+Attrs(m.MethodReturnType),string.Join(";",m.Overrides.Select(o=>o.FullName)),m.HasPInvokeInfo?m.PInvokeInfo.Attributes+":"+m.PInvokeInfo.Module.Name+":"+m.PInvokeInfo.EntryPoint:"");
    public static string Body(MethodDefinition m, bool skeleton=false) {
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
    public static SortedDictionary<string,string> Tree(ModuleDefinition m) {
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
    public static bool Equal(SortedDictionary<string,string> a,SortedDictionary<string,string> b) => a.Count==b.Count && a.All(p=>b.TryGetValue(p.Key,out var s)&&s==p.Value);
    public static byte[] Serialize(ModuleDefinition m) { using var s=new MemoryStream();m.Write(s);return s.ToArray(); }
}
