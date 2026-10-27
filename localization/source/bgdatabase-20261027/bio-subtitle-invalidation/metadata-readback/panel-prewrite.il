TYPE PixelCrushers.DialogueSystem.StandardUISubtitlePanel
METHOD PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_currentSubtitle() | attributes=Public, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.StandardUISubtitlePanel::m_currentSubtitle
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_currentSubtitle(PixelCrushers.DialogueSystem.Subtitle) | attributes=Family, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.StandardUISubtitlePanel::m_currentSubtitle
IL_0007: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::CheckSubtitleAnimator(PixelCrushers.DialogueSystem.Subtitle) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse IL_00e0
IL_0006: ldarg.0
IL_0007: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::useAnimatedPortraits
IL_000c: brfalse IL_00e0
IL_0011: ldarg.0
IL_0012: call UnityEngine.Animator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_animator()
IL_0017: ldnull
IL_0018: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001d: brfalse IL_00e0
IL_0022: ldarg.1
IL_0023: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0028: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_002d: call PixelCrushers.DialogueSystem.DialogueActor PixelCrushers.DialogueSystem.DialogueActor::GetDialogueActorComponent(UnityEngine.Transform)
IL_0032: stloc.0
IL_0033: ldloc.0
IL_0034: ldnull
IL_0035: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_003a: brfalse IL_00d2
IL_003f: ldloc.0
IL_0040: callvirt PixelCrushers.DialogueSystem.SubtitlePanelNumber PixelCrushers.DialogueSystem.DialogueActor::GetSubtitlePanelNumber()
IL_0045: stloc.1
IL_0046: ldarg.0
IL_0047: call UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_actorOverridingPanel()
IL_004c: ldarg.1
IL_004d: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0052: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_0057: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_005c: brtrue.s IL_00b6
IL_005e: ldloc.1
IL_005f: call System.Int32 PixelCrushers.DialogueSystem.PanelNumberUtility::GetSubtitlePanelIndex(PixelCrushers.DialogueSystem.SubtitlePanelNumber)
IL_0064: ldarg.0
IL_0065: call System.Int32 PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_panelNumber()
IL_006a: beq.s IL_00b6
IL_006c: ldloc.1
IL_006d: brtrue.s IL_0084
IL_006f: ldarg.1
IL_0070: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0075: callvirt System.Boolean PixelCrushers.DialogueSystem.CharacterInfo::get_isNPC()
IL_007a: brfalse.s IL_0084
IL_007c: ldarg.0
IL_007d: call System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_isDefaultNPCPanel()
IL_0082: brtrue.s IL_00b6
IL_0084: ldloc.1
IL_0085: brtrue.s IL_009c
IL_0087: ldarg.1
IL_0088: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_008d: callvirt System.Boolean PixelCrushers.DialogueSystem.CharacterInfo::get_isPlayer()
IL_0092: brfalse.s IL_009c
IL_0094: ldarg.0
IL_0095: call System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_isDefaultPCPanel()
IL_009a: brtrue.s IL_00b6
IL_009c: ldloc.1
IL_009d: ldc.i4.2
IL_009e: bne.un.s IL_00b3
IL_00a0: ldloc.0
IL_00a1: ldfld PixelCrushers.DialogueSystem.DialogueActor/StandardDialogueUISettings PixelCrushers.DialogueSystem.DialogueActor::standardDialogueUISettings
IL_00a6: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.DialogueActor/StandardDialogueUISettings::customSubtitlePanel
IL_00ab: ldarg.0
IL_00ac: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00b1: br.s IL_00b7
IL_00b3: ldc.i4.0
IL_00b4: br.s IL_00b7
IL_00b6: ldc.i4.1
IL_00b7: brfalse.s IL_00e0
IL_00b9: ldarg.0
IL_00ba: ldarg.0
IL_00bb: ldloc.0
IL_00bc: ldfld PixelCrushers.DialogueSystem.DialogueActor/StandardDialogueUISettings PixelCrushers.DialogueSystem.DialogueActor::standardDialogueUISettings
IL_00c1: ldfld UnityEngine.RuntimeAnimatorController PixelCrushers.DialogueSystem.DialogueActor/StandardDialogueUISettings::portraitAnimatorController
IL_00c6: callvirt System.Collections.IEnumerator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::SetAnimatorAtEndOfFrame(UnityEngine.RuntimeAnimatorController)
IL_00cb: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_00d0: pop
IL_00d1: ret
IL_00d2: ldarg.0
IL_00d3: ldarg.0
IL_00d4: ldnull
IL_00d5: callvirt System.Collections.IEnumerator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::SetAnimatorAtEndOfFrame(UnityEngine.RuntimeAnimatorController)
IL_00da: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_00df: pop
IL_00e0: ret
