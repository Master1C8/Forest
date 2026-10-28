TYPE TheForestOfLove.DashQuestController
METHOD System.Void TheForestOfLove.DashQuestController::InitArenaPhase() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.CollisionEventListener TheForestOfLove.DashQuestController::finishLine
IL_0006: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_000b: ldc.i4.0
IL_000c: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0011: ldarg.0
IL_0012: ldfld UnityEngine.Transform TheForestOfLove.DashQuestController::raceArena
IL_0017: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001c: ldc.i4.0
IL_001d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld UnityEngine.Transform TheForestOfLove.DashQuestController::dashrollArena
IL_0028: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_002d: ldc.i4.1
IL_002e: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0033: ldarg.0
IL_0034: ldc.i4.1
IL_0035: stfld System.Boolean TheForestOfLove.DashQuestController::waitingForPlayerToDashroll
IL_003a: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnDashQuestAbilityLearned()
IL_003f: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0044: callvirt System.Void TheForestOfLove.Player::CheckUnlockedDashroll()
IL_0049: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_004e: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0053: ldarg.0
IL_0054: ldfld TheForestOfLove.DashQuestReminderUI TheForestOfLove.DashQuestController::reminderUI
IL_0059: callvirt System.Void TheForestOfLove.DashQuestReminderUI::ActivateReminders()
IL_005e: ldarg.0
IL_005f: ldfld UnityEngine.GameObject TheForestOfLove.DashQuestController::squirrel
IL_0064: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren<TheForestOfLove.DialogueSettings>()
IL_0069: stloc.0
IL_006a: ldloc.0
IL_006b: ldnull
IL_006c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0071: brfalse.s IL_0089
IL_0073: ldloc.0
IL_0074: ldstr "DashQuest_RaceTheSquirrel"
IL_0079: callvirt System.Void TheForestOfLove.DialogueSettings::SetDialogueDbName(System.String)
IL_007e: ldloc.0
IL_007f: ldstr "waiting_for_dashroll"
IL_0084: callvirt System.Void TheForestOfLove.DialogueSettings::SetArcDbName(System.String)
IL_0089: ret
