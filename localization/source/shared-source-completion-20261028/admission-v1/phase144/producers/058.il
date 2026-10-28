TYPE TheForestOfLove.DevTools.DialogueDebugger
METHOD System.Void TheForestOfLove.DevTools.DialogueDebugger::GenerateDebugText() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Boolean TheForestOfLove.DevTools.DialogueDebugger::suppressAutoUpdate
IL_0007: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.ActorTrackingService>()
IL_000c: pop
IL_000d: ldsfld System.String System.String::Empty
IL_0012: stloc.0
IL_0013: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Services.Persistence.DataService::GetActors()
IL_0018: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Actor>::GetEnumerator()
IL_001d: stloc.1
IL_001e: br IL_00a3
IL_0023: ldloc.1
IL_0024: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Actor>::get_Current()
IL_0029: stloc.2
IL_002a: ldloc.2
IL_002b: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0030: call TheForestOfLove.Narrative.ActorDialogueOracle TheForestOfLove.Services.Persistence.DataService::GetActorDialogueOracleByActorDbName(System.String)
IL_0035: stloc.3
IL_0036: ldloc.3
IL_0037: brfalse.s IL_00a3
IL_0039: ldsfld System.String System.String::Empty
IL_003e: stloc.s V_4
IL_0040: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_0045: stloc.s V_5
IL_0047: ldarg.0
IL_0048: ldloc.3
IL_0049: ldloc.s V_5
IL_004b: ldloca.s V_4
IL_004d: call System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_NewQuests(TheForestOfLove.Narrative.ActorDialogueOracle,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String&)
IL_0052: ldarg.0
IL_0053: ldloc.3
IL_0054: ldloc.s V_5
IL_0056: ldloca.s V_4
IL_0058: call System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_QuestsToTurnIn(TheForestOfLove.Narrative.ActorDialogueOracle,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String&)
IL_005d: ldarg.0
IL_005e: ldloc.3
IL_005f: ldloc.s V_5
IL_0061: ldloca.s V_4
IL_0063: call System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_QuestSteps(TheForestOfLove.Narrative.ActorDialogueOracle,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String&)
IL_0068: ldloc.s V_5
IL_006a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Clear()
IL_006f: ldarg.0
IL_0070: ldloc.3
IL_0071: ldloc.s V_5
IL_0073: ldloca.s V_4
IL_0075: call System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_DynamicQuestions(TheForestOfLove.Narrative.ActorDialogueOracle,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String&)
IL_007a: ldloc.s V_4
IL_007c: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0081: brtrue.s IL_00a3
IL_0083: ldloc.0
IL_0084: ldstr "{0}:
"
IL_0089: ldloc.2
IL_008a: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_008f: call System.String System.String::Format(System.String,System.Object)
IL_0094: call System.String System.String::Concat(System.String,System.String)
IL_0099: stloc.0
IL_009a: ldloc.0
IL_009b: ldloc.s V_4
IL_009d: call System.String System.String::Concat(System.String,System.String)
IL_00a2: stloc.0
IL_00a3: ldloc.1
IL_00a4: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_00a9: brtrue IL_0023
IL_00ae: leave.s IL_00ba
IL_00b0: ldloc.1
IL_00b1: brfalse.s IL_00b9
IL_00b3: ldloc.1
IL_00b4: callvirt System.Void System.IDisposable::Dispose()
IL_00b9: endfinally
IL_00ba: ldarg.0
IL_00bb: ldfld UnityEngine.UI.Text TheForestOfLove.DevTools.DialogueDebugger::label
IL_00c0: ldloc.0
IL_00c1: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_00c6: ret
METHOD System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_NewQuests(TheForestOfLove.Narrative.ActorDialogueOracle,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.2
IL_0002: ldarg.1
IL_0003: callvirt System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.ActorDialogueOracle::GetAllNewQuests()
IL_0008: ldstr "New Quests"
IL_000d: ldarg.3
IL_000e: call System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_Subroutine(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>,System.String,System.String&)
IL_0013: ret
METHOD System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_QuestsToTurnIn(TheForestOfLove.Narrative.ActorDialogueOracle,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.2
IL_0002: ldarg.1
IL_0003: callvirt System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.ActorDialogueOracle::GetAllQuestsToTurnIn()
IL_0008: ldstr "Quests to Turn In"
IL_000d: ldarg.3
IL_000e: call System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_Subroutine(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>,System.String,System.String&)
IL_0013: ret
METHOD System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_QuestSteps(TheForestOfLove.Narrative.ActorDialogueOracle,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.2
IL_0002: ldarg.1
IL_0003: callvirt System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.ActorDialogueOracle::GetAllUnplayedQuestDialogues()
IL_0008: ldstr "Quest Steps"
IL_000d: ldarg.3
IL_000e: call System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_Subroutine(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>,System.String,System.String&)
IL_0013: ret
METHOD System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_DynamicQuestions(TheForestOfLove.Narrative.ActorDialogueOracle,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.2
IL_0002: ldarg.1
IL_0003: callvirt System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.ActorDialogueOracle::GetAvailableDynamicQuestions()
IL_0008: ldstr "Dynamic Questions"
IL_000d: ldarg.3
IL_000e: call System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_Subroutine(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>,System.String,System.String&)
IL_0013: ret
METHOD System.Void TheForestOfLove.DevTools.DialogueDebugger::BuildOutput_Subroutine(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>,System.String,System.String&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldarg.2
IL_0003: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0008: stloc.1
IL_0009: br.s IL_0068
IL_000b: ldloc.1
IL_000c: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0011: stloc.2
IL_0012: ldarg.1
IL_0013: ldloc.2
IL_0014: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Contains(!0)
IL_0019: brtrue.s IL_0068
IL_001b: ldloc.0
IL_001c: brtrue.s IL_0036
IL_001e: ldc.i4.1
IL_001f: stloc.0
IL_0020: ldarg.s output
IL_0022: ldarg.s output
IL_0024: ldind.ref
IL_0025: ldstr "    {0}: 
"
IL_002a: ldarg.3
IL_002b: call System.String System.String::Format(System.String,System.Object)
IL_0030: call System.String System.String::Concat(System.String,System.String)
IL_0035: stind.ref
IL_0036: ldarg.s output
IL_0038: ldarg.s output
IL_003a: ldind.ref
IL_003b: ldstr "        {0} {1}
"
IL_0040: ldloc.2
IL_0041: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0046: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_004b: box System.Int32
IL_0050: ldloc.2
IL_0051: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0056: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_005b: call System.String System.String::Concat(System.String,System.String)
IL_0060: stind.ref
IL_0061: ldarg.1
IL_0062: ldloc.2
IL_0063: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_0068: ldloc.1
IL_0069: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_006e: brtrue.s IL_000b
IL_0070: leave.s IL_007c
IL_0072: ldloc.1
IL_0073: brfalse.s IL_007b
IL_0075: ldloc.1
IL_0076: callvirt System.Void System.IDisposable::Dispose()
IL_007b: endfinally
IL_007c: ret
METHOD System.Void TheForestOfLove.DevTools.DialogueDebugger::TryClearDialogueIdInput() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Toggle TheForestOfLove.DevTools.DialogueDebugger::dialogueIdClearToggle
IL_0006: callvirt System.Boolean UnityEngine.UI.Toggle::get_isOn()
IL_000b: brfalse.s IL_0013
IL_000d: ldarg.0
IL_000e: call System.Void TheForestOfLove.DevTools.DialogueDebugger::ClearDialogueIdInput()
IL_0013: ldarg.0
IL_0014: ldfld UnityEngine.UI.Text TheForestOfLove.DevTools.DialogueDebugger::dialogueIdClearToggleLabel
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.UI.Toggle TheForestOfLove.DevTools.DialogueDebugger::dialogueIdClearToggle
IL_001f: callvirt System.Boolean UnityEngine.UI.Toggle::get_isOn()
IL_0024: brtrue.s IL_002d
IL_0026: ldstr "<Pinned"
IL_002b: br.s IL_0032
IL_002d: ldstr "Pin?"
IL_0032: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0037: ret
