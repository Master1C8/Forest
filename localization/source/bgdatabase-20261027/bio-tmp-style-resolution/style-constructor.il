TYPE TMPro.TMP_Style
METHOD System.Void TMPro.TMP_Style::.ctor(System.String,System.String,System.String) | attributes=Assembly, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: ldarg.0
IL_0007: ldarg.1
IL_0008: stfld System.String TMPro.TMP_Style::m_Name
IL_000d: ldarg.0
IL_000e: ldarg.1
IL_000f: call System.Int32 TMPro.TMP_TextParsingUtilities::GetHashCode(System.String)
IL_0014: stfld System.Int32 TMPro.TMP_Style::m_HashCode
IL_0019: ldarg.0
IL_001a: ldarg.2
IL_001b: stfld System.String TMPro.TMP_Style::m_OpeningDefinition
IL_0020: ldarg.0
IL_0021: ldarg.3
IL_0022: stfld System.String TMPro.TMP_Style::m_ClosingDefinition
IL_0027: ldarg.0
IL_0028: call System.Void TMPro.TMP_Style::RefreshStyle()
IL_002d: ret
