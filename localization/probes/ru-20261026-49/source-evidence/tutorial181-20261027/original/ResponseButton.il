TYPE PixelCrushers.DialogueSystem.StandardUIResponseButton
METHOD System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::Awake() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_001a
IL_000e: ldarg.0
IL_000f: ldarg.0
IL_0010: call !!0 UnityEngine.Component::GetComponent<UnityEngine.UI.Button>()
IL_0015: stfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_001a: ldarg.0
IL_001b: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0020: ldnull
IL_0021: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0026: brfalse.s IL_0043
IL_0028: ldstr "Dialogue System: Response button '"
IL_002d: ldarg.0
IL_002e: call System.String UnityEngine.Object::get_name()
IL_0033: ldstr "' is missing a Unity UI Button component!"
IL_0038: call System.String System.String::Concat(System.String,System.String,System.String)
IL_003d: ldarg.0
IL_003e: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_0043: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::Start() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_003d
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0014: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0019: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_001e: brtrue.s IL_003d
IL_0020: ldarg.0
IL_0021: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0026: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_002b: ldarg.0
IL_002c: dup
IL_002d: ldvirtftn System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::OnClick()
IL_0033: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0038: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_003d: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::OnClick() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: call UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_002b
IL_000e: ldarg.0
IL_000f: callvirt System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::SetCurrentResponse()
IL_0014: ldarg.0
IL_0015: call UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_001a: ldstr "OnClick"
IL_001f: ldarg.0
IL_0020: call PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0025: ldc.i4.0
IL_0026: callvirt System.Void UnityEngine.Component::SendMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_002b: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::SetCurrentResponse() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0005: callvirt PixelCrushers.DialogueSystem.ConversationController PixelCrushers.DialogueSystem.DialogueSystemController::get_conversationController()
IL_000a: brfalse.s IL_0021
IL_000c: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0011: callvirt PixelCrushers.DialogueSystem.ConversationController PixelCrushers.DialogueSystem.DialogueSystemController::get_conversationController()
IL_0016: ldarg.0
IL_0017: call PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_001c: callvirt System.Void PixelCrushers.DialogueSystem.ConversationController::SetCurrentResponse(PixelCrushers.DialogueSystem.Response)
IL_0021: ret
