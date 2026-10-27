TYPE TMPro.TMP_Style
METHOD TMPro.TMP_Style TMPro.TMP_Style::get_NormalStyle() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld TMPro.TMP_Style TMPro.TMP_Style::k_NormalStyle
IL_0005: brtrue.s IL_0020
IL_0007: ldstr "Normal"
IL_000c: ldsfld System.String System.String::Empty
IL_0011: ldsfld System.String System.String::Empty
IL_0016: newobj System.Void TMPro.TMP_Style::.ctor(System.String,System.String,System.String)
IL_001b: stsfld TMPro.TMP_Style TMPro.TMP_Style::k_NormalStyle
IL_0020: ldsfld TMPro.TMP_Style TMPro.TMP_Style::k_NormalStyle
IL_0025: ret
