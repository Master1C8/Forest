TYPE TheForestOfLove.DialogueNameplateController
METHOD System.Void TheForestOfLove.DialogueNameplateController::OnChangeFont(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_001d
IL_0003: ldarg.1
IL_0004: ldstr "main"
IL_0009: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000e: brtrue.s IL_001d
IL_0010: ldarg.1
IL_0011: ldstr "mouse"
IL_0016: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_001b: brtrue.s IL_0024
IL_001d: ldarg.0
IL_001e: call System.Void TheForestOfLove.DialogueNameplateController::SetFontToMainNextLine()
IL_0023: ret
IL_0024: ldarg.0
IL_0025: call System.Void TheForestOfLove.DialogueNameplateController::SetFontToMouseNextLine()
IL_002a: ret
