TYPE TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests
METHOD System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::IsConditionSatisfied() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean Globals::Debug_DisableDialoguePrecondition_PrecedingQuests
IL_0005: brfalse.s IL_0009
IL_0007: ldc.i4.1
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::negateCondition
IL_000f: brfalse IL_00a8
IL_0014: ldarg.0
IL_0015: ldfld System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::requireAll
IL_001a: brfalse.s IL_006a
IL_001c: ldc.i4.1
IL_001d: stloc.0
IL_001e: ldarg.0
IL_001f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::quests
IL_0024: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::GetEnumerator()
IL_0029: stloc.1
IL_002a: br.s IL_003d
IL_002c: ldloca.s V_1
IL_002e: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::get_Current()
IL_0033: stloc.2
IL_0034: ldloc.0
IL_0035: ldloc.2
IL_0036: callvirt System.Boolean TheForestOfLove.Narrative.Quest::get_isCompleted()
IL_003b: and
IL_003c: stloc.0
IL_003d: ldloca.s V_1
IL_003f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::MoveNext()
IL_0044: brtrue.s IL_002c
IL_0046: leave.s IL_0056
IL_0048: ldloca.s V_1
IL_004a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>
IL_0050: callvirt System.Void System.IDisposable::Dispose()
IL_0055: endfinally
IL_0056: ldloc.0
IL_0057: brtrue.s IL_0068
IL_0059: ldarg.0
IL_005a: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::quests
IL_005f: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::get_Count()
IL_0064: ldc.i4.0
IL_0065: ceq
IL_0067: ret
IL_0068: ldc.i4.1
IL_0069: ret
IL_006a: ldarg.0
IL_006b: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::quests
IL_0070: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::GetEnumerator()
IL_0075: stloc.1
IL_0076: br.s IL_008d
IL_0078: ldloca.s V_1
IL_007a: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::get_Current()
IL_007f: callvirt System.Boolean TheForestOfLove.Narrative.Quest::get_isCompleted()
IL_0084: brfalse.s IL_008d
IL_0086: ldc.i4.0
IL_0087: stloc.3
IL_0088: leave IL_0133
IL_008d: ldloca.s V_1
IL_008f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::MoveNext()
IL_0094: brtrue.s IL_0078
IL_0096: leave.s IL_00a6
IL_0098: ldloca.s V_1
IL_009a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>
IL_00a0: callvirt System.Void System.IDisposable::Dispose()
IL_00a5: endfinally
IL_00a6: ldc.i4.1
IL_00a7: ret
IL_00a8: ldarg.0
IL_00a9: ldfld System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::requireAll
IL_00ae: brfalse.s IL_00eb
IL_00b0: ldarg.0
IL_00b1: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::quests
IL_00b6: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::GetEnumerator()
IL_00bb: stloc.1
IL_00bc: br.s IL_00d0
IL_00be: ldloca.s V_1
IL_00c0: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::get_Current()
IL_00c5: callvirt System.Boolean TheForestOfLove.Narrative.Quest::get_isCompleted()
IL_00ca: brtrue.s IL_00d0
IL_00cc: ldc.i4.0
IL_00cd: stloc.3
IL_00ce: leave.s IL_0133
IL_00d0: ldloca.s V_1
IL_00d2: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::MoveNext()
IL_00d7: brtrue.s IL_00be
IL_00d9: leave.s IL_00e9
IL_00db: ldloca.s V_1
IL_00dd: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>
IL_00e3: callvirt System.Void System.IDisposable::Dispose()
IL_00e8: endfinally
IL_00e9: ldc.i4.1
IL_00ea: ret
IL_00eb: ldarg.0
IL_00ec: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::quests
IL_00f1: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::GetEnumerator()
IL_00f6: stloc.1
IL_00f7: br.s IL_010b
IL_00f9: ldloca.s V_1
IL_00fb: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::get_Current()
IL_0100: callvirt System.Boolean TheForestOfLove.Narrative.Quest::get_isCompleted()
IL_0105: brfalse.s IL_010b
IL_0107: ldc.i4.1
IL_0108: stloc.3
IL_0109: leave.s IL_0133
IL_010b: ldloca.s V_1
IL_010d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::MoveNext()
IL_0112: brtrue.s IL_00f9
IL_0114: leave.s IL_0124
IL_0116: ldloca.s V_1
IL_0118: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>
IL_011e: callvirt System.Void System.IDisposable::Dispose()
IL_0123: endfinally
IL_0124: ldarg.0
IL_0125: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::quests
IL_012a: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::get_Count()
IL_012f: ldc.i4.0
IL_0130: ceq
IL_0132: ret
IL_0133: ldloc.3
IL_0134: ret
