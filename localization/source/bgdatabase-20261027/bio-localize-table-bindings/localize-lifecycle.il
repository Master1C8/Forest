TYPE PixelCrushers.LocalizeUI
METHOD System.Void PixelCrushers.LocalizeUI::Start() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void PixelCrushers.LocalizeUI::set_started(System.Boolean)
IL_0007: ldarg.0
IL_0008: callvirt System.Void PixelCrushers.LocalizeUI::UpdateText()
IL_000d: ret
METHOD System.Void PixelCrushers.LocalizeUI::OnEnable() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Void PixelCrushers.LocalizeUI::UpdateText()
IL_0006: ret
METHOD System.Void PixelCrushers.LocalizeUI::SetFieldName(System.String) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: call UnityEngine.UI.Text PixelCrushers.LocalizeUI::get_text()
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_001a
IL_000e: ldarg.0
IL_000f: ldarg.0
IL_0010: call !!0 UnityEngine.Component::GetComponent<UnityEngine.UI.Text>()
IL_0015: call System.Void PixelCrushers.LocalizeUI::set_text(UnityEngine.UI.Text)
IL_001a: ldarg.0
IL_001b: ldarg.1
IL_001c: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0021: brfalse.s IL_0031
IL_0023: ldarg.0
IL_0024: call UnityEngine.UI.Text PixelCrushers.LocalizeUI::get_text()
IL_0029: ldnull
IL_002a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_002f: brtrue.s IL_0034
IL_0031: ldarg.1
IL_0032: br.s IL_003f
IL_0034: ldarg.0
IL_0035: call UnityEngine.UI.Text PixelCrushers.LocalizeUI::get_text()
IL_003a: callvirt System.String UnityEngine.UI.Text::get_text()
IL_003f: call System.Void PixelCrushers.LocalizeUI::set_fieldName(System.String)
IL_0044: ret
METHOD System.Void PixelCrushers.LocalizeUI::UpdateDropdownOptions() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Collections.Generic.List`1<System.String> PixelCrushers.LocalizeUI::get_fieldNames()
IL_0006: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_000b: ldarg.0
IL_000c: callvirt System.Void PixelCrushers.LocalizeUI::UpdateText()
IL_0011: ret
METHOD System.Void PixelCrushers.LocalizeUI::<UpdateText>b__31_0(UnityEngine.UI.Dropdown/OptionData) | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Collections.Generic.List`1<System.String> PixelCrushers.LocalizeUI::get_fieldNames()
IL_0006: ldarg.1
IL_0007: callvirt System.String UnityEngine.UI.Dropdown/OptionData::get_text()
IL_000c: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0011: ret
