TYPE TMPro.TMP_Text
METHOD UnityEngine.RectTransform TMPro.TMP_Text::get_rectTransform() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.RectTransform TMPro.TMP_Text::m_rectTransform
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_001a
IL_000e: ldarg.0
IL_000f: ldarg.0
IL_0010: call !!0 UnityEngine.Component::GetComponent<UnityEngine.RectTransform>()
IL_0015: stfld UnityEngine.RectTransform TMPro.TMP_Text::m_rectTransform
IL_001a: ldarg.0
IL_001b: ldfld UnityEngine.RectTransform TMPro.TMP_Text::m_rectTransform
IL_0020: ret
