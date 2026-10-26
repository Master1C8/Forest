TYPE TheForestOfLove.DevTools.DevRoomController
METHOD System.Void TheForestOfLove.DevTools.DevRoomController::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4 279
IL_0005: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_000a: brfalse.s IL_0027
IL_000c: ldc.i4 304
IL_0011: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_0016: brfalse.s IL_0027
IL_0018: call System.Void TheForestOfLove.Services.Persistence.SaveManager::DeleteSavedPlaySession()
IL_001d: call System.Void TheForestOfLove.Services.Persistence.SaveManager::DeleteGlobalSettings()
IL_0022: call System.Void UnityEngine.Application::Quit()
IL_0027: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_002c: brfalse.s IL_003d
IL_002e: ldc.i4.s 120
IL_0030: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_0035: brfalse.s IL_003d
IL_0037: ldarg.0
IL_0038: call System.Void TheForestOfLove.DevTools.DevRoomController::TrySkipConversation()
IL_003d: ldc.i4.s 110
IL_003f: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_0044: brfalse.s IL_0064
IL_0046: ldarg.0
IL_0047: ldfld UnityEngine.Transform TheForestOfLove.DevTools.DevRoomController::critters
IL_004c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0051: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0056: brfalse.s IL_005f
IL_0058: call System.Void TheForestOfLove.DevTools.DevRoomController::OpenNavMap()
IL_005d: br.s IL_0064
IL_005f: call System.Void TheForestOfLove.DevTools.DevRoomController::SendPlayerHome()
IL_0064: ldc.i4.s 104
IL_0066: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_006b: brfalse.s IL_0072
IL_006d: call System.Void TheForestOfLove.DevTools.DevRoomController::SendPlayerHome()
IL_0072: ret
