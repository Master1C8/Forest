TYPE TheForestOfLove.DialogueNameplateController
METHOD System.Void TheForestOfLove.DialogueNameplateController::OnConversationTriggerUpdatePortraits(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean Globals::get_DisableTriggeredEffects()
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldarg.1
IL_0009: brfalse.s IL_003d
IL_000b: ldarg.1
IL_000c: ldstr "everyone"
IL_0011: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0016: brtrue.s IL_0026
IL_0018: ldarg.1
IL_0019: ldstr "unison"
IL_001e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0023: brtrue.s IL_0032
IL_0025: ret
IL_0026: ldarg.0
IL_0027: ldstr "(Everyone)"
IL_002c: call System.Void TheForestOfLove.DialogueNameplateController::SetCustomNameplateNextLineOnly(System.String)
IL_0031: ret
IL_0032: ldarg.0
IL_0033: ldstr "(Both)"
IL_0038: call System.Void TheForestOfLove.DialogueNameplateController::SetCustomNameplateNextLineOnly(System.String)
IL_003d: ret
METHOD System.Void TheForestOfLove.DialogueNameplateController::UpdateNameplate(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.DialogueNameplateController::customNameplate
IL_0006: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_000b: brtrue.s IL_0057
IL_000d: ldarg.0
IL_000e: ldfld UnityEngine.CanvasGroup TheForestOfLove.DialogueNameplateController::nameplateRootCanvasGroup
IL_0013: ldc.r4 1
IL_0018: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001d: ldarg.0
IL_001e: ldfld UnityEngine.Transform TheForestOfLove.DialogueNameplateController::nameplateRoot
IL_0023: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_0028: stloc.0
IL_0029: ldc.i4.0
IL_002a: stloc.1
IL_002b: br.s IL_003f
IL_002d: ldloc.0
IL_002e: ldloc.1
IL_002f: ldelem.ref
IL_0030: ldarg.0
IL_0031: ldfld System.String TheForestOfLove.DialogueNameplateController::customNameplate
IL_0036: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_003b: ldloc.1
IL_003c: ldc.i4.1
IL_003d: add
IL_003e: stloc.1
IL_003f: ldloc.1
IL_0040: ldloc.0
IL_0041: ldlen
IL_0042: conv.i4
IL_0043: blt.s IL_002d
IL_0045: ldarg.0
IL_0046: ldfld System.Boolean TheForestOfLove.DialogueNameplateController::customNameplateNextLineOnly
IL_004b: brfalse IL_0117
IL_0050: ldarg.0
IL_0051: call System.Void TheForestOfLove.DialogueNameplateController::ClearCustomNameplate()
IL_0056: ret
IL_0057: ldarg.1
IL_0058: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_005d: brfalse.s IL_0070
IL_005f: ldarg.0
IL_0060: ldfld UnityEngine.CanvasGroup TheForestOfLove.DialogueNameplateController::nameplateRootCanvasGroup
IL_0065: ldc.r4 0
IL_006a: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_006f: ret
IL_0070: ldarg.1
IL_0071: callvirt System.String System.String::ToLower()
IL_0076: ldstr "narrator"
IL_007b: callvirt System.Boolean System.String::Contains(System.String)
IL_0080: brfalse.s IL_0093
IL_0082: ldarg.0
IL_0083: ldfld UnityEngine.CanvasGroup TheForestOfLove.DialogueNameplateController::nameplateRootCanvasGroup
IL_0088: ldc.r4 0
IL_008d: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0092: ret
IL_0093: ldarg.1
IL_0094: callvirt System.String System.String::ToLower()
IL_0099: ldstr "player"
IL_009e: callvirt System.Boolean System.String::Contains(System.String)
IL_00a3: brtrue.s IL_0117
IL_00a5: ldarg.1
IL_00a6: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_00ab: stloc.2
IL_00ac: ldloc.2
IL_00ad: brtrue.s IL_00c0
IL_00af: ldarg.0
IL_00b0: ldfld UnityEngine.CanvasGroup TheForestOfLove.DialogueNameplateController::nameplateRootCanvasGroup
IL_00b5: ldc.r4 0
IL_00ba: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_00bf: ret
IL_00c0: ldarg.0
IL_00c1: ldfld UnityEngine.CanvasGroup TheForestOfLove.DialogueNameplateController::nameplateRootCanvasGroup
IL_00c6: ldc.r4 1
IL_00cb: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_00d0: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_00d5: brtrue.s IL_00ed
IL_00d7: ldloc.2
IL_00d8: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_00dd: brtrue.s IL_00ed
IL_00df: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_00e4: brtrue.s IL_00ed
IL_00e6: ldstr "???"
IL_00eb: br.s IL_00f3
IL_00ed: ldloc.2
IL_00ee: callvirt System.String TheForestOfLove.Narrative.Actor::get_NameplateName()
IL_00f3: stloc.3
IL_00f4: ldarg.0
IL_00f5: ldfld UnityEngine.Transform TheForestOfLove.DialogueNameplateController::nameplateRoot
IL_00fa: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_00ff: stloc.0
IL_0100: ldc.i4.0
IL_0101: stloc.1
IL_0102: br.s IL_0111
IL_0104: ldloc.0
IL_0105: ldloc.1
IL_0106: ldelem.ref
IL_0107: ldloc.3
IL_0108: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_010d: ldloc.1
IL_010e: ldc.i4.1
IL_010f: add
IL_0110: stloc.1
IL_0111: ldloc.1
IL_0112: ldloc.0
IL_0113: ldlen
IL_0114: conv.i4
IL_0115: blt.s IL_0104
IL_0117: ret
