TYPE PixelCrushers.DialogueSystem.StandardUISubtitlePanel
METHOD UnityEngine.Animator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_animator() | attributes=Family, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Animator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::m_animator
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_002d
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.UI.Image PixelCrushers.DialogueSystem.StandardUISubtitlePanel::portraitImage
IL_0014: ldnull
IL_0015: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001a: brfalse.s IL_002d
IL_001c: ldarg.0
IL_001d: ldarg.0
IL_001e: ldfld UnityEngine.UI.Image PixelCrushers.DialogueSystem.StandardUISubtitlePanel::portraitImage
IL_0023: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_0028: stfld UnityEngine.Animator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::m_animator
IL_002d: ldarg.0
IL_002e: ldfld UnityEngine.Animator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::m_animator
IL_0033: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_isDefaultNPCPanel() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::m_isDefaultNPCPanel
IL_0006: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_isDefaultPCPanel() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::m_isDefaultPCPanel
IL_0006: ret
METHOD System.Int32 PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_panelNumber() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 PixelCrushers.DialogueSystem.StandardUISubtitlePanel::m_panelNumber
IL_0006: ret
METHOD UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_actorOverridingPanel() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUISubtitlePanel::m_actorOverridingPanel
IL_0006: ret
METHOD System.Collections.IEnumerator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::SetAnimatorAtEndOfFrame(UnityEngine.RuntimeAnimatorController) | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.IteratorStateMachineAttribute
IL_0000: ldc.i4.0
IL_0001: newobj System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::.ctor(System.Int32)
IL_0006: dup
IL_0007: ldarg.0
IL_0008: stfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::<>4__this
IL_000d: dup
IL_000e: ldarg.1
IL_000f: stfld UnityEngine.RuntimeAnimatorController PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::animatorController
IL_0014: ret
