TYPE TheForestOfLove.BunnyCuckMovie
METHOD System.Void TheForestOfLove.BunnyCuckMovie::SetFSMParamCanAdvance(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.BunnyCuckMovie::waitingOnConversation
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_000e: brtrue.s IL_0035
IL_0010: ldarg.0
IL_0011: ldfld System.Boolean TheForestOfLove.BunnyCuckMovie::debugSimulateStartMenu
IL_0016: brtrue.s IL_0035
IL_0018: ldarg.0
IL_0019: ldfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipCurrentLoops
IL_001e: ldarg.0
IL_001f: ldfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipMinLoops
IL_0024: bge.s IL_0035
IL_0026: ldarg.0
IL_0027: ldarg.0
IL_0028: ldfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipCurrentLoops
IL_002d: ldc.i4.1
IL_002e: add
IL_002f: stfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipCurrentLoops
IL_0034: ret
IL_0035: ldarg.0
IL_0036: ldarg.0
IL_0037: ldfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipCurrentLoops
IL_003c: ldc.i4.1
IL_003d: add
IL_003e: stfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipCurrentLoops
IL_0043: ldarg.0
IL_0044: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_0049: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_004e: brfalse.s IL_005e
IL_0050: ldarg.0
IL_0051: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_0056: ldarg.1
IL_0057: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_005c: brfalse.s IL_00b6
IL_005e: ldarg.0
IL_005f: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.BunnyCuckMovie::blackboard
IL_0064: ldstr "canAdvance"
IL_0069: ldc.i4.1
IL_006a: box System.Boolean
IL_006f: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0074: pop
IL_0075: ldarg.0
IL_0076: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.BunnyCuckMovie::fsm
IL_007b: callvirt System.Boolean NodeCanvas.Framework.GraphOwner::get_isRunning()
IL_0080: brfalse.s IL_008d
IL_0082: ldarg.0
IL_0083: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.BunnyCuckMovie::fsm
IL_0088: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_008d: ldarg.0
IL_008e: ldfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipCurrentLoops
IL_0093: ldc.i4.1
IL_0094: blt.s IL_00b6
IL_0096: ldarg.0
IL_0097: ldfld System.Boolean TheForestOfLove.BunnyCuckMovie::showNextButtonWhenCanAdvance
IL_009c: brfalse.s IL_00b6
IL_009e: ldarg.0
IL_009f: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.BunnyCuckMovie::movieWrapper
IL_00a4: callvirt System.Boolean TheForestOfLove.MovieWrapper::get_isNextButtonVisible()
IL_00a9: brtrue.s IL_00b6
IL_00ab: ldarg.0
IL_00ac: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.BunnyCuckMovie::movieWrapper
IL_00b1: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_00b6: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::PullFSMCurrentJumpStateNames() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.BunnyCuckMovie::blackboard
IL_0007: ldstr "jumpBackStateName"
IL_000c: callvirt !!0 NodeCanvas.Framework.Blackboard::GetVariableValue<System.String>(System.String)
IL_0011: stfld System.String TheForestOfLove.BunnyCuckMovie::currentJumpBackStateName
IL_0016: ldarg.0
IL_0017: ldarg.0
IL_0018: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.BunnyCuckMovie::blackboard
IL_001d: ldstr "jumpAheadStateName"
IL_0022: callvirt !!0 NodeCanvas.Framework.Blackboard::GetVariableValue<System.String>(System.String)
IL_0027: stfld System.String TheForestOfLove.BunnyCuckMovie::currentJumpAheadStateName
IL_002c: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::ClearFSMParamCanAdvance() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.BunnyCuckMovie::blackboard
IL_0006: ldstr "canAdvance"
IL_000b: ldc.i4.0
IL_000c: box System.Boolean
IL_0011: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0016: pop
IL_0017: ldarg.0
IL_0018: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.BunnyCuckMovie::fsm
IL_001d: callvirt System.Boolean NodeCanvas.Framework.GraphOwner::get_isRunning()
IL_0022: brfalse.s IL_002f
IL_0024: ldarg.0
IL_0025: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.BunnyCuckMovie::fsm
IL_002a: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_002f: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::ClearFSMAdvanceTriggers() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.BunnyCuckMovie::blackboard
IL_0006: ldstr "canAdvance"
IL_000b: ldc.i4.0
IL_000c: box System.Boolean
IL_0011: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0016: pop
IL_0017: ldarg.0
IL_0018: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.BunnyCuckMovie::blackboard
IL_001d: ldstr "advanceTrigger"
IL_0022: ldc.i4.0
IL_0023: box System.Boolean
IL_0028: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_002d: pop
IL_002e: ldarg.0
IL_002f: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.BunnyCuckMovie::fsm
IL_0034: callvirt System.Boolean NodeCanvas.Framework.GraphOwner::get_isRunning()
IL_0039: brfalse.s IL_0046
IL_003b: ldarg.0
IL_003c: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.BunnyCuckMovie::fsm
IL_0041: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0046: ldarg.0
IL_0047: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.BunnyCuckMovie::movieWrapper
IL_004c: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_0051: ldarg.0
IL_0052: ldc.i4.0
IL_0053: stfld System.Boolean TheForestOfLove.BunnyCuckMovie::showNextButtonWhenCanAdvance
IL_0058: ldarg.0
IL_0059: ldc.i4.0
IL_005a: stfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipMinLoops
IL_005f: ldarg.0
IL_0060: ldc.i4.0
IL_0061: stfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipCurrentLoops
IL_0066: ldarg.0
IL_0067: call System.Void TheForestOfLove.BunnyCuckMovie::ClearAnimatorTriggers()
IL_006c: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::SetFSMAdvanceTrigger() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.BunnyCuckMovie::waitingOnConversation
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.BunnyCuckMovie::blackboard
IL_000f: ldstr "advanceTrigger"
IL_0014: ldc.i4.1
IL_0015: box System.Boolean
IL_001a: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_001f: pop
IL_0020: ldarg.0
IL_0021: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.BunnyCuckMovie::fsm
IL_0026: callvirt System.Boolean NodeCanvas.Framework.GraphOwner::get_isRunning()
IL_002b: brfalse.s IL_0038
IL_002d: ldarg.0
IL_002e: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.BunnyCuckMovie::fsm
IL_0033: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0038: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::ClearFSMAdvanceTrigger() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.BunnyCuckMovie::blackboard
IL_0006: ldstr "advanceTrigger"
IL_000b: ldc.i4.0
IL_000c: box System.Boolean
IL_0011: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0016: pop
IL_0017: ldarg.0
IL_0018: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.BunnyCuckMovie::fsm
IL_001d: callvirt System.Boolean NodeCanvas.Framework.GraphOwner::get_isRunning()
IL_0022: brfalse.s IL_002f
IL_0024: ldarg.0
IL_0025: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.BunnyCuckMovie::fsm
IL_002a: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_002f: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::SetRedBlinkBTreeTriggerName(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.BunnyCuckMovie::redBlinkBehaviorTree
IL_0006: callvirt System.Boolean NodeCanvas.Framework.GraphOwner::get_isRunning()
IL_000b: brtrue.s IL_0018
IL_000d: ldarg.0
IL_000e: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.BunnyCuckMovie::redBlinkBehaviorTree
IL_0013: callvirt System.Void NodeCanvas.Framework.GraphOwner::StartBehaviour()
IL_0018: ldarg.0
IL_0019: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.BunnyCuckMovie::redBlinkBehaviorTree
IL_001e: callvirt NodeCanvas.Framework.IBlackboard NodeCanvas.Framework.GraphOwner::get_blackboard()
IL_0023: callvirt System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable> NodeCanvas.Framework.IBlackboard::get_variables()
IL_0028: ldstr "triggerName"
IL_002d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable>::get_Item(!0)
IL_0032: ldarg.1
IL_0033: callvirt System.Void NodeCanvas.Framework.Variable::set_value(System.Object)
IL_0038: ldarg.0
IL_0039: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.BunnyCuckMovie::redBlinkBehaviorTree
IL_003e: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0043: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::SetScarlettBlinkBTreeTriggerName(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.BunnyCuckMovie::scarlettBlinkBehaviorTree
IL_0006: callvirt System.Boolean NodeCanvas.Framework.GraphOwner::get_isRunning()
IL_000b: brtrue.s IL_0018
IL_000d: ldarg.0
IL_000e: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.BunnyCuckMovie::scarlettBlinkBehaviorTree
IL_0013: callvirt System.Void NodeCanvas.Framework.GraphOwner::StartBehaviour()
IL_0018: ldarg.0
IL_0019: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.BunnyCuckMovie::scarlettBlinkBehaviorTree
IL_001e: callvirt NodeCanvas.Framework.IBlackboard NodeCanvas.Framework.GraphOwner::get_blackboard()
IL_0023: callvirt System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable> NodeCanvas.Framework.IBlackboard::get_variables()
IL_0028: ldstr "triggerName"
IL_002d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable>::get_Item(!0)
IL_0032: ldarg.1
IL_0033: callvirt System.Void NodeCanvas.Framework.Variable::set_value(System.Object)
IL_0038: ldarg.0
IL_0039: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.BunnyCuckMovie::scarlettBlinkBehaviorTree
IL_003e: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0043: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::OnFSMStateLoop1Shallow() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.BunnyCuckMovie::awakened
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: call System.Void TheForestOfLove.BunnyCuckMovie::ClearFSMAdvanceTriggers()
IL_000f: ldarg.0
IL_0010: ldstr ""
IL_0015: call System.Void TheForestOfLove.BunnyCuckMovie::SetRedBlinkBTreeTriggerName(System.String)
IL_001a: ldarg.0
IL_001b: ldstr ""
IL_0020: call System.Void TheForestOfLove.BunnyCuckMovie::SetScarlettBlinkBTreeTriggerName(System.String)
IL_0025: ldarg.0
IL_0026: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::redBlink
IL_002b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0030: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0035: ldstr "hide"
IL_003a: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_003f: ldarg.0
IL_0040: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::scarlettBlink
IL_0045: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_004a: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_004f: ldstr "hide"
IL_0054: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0059: ldarg.0
IL_005a: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_005f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0064: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0069: ldstr "loop1_shallow"
IL_006e: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0073: ldarg.0
IL_0074: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::cum
IL_0079: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_007e: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0083: ldstr "hide"
IL_0088: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_008d: ldarg.0
IL_008e: call System.Void TheForestOfLove.BunnyCuckMovie::UnsubscribeAllLayerEventListeners()
IL_0093: ldarg.0
IL_0094: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_0099: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_009e: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_00a3: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_00a8: ldarg.0
IL_00a9: ldftn System.Void TheForestOfLove.BunnyCuckMovie::SetFSMParamCanAdvance(System.String)
IL_00af: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00b4: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00b9: ldarg.0
IL_00ba: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00bf: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00c4: ldarg.0
IL_00c5: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00ca: ldstr "BunnyAndHusbandFinal_RedScarlett_Loop1_Shallow"
IL_00cf: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00d4: ldarg.0
IL_00d5: ldarg.0
IL_00d6: ldfld System.Int32 TheForestOfLove.BunnyCuckMovie::minLoopsLoop1Shallow
IL_00db: stfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipMinLoops
IL_00e0: ldarg.0
IL_00e1: ldc.i4.1
IL_00e2: stfld System.Boolean TheForestOfLove.BunnyCuckMovie::showNextButtonWhenCanAdvance
IL_00e7: ldarg.0
IL_00e8: call System.Void TheForestOfLove.BunnyCuckMovie::TickAllLayerAnimators()
IL_00ed: ldarg.0
IL_00ee: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMovie::bunnyCuckMoviePeter
IL_00f3: ldc.i4.0
IL_00f4: callvirt System.Void TheForestOfLove.BunnyCuckMoviePeter::SetPriority(System.Int32)
IL_00f9: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::OnFSMStateTrans1ShallowToDeep() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.BunnyCuckMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: ldstr ""
IL_000c: call System.Void TheForestOfLove.BunnyCuckMovie::SetRedBlinkBTreeTriggerName(System.String)
IL_0011: ldarg.0
IL_0012: ldstr ""
IL_0017: call System.Void TheForestOfLove.BunnyCuckMovie::SetScarlettBlinkBTreeTriggerName(System.String)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::redBlink
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "hide"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::scarlettBlink
IL_003c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0041: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0046: ldstr "hide"
IL_004b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_0056: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_005b: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0060: ldstr "trans1_shallowToDeep"
IL_0065: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006a: ldarg.0
IL_006b: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::cum
IL_0070: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0075: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_007a: ldstr "hide"
IL_007f: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0084: ldarg.0
IL_0085: call System.Void TheForestOfLove.BunnyCuckMovie::UnsubscribeAllLayerEventListeners()
IL_008a: ldarg.0
IL_008b: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_0090: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0095: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_009a: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_009f: ldarg.0
IL_00a0: ldftn System.Void TheForestOfLove.BunnyCuckMovie::SetFSMParamCanAdvance(System.String)
IL_00a6: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00ab: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00b0: ldarg.0
IL_00b1: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00b6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00bb: ldarg.0
IL_00bc: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00c1: ldstr "BunnyAndHusbandFinal_RedScarlett_Transition1_ShallowToDeep"
IL_00c6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00cb: ldarg.0
IL_00cc: call System.Void TheForestOfLove.BunnyCuckMovie::TickAllLayerAnimators()
IL_00d1: ldarg.0
IL_00d2: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMovie::bunnyCuckMoviePeter
IL_00d7: ldc.i4.2
IL_00d8: callvirt System.Void TheForestOfLove.BunnyCuckMoviePeter::SetPriority(System.Int32)
IL_00dd: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::OnFSMStateLoop2Deep() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.BunnyCuckMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: ldstr ""
IL_000c: call System.Void TheForestOfLove.BunnyCuckMovie::SetRedBlinkBTreeTriggerName(System.String)
IL_0011: ldarg.0
IL_0012: ldstr ""
IL_0017: call System.Void TheForestOfLove.BunnyCuckMovie::SetScarlettBlinkBTreeTriggerName(System.String)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::redBlink
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "hide"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::scarlettBlink
IL_003c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0041: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0046: ldstr "hide"
IL_004b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_0056: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_005b: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0060: ldstr "loop2_deep"
IL_0065: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006a: ldarg.0
IL_006b: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::cum
IL_0070: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0075: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_007a: ldstr "hide"
IL_007f: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0084: ldarg.0
IL_0085: call System.Void TheForestOfLove.BunnyCuckMovie::UnsubscribeAllLayerEventListeners()
IL_008a: ldarg.0
IL_008b: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_0090: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0095: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_009a: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_009f: ldarg.0
IL_00a0: ldftn System.Void TheForestOfLove.BunnyCuckMovie::SetFSMParamCanAdvance(System.String)
IL_00a6: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00ab: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00b0: ldarg.0
IL_00b1: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00b6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00bb: ldarg.0
IL_00bc: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00c1: ldstr "BunnyAndHusbandFinal_RedScarlett_Loop2_Deep"
IL_00c6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00cb: ldarg.0
IL_00cc: ldarg.0
IL_00cd: ldfld System.Int32 TheForestOfLove.BunnyCuckMovie::minLoopsLoop2Deep
IL_00d2: stfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipMinLoops
IL_00d7: ldarg.0
IL_00d8: ldc.i4.1
IL_00d9: stfld System.Boolean TheForestOfLove.BunnyCuckMovie::showNextButtonWhenCanAdvance
IL_00de: ldarg.0
IL_00df: call System.Void TheForestOfLove.BunnyCuckMovie::TickAllLayerAnimators()
IL_00e4: ldarg.0
IL_00e5: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMovie::bunnyCuckMoviePeter
IL_00ea: ldc.i4.2
IL_00eb: callvirt System.Void TheForestOfLove.BunnyCuckMoviePeter::SetPriority(System.Int32)
IL_00f0: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::OnFSMStateTrans2DeepToKnotted() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.BunnyCuckMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: ldstr ""
IL_000c: call System.Void TheForestOfLove.BunnyCuckMovie::SetRedBlinkBTreeTriggerName(System.String)
IL_0011: ldarg.0
IL_0012: ldstr ""
IL_0017: call System.Void TheForestOfLove.BunnyCuckMovie::SetScarlettBlinkBTreeTriggerName(System.String)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::redBlink
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "hide"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::scarlettBlink
IL_003c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0041: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0046: ldstr "hide"
IL_004b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_0056: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_005b: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0060: ldstr "trans2_deepToKnotted"
IL_0065: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006a: ldarg.0
IL_006b: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::cum
IL_0070: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0075: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_007a: ldstr "hide"
IL_007f: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0084: ldarg.0
IL_0085: call System.Void TheForestOfLove.BunnyCuckMovie::UnsubscribeAllLayerEventListeners()
IL_008a: ldarg.0
IL_008b: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_0090: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0095: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_009a: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_009f: ldarg.0
IL_00a0: ldftn System.Void TheForestOfLove.BunnyCuckMovie::SetFSMParamCanAdvance(System.String)
IL_00a6: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00ab: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00b0: ldarg.0
IL_00b1: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00b6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00bb: ldarg.0
IL_00bc: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00c1: ldstr "BunnyAndHusbandFinal_RedScarlett_Transition2_DeepToKnotted"
IL_00c6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00cb: ldarg.0
IL_00cc: call System.Void TheForestOfLove.BunnyCuckMovie::TickAllLayerAnimators()
IL_00d1: ldarg.0
IL_00d2: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMovie::bunnyCuckMoviePeter
IL_00d7: ldc.i4.3
IL_00d8: callvirt System.Void TheForestOfLove.BunnyCuckMoviePeter::SetPriority(System.Int32)
IL_00dd: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::OnFSMStateLoop3Knotted() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.BunnyCuckMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: ldstr ""
IL_000c: call System.Void TheForestOfLove.BunnyCuckMovie::SetRedBlinkBTreeTriggerName(System.String)
IL_0011: ldarg.0
IL_0012: ldstr ""
IL_0017: call System.Void TheForestOfLove.BunnyCuckMovie::SetScarlettBlinkBTreeTriggerName(System.String)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::redBlink
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "hide"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::scarlettBlink
IL_003c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0041: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0046: ldstr "hide"
IL_004b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_0056: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_005b: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0060: ldstr "loop3_knotted"
IL_0065: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006a: ldarg.0
IL_006b: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::cum
IL_0070: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0075: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_007a: ldstr "hide"
IL_007f: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0084: ldarg.0
IL_0085: call System.Void TheForestOfLove.BunnyCuckMovie::UnsubscribeAllLayerEventListeners()
IL_008a: ldarg.0
IL_008b: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_0090: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0095: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_009a: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_009f: ldarg.0
IL_00a0: ldftn System.Void TheForestOfLove.BunnyCuckMovie::SetFSMParamCanAdvance(System.String)
IL_00a6: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00ab: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00b0: ldarg.0
IL_00b1: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00b6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00bb: ldarg.0
IL_00bc: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00c1: ldstr "BunnyAndHusbandFinal_RedScarlett_Transition2_DeepToKnotted"
IL_00c6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00cb: ldarg.0
IL_00cc: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00d1: ldstr "BunnyAndHusbandFinal_RedScarlett_Loop3_Knotted"
IL_00d6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00db: ldarg.0
IL_00dc: ldarg.0
IL_00dd: ldfld System.Int32 TheForestOfLove.BunnyCuckMovie::minLoopsLoop3Knotted
IL_00e2: stfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipMinLoops
IL_00e7: ldarg.0
IL_00e8: ldc.i4.1
IL_00e9: stfld System.Boolean TheForestOfLove.BunnyCuckMovie::showNextButtonWhenCanAdvance
IL_00ee: ldarg.0
IL_00ef: call System.Void TheForestOfLove.BunnyCuckMovie::TickAllLayerAnimators()
IL_00f4: ldarg.0
IL_00f5: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMovie::bunnyCuckMoviePeter
IL_00fa: ldc.i4.1
IL_00fb: callvirt System.Void TheForestOfLove.BunnyCuckMoviePeter::SetPriority(System.Int32)
IL_0100: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::OnFSMStateTrans3Pullout() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.BunnyCuckMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: ldstr ""
IL_000c: call System.Void TheForestOfLove.BunnyCuckMovie::SetRedBlinkBTreeTriggerName(System.String)
IL_0011: ldarg.0
IL_0012: ldstr ""
IL_0017: call System.Void TheForestOfLove.BunnyCuckMovie::SetScarlettBlinkBTreeTriggerName(System.String)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::redBlink
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "hide"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::scarlettBlink
IL_003c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0041: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0046: ldstr "hide"
IL_004b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_0056: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_005b: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0060: ldstr "trans3_pullout"
IL_0065: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006a: ldarg.0
IL_006b: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::cum
IL_0070: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0075: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_007a: ldstr "hide"
IL_007f: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0084: ldarg.0
IL_0085: call System.Void TheForestOfLove.BunnyCuckMovie::UnsubscribeAllLayerEventListeners()
IL_008a: ldarg.0
IL_008b: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_0090: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0095: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_009a: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_009f: ldarg.0
IL_00a0: ldftn System.Void TheForestOfLove.BunnyCuckMovie::SetFSMParamCanAdvance(System.String)
IL_00a6: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00ab: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00b0: ldarg.0
IL_00b1: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00b6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00bb: ldarg.0
IL_00bc: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00c1: ldstr "BunnyAndHusbandFinal_RedScarlett_Transition3_Pullout"
IL_00c6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00cb: ldarg.0
IL_00cc: call System.Void TheForestOfLove.BunnyCuckMovie::TickAllLayerAnimators()
IL_00d1: ldarg.0
IL_00d2: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMovie::bunnyCuckMoviePeter
IL_00d7: ldc.i4.3
IL_00d8: callvirt System.Void TheForestOfLove.BunnyCuckMoviePeter::SetPriority(System.Int32)
IL_00dd: ret
METHOD System.Void TheForestOfLove.BunnyCuckMovie::OnFSMStateLoop4Idle() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.BunnyCuckMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: ldstr "main"
IL_000c: call System.Void TheForestOfLove.BunnyCuckMovie::SetRedBlinkBTreeTriggerName(System.String)
IL_0011: ldarg.0
IL_0012: ldstr "main"
IL_0017: call System.Void TheForestOfLove.BunnyCuckMovie::SetScarlettBlinkBTreeTriggerName(System.String)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::redBlink
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "hide"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::scarlettBlink
IL_003c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0041: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0046: ldstr "hide"
IL_004b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::mainScene
IL_0056: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_005b: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0060: ldstr "loop4_idle"
IL_0065: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006a: ldarg.0
IL_006b: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::cum
IL_0070: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0075: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_007a: ldstr "cum"
IL_007f: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0084: ldarg.0
IL_0085: call System.Void TheForestOfLove.BunnyCuckMovie::UnsubscribeAllLayerEventListeners()
IL_008a: ldarg.0
IL_008b: ldfld UnityEngine.CanvasGroup TheForestOfLove.BunnyCuckMovie::cum
IL_0090: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0095: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_009a: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_009f: ldarg.0
IL_00a0: ldftn System.Void TheForestOfLove.BunnyCuckMovie::SetFSMParamCanAdvance(System.String)
IL_00a6: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00ab: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00b0: ldarg.0
IL_00b1: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00b6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00bb: ldarg.0
IL_00bc: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.BunnyCuckMovie::onlyAdvanceOnTheseClips
IL_00c1: ldstr "BunnyAndHusbandFinal_Cum_Cum_Final"
IL_00c6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00cb: ldarg.0
IL_00cc: ldarg.0
IL_00cd: ldfld System.Int32 TheForestOfLove.BunnyCuckMovie::minLoopsLoop4IdleCumdrips
IL_00d2: stfld System.Int32 TheForestOfLove.BunnyCuckMovie::runningClipMinLoops
IL_00d7: ldarg.0
IL_00d8: ldc.i4.1
IL_00d9: stfld System.Boolean TheForestOfLove.BunnyCuckMovie::showNextButtonWhenCanAdvance
IL_00de: ldarg.0
IL_00df: call System.Void TheForestOfLove.BunnyCuckMovie::TickAllLayerAnimators()
IL_00e4: ldarg.0
IL_00e5: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMovie::bunnyCuckMoviePeter
IL_00ea: ldc.i4.4
IL_00eb: callvirt System.Void TheForestOfLove.BunnyCuckMoviePeter::SetPriority(System.Int32)
IL_00f0: ret
