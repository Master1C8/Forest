TYPE TheForestOfLove.RamAnalMovie
METHOD System.Void TheForestOfLove.RamAnalMovie::SetFSMParamCanAdvance(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.RamAnalMovie::waitingOnConversation
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld System.Boolean TheForestOfLove.RamAnalMovie::debugSimulateStartMenu
IL_000f: brtrue.s IL_0035
IL_0011: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0016: brtrue.s IL_0035
IL_0018: ldarg.0
IL_0019: ldfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipCurrentLoops
IL_001e: ldarg.0
IL_001f: ldfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipMinLoops
IL_0024: bge.s IL_0035
IL_0026: ldarg.0
IL_0027: ldarg.0
IL_0028: ldfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipCurrentLoops
IL_002d: ldc.i4.1
IL_002e: add
IL_002f: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipCurrentLoops
IL_0034: ret
IL_0035: ldarg.0
IL_0036: ldarg.0
IL_0037: ldfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipCurrentLoops
IL_003c: ldc.i4.1
IL_003d: add
IL_003e: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipCurrentLoops
IL_0043: ldarg.0
IL_0044: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_0049: ldstr "FinleyRascalFinal_Edited_Cum_T_Entry"
IL_004e: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_0053: brfalse.s IL_0062
IL_0055: ldarg.1
IL_0056: ldstr "FinleyRascalFinal_Edited_Cum_L_Penetration"
IL_005b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0060: brtrue.s IL_0081
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_0068: ldstr "FinleyRascalFinal_Edited_Cum_T_Pullout"
IL_006d: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_0072: brfalse.s IL_00a4
IL_0074: ldarg.1
IL_0075: ldstr "FinleyRascalFinal_Edited_Cum_L_Afterglow"
IL_007a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_007f: brfalse.s IL_00a4
IL_0081: ldarg.0
IL_0082: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.RamAnalMovie::blackboard
IL_0087: ldstr "canAdvance"
IL_008c: ldc.i4.1
IL_008d: box System.Boolean
IL_0092: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0097: pop
IL_0098: ldarg.0
IL_0099: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.RamAnalMovie::fsm
IL_009e: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_00a3: ret
IL_00a4: ldarg.0
IL_00a5: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00aa: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_00af: brfalse.s IL_00bf
IL_00b1: ldarg.0
IL_00b2: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00b7: ldarg.1
IL_00b8: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_00bd: brfalse.s IL_010a
IL_00bf: ldarg.0
IL_00c0: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.RamAnalMovie::blackboard
IL_00c5: ldstr "canAdvance"
IL_00ca: ldc.i4.1
IL_00cb: box System.Boolean
IL_00d0: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_00d5: pop
IL_00d6: ldarg.0
IL_00d7: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.RamAnalMovie::fsm
IL_00dc: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_00e1: ldarg.0
IL_00e2: ldfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipCurrentLoops
IL_00e7: ldc.i4.1
IL_00e8: blt.s IL_010a
IL_00ea: ldarg.0
IL_00eb: ldfld System.Boolean TheForestOfLove.RamAnalMovie::showNextButtonWhenCanAdvance
IL_00f0: brfalse.s IL_010a
IL_00f2: ldarg.0
IL_00f3: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.RamAnalMovie::movieWrapper
IL_00f8: callvirt System.Boolean TheForestOfLove.MovieWrapper::get_isNextButtonVisible()
IL_00fd: brtrue.s IL_010a
IL_00ff: ldarg.0
IL_0100: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.RamAnalMovie::movieWrapper
IL_0105: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_010a: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::PullFSMCurrentJumpStateNames() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.RamAnalMovie::blackboard
IL_0007: ldstr "jumpBackStateName"
IL_000c: callvirt !!0 NodeCanvas.Framework.Blackboard::GetVariableValue<System.String>(System.String)
IL_0011: stfld System.String TheForestOfLove.RamAnalMovie::currentJumpBackStateName
IL_0016: ldarg.0
IL_0017: ldarg.0
IL_0018: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.RamAnalMovie::blackboard
IL_001d: ldstr "jumpAheadStateName"
IL_0022: callvirt !!0 NodeCanvas.Framework.Blackboard::GetVariableValue<System.String>(System.String)
IL_0027: stfld System.String TheForestOfLove.RamAnalMovie::currentJumpAheadStateName
IL_002c: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::ClearFSMParamCanAdvance() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.RamAnalMovie::blackboard
IL_0006: ldstr "canAdvance"
IL_000b: ldc.i4.0
IL_000c: box System.Boolean
IL_0011: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0016: pop
IL_0017: ldarg.0
IL_0018: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.RamAnalMovie::fsm
IL_001d: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0022: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::ClearFSMParamCanAdvance(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.RamAnalMovie::ClearFSMParamCanAdvance()
IL_0006: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::ClearFSMAdvanceTriggers() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.RamAnalMovie::blackboard
IL_0006: ldstr "canAdvance"
IL_000b: ldc.i4.0
IL_000c: box System.Boolean
IL_0011: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0016: pop
IL_0017: ldarg.0
IL_0018: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.RamAnalMovie::blackboard
IL_001d: ldstr "advanceTrigger"
IL_0022: ldc.i4.0
IL_0023: box System.Boolean
IL_0028: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_002d: pop
IL_002e: ldarg.0
IL_002f: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.RamAnalMovie::fsm
IL_0034: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0039: ldarg.0
IL_003a: ldnull
IL_003b: stfld System.Action TheForestOfLove.RamAnalMovie::onAdvanceActionOverride
IL_0040: ldarg.0
IL_0041: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.RamAnalMovie::movieWrapper
IL_0046: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_004b: ldarg.0
IL_004c: ldc.i4.0
IL_004d: stfld System.Boolean TheForestOfLove.RamAnalMovie::showNextButtonWhenCanAdvance
IL_0052: ldarg.0
IL_0053: ldc.i4.0
IL_0054: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipMinLoops
IL_0059: ldarg.0
IL_005a: ldc.i4.0
IL_005b: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipCurrentLoops
IL_0060: ldarg.0
IL_0061: call System.Void TheForestOfLove.RamAnalMovie::ClearAnimatorTriggers()
IL_0066: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::SetFSMAdvanceTrigger() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.RamAnalMovie::waitingOnConversation
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.RamAnalMovie::blackboard
IL_000f: ldstr "advanceTrigger"
IL_0014: ldc.i4.1
IL_0015: box System.Boolean
IL_001a: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_001f: pop
IL_0020: ldarg.0
IL_0021: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.RamAnalMovie::fsm
IL_0026: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_002b: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::ClearFSMAdvanceTrigger() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.RamAnalMovie::blackboard
IL_0006: ldstr "advanceTrigger"
IL_000b: ldc.i4.0
IL_000c: box System.Boolean
IL_0011: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0016: pop
IL_0017: ldarg.0
IL_0018: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.RamAnalMovie::fsm
IL_001d: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0022: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::SetRedBTreeTriggerName(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.RamAnalMovie::redBlinksBehaviorTree
IL_0006: callvirt System.Boolean NodeCanvas.Framework.GraphOwner::get_isRunning()
IL_000b: brtrue.s IL_0018
IL_000d: ldarg.0
IL_000e: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.RamAnalMovie::redBlinksBehaviorTree
IL_0013: callvirt System.Void NodeCanvas.Framework.GraphOwner::StartBehaviour()
IL_0018: ldarg.0
IL_0019: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.RamAnalMovie::redBlinksBehaviorTree
IL_001e: callvirt NodeCanvas.Framework.IBlackboard NodeCanvas.Framework.GraphOwner::get_blackboard()
IL_0023: callvirt System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable> NodeCanvas.Framework.IBlackboard::get_variables()
IL_0028: ldstr "triggerName"
IL_002d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable>::get_Item(!0)
IL_0032: ldarg.1
IL_0033: callvirt System.Void NodeCanvas.Framework.Variable::set_value(System.Object)
IL_0038: ldarg.0
IL_0039: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.RamAnalMovie::redBlinksBehaviorTree
IL_003e: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0043: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::SetFinleyBTreeTriggerName(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.RamAnalMovie::finleyBlinksBehaviorTree
IL_0006: callvirt System.Boolean NodeCanvas.Framework.GraphOwner::get_isRunning()
IL_000b: brtrue.s IL_0018
IL_000d: ldarg.0
IL_000e: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.RamAnalMovie::finleyBlinksBehaviorTree
IL_0013: callvirt System.Void NodeCanvas.Framework.GraphOwner::StartBehaviour()
IL_0018: ldarg.0
IL_0019: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.RamAnalMovie::finleyBlinksBehaviorTree
IL_001e: callvirt NodeCanvas.Framework.IBlackboard NodeCanvas.Framework.GraphOwner::get_blackboard()
IL_0023: callvirt System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable> NodeCanvas.Framework.IBlackboard::get_variables()
IL_0028: ldstr "triggerName"
IL_002d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable>::get_Item(!0)
IL_0032: ldarg.1
IL_0033: callvirt System.Void NodeCanvas.Framework.Variable::set_value(System.Object)
IL_0038: ldarg.0
IL_0039: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.RamAnalMovie::finleyBlinksBehaviorTree
IL_003e: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0043: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::OnFSMStateDefault() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.RamAnalMovie::awakened
IL_0006: brfalse.s IL_0010
IL_0008: ldarg.0
IL_0009: ldfld System.Boolean TheForestOfLove.RamAnalMovie::wrapperFinishedFading
IL_000e: brtrue.s IL_0011
IL_0010: ret
IL_0011: ldarg.0
IL_0012: call System.Void TheForestOfLove.RamAnalMovie::ClearFSMAdvanceTriggers()
IL_0017: ldarg.0
IL_0018: call System.Void TheForestOfLove.RamAnalMovie::HideAllLayers()
IL_001d: ldarg.0
IL_001e: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::redBlinks
IL_0023: ldc.r4 1
IL_0028: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002d: ldarg.0
IL_002e: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::finleyBlinks
IL_0033: ldc.r4 1
IL_0038: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_003d: ldarg.0
IL_003e: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_0043: ldc.r4 1
IL_0048: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_004d: ldarg.0
IL_004e: ldstr "main"
IL_0053: call System.Void TheForestOfLove.RamAnalMovie::SetRedBTreeTriggerName(System.String)
IL_0058: ldarg.0
IL_0059: ldstr "main"
IL_005e: call System.Void TheForestOfLove.RamAnalMovie::SetFinleyBTreeTriggerName(System.String)
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::redBlinks
IL_0069: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_006e: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0073: ldstr "loop"
IL_0078: ldc.i4.0
IL_0079: callvirt System.Void UnityEngine.Animator::SetInteger(System.String,System.Int32)
IL_007e: ldarg.0
IL_007f: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::finleyBlinks
IL_0084: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0089: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_008e: ldstr "loop"
IL_0093: ldc.i4.0
IL_0094: callvirt System.Void UnityEngine.Animator::SetInteger(System.String,System.Int32)
IL_0099: ldarg.0
IL_009a: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_009f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00a4: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_00a9: ldstr "idle"
IL_00ae: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00b3: ldarg.0
IL_00b4: call System.Void TheForestOfLove.RamAnalMovie::UnsubscribeAllLayerEventListeners()
IL_00b9: ldarg.0
IL_00ba: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_00bf: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00c4: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_00c9: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_00ce: ldarg.0
IL_00cf: ldftn System.Void TheForestOfLove.RamAnalMovie::SetFSMParamCanAdvance(System.String)
IL_00d5: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00da: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00df: ldarg.0
IL_00e0: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00e5: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00ea: ldarg.0
IL_00eb: call System.Void TheForestOfLove.RamAnalMovie::SetFSMAdvanceTrigger()
IL_00f0: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::OnFSMStateIdle() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.RamAnalMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.RamAnalMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::redBlinks
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::finleyBlinks
IL_0022: ldc.r4 1
IL_0027: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_0032: ldc.r4 1
IL_0037: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_003c: ldarg.0
IL_003d: ldstr "main"
IL_0042: call System.Void TheForestOfLove.RamAnalMovie::SetRedBTreeTriggerName(System.String)
IL_0047: ldarg.0
IL_0048: ldstr "main"
IL_004d: call System.Void TheForestOfLove.RamAnalMovie::SetFinleyBTreeTriggerName(System.String)
IL_0052: ldarg.0
IL_0053: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::redBlinks
IL_0058: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_005d: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0062: ldstr "loop"
IL_0067: ldc.i4.0
IL_0068: callvirt System.Void UnityEngine.Animator::SetInteger(System.String,System.Int32)
IL_006d: ldarg.0
IL_006e: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::finleyBlinks
IL_0073: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0078: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_007d: ldstr "loop"
IL_0082: ldc.i4.0
IL_0083: callvirt System.Void UnityEngine.Animator::SetInteger(System.String,System.Int32)
IL_0088: ldarg.0
IL_0089: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_008e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0093: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0098: ldstr "idle"
IL_009d: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00a2: ldarg.0
IL_00a3: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_00a8: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00ad: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_00b2: ldstr "idle"
IL_00b7: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00bc: ldarg.0
IL_00bd: call System.Void TheForestOfLove.RamAnalMovie::UnsubscribeAllLayerEventListeners()
IL_00c2: ldarg.0
IL_00c3: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_00c8: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00cd: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_00d2: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_00d7: ldarg.0
IL_00d8: ldftn System.Void TheForestOfLove.RamAnalMovie::SetFSMParamCanAdvance(System.String)
IL_00de: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00e3: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00e8: ldarg.0
IL_00e9: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00ee: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00f3: ldarg.0
IL_00f4: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00f9: ldstr "FinleyRascalFinal_Edited_Cum_CUSTOM_idle"
IL_00fe: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0103: ldarg.0
IL_0104: ldfld System.Boolean TheForestOfLove.RamAnalMovie::debugSkipConvos
IL_0109: brtrue.s IL_0112
IL_010b: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0110: brfalse.s IL_0120
IL_0112: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0117: brfalse.s IL_0156
IL_0119: ldsfld System.Boolean Globals::allowDialogueInStartMenu
IL_011e: brfalse.s IL_0156
IL_0120: ldarg.0
IL_0121: ldfld System.Int32 TheForestOfLove.RamAnalMovie::currentRound
IL_0126: ldc.i4.1
IL_0127: bne.un.s IL_0156
IL_0129: ldarg.0
IL_012a: ldc.i4.0
IL_012b: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipMinLoops
IL_0130: ldarg.0
IL_0131: ldc.i4.0
IL_0132: stfld System.Boolean TheForestOfLove.RamAnalMovie::showNextButtonWhenCanAdvance
IL_0137: ldarg.0
IL_0138: ldc.i4.1
IL_0139: stfld System.Boolean TheForestOfLove.RamAnalMovie::waitingOnConversation
IL_013e: ldc.r4 0.5
IL_0143: ldarg.0
IL_0144: ldftn System.Void TheForestOfLove.RamAnalMovie::<OnFSMStateIdle>b__96_0()
IL_014a: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_014f: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0154: br.s IL_0169
IL_0156: ldarg.0
IL_0157: ldarg.0
IL_0158: ldfld System.Int32 TheForestOfLove.RamAnalMovie::minLoopsIdle
IL_015d: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipMinLoops
IL_0162: ldarg.0
IL_0163: ldc.i4.1
IL_0164: stfld System.Boolean TheForestOfLove.RamAnalMovie::showNextButtonWhenCanAdvance
IL_0169: ldarg.0
IL_016a: call System.Void TheForestOfLove.RamAnalMovie::TickAllLayerAnimators()
IL_016f: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::OnFSMStateIdleToPenetration() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.RamAnalMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.RamAnalMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_0022: ldc.r4 1
IL_0027: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002c: ldarg.0
IL_002d: ldstr ""
IL_0032: call System.Void TheForestOfLove.RamAnalMovie::SetRedBTreeTriggerName(System.String)
IL_0037: ldarg.0
IL_0038: ldstr ""
IL_003d: call System.Void TheForestOfLove.RamAnalMovie::SetFinleyBTreeTriggerName(System.String)
IL_0042: ldarg.0
IL_0043: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_0048: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_004d: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0052: ldstr "idle_to_penetration"
IL_0057: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_005c: ldarg.0
IL_005d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_0062: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0067: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_006c: ldstr "idle_to_penetration"
IL_0071: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0076: ldarg.0
IL_0077: call System.Void TheForestOfLove.RamAnalMovie::UnsubscribeAllLayerEventListeners()
IL_007c: ldarg.0
IL_007d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_0082: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0087: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_008c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0091: ldarg.0
IL_0092: ldftn System.Void TheForestOfLove.RamAnalMovie::SetFSMParamCanAdvance(System.String)
IL_0098: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_009d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00a2: ldarg.0
IL_00a3: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00a8: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00ad: ldarg.0
IL_00ae: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00b3: ldstr "FinleyRascalFinal_Edited_Cum_T_Entry"
IL_00b8: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00bd: ldarg.0
IL_00be: ldc.i4.0
IL_00bf: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipMinLoops
IL_00c4: ldarg.0
IL_00c5: ldc.i4.0
IL_00c6: stfld System.Boolean TheForestOfLove.RamAnalMovie::showNextButtonWhenCanAdvance
IL_00cb: ldarg.0
IL_00cc: call System.Void TheForestOfLove.RamAnalMovie::TickAllLayerAnimators()
IL_00d1: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::OnFSMStatePenetration() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.RamAnalMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.RamAnalMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::redBlinks
IL_0022: ldc.r4 1
IL_0027: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_0032: ldc.r4 1
IL_0037: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_003c: ldarg.0
IL_003d: ldstr "main"
IL_0042: call System.Void TheForestOfLove.RamAnalMovie::SetRedBTreeTriggerName(System.String)
IL_0047: ldarg.0
IL_0048: ldstr ""
IL_004d: call System.Void TheForestOfLove.RamAnalMovie::SetFinleyBTreeTriggerName(System.String)
IL_0052: ldarg.0
IL_0053: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::redBlinks
IL_0058: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_005d: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0062: ldstr "loop"
IL_0067: ldc.i4.1
IL_0068: callvirt System.Void UnityEngine.Animator::SetInteger(System.String,System.Int32)
IL_006d: ldarg.0
IL_006e: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_0073: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0078: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_007d: ldstr "penetration_loop"
IL_0082: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0087: ldarg.0
IL_0088: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_008d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0092: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0097: ldstr "penetration_loop"
IL_009c: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00a1: ldarg.0
IL_00a2: call System.Void TheForestOfLove.RamAnalMovie::UnsubscribeAllLayerEventListeners()
IL_00a7: ldarg.0
IL_00a8: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_00ad: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00b2: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_00b7: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_00bc: ldarg.0
IL_00bd: ldftn System.Void TheForestOfLove.RamAnalMovie::SetFSMParamCanAdvance(System.String)
IL_00c3: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00c8: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00cd: ldarg.0
IL_00ce: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00d3: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00d8: ldarg.0
IL_00d9: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00de: ldstr "FinleyRascalFinal_Edited_Cum_L_Penetration"
IL_00e3: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00e8: ldarg.0
IL_00e9: ldarg.0
IL_00ea: ldfld System.Int32 TheForestOfLove.RamAnalMovie::minLoopsPenetration
IL_00ef: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipMinLoops
IL_00f4: ldarg.0
IL_00f5: ldc.i4.1
IL_00f6: stfld System.Boolean TheForestOfLove.RamAnalMovie::showNextButtonWhenCanAdvance
IL_00fb: ldarg.0
IL_00fc: call System.Void TheForestOfLove.RamAnalMovie::TickAllLayerAnimators()
IL_0101: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::OnFSMStatePenetrationToKnotted() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.RamAnalMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.RamAnalMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_0022: ldc.r4 1
IL_0027: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002c: ldarg.0
IL_002d: ldstr ""
IL_0032: call System.Void TheForestOfLove.RamAnalMovie::SetRedBTreeTriggerName(System.String)
IL_0037: ldarg.0
IL_0038: ldstr ""
IL_003d: call System.Void TheForestOfLove.RamAnalMovie::SetFinleyBTreeTriggerName(System.String)
IL_0042: ldarg.0
IL_0043: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_0048: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_004d: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0052: ldstr "penetration_to_knotted"
IL_0057: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_005c: ldarg.0
IL_005d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_0062: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0067: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_006c: ldstr "penetration_to_knotted"
IL_0071: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0076: ldarg.0
IL_0077: call System.Void TheForestOfLove.RamAnalMovie::UnsubscribeAllLayerEventListeners()
IL_007c: ldarg.0
IL_007d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_0082: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0087: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_008c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0091: ldarg.0
IL_0092: ldftn System.Void TheForestOfLove.RamAnalMovie::SetFSMParamCanAdvance(System.String)
IL_0098: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_009d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00a2: ldarg.0
IL_00a3: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00a8: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00ad: ldarg.0
IL_00ae: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00b3: ldstr "FinleyRascalFinal_Edited_Cum_T_Relaxing"
IL_00b8: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00bd: ldarg.0
IL_00be: ldc.i4.0
IL_00bf: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipMinLoops
IL_00c4: ldarg.0
IL_00c5: ldc.i4.0
IL_00c6: stfld System.Boolean TheForestOfLove.RamAnalMovie::showNextButtonWhenCanAdvance
IL_00cb: ldarg.0
IL_00cc: call System.Void TheForestOfLove.RamAnalMovie::TickAllLayerAnimators()
IL_00d1: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::OnFSMStateKnotted() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.RamAnalMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.RamAnalMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::redBlinks
IL_0022: ldc.r4 1
IL_0027: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::finleyBlinks
IL_0032: ldc.r4 1
IL_0037: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_0042: ldc.r4 1
IL_0047: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_004c: ldarg.0
IL_004d: ldstr "main"
IL_0052: call System.Void TheForestOfLove.RamAnalMovie::SetRedBTreeTriggerName(System.String)
IL_0057: ldarg.0
IL_0058: ldstr "main"
IL_005d: call System.Void TheForestOfLove.RamAnalMovie::SetFinleyBTreeTriggerName(System.String)
IL_0062: ldarg.0
IL_0063: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::redBlinks
IL_0068: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_006d: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0072: ldstr "loop"
IL_0077: ldc.i4.2
IL_0078: callvirt System.Void UnityEngine.Animator::SetInteger(System.String,System.Int32)
IL_007d: ldarg.0
IL_007e: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::finleyBlinks
IL_0083: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0088: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_008d: ldstr "loop"
IL_0092: ldc.i4.2
IL_0093: callvirt System.Void UnityEngine.Animator::SetInteger(System.String,System.Int32)
IL_0098: ldarg.0
IL_0099: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_009e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00a3: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_00a8: ldstr "knotted"
IL_00ad: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00b2: ldarg.0
IL_00b3: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_00b8: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00bd: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_00c2: ldstr "knotted"
IL_00c7: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00cc: ldarg.0
IL_00cd: call System.Void TheForestOfLove.RamAnalMovie::UnsubscribeAllLayerEventListeners()
IL_00d2: ldarg.0
IL_00d3: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_00d8: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00dd: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_00e2: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_00e7: ldarg.0
IL_00e8: ldftn System.Void TheForestOfLove.RamAnalMovie::SetFSMParamCanAdvance(System.String)
IL_00ee: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00f3: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00f8: ldarg.0
IL_00f9: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00fe: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_0103: ldarg.0
IL_0104: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_0109: ldstr "FinleyRascalFinal_Edited_Cum_L_IdleKnotted"
IL_010e: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0113: ldarg.0
IL_0114: ldarg.0
IL_0115: ldfld System.Int32 TheForestOfLove.RamAnalMovie::minLoopsKnotted
IL_011a: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipMinLoops
IL_011f: ldarg.0
IL_0120: ldc.i4.1
IL_0121: stfld System.Boolean TheForestOfLove.RamAnalMovie::showNextButtonWhenCanAdvance
IL_0126: ldarg.0
IL_0127: call System.Void TheForestOfLove.RamAnalMovie::TickAllLayerAnimators()
IL_012c: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::OnFSMStateKnottedToAfterglow() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.RamAnalMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.RamAnalMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_0022: ldc.r4 1
IL_0027: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002c: ldarg.0
IL_002d: ldstr ""
IL_0032: call System.Void TheForestOfLove.RamAnalMovie::SetRedBTreeTriggerName(System.String)
IL_0037: ldarg.0
IL_0038: ldstr ""
IL_003d: call System.Void TheForestOfLove.RamAnalMovie::SetFinleyBTreeTriggerName(System.String)
IL_0042: ldarg.0
IL_0043: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_0048: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_004d: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0052: ldstr "knotted_to_afterglow"
IL_0057: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_005c: ldarg.0
IL_005d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_0062: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0067: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_006c: ldstr "knotted_to_afterglow"
IL_0071: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0076: ldarg.0
IL_0077: call System.Void TheForestOfLove.RamAnalMovie::UnsubscribeAllLayerEventListeners()
IL_007c: ldarg.0
IL_007d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_0082: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0087: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_008c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0091: ldarg.0
IL_0092: ldftn System.Void TheForestOfLove.RamAnalMovie::SetFSMParamCanAdvance(System.String)
IL_0098: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_009d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00a2: ldarg.0
IL_00a3: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00a8: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00ad: ldarg.0
IL_00ae: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00b3: ldstr "FinleyRascalFinal_Edited_Cum_T_Pullout"
IL_00b8: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00bd: ldarg.0
IL_00be: call System.Void TheForestOfLove.RamAnalMovie::SpawnCumOverlap()
IL_00c3: ldarg.0
IL_00c4: ldc.i4.0
IL_00c5: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipMinLoops
IL_00ca: ldarg.0
IL_00cb: ldc.i4.0
IL_00cc: stfld System.Boolean TheForestOfLove.RamAnalMovie::showNextButtonWhenCanAdvance
IL_00d1: ldarg.0
IL_00d2: call System.Void TheForestOfLove.RamAnalMovie::TickAllLayerAnimators()
IL_00d7: ret
METHOD System.Void TheForestOfLove.RamAnalMovie::OnFSMStateAfterglow() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.RamAnalMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.RamAnalMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::redBlinks
IL_0022: ldc.r4 1
IL_0027: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::finleyBlinks
IL_0032: ldc.r4 1
IL_0037: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_0042: ldc.r4 1
IL_0047: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_004c: ldarg.0
IL_004d: ldstr "main"
IL_0052: call System.Void TheForestOfLove.RamAnalMovie::SetRedBTreeTriggerName(System.String)
IL_0057: ldarg.0
IL_0058: ldstr "main"
IL_005d: call System.Void TheForestOfLove.RamAnalMovie::SetFinleyBTreeTriggerName(System.String)
IL_0062: ldarg.0
IL_0063: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::redBlinks
IL_0068: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_006d: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0072: ldstr "loop"
IL_0077: ldc.i4.0
IL_0078: callvirt System.Void UnityEngine.Animator::SetInteger(System.String,System.Int32)
IL_007d: ldarg.0
IL_007e: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::finleyBlinks
IL_0083: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0088: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_008d: ldstr "loop"
IL_0092: ldc.i4.0
IL_0093: callvirt System.Void UnityEngine.Animator::SetInteger(System.String,System.Int32)
IL_0098: ldarg.0
IL_0099: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::critters
IL_009e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00a3: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_00a8: ldstr "afterglow"
IL_00ad: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00b2: ldarg.0
IL_00b3: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_00b8: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00bd: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_00c2: ldstr "afterglow"
IL_00c7: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00cc: ldarg.0
IL_00cd: call System.Void TheForestOfLove.RamAnalMovie::UnsubscribeAllLayerEventListeners()
IL_00d2: ldarg.0
IL_00d3: ldfld UnityEngine.CanvasGroup TheForestOfLove.RamAnalMovie::cum
IL_00d8: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00dd: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_00e2: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_00e7: ldarg.0
IL_00e8: ldftn System.Void TheForestOfLove.RamAnalMovie::SetFSMParamCanAdvance(System.String)
IL_00ee: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00f3: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00f8: ldarg.0
IL_00f9: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_00fe: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_0103: ldarg.0
IL_0104: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.RamAnalMovie::onlyAdvanceOnTheseClips
IL_0109: ldstr "FinleyRascalFinal_Edited_Cum_L_Afterglow"
IL_010e: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0113: ldarg.0
IL_0114: ldfld System.Boolean TheForestOfLove.RamAnalMovie::debugSkipConvos
IL_0119: brtrue.s IL_0122
IL_011b: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0120: brfalse.s IL_0130
IL_0122: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0127: brfalse.s IL_01a8
IL_0129: ldsfld System.Boolean Globals::allowDialogueInStartMenu
IL_012e: brfalse.s IL_01a8
IL_0130: ldarg.0
IL_0131: ldfld System.Int32 TheForestOfLove.RamAnalMovie::currentRound
IL_0136: ldc.i4.1
IL_0137: bne.un.s IL_01a8
IL_0139: ldarg.0
IL_013a: ldc.i4.0
IL_013b: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipMinLoops
IL_0140: ldarg.0
IL_0141: ldc.i4.0
IL_0142: stfld System.Boolean TheForestOfLove.RamAnalMovie::showNextButtonWhenCanAdvance
IL_0147: ldarg.0
IL_0148: ldc.i4.1
IL_0149: stfld System.Boolean TheForestOfLove.RamAnalMovie::waitingOnConversation
IL_014e: ldarg.0
IL_014f: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.RamAnalMovie::movieDialogueManager
IL_0154: ldstr "Movies_RamAnal_Dialogue"
IL_0159: ldstr "Finley"
IL_015e: ldstr "afterglow"
IL_0163: ldarg.0
IL_0164: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.RamAnalMovie::dialogueUi
IL_0169: callvirt System.Void TheForestOfLove.MovieDialogueManager::StartDialogue(System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI)
IL_016e: ldarg.0
IL_016f: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.RamAnalMovie::movieDialogueManager
IL_0174: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.MovieDialogueManager::onDialogueFinished
IL_0179: ldarg.0
IL_017a: ldftn System.Void TheForestOfLove.RamAnalMovie::OnDialogueFinished()
IL_0180: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0185: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_018a: ldarg.0
IL_018b: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.RamAnalMovie::movieDialogueManager
IL_0190: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.MovieDialogueManager::onDialogueFinished
IL_0195: ldarg.0
IL_0196: ldftn System.Void TheForestOfLove.RamAnalMovie::OnCallback_EndScene()
IL_019c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01a1: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01a6: br.s IL_01d8
IL_01a8: ldarg.0
IL_01a9: ldarg.0
IL_01aa: ldfld System.Int32 TheForestOfLove.RamAnalMovie::minLoopsAfterglow
IL_01af: stfld System.Int32 TheForestOfLove.RamAnalMovie::runningClipMinLoops
IL_01b4: ldarg.0
IL_01b5: ldc.i4.1
IL_01b6: stfld System.Boolean TheForestOfLove.RamAnalMovie::showNextButtonWhenCanAdvance
IL_01bb: ldarg.0
IL_01bc: ldarg.0
IL_01bd: ldftn System.Void TheForestOfLove.RamAnalMovie::OnCallback_EndScene()
IL_01c3: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01c8: stfld System.Action TheForestOfLove.RamAnalMovie::onAdvanceActionOverride
IL_01cd: ldarg.0
IL_01ce: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.RamAnalMovie::movieWrapper
IL_01d3: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_01d8: ldarg.0
IL_01d9: call System.Void TheForestOfLove.RamAnalMovie::TickAllLayerAnimators()
IL_01de: ret
