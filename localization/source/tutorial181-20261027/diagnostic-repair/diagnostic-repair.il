TYPE ForestProbe
METHOD System.Void ForestProbe::ReadTutorialCompletionRecord(ForestProbe/State) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.1
IL_0002: ldfld System.Boolean ForestProbe/State::conversationActive
IL_0007: brfalse.s IL_0022
IL_0009: ldarg.1
IL_000a: ldfld System.Int32 ForestProbe/State::conversationId
IL_000f: ldc.i4.s 120
IL_0011: bne.un.s IL_0022
IL_0013: ldarg.1
IL_0014: ldfld System.Int32 ForestProbe/State::entryId
IL_0019: ldc.i4 158
IL_001e: ceq
IL_0020: br.s IL_0023
IL_0022: ldc.i4.0
IL_0023: stloc.0
IL_0024: ldloc.0
IL_0025: brfalse.s IL_00a4
IL_0027: nop
IL_0028: ldarg.1
IL_0029: ldarg.0
IL_002a: ldloca.s V_1
IL_002c: call ForestProbe/TutorialCompletion ForestProbe::ReadTutorialCompletion(UnityEngine.UI.Button&)
IL_0031: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_0036: stfld System.String ForestProbe/State::tutorialCompletionRecord
IL_003b: ldarg.1
IL_003c: ldfld System.Boolean ForestProbe/State::typing
IL_0041: brtrue.s IL_0053
IL_0043: ldarg.0
IL_0044: call System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_0049: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_004e: ldc.i4.2
IL_004f: ceq
IL_0051: br.s IL_0054
IL_0053: ldc.i4.0
IL_0054: stloc.2
IL_0055: ldloc.2
IL_0056: brfalse.s IL_00a3
IL_0058: nop
IL_0059: ldarg.1
IL_005a: ldarg.0
IL_005b: call ForestProbe/Tutorial181Control ForestProbe::ReadTutorial181Control()
IL_0060: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_0065: stfld System.String ForestProbe/State::tutorial181ControlRecord
IL_006a: nop
IL_006b: ldarg.1
IL_006c: ldarg.0
IL_006d: ldloca.s V_1
IL_006f: call ForestProbe/Tutorial181Selection ForestProbe::ReadTutorial181(UnityEngine.UI.Button&)
IL_0074: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_0079: stfld System.String ForestProbe/State::tutorial181Record
IL_007e: nop
IL_007f: leave.s IL_00a2
IL_0081: stloc.3
IL_0082: nop
IL_0083: ldarg.1
IL_0084: newobj System.Void ForestProbe/Tutorial181Rejection::.ctor()
IL_0089: dup
IL_008a: ldloc.3
IL_008b: callvirt System.String System.Exception::get_Message()
IL_0090: stfld System.String ForestProbe/Tutorial181Rejection::error
IL_0095: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_009a: stfld System.String ForestProbe/State::tutorial181Record
IL_009f: nop
IL_00a0: leave.s IL_00a2
IL_00a2: nop
IL_00a3: nop
IL_00a4: ret
METHOD ForestProbe/Tutorial181Control ForestProbe::ReadTutorial181Control() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void ForestProbe/Tutorial181Control::.ctor()
IL_0006: dup
IL_0007: ldc.i4.m1
IL_0008: stfld System.Int32 ForestProbe/Tutorial181Control::persistentListenerCount
IL_000d: stloc.0
IL_000e: nop
IL_000f: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUIResponseButton>()
IL_0014: stloc.1
IL_0015: ldc.i4.0
IL_0016: stloc.2
IL_0017: br IL_018e
IL_001c: ldloc.1
IL_001d: ldloc.2
IL_001e: ldelem.ref
IL_001f: stloc.3
IL_0020: ldloc.3
IL_0021: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0026: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_002b: stloc.s V_5
IL_002d: ldloca.s V_5
IL_002f: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0034: brfalse.s IL_0071
IL_0036: ldloc.3
IL_0037: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_003c: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0041: brfalse.s IL_0071
IL_0043: ldloc.3
IL_0044: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0049: brfalse.s IL_0071
IL_004b: ldloc.3
IL_004c: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0051: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0056: brfalse.s IL_0071
IL_0058: ldloc.3
IL_0059: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_005e: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0063: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0068: ldc.i4 181
IL_006d: ceq
IL_006f: br.s IL_0072
IL_0071: ldc.i4.0
IL_0072: stloc.s V_4
IL_0074: ldloc.s V_4
IL_0076: brfalse IL_018a
IL_007b: nop
IL_007c: ldloc.0
IL_007d: dup
IL_007e: ldfld System.Int32 ForestProbe/Tutorial181Control::matches
IL_0083: ldc.i4.1
IL_0084: add
IL_0085: stfld System.Int32 ForestProbe/Tutorial181Control::matches
IL_008a: ldloc.0
IL_008b: ldloc.3
IL_008c: callvirt System.Type System.Object::GetType()
IL_0091: callvirt System.String System.Type::get_FullName()
IL_0096: stfld System.String ForestProbe/Tutorial181Control::controllerType
IL_009b: ldloc.0
IL_009c: ldloc.3
IL_009d: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_00a2: stfld System.Boolean ForestProbe/Tutorial181Control::controllerEnabled
IL_00a7: ldloc.0
IL_00a8: ldloc.3
IL_00a9: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_00ae: stfld System.Int32 ForestProbe/Tutorial181Control::controllerInstance
IL_00b3: ldloc.0
IL_00b4: ldloc.3
IL_00b5: callvirt System.String PixelCrushers.DialogueSystem.StandardUIResponseButton::get_text()
IL_00ba: stfld System.String ForestProbe/Tutorial181Control::text
IL_00bf: ldloc.0
IL_00c0: ldloc.3
IL_00c1: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00c6: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_00cb: stfld System.String ForestProbe/Tutorial181Control::path
IL_00d0: ldloc.0
IL_00d1: ldloc.3
IL_00d2: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_00d7: ldnull
IL_00d8: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00dd: brtrue.s IL_00ec
IL_00df: ldloc.3
IL_00e0: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_00e5: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_00ea: br.s IL_00f1
IL_00ec: ldstr ""
IL_00f1: stfld System.String ForestProbe/Tutorial181Control::targetPath
IL_00f6: ldloc.0
IL_00f7: ldloc.3
IL_00f8: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isVisible()
IL_00fd: stfld System.Boolean ForestProbe/Tutorial181Control::visible
IL_0102: ldloc.0
IL_0103: ldloc.3
IL_0104: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isClickable()
IL_0109: stfld System.Boolean ForestProbe/Tutorial181Control::clickable
IL_010e: ldloc.3
IL_010f: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0114: stloc.s V_6
IL_0116: ldloc.s V_6
IL_0118: ldnull
IL_0119: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_011e: stloc.s V_7
IL_0120: ldloc.s V_7
IL_0122: brfalse.s IL_0189
IL_0124: nop
IL_0125: ldloc.0
IL_0126: ldloc.s V_6
IL_0128: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_012d: stfld System.Int32 ForestProbe/Tutorial181Control::buttonInstance
IL_0132: ldloc.0
IL_0133: ldloc.s V_6
IL_0135: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_013a: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_013f: stfld System.String ForestProbe/Tutorial181Control::buttonPath
IL_0144: ldloc.0
IL_0145: ldloc.s V_6
IL_0147: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_014c: stfld System.Boolean ForestProbe/Tutorial181Control::buttonEnabled
IL_0151: ldloc.0
IL_0152: ldloc.s V_6
IL_0154: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_0159: stfld System.Boolean ForestProbe/Tutorial181Control::buttonInteractable
IL_015e: ldloc.0
IL_015f: ldloc.s V_6
IL_0161: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0166: ldloc.3
IL_0167: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_016c: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0171: stfld System.Boolean ForestProbe/Tutorial181Control::sameTransform
IL_0176: ldloc.0
IL_0177: ldloc.s V_6
IL_0179: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_017e: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_0183: stfld System.Int32 ForestProbe/Tutorial181Control::persistentListenerCount
IL_0188: nop
IL_0189: nop
IL_018a: ldloc.2
IL_018b: ldc.i4.1
IL_018c: add
IL_018d: stloc.2
IL_018e: ldloc.2
IL_018f: ldloc.1
IL_0190: ldlen
IL_0191: conv.i4
IL_0192: blt IL_001c
IL_0197: ldloc.0
IL_0198: stloc.s V_8
IL_019a: br.s IL_019c
IL_019c: ldloc.s V_8
IL_019e: ret
