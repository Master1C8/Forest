TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineBegin(PixelCrushers.DialogueSystem.Subtitle)
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Void TheForestOfLove.Narrative.DialogueService::HandleDialogueLineTriggering(PixelCrushers.DialogueSystem.Subtitle)
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: call System.Void TheForestOfLove.Narrative.DialogueService::HandleDialogueLineActor(PixelCrushers.DialogueSystem.Subtitle)
IL_000e: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::HandleDialogueLineTriggering(PixelCrushers.DialogueSystem.Subtitle)
IL_0000: ldarg.1
IL_0001: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0006: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_000b: ldarg.1
IL_000c: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0011: brfalse.s IL_002a
IL_0013: ldarg.1
IL_0014: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0019: callvirt System.String System.String::ToLower()
IL_001e: ldstr "none"
IL_0023: callvirt System.Boolean System.String::Contains(System.String)
IL_0028: br.s IL_002b
IL_002a: ldc.i4.0
IL_002b: stloc.0
IL_002c: ldc.i4.0
IL_002d: ble.s IL_0053
IL_002f: ldloc.0
IL_0030: brtrue.s IL_0053
IL_0032: ldarg.1
IL_0033: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0038: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_003d: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByPluginDbId(System.Int32)
IL_0042: stloc.1
IL_0043: ldarg.0
IL_0044: ldloc.1
IL_0045: call System.Boolean TheForestOfLove.Narrative.DialogueService::CheckIfActorChanged(TheForestOfLove.Narrative.Actor)
IL_004a: brfalse.s IL_0053
IL_004c: ldarg.0
IL_004d: ldc.i4.1
IL_004e: stfld System.Boolean TheForestOfLove.Narrative.DialogueService::encounteredSpokenLineInCurrentDialogue
IL_0053: ldarg.0
IL_0054: ldfld System.Boolean TheForestOfLove.Narrative.DialogueService::encounteredSpokenLineInCurrentDialogue
IL_0059: brtrue.s IL_0062
IL_005b: ldarg.0
IL_005c: ldarg.1
IL_005d: call System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineEnd(PixelCrushers.DialogueSystem.Subtitle)
IL_0062: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::HandleDialogueLineActor(PixelCrushers.DialogueSystem.Subtitle)
IL_0000: ldarg.1
IL_0001: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0006: brtrue.s IL_000f
IL_0008: ldsfld System.String System.String::Empty
IL_000d: br.s IL_001a
IL_000f: ldarg.1
IL_0010: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0015: callvirt System.String System.String::ToLower()
IL_001a: stloc.0
IL_001b: ldloc.0
IL_001c: ldstr "none"
IL_0021: callvirt System.Boolean System.String::Contains(System.String)
IL_0026: brtrue.s IL_0042
IL_0028: ldloc.0
IL_0029: ldstr "delay"
IL_002e: callvirt System.Boolean System.String::Contains(System.String)
IL_0033: brtrue.s IL_0042
IL_0035: ldloc.0
IL_0036: ldstr "continue"
IL_003b: callvirt System.Boolean System.String::Contains(System.String)
IL_0040: brfalse.s IL_0043
IL_0042: ret
IL_0043: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0048: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_004d: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0052: ldfld System.Int32 PixelCrushers.DialogueSystem.CharacterInfo::id
IL_0057: stloc.1
IL_0058: ldloc.1
IL_0059: ldc.i4.0
IL_005a: bgt.s IL_0063
IL_005c: ldarg.0
IL_005d: call System.Int32 TheForestOfLove.Narrative.DialogueService::GetActorPluginIdTheSlowWay()
IL_0062: stloc.1
IL_0063: ldloc.1
IL_0064: ldc.i4.0
IL_0065: bgt.s IL_0068
IL_0067: ret
IL_0068: ldloc.1
IL_0069: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByPluginDbId(System.Int32)
IL_006e: stloc.2
IL_006f: ldloc.2
IL_0070: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentActor(TheForestOfLove.Narrative.Actor)
IL_0075: ldloc.2
IL_0076: brtrue.s IL_0092
IL_0078: ldstr "dialogue {0} could not find actor {1}"
IL_007d: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0082: ldloc.1
IL_0083: box System.Int32
IL_0088: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_008d: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0092: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginDetailed
IL_0097: ldloc.2
IL_0098: ldarg.1
IL_0099: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::Invoke(!0,!1)
IL_009e: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBegin
IL_00a3: ldloc.2
IL_00a4: ldarg.1
IL_00a5: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_00aa: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_00af: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::Invoke(!0,!1)
IL_00b4: ldarg.0
IL_00b5: ldarg.1
IL_00b6: call System.Void TheForestOfLove.Narrative.DialogueService::OnConversationLine_Handler(PixelCrushers.DialogueSystem.Subtitle)
IL_00bb: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsCurrentActorNarrator()
IL_00c0: brfalse.s IL_00da
IL_00c2: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginNarrator
IL_00c7: ldloc.2
IL_00c8: ldarg.1
IL_00c9: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_00ce: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_00d3: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::Invoke(!0,!1)
IL_00d8: br.s IL_0116
IL_00da: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsCurrentActorPlayer()
IL_00df: brfalse.s IL_00f9
IL_00e1: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginPlayer
IL_00e6: ldloc.2
IL_00e7: ldarg.1
IL_00e8: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_00ed: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_00f2: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::Invoke(!0,!1)
IL_00f7: br.s IL_0116
IL_00f9: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsCurrentActorNpc()
IL_00fe: brfalse.s IL_0116
IL_0100: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginNpc
IL_0105: ldloc.2
IL_0106: ldarg.1
IL_0107: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_010c: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0111: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::Invoke(!0,!1)
IL_0116: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueLine
IL_011b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0120: ret
