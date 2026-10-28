TYPE Febucci.UI.TextAnimator_TMP
METHOD System.Void Febucci.UI.TextAnimator_TMP::SetTextToSource(System.String) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::get_TMProComponent()
IL_0006: ldc.i4.0
IL_0007: callvirt System.Void TMPro.TMP_Text::set_renderMode(TMPro.TextRenderFlags)
IL_000c: ldarg.0
IL_000d: ldfld TMPro.TMP_InputField Febucci.UI.TextAnimator_TMP::attachedInputField
IL_0012: call System.Boolean UnityEngine.Object::op_Implicit(UnityEngine.Object)
IL_0017: brfalse.s IL_0027
IL_0019: ldarg.0
IL_001a: ldfld TMPro.TMP_InputField Febucci.UI.TextAnimator_TMP::attachedInputField
IL_001f: ldarg.1
IL_0020: callvirt System.Void TMPro.TMP_InputField::set_text(System.String)
IL_0025: br.s IL_0033
IL_0027: ldarg.0
IL_0028: ldfld TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::tmpComponent
IL_002d: ldarg.1
IL_002e: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0033: ldarg.0
IL_0034: callvirt System.Void Febucci.UI.Core.TAnimCore::OnForceMeshUpdate()
IL_0039: ldarg.0
IL_003a: ldarg.0
IL_003b: ldfld TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::tmpComponent
IL_0040: ldarg.0
IL_0041: ldfld TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::tmpComponent
IL_0046: callvirt System.String TMPro.TMP_Text::get_text()
IL_004b: callvirt TMPro.TMP_TextInfo TMPro.TMP_Text::GetTextInfo(System.String)
IL_0050: stfld TMPro.TMP_TextInfo Febucci.UI.TextAnimator_TMP::textInfo
IL_0055: ldarg.0
IL_0056: ldfld TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::tmpComponent
IL_005b: ldc.i4.0
IL_005c: callvirt System.Void TMPro.TMP_Text::set_renderMode(TMPro.TextRenderFlags)
IL_0061: ret
METHOD System.Boolean Febucci.UI.TextAnimator_TMP::HasChangedText(System.String) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::tmpComponent
IL_0006: callvirt System.String TMPro.TMP_Text::get_text()
IL_000b: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0010: brfalse.s IL_001c
IL_0012: ldarg.1
IL_0013: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0018: brfalse.s IL_001c
IL_001a: ldc.i4.0
IL_001b: ret
IL_001c: ldarg.0
IL_001d: ldfld TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::tmpComponent
IL_0022: callvirt System.String TMPro.TMP_Text::get_text()
IL_0027: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_002c: ldarg.1
IL_002d: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0032: beq.s IL_0036
IL_0034: ldc.i4.1
IL_0035: ret
IL_0036: ldarg.0
IL_0037: ldfld TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::tmpComponent
IL_003c: callvirt System.String TMPro.TMP_Text::get_text()
IL_0041: ldarg.1
IL_0042: callvirt System.Boolean System.String::Equals(System.String)
IL_0047: ldc.i4.0
IL_0048: ceq
IL_004a: ret
