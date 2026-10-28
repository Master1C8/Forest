TYPE PixelCrushers.DialogueSystem.DialogueSystemTrigger
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::Fire(UnityEngine.Transform) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_0005: brfalse.s IL_002d
IL_0007: ldstr "Dialogue System: Dialogue System Trigger is firing "
IL_000c: ldarg.0
IL_000d: ldflda PixelCrushers.DialogueSystem.DialogueSystemTriggerEvent PixelCrushers.DialogueSystem.DialogueSystemTrigger::trigger
IL_0012: constrained. PixelCrushers.DialogueSystem.DialogueSystemTriggerEvent
IL_0018: callvirt System.String System.Object::ToString()
IL_001d: ldstr "."
IL_0022: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0027: ldarg.0
IL_0028: call System.Void UnityEngine.Debug::Log(System.Object,UnityEngine.Object)
IL_002d: ldarg.0
IL_002e: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::DoQuestAction()
IL_0033: ldarg.0
IL_0034: ldarg.1
IL_0035: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::DoLuaAction(UnityEngine.Transform)
IL_003a: ldarg.0
IL_003b: ldarg.1
IL_003c: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::DoSequenceAction(UnityEngine.Transform)
IL_0041: ldarg.0
IL_0042: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::DoAlertAction()
IL_0047: ldarg.0
IL_0048: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::DoSendMessageActions()
IL_004d: ldarg.0
IL_004e: ldarg.1
IL_004f: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::DoBarkAction(UnityEngine.Transform)
IL_0054: ldarg.0
IL_0055: ldarg.1
IL_0056: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::DoConversationAction(UnityEngine.Transform)
IL_005b: ldarg.0
IL_005c: ldarg.1
IL_005d: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::DoSetActiveActions(UnityEngine.Transform)
IL_0062: ldarg.0
IL_0063: ldarg.1
IL_0064: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::DoSetEnabledActions(UnityEngine.Transform)
IL_0069: ldarg.0
IL_006a: ldarg.1
IL_006b: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::DoSetAnimatorStateActions(UnityEngine.Transform)
IL_0070: ldarg.0
IL_0071: ldfld PixelCrushers.GameObjectUnityEvent PixelCrushers.DialogueSystem.DialogueSystemTrigger::onExecute
IL_0076: ldarg.1
IL_0077: ldnull
IL_0078: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_007d: brtrue.s IL_0082
IL_007f: ldnull
IL_0080: br.s IL_0088
IL_0082: ldarg.1
IL_0083: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0088: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.GameObject>::Invoke(!0)
IL_008d: call System.Void PixelCrushers.DialogueSystem.DialogueManager::SendUpdateTracker()
IL_0092: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::DoConversationAction(UnityEngine.Transform) | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String PixelCrushers.DialogueSystem.DialogueSystemTrigger::conversation
IL_0006: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000b: brfalse.s IL_000e
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemTrigger::replace
IL_0014: brfalse.s IL_0063
IL_0016: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_001b: brfalse.s IL_0063
IL_001d: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_0022: brfalse.s IL_005e
IL_0024: ldc.i4.5
IL_0025: newarr System.String
IL_002a: dup
IL_002b: ldc.i4.0
IL_002c: ldstr "Dialogue System: Stopping current active conversation "
IL_0031: stelem.ref
IL_0032: dup
IL_0033: ldc.i4.1
IL_0034: call System.String PixelCrushers.DialogueSystem.DialogueManager::get_lastConversationStarted()
IL_0039: stelem.ref
IL_003a: dup
IL_003b: ldc.i4.2
IL_003c: ldstr " and starting "
IL_0041: stelem.ref
IL_0042: dup
IL_0043: ldc.i4.3
IL_0044: ldarg.0
IL_0045: ldfld System.String PixelCrushers.DialogueSystem.DialogueSystemTrigger::conversation
IL_004a: stelem.ref
IL_004b: dup
IL_004c: ldc.i4.4
IL_004d: ldstr "."
IL_0052: stelem.ref
IL_0053: call System.String System.String::Concat(System.String[])
IL_0058: ldarg.0
IL_0059: call System.Void UnityEngine.Debug::Log(System.Object,UnityEngine.Object)
IL_005e: call System.Void PixelCrushers.DialogueSystem.DialogueManager::StopConversation()
IL_0063: ldarg.0
IL_0064: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemTrigger::exclusive
IL_0069: brfalse.s IL_0098
IL_006b: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0070: brfalse.s IL_0098
IL_0072: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_0077: brfalse IL_01db
IL_007c: ldstr "Dialogue System: Conversation triggered on "
IL_0081: ldarg.0
IL_0082: call System.String UnityEngine.Object::get_name()
IL_0087: ldstr " but skipping because another conversation is active."
IL_008c: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0091: ldarg.0
IL_0092: call System.Void UnityEngine.Debug::Log(System.Object,UnityEngine.Object)
IL_0097: ret
IL_0098: ldc.i4.2
IL_0099: newarr UnityEngine.Transform
IL_009e: dup
IL_009f: ldc.i4.0
IL_00a0: ldarg.0
IL_00a1: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.DialogueSystemTrigger::conversationActor
IL_00a6: stelem.ref
IL_00a7: dup
IL_00a8: ldc.i4.1
IL_00a9: ldarg.1
IL_00aa: stelem.ref
IL_00ab: call UnityEngine.Transform PixelCrushers.DialogueSystem.Tools::Select(UnityEngine.Transform[])
IL_00b0: stloc.0
IL_00b1: ldarg.0
IL_00b2: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.DialogueSystemTrigger::conversationConversant
IL_00b7: stloc.1
IL_00b8: ldloc.1
IL_00b9: ldnull
IL_00ba: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00bf: brfalse.s IL_0111
IL_00c1: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueManager::get_MasterDatabase()
IL_00c6: ldarg.0
IL_00c7: ldfld System.String PixelCrushers.DialogueSystem.DialogueSystemTrigger::conversation
IL_00cc: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)
IL_00d1: stloc.2
IL_00d2: ldloc.2
IL_00d3: brtrue.s IL_00d8
IL_00d5: ldnull
IL_00d6: br.s IL_00e8
IL_00d8: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueManager::get_MasterDatabase()
IL_00dd: ldloc.2
IL_00de: callvirt System.Int32 PixelCrushers.DialogueSystem.Conversation::get_ConversantID()
IL_00e3: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32)
IL_00e8: stloc.3
IL_00e9: ldloc.3
IL_00ea: brtrue.s IL_00ef
IL_00ec: ldnull
IL_00ed: br.s IL_00fa
IL_00ef: ldloc.3
IL_00f0: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_00f5: call UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::GetRegisteredActorTransform(System.String)
IL_00fa: stloc.s V_4
IL_00fc: ldloc.s V_4
IL_00fe: ldnull
IL_00ff: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0104: brtrue.s IL_010e
IL_0106: ldarg.0
IL_0107: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_010c: br.s IL_0110
IL_010e: ldloc.s V_4
IL_0110: stloc.1
IL_0111: ldarg.0
IL_0112: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemTrigger::skipIfNoValidEntries
IL_0117: brfalse.s IL_0154
IL_0119: ldarg.0
IL_011a: ldfld System.String PixelCrushers.DialogueSystem.DialogueSystemTrigger::conversation
IL_011f: ldloc.0
IL_0120: ldloc.1
IL_0121: ldarg.0
IL_0122: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueSystemTrigger::startConversationEntryID
IL_0127: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::ConversationHasValidEntry(System.String,UnityEngine.Transform,UnityEngine.Transform,System.Int32)
IL_012c: brtrue.s IL_0154
IL_012e: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_0133: brfalse IL_01db
IL_0138: ldstr "Dialogue System: Conversation triggered on "
IL_013d: ldarg.0
IL_013e: call System.String UnityEngine.Object::get_name()
IL_0143: ldstr " but skipping because no entries are currently valid."
IL_0148: call System.String System.String::Concat(System.String,System.String,System.String)
IL_014d: ldarg.0
IL_014e: call System.Void UnityEngine.Debug::Log(System.Object,UnityEngine.Object)
IL_0153: ret
IL_0154: ldarg.0
IL_0155: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemTrigger::stopConversationIfTooFar
IL_015a: brtrue.s IL_016c
IL_015c: ldarg.0
IL_015d: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemTrigger::showCursorDuringConversation
IL_0162: brtrue.s IL_016c
IL_0164: ldarg.0
IL_0165: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemTrigger::pauseGameDuringConversation
IL_016a: brfalse.s IL_0198
IL_016c: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0171: ldarg.0
IL_0172: ldftn System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::OnConversationStartAnywhere(UnityEngine.Transform)
IL_0178: newobj System.Void PixelCrushers.DialogueSystem.TransformDelegate::.ctor(System.Object,System.IntPtr)
IL_017d: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemController::add_conversationStarted(PixelCrushers.DialogueSystem.TransformDelegate)
IL_0182: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0187: ldarg.0
IL_0188: ldftn System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::OnConversationEndAnywhere(UnityEngine.Transform)
IL_018e: newobj System.Void PixelCrushers.DialogueSystem.TransformDelegate::.ctor(System.Object,System.IntPtr)
IL_0193: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemController::add_conversationEnded(PixelCrushers.DialogueSystem.TransformDelegate)
IL_0198: ldarg.0
IL_0199: ldfld System.String PixelCrushers.DialogueSystem.DialogueSystemTrigger::conversation
IL_019e: ldloc.0
IL_019f: ldloc.1
IL_01a0: ldarg.0
IL_01a1: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueSystemTrigger::startConversationEntryID
IL_01a6: call System.Void PixelCrushers.DialogueSystem.DialogueManager::StartConversation(System.String,UnityEngine.Transform,UnityEngine.Transform,System.Int32)
IL_01ab: ldarg.0
IL_01ac: call System.Single UnityEngine.Time::get_time()
IL_01b1: ldc.r4 0.2
IL_01b6: add
IL_01b7: stfld System.Single PixelCrushers.DialogueSystem.DialogueSystemTrigger::earliestTimeToAllowTriggerExit
IL_01bc: ldarg.0
IL_01bd: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemTrigger::stopConversationIfTooFar
IL_01c2: brfalse.s IL_01db
IL_01c4: ldarg.0
IL_01c5: ldarg.0
IL_01c6: ldarg.0
IL_01c7: call UnityEngine.Transform PixelCrushers.DialogueSystem.DialogueManager::get_currentActor()
IL_01cc: call System.Collections.IEnumerator PixelCrushers.DialogueSystem.DialogueSystemTrigger::MonitorDistance(UnityEngine.Transform)
IL_01d1: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_01d6: stfld UnityEngine.Coroutine PixelCrushers.DialogueSystem.DialogueSystemTrigger::monitorDistanceCoroutine
IL_01db: ret
