TYPE Itelisoft.KOF.TheKingOfJoysticks
METHOD System.Void Itelisoft.KOF.TheKingOfJoysticks::UpdateTouchMode()
IL_0000: ldc.i4.0
IL_0001: stloc.1
IL_0002: br.s IL_004f
IL_0004: call UnityEngine.Touch[] UnityEngine.Input::get_touches()
IL_0009: ldloc.1
IL_000a: ldelem.any UnityEngine.Touch
IL_000f: stloc.2
IL_0010: ldarg.0
IL_0011: ldfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::inUse
IL_0016: brtrue.s IL_004b
IL_0018: ldloca.s V_2
IL_001a: call UnityEngine.TouchPhase UnityEngine.Touch::get_phase()
IL_001f: brtrue.s IL_004b
IL_0021: ldarg.0
IL_0022: ldloca.s V_2
IL_0024: call UnityEngine.Vector2 UnityEngine.Touch::get_position()
IL_0029: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_002e: call System.Boolean Itelisoft.KOF.TheKingOfJoysticks::IsPositionOutOfBounds(UnityEngine.Vector3)
IL_0033: brtrue.s IL_004b
IL_0035: ldarg.0
IL_0036: ldc.i4.1
IL_0037: stfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::inUse
IL_003c: ldarg.0
IL_003d: ldarg.0
IL_003e: call System.Collections.IEnumerator Itelisoft.KOF.TheKingOfJoysticks::ValidateTouchMode()
IL_0043: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_0048: pop
IL_0049: br.s IL_0059
IL_004b: ldloc.1
IL_004c: ldc.i4.1
IL_004d: add
IL_004e: stloc.1
IL_004f: ldloc.1
IL_0050: call UnityEngine.Touch[] UnityEngine.Input::get_touches()
IL_0055: ldlen
IL_0056: conv.i4
IL_0057: blt.s IL_0004
IL_0059: ldarg.0
IL_005a: ldfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::inUse
IL_005f: brfalse.s IL_00b7
IL_0061: ldc.i4.0
IL_0062: stloc.3
IL_0063: br.s IL_00ad
IL_0065: call UnityEngine.Touch[] UnityEngine.Input::get_touches()
IL_006a: ldloc.3
IL_006b: ldelem.any UnityEngine.Touch
IL_0070: stloc.s V_4
IL_0072: ldarg.0
IL_0073: ldloca.s V_4
IL_0075: call UnityEngine.Vector2 UnityEngine.Touch::get_position()
IL_007a: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_007f: call System.Boolean Itelisoft.KOF.TheKingOfJoysticks::IsPositionOutOfBounds(UnityEngine.Vector3)
IL_0084: brtrue.s IL_00a9
IL_0086: ldloca.s V_4
IL_0088: call UnityEngine.TouchPhase UnityEngine.Touch::get_phase()
IL_008d: ldc.i4.1
IL_008e: beq.s IL_009a
IL_0090: ldloca.s V_4
IL_0092: call UnityEngine.TouchPhase UnityEngine.Touch::get_phase()
IL_0097: ldc.i4.2
IL_0098: bne.un.s IL_00a9
IL_009a: ldarg.0
IL_009b: ldloca.s V_4
IL_009d: call UnityEngine.Vector2 UnityEngine.Touch::get_position()
IL_00a2: call System.Void Itelisoft.KOF.TheKingOfJoysticks::TranslateCenter(UnityEngine.Vector2)
IL_00a7: br.s IL_00b7
IL_00a9: ldloc.3
IL_00aa: ldc.i4.1
IL_00ab: add
IL_00ac: stloc.3
IL_00ad: ldloc.3
IL_00ae: call UnityEngine.Touch[] UnityEngine.Input::get_touches()
IL_00b3: ldlen
IL_00b4: conv.i4
IL_00b5: blt.s IL_0065
IL_00b7: ldarg.0
IL_00b8: ldfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::inUse
IL_00bd: brfalse.s IL_0112
IL_00bf: ldc.i4.0
IL_00c0: stloc.s V_5
IL_00c2: br.s IL_0107
IL_00c4: call UnityEngine.Touch[] UnityEngine.Input::get_touches()
IL_00c9: ldloc.s V_5
IL_00cb: ldelem.any UnityEngine.Touch
IL_00d0: stloc.s V_6
IL_00d2: ldloca.s V_6
IL_00d4: call UnityEngine.TouchPhase UnityEngine.Touch::get_phase()
IL_00d9: ldc.i4.3
IL_00da: beq.s IL_00e6
IL_00dc: ldloca.s V_6
IL_00de: call UnityEngine.TouchPhase UnityEngine.Touch::get_phase()
IL_00e3: ldc.i4.4
IL_00e4: bne.un.s IL_0101
IL_00e6: ldarg.0
IL_00e7: ldloca.s V_6
IL_00e9: call UnityEngine.Vector2 UnityEngine.Touch::get_position()
IL_00ee: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_00f3: call System.Boolean Itelisoft.KOF.TheKingOfJoysticks::IsPositionOutOfBounds(UnityEngine.Vector3)
IL_00f8: brtrue.s IL_0101
IL_00fa: ldarg.0
IL_00fb: call System.Void Itelisoft.KOF.TheKingOfJoysticks::EndUsingJoystick()
IL_0100: ret
IL_0101: ldloc.s V_5
IL_0103: ldc.i4.1
IL_0104: add
IL_0105: stloc.s V_5
IL_0107: ldloc.s V_5
IL_0109: call UnityEngine.Touch[] UnityEngine.Input::get_touches()
IL_010e: ldlen
IL_010f: conv.i4
IL_0110: blt.s IL_00c4
IL_0112: ret
METHOD System.Collections.IEnumerator Itelisoft.KOF.TheKingOfJoysticks::ValidateTouchMode()
IL_0000: ldc.i4.0
IL_0001: newobj System.Void Itelisoft.KOF.TheKingOfJoysticks/<ValidateTouchMode>d__63::.ctor(System.Int32)
IL_0006: dup
IL_0007: ldarg.0
IL_0008: stfld Itelisoft.KOF.TheKingOfJoysticks Itelisoft.KOF.TheKingOfJoysticks/<ValidateTouchMode>d__63::<>4__this
IL_000d: ret
