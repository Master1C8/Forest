TYPE TheForestOfLove.PauseScreenUiController
METHOD System.Void TheForestOfLove.PauseScreenUiController::MainMenuChapterSelect() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Void TheForestOfLove.BugReportApiHelper::OnPauseMenuClosedForAnyReason()
IL_0005: ldarg.0
IL_0006: callvirt System.Void TheForestOfLove.UIPanelController::OnClose()
IL_000b: ldarg.0
IL_000c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenUiController::onResume
IL_0011: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0016: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_001b: ldnull
IL_001c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0021: brfalse.s IL_0046
IL_0023: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0028: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_002d: ldnull
IL_002e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0033: brfalse.s IL_0046
IL_0035: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_003a: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_003f: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_0044: br.s IL_0047
IL_0046: ldc.i4.0
IL_0047: brtrue.s IL_004e
IL_0049: call System.Void TheForestOfLove.ChapterSelectUI::ShowUi()
IL_004e: ret
