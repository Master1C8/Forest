TYPE TheForestOfLove.DialogueSkipProgressIndicator
METHOD System.Void TheForestOfLove.DialogueSkipProgressIndicator::OnDialogueSkipInProgress(System.Single) | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "skipping dialogue: {0}"
IL_0005: ldarg.1
IL_0006: ldc.r4 100
IL_000b: mul
IL_000c: conv.i4
IL_000d: box System.Int32
IL_0012: call System.String System.String::Format(System.String,System.Object)
IL_0017: call System.Void UnityEngine.Debug::Log(System.Object)
IL_001c: ret
