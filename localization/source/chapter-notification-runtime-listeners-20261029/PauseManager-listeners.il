TYPE TheForestOfLove.PauseScreenUIManager
METHOD System.Void TheForestOfLove.PauseScreenUIManager::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.PauseScreenUiController TheForestOfLove.PauseScreenUIManager::pauseScreenUi
IL_000c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenUiController::onResume
IL_0011: ldarg.0
IL_0012: ldftn System.Void TheForestOfLove.PauseScreenUIManager::OnResume()
IL_0018: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_001d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.PauseScreenUiController TheForestOfLove.PauseScreenUIManager::pauseScreenUi
IL_0028: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenUiController::onLoadStartMenu
IL_002d: ldarg.0
IL_002e: ldftn System.Void TheForestOfLove.PauseScreenUIManager::LoadStartMenu()
IL_0034: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0039: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_003e: ldarg.0
IL_003f: ldfld TheForestOfLove.PauseScreenUiController TheForestOfLove.PauseScreenUIManager::pauseScreenUi
IL_0044: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenUiController::onQuit
IL_0049: ldarg.0
IL_004a: ldftn System.Void TheForestOfLove.PauseScreenUIManager::Quit()
IL_0050: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0055: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_005a: ldarg.0
IL_005b: ldfld TheForestOfLove.PauseScreenUiController TheForestOfLove.PauseScreenUIManager::pauseScreenUi
IL_0060: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenUiController::onLoadCentralForest
IL_0065: ldarg.0
IL_0066: ldftn System.Void TheForestOfLove.PauseScreenUIManager::LoadCentralForest()
IL_006c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0071: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0076: ldarg.0
IL_0077: ldfld TheForestOfLove.PauseScreenUiController TheForestOfLove.PauseScreenUIManager::pauseScreenUi
IL_007c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenUiController::onLoadDustinMinigame
IL_0081: ldarg.0
IL_0082: ldftn System.Void TheForestOfLove.PauseScreenUIManager::LoadDustinMinigame()
IL_0088: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_008d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0092: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onPause
IL_0097: ldarg.0
IL_0098: ldftn System.Void TheForestOfLove.PauseScreenUIManager::OnPause()
IL_009e: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00a3: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00a8: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onUnpause
IL_00ad: ldarg.0
IL_00ae: ldftn System.Void TheForestOfLove.PauseScreenUIManager::OnResume()
IL_00b4: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00b9: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00be: ret
