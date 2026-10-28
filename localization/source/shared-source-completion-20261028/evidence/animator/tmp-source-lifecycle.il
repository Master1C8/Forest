TYPE Febucci.UI.TextAnimator_TMP
METHOD System.Void Febucci.UI.TextAnimator_TMP::CacheComponentsOnce() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean Febucci.UI.TextAnimator_TMP::componentsCached
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_000f: ldarg.0
IL_0010: ldflda TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::tmpComponent
IL_0015: callvirt System.Boolean UnityEngine.GameObject::TryGetComponent<TMPro.TMP_Text>(!!0&)
IL_001a: brtrue.s IL_003c
IL_001c: ldstr "TextAnimator_TMP "
IL_0021: ldarg.0
IL_0022: call System.String UnityEngine.Object::get_name()
IL_0027: ldstr " requires a TMP_Text component to work."
IL_002c: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0031: ldarg.0
IL_0032: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0037: call System.Void UnityEngine.Debug::LogError(System.Object,UnityEngine.Object)
IL_003c: ldarg.0
IL_003d: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0042: ldarg.0
IL_0043: ldflda TMPro.TMP_InputField Febucci.UI.TextAnimator_TMP::attachedInputField
IL_0048: callvirt System.Boolean UnityEngine.GameObject::TryGetComponent<TMPro.TMP_InputField>(!!0&)
IL_004d: pop
IL_004e: ldarg.0
IL_004f: ldc.i4.1
IL_0050: stfld System.Boolean Febucci.UI.TextAnimator_TMP::componentsCached
IL_0055: ldarg.0
IL_0056: ldarg.0
IL_0057: ldfld TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::tmpComponent
IL_005c: isinst TMPro.TextMeshProUGUI
IL_0061: ldnull
IL_0062: cgt.un
IL_0064: stfld System.Boolean Febucci.UI.TextAnimator_TMP::isUI
IL_0069: ret
METHOD System.Void Febucci.UI.TextAnimator_TMP::OnInitialized() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void Febucci.UI.TextAnimator_TMP::CacheComponentsOnce()
IL_0006: ldarg.0
IL_0007: ldfld TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::tmpComponent
IL_000c: ldc.i4.0
IL_000d: callvirt System.Void TMPro.TMP_Text::set_renderMode(TMPro.TextRenderFlags)
IL_0012: ret
METHOD System.Void Febucci.UI.TextAnimator_TMP::OnEnable() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void Febucci.UI.Core.TAnimCore::OnEnable()
IL_0006: ldarg.0
IL_0007: ldarg.0
IL_0008: call TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::get_TMProComponent()
IL_000d: callvirt TMPro.TMP_TextInfo TMPro.TMP_Text::get_textInfo()
IL_0012: stfld TMPro.TMP_TextInfo Febucci.UI.TextAnimator_TMP::textInfo
IL_0017: ret
METHOD System.String Febucci.UI.TextAnimator_TMP::GetOriginalTextFromSource() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TMPro.TMP_Text Febucci.UI.TextAnimator_TMP::get_TMProComponent()
IL_0006: callvirt System.String TMPro.TMP_Text::get_text()
IL_000b: ret
