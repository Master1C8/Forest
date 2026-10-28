TYPE SickDev.DevConsole.Entry
METHOD System.Void SickDev.DevConsole.Entry::SetContentText() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GUIContent SickDev.DevConsole.Entry::textContent
IL_0006: ldarg.0
IL_0007: call System.Boolean SickDev.DevConsole.Entry::get_isExpanded()
IL_000c: brtrue.s IL_001b
IL_000e: ldarg.0
IL_000f: ldfld SickDev.DevConsole.Entry/SimpleTextBuilder SickDev.DevConsole.Entry::builder
IL_0014: ldfld System.String SickDev.DevConsole.Entry/SimpleTextBuilder::simpleText
IL_0019: br.s IL_0026
IL_001b: ldarg.0
IL_001c: call SickDev.DevConsole.EntryData SickDev.DevConsole.Entry::get_data()
IL_0021: ldfld System.String SickDev.DevConsole.EntryData::text
IL_0026: callvirt System.Void UnityEngine.GUIContent::set_text(System.String)
IL_002b: ldarg.0
IL_002c: call System.Boolean SickDev.DevConsole.Entry::get_showStackTrace()
IL_0031: brfalse.s IL_0059
IL_0033: ldarg.0
IL_0034: ldfld UnityEngine.GUIContent SickDev.DevConsole.Entry::textContent
IL_0039: dup
IL_003a: callvirt System.String UnityEngine.GUIContent::get_text()
IL_003f: ldstr "

"
IL_0044: ldarg.0
IL_0045: call SickDev.DevConsole.EntryData SickDev.DevConsole.Entry::get_data()
IL_004a: ldfld System.String SickDev.DevConsole.EntryData::stackTrace
IL_004f: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0054: callvirt System.Void UnityEngine.GUIContent::set_text(System.String)
IL_0059: ret
METHOD System.Void SickDev.DevConsole.Entry::DrawText(UnityEngine.Rect&,System.Single) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldarg.2
IL_0002: call System.Void UnityEngine.Rect::set_width(System.Single)
IL_0007: ldarg.1
IL_0008: ldarg.0
IL_0009: call System.Single SickDev.DevConsole.Entry::get_height()
IL_000e: call System.Void UnityEngine.Rect::set_height(System.Single)
IL_0013: ldarg.0
IL_0014: ldfld System.Int32 SickDev.DevConsole.Entry::id
IL_0019: ldc.i4.1
IL_001a: call System.Int32 UnityEngine.GUIUtility::GetControlID(System.Int32,UnityEngine.FocusType)
IL_001f: pop
IL_0020: ldarg.0
IL_0021: call System.Void SickDev.DevConsole.Entry::ApplyStyle()
IL_0026: ldarg.0
IL_0027: ldfld System.String SickDev.DevConsole.Entry::name
IL_002c: call System.Void UnityEngine.GUI::SetNextControlName(System.String)
IL_0031: call System.Boolean UnityEngine.Application::get_isMobilePlatform()
IL_0036: brfalse.s IL_0056
IL_0038: ldarg.1
IL_0039: ldobj UnityEngine.Rect
IL_003e: ldarg.0
IL_003f: ldfld UnityEngine.GUIContent SickDev.DevConsole.Entry::textContent
IL_0044: callvirt System.String UnityEngine.GUIContent::get_text()
IL_0049: ldarg.0
IL_004a: ldfld UnityEngine.GUIStyle SickDev.DevConsole.Entry::textStyle
IL_004f: call System.Void UnityEngine.GUI::Label(UnityEngine.Rect,System.String,UnityEngine.GUIStyle)
IL_0054: br.s IL_0073
IL_0056: ldarg.1
IL_0057: ldobj UnityEngine.Rect
IL_005c: ldarg.0
IL_005d: ldfld UnityEngine.GUIContent SickDev.DevConsole.Entry::textContent
IL_0062: callvirt System.String UnityEngine.GUIContent::get_text()
IL_0067: ldarg.0
IL_0068: ldfld UnityEngine.GUIStyle SickDev.DevConsole.Entry::textStyle
IL_006d: call System.String UnityEngine.GUI::TextField(UnityEngine.Rect,System.String,UnityEngine.GUIStyle)
IL_0072: pop
IL_0073: ldarg.0
IL_0074: call System.Void SickDev.DevConsole.Entry::RestoreStyle()
IL_0079: ret
