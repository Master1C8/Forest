TYPE TMPro.TMP_Text
METHOD System.Void TMPro.TMP_Text::ParseInputText() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.TMP_Text/TextInputSources TMPro.TMP_Text::m_inputSource
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: switch IL_001f,IL_004c,IL_004c,IL_001f
IL_001d: br.s IL_004c
IL_001f: ldarg.0
IL_0020: ldarg.0
IL_0021: ldfld TMPro.ITextPreprocessor TMPro.TMP_Text::m_TextPreprocessor
IL_0026: brfalse.s IL_003b
IL_0028: ldarg.0
IL_0029: ldfld TMPro.ITextPreprocessor TMPro.TMP_Text::m_TextPreprocessor
IL_002e: ldarg.0
IL_002f: ldfld System.String TMPro.TMP_Text::m_text
IL_0034: callvirt System.String TMPro.ITextPreprocessor::PreprocessText(System.String)
IL_0039: br.s IL_0041
IL_003b: ldarg.0
IL_003c: ldfld System.String TMPro.TMP_Text::m_text
IL_0041: call System.Void TMPro.TMP_Text::PopulateTextBackingArray(System.String)
IL_0046: ldarg.0
IL_0047: call System.Void TMPro.TMP_Text::PopulateTextProcessingArray()
IL_004c: ldarg.0
IL_004d: ldarg.0
IL_004e: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0053: callvirt System.Int32 TMPro.TMP_Text::SetArraySizes(TMPro.TMP_Text/UnicodeChar[])
IL_0058: pop
IL_0059: ret
