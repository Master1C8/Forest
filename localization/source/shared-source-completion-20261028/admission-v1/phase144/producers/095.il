TYPE TheForestOfLove.GossipUI
METHOD System.Void TheForestOfLove.GossipUI::ShowGreeting(System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.GossipUI::greetingVisible
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.r4 0
IL_000f: stfld System.Single TheForestOfLove.GossipUI::greetingCurrentSeconds
IL_0014: ldarg.0
IL_0015: ldc.i4.1
IL_0016: stfld System.Boolean TheForestOfLove.GossipUI::greetingVisible
IL_001b: ldarg.0
IL_001c: ldfld UnityEngine.Animator TheForestOfLove.GossipUI::greetingAnimator
IL_0021: ldstr "visible"
IL_0026: ldarg.1
IL_0027: ldc.i4.0
IL_0028: ceq
IL_002a: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_002f: ldarg.0
IL_0030: ldfld UnityEngine.Animator TheForestOfLove.GossipUI::greetingAnimatorRight
IL_0035: ldstr "visible"
IL_003a: ldarg.1
IL_003b: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0040: ret
METHOD System.String TheForestOfLove.GossipUI::GenerateTooltipText(TheForestOfLove.GossipUI/GossipItem) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.GossipUI/GossipItem::dialogue
IL_0006: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition> TheForestOfLove.Narrative.Dialogue::preconditions
IL_000b: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::GetEnumerator()
IL_0010: stloc.0
IL_0011: br IL_00a6
IL_0016: ldloca.s V_0
IL_0018: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::get_Current()
IL_001d: stloc.1
IL_001e: ldloc.1
IL_001f: callvirt System.Type System.Object::GetType()
IL_0024: ldtoken TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule
IL_0029: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_002e: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_0033: brfalse.s IL_00a6
IL_0035: ldloc.1
IL_0036: castclass TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule
IL_003b: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::antiTagsAny
IL_0040: stloc.2
IL_0041: ldloc.2
IL_0042: brfalse.s IL_00a6
IL_0044: ldloc.2
IL_0045: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::tags
IL_004a: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_004f: stloc.3
IL_0050: br.s IL_008d
IL_0052: ldloca.s V_3
IL_0054: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_0059: stloc.s V_4
IL_005b: ldloc.s V_4
IL_005d: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_0062: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_0067: brfalse.s IL_008d
IL_0069: ldloc.s V_4
IL_006b: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_0070: stloc.s V_5
IL_0072: ldloc.s V_5
IL_0074: brfalse.s IL_008d
IL_0076: ldloc.s V_5
IL_0078: ldstr "Instanced Event Blessing of the Bells"
IL_007d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0082: brfalse.s IL_008d
IL_0084: ldstr "This gossip is blocked during Blessing of the Bells"
IL_0089: stloc.s V_6
IL_008b: leave.s IL_00c8
IL_008d: ldloca.s V_3
IL_008f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_0094: brtrue.s IL_0052
IL_0096: leave.s IL_00a6
IL_0098: ldloca.s V_3
IL_009a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_00a0: callvirt System.Void System.IDisposable::Dispose()
IL_00a5: endfinally
IL_00a6: ldloca.s V_0
IL_00a8: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::MoveNext()
IL_00ad: brtrue IL_0016
IL_00b2: leave.s IL_00c2
IL_00b4: ldloca.s V_0
IL_00b6: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>
IL_00bc: callvirt System.Void System.IDisposable::Dispose()
IL_00c1: endfinally
IL_00c2: ldsfld System.String System.String::Empty
IL_00c7: ret
IL_00c8: ldloc.s V_6
IL_00ca: ret
