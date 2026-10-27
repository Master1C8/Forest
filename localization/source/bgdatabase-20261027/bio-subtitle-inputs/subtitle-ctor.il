TYPE PixelCrushers.DialogueSystem.Subtitle
METHOD System.Void PixelCrushers.DialogueSystem.Subtitle::.ctor(PixelCrushers.DialogueSystem.CharacterInfo,PixelCrushers.DialogueSystem.CharacterInfo,PixelCrushers.DialogueSystem.FormattedText,System.String,System.String,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldsfld System.String System.String::Empty
IL_0006: stfld System.String PixelCrushers.DialogueSystem.Subtitle::entrytag
IL_000b: ldarg.0
IL_000c: call System.Void System.Object::.ctor()
IL_0011: ldarg.0
IL_0012: ldarg.1
IL_0013: stfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0018: ldarg.0
IL_0019: ldarg.2
IL_001a: stfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::listenerInfo
IL_001f: ldarg.0
IL_0020: ldarg.3
IL_0021: stfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0026: ldarg.0
IL_0027: ldarg.s sequence
IL_0029: stfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_002e: ldarg.0
IL_002f: ldarg.s responseMenuSequence
IL_0031: stfld System.String PixelCrushers.DialogueSystem.Subtitle::responseMenuSequence
IL_0036: ldarg.0
IL_0037: ldarg.s dialogueEntry
IL_0039: stfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_003e: ldarg.0
IL_003f: ldnull
IL_0040: stfld System.String PixelCrushers.DialogueSystem.Subtitle::entrytag
IL_0045: ldarg.0
IL_0046: call System.Void PixelCrushers.DialogueSystem.Subtitle::CheckVariableInputPrompt()
IL_004b: ret
METHOD System.Void PixelCrushers.DialogueSystem.Subtitle::.ctor(PixelCrushers.DialogueSystem.CharacterInfo,PixelCrushers.DialogueSystem.CharacterInfo,PixelCrushers.DialogueSystem.FormattedText,System.String,System.String,PixelCrushers.DialogueSystem.DialogueEntry,System.String) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldsfld System.String System.String::Empty
IL_0006: stfld System.String PixelCrushers.DialogueSystem.Subtitle::entrytag
IL_000b: ldarg.0
IL_000c: call System.Void System.Object::.ctor()
IL_0011: ldarg.0
IL_0012: ldarg.1
IL_0013: stfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0018: ldarg.0
IL_0019: ldarg.2
IL_001a: stfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::listenerInfo
IL_001f: ldarg.0
IL_0020: ldarg.3
IL_0021: stfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0026: ldarg.0
IL_0027: ldarg.s sequence
IL_0029: stfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_002e: ldarg.0
IL_002f: ldarg.s responseMenuSequence
IL_0031: stfld System.String PixelCrushers.DialogueSystem.Subtitle::responseMenuSequence
IL_0036: ldarg.0
IL_0037: ldarg.s dialogueEntry
IL_0039: stfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_003e: ldarg.0
IL_003f: ldarg.s entrytag
IL_0041: stfld System.String PixelCrushers.DialogueSystem.Subtitle::entrytag
IL_0046: ldarg.0
IL_0047: call System.Void PixelCrushers.DialogueSystem.Subtitle::CheckVariableInputPrompt()
IL_004c: ret
METHOD System.Void PixelCrushers.DialogueSystem.Subtitle::CheckVariableInputPrompt() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0006: brfalse.s IL_004f
IL_0008: ldarg.0
IL_0009: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_000e: callvirt System.Boolean PixelCrushers.DialogueSystem.FormattedText::get_hasVariableInputPrompt()
IL_0013: brfalse.s IL_004f
IL_0015: ldarg.0
IL_0016: ldstr "{0}{1}TextInput(Text Field UI,{2},{2})"
IL_001b: ldarg.0
IL_001c: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0021: ldarg.0
IL_0022: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0027: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_002c: brtrue.s IL_0035
IL_002e: ldstr "; "
IL_0033: br.s IL_003a
IL_0035: ldsfld System.String System.String::Empty
IL_003a: ldarg.0
IL_003b: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0040: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_variableInputPrompt()
IL_0045: call System.String System.String::Format(System.String,System.Object,System.Object,System.Object)
IL_004a: stfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_004f: ret
