TYPE TheForestOfLove.PlantQuestMinigameUIController
METHOD System.Void TheForestOfLove.PlantQuestMinigameUIController::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: call !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_0007: stfld UnityEngine.Animator TheForestOfLove.PlantQuestMinigameUIController::animator
IL_000c: ldarg.0
IL_000d: ldarg.0
IL_000e: call !!0 UnityEngine.Component::GetComponentInParent<TheForestOfLove.PlantQuestMinigameControllerRedux>()
IL_0013: stfld TheForestOfLove.PlantQuestMinigameControllerRedux TheForestOfLove.PlantQuestMinigameUIController::minigameController
IL_0018: ldarg.0
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.UI.Text TheForestOfLove.PlantQuestMinigameUIController::timerContainer
IL_001f: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_0024: stfld UnityEngine.UI.Text[] TheForestOfLove.PlantQuestMinigameUIController::timerLabels
IL_0029: ldarg.0
IL_002a: ldarg.0
IL_002b: ldfld UnityEngine.UI.Text TheForestOfLove.PlantQuestMinigameUIController::timerContainer
IL_0030: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_0035: stfld UnityEngine.Animator TheForestOfLove.PlantQuestMinigameUIController::timerAnimator
IL_003a: ldarg.0
IL_003b: ldarg.0
IL_003c: ldfld UnityEngine.UI.Text TheForestOfLove.PlantQuestMinigameUIController::dashesContainer
IL_0041: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_0046: stfld UnityEngine.UI.Text[] TheForestOfLove.PlantQuestMinigameUIController::dashesLabels
IL_004b: ldarg.0
IL_004c: ldarg.0
IL_004d: ldfld UnityEngine.UI.Text TheForestOfLove.PlantQuestMinigameUIController::dashesContainer
IL_0052: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_0057: stfld UnityEngine.Animator TheForestOfLove.PlantQuestMinigameUIController::dashesAnimator
IL_005c: ldarg.0
IL_005d: ldarg.0
IL_005e: ldfld UnityEngine.UI.Text TheForestOfLove.PlantQuestMinigameUIController::instructionsContainer
IL_0063: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_0068: stfld UnityEngine.Animator TheForestOfLove.PlantQuestMinigameUIController::instructionsAnimator
IL_006d: ldarg.0
IL_006e: ldarg.0
IL_006f: ldfld UnityEngine.UI.Text TheForestOfLove.PlantQuestMinigameUIController::failureContainer
IL_0074: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_0079: stfld UnityEngine.Animator TheForestOfLove.PlantQuestMinigameUIController::failureAnimator
IL_007e: ldarg.0
IL_007f: ldarg.0
IL_0080: ldfld UnityEngine.UI.Text TheForestOfLove.PlantQuestMinigameUIController::buttonHintsContainer
IL_0085: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_008a: stfld UnityEngine.Animator TheForestOfLove.PlantQuestMinigameUIController::buttonHintsAnimator
IL_008f: ret
METHOD System.Void TheForestOfLove.PlantQuestMinigameUIController::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.PlantQuestMinigameUIController::UpdateAnimators()
IL_0006: ret
METHOD System.Void TheForestOfLove.PlantQuestMinigameUIController::LabelsNormal() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Animator TheForestOfLove.PlantQuestMinigameUIController::labelsAnimator
IL_0006: ldstr "oozing_alert"
IL_000b: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.Animator TheForestOfLove.PlantQuestMinigameUIController::labelsAnimator
IL_0016: ldstr "normal"
IL_001b: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_0020: ldarg.0
IL_0021: ldfld UnityEngine.Animator TheForestOfLove.PlantQuestMinigameUIController::labelsAnimator
IL_0026: ldstr "normal"
IL_002b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0030: ret
METHOD System.Void TheForestOfLove.PlantQuestMinigameUIController::LabelsOozingAlert() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Animator TheForestOfLove.PlantQuestMinigameUIController::labelsAnimator
IL_0006: ldstr "oozing_alert"
IL_000b: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.Animator TheForestOfLove.PlantQuestMinigameUIController::labelsAnimator
IL_0016: ldstr "normal"
IL_001b: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_0020: ldarg.0
IL_0021: ldfld UnityEngine.Animator TheForestOfLove.PlantQuestMinigameUIController::labelsAnimator
IL_0026: ldstr "oozing_alert"
IL_002b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0030: ret
