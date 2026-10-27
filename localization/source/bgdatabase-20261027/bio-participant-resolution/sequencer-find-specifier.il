TYPE PixelCrushers.DialogueSystem.SequencerTools
METHOD UnityEngine.GameObject PixelCrushers.DialogueSystem.SequencerTools::FindSpecifier(System.String,System.Boolean) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0006: brfalse.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: call System.Boolean PixelCrushers.DialogueSystem.SequencerTools::SpecifierSpecifiesTag(System.String)
IL_0010: brfalse.s IL_003f
IL_0012: ldarg.0
IL_0013: call System.String PixelCrushers.DialogueSystem.SequencerTools::GetSpecifiedTag(System.String)
IL_0018: stloc.2
IL_0019: ldloc.2
IL_001a: call UnityEngine.GameObject UnityEngine.GameObject::FindGameObjectWithTag(System.String)
IL_001f: stloc.3
IL_0020: ldloc.3
IL_0021: ldnull
IL_0022: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0027: brfalse.s IL_002b
IL_0029: ldloc.3
IL_002a: ret
IL_002b: ldloc.2
IL_002c: call UnityEngine.GameObject[] PixelCrushers.DialogueSystem.Tools::FindGameObjectsWithTagHard(System.String)
IL_0031: stloc.s V_4
IL_0033: ldloc.s V_4
IL_0035: ldlen
IL_0036: brtrue.s IL_003a
IL_0038: ldnull
IL_0039: ret
IL_003a: ldloc.s V_4
IL_003c: ldc.i4.0
IL_003d: ldelem.ref
IL_003e: ret
IL_003f: ldarg.0
IL_0040: call UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::GetRegisteredActorTransform(System.String)
IL_0045: stloc.0
IL_0046: ldloc.0
IL_0047: ldnull
IL_0048: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_004d: brfalse.s IL_0056
IL_004f: ldloc.0
IL_0050: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0055: ret
IL_0056: ldarg.0
IL_0057: call UnityEngine.GameObject UnityEngine.GameObject::Find(System.String)
IL_005c: stloc.1
IL_005d: ldloc.1
IL_005e: ldnull
IL_005f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0064: brfalse.s IL_0068
IL_0066: ldloc.1
IL_0067: ret
IL_0068: ldarg.1
IL_0069: brfalse.s IL_006d
IL_006b: ldnull
IL_006c: ret
IL_006d: ldarg.0
IL_006e: call UnityEngine.GameObject PixelCrushers.DialogueSystem.Tools::GameObjectHardFind(System.String)
IL_0073: stloc.1
IL_0074: ldloc.1
IL_0075: ldnull
IL_0076: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_007b: brfalse.s IL_007f
IL_007d: ldloc.1
IL_007e: ret
IL_007f: ldtoken UnityEngine.GameObject
IL_0084: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0089: call UnityEngine.Object[] UnityEngine.Resources::FindObjectsOfTypeAll(System.Type)
IL_008e: isinst UnityEngine.GameObject[]
IL_0093: stloc.s V_5
IL_0095: ldc.i4.0
IL_0096: stloc.s V_6
IL_0098: br.s IL_00ba
IL_009a: ldloc.s V_5
IL_009c: ldloc.s V_6
IL_009e: ldelem.ref
IL_009f: stloc.s V_7
IL_00a1: ldarg.0
IL_00a2: ldloc.s V_7
IL_00a4: callvirt System.String UnityEngine.Object::get_name()
IL_00a9: ldc.i4.5
IL_00aa: call System.Int32 System.String::Compare(System.String,System.String,System.StringComparison)
IL_00af: brtrue.s IL_00b4
IL_00b1: ldloc.s V_7
IL_00b3: ret
IL_00b4: ldloc.s V_6
IL_00b6: ldc.i4.1
IL_00b7: add
IL_00b8: stloc.s V_6
IL_00ba: ldloc.s V_6
IL_00bc: ldloc.s V_5
IL_00be: ldlen
IL_00bf: conv.i4
IL_00c0: blt.s IL_009a
IL_00c2: ldnull
IL_00c3: ret
