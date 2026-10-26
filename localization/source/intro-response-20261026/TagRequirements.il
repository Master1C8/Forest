TYPE TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags
METHOD System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::IsConditionSatisfied()
IL_0000: ldsfld System.Boolean Globals::Debug_DisableDialoguePrecondition_PrecedingTags
IL_0005: brfalse.s IL_0009
IL_0007: ldc.i4.1
IL_0008: ret
IL_0009: call System.Boolean TheForestOfLove.Narrative.StoryManager::get_BypassPreconditionsForSingleDialogue()
IL_000e: brfalse.s IL_0012
IL_0010: ldc.i4.1
IL_0011: ret
IL_0012: ldarg.0
IL_0013: ldfld System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::negateCondition
IL_0018: brfalse IL_00bb
IL_001d: ldarg.0
IL_001e: ldfld System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::requireAll
IL_0023: brfalse.s IL_0078
IL_0025: ldc.i4.1
IL_0026: stloc.0
IL_0027: ldarg.0
IL_0028: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::tags
IL_002d: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_0032: stloc.1
IL_0033: br.s IL_004b
IL_0035: ldloca.s V_1
IL_0037: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_003c: stloc.2
IL_003d: ldloc.0
IL_003e: ldloc.2
IL_003f: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_0044: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_0049: and
IL_004a: stloc.0
IL_004b: ldloca.s V_1
IL_004d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_0052: brtrue.s IL_0035
IL_0054: leave.s IL_0064
IL_0056: ldloca.s V_1
IL_0058: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_005e: callvirt System.Void System.IDisposable::Dispose()
IL_0063: endfinally
IL_0064: ldloc.0
IL_0065: brtrue.s IL_0076
IL_0067: ldarg.0
IL_0068: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::tags
IL_006d: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::get_Count()
IL_0072: ldc.i4.0
IL_0073: ceq
IL_0075: ret
IL_0076: ldc.i4.1
IL_0077: ret
IL_0078: ldarg.0
IL_0079: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::tags
IL_007e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_0083: stloc.1
IL_0084: br.s IL_00a0
IL_0086: ldloca.s V_1
IL_0088: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_008d: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_0092: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_0097: brfalse.s IL_00a0
IL_0099: ldc.i4.0
IL_009a: stloc.3
IL_009b: leave IL_0150
IL_00a0: ldloca.s V_1
IL_00a2: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_00a7: brtrue.s IL_0086
IL_00a9: leave.s IL_00b9
IL_00ab: ldloca.s V_1
IL_00ad: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_00b3: callvirt System.Void System.IDisposable::Dispose()
IL_00b8: endfinally
IL_00b9: ldc.i4.1
IL_00ba: ret
IL_00bb: ldarg.0
IL_00bc: ldfld System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::requireAll
IL_00c1: brfalse.s IL_0103
IL_00c3: ldarg.0
IL_00c4: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::tags
IL_00c9: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_00ce: stloc.1
IL_00cf: br.s IL_00e8
IL_00d1: ldloca.s V_1
IL_00d3: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_00d8: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_00dd: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_00e2: brtrue.s IL_00e8
IL_00e4: ldc.i4.0
IL_00e5: stloc.3
IL_00e6: leave.s IL_0150
IL_00e8: ldloca.s V_1
IL_00ea: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_00ef: brtrue.s IL_00d1
IL_00f1: leave.s IL_0101
IL_00f3: ldloca.s V_1
IL_00f5: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_00fb: callvirt System.Void System.IDisposable::Dispose()
IL_0100: endfinally
IL_0101: ldc.i4.1
IL_0102: ret
IL_0103: ldarg.0
IL_0104: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::tags
IL_0109: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_010e: stloc.1
IL_010f: br.s IL_0128
IL_0111: ldloca.s V_1
IL_0113: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_0118: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_011d: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_0122: brfalse.s IL_0128
IL_0124: ldc.i4.1
IL_0125: stloc.3
IL_0126: leave.s IL_0150
IL_0128: ldloca.s V_1
IL_012a: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_012f: brtrue.s IL_0111
IL_0131: leave.s IL_0141
IL_0133: ldloca.s V_1
IL_0135: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_013b: callvirt System.Void System.IDisposable::Dispose()
IL_0140: endfinally
IL_0141: ldarg.0
IL_0142: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::tags
IL_0147: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::get_Count()
IL_014c: ldc.i4.0
IL_014d: ceq
IL_014f: ret
IL_0150: ldloc.3
IL_0151: ret
