TYPE TheForestOfLove.CoyotesOralMovie
METHOD System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.CoyotesOralMovie::waitingOnConversation
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld System.Boolean TheForestOfLove.CoyotesOralMovie::debugSimulateStartMenu
IL_000f: brtrue.s IL_0035
IL_0011: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0016: brtrue.s IL_0035
IL_0018: ldarg.0
IL_0019: ldfld System.Int32 TheForestOfLove.CoyotesOralMovie::runningClipCurrentLoops
IL_001e: ldarg.0
IL_001f: ldfld System.Int32 TheForestOfLove.CoyotesOralMovie::runningClipMinLoops
IL_0024: bge.s IL_0035
IL_0026: ldarg.0
IL_0027: ldarg.0
IL_0028: ldfld System.Int32 TheForestOfLove.CoyotesOralMovie::runningClipCurrentLoops
IL_002d: ldc.i4.1
IL_002e: add
IL_002f: stfld System.Int32 TheForestOfLove.CoyotesOralMovie::runningClipCurrentLoops
IL_0034: ret
IL_0035: ldarg.0
IL_0036: ldarg.0
IL_0037: ldfld System.Int32 TheForestOfLove.CoyotesOralMovie::runningClipCurrentLoops
IL_003c: ldc.i4.1
IL_003d: add
IL_003e: stfld System.Int32 TheForestOfLove.CoyotesOralMovie::runningClipCurrentLoops
IL_0043: ldarg.0
IL_0044: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0049: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_004e: brfalse.s IL_005e
IL_0050: ldarg.0
IL_0051: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0056: ldarg.1
IL_0057: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_005c: brfalse.s IL_00a9
IL_005e: ldarg.0
IL_005f: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.CoyotesOralMovie::blackboard
IL_0064: ldstr "canAdvance"
IL_0069: ldc.i4.1
IL_006a: box System.Boolean
IL_006f: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0074: pop
IL_0075: ldarg.0
IL_0076: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.CoyotesOralMovie::fsm
IL_007b: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0080: ldarg.0
IL_0081: ldfld System.Int32 TheForestOfLove.CoyotesOralMovie::runningClipCurrentLoops
IL_0086: ldc.i4.1
IL_0087: blt.s IL_00a9
IL_0089: ldarg.0
IL_008a: ldfld System.Boolean TheForestOfLove.CoyotesOralMovie::showNextButtonWhenCanAdvance
IL_008f: brfalse.s IL_00a9
IL_0091: ldarg.0
IL_0092: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.CoyotesOralMovie::movieWrapper
IL_0097: callvirt System.Boolean TheForestOfLove.MovieWrapper::get_isNextButtonVisible()
IL_009c: brtrue.s IL_00a9
IL_009e: ldarg.0
IL_009f: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.CoyotesOralMovie::movieWrapper
IL_00a4: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_00a9: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::PullFSMCurrentJumpStateNames() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.CoyotesOralMovie::blackboard
IL_0007: ldstr "jumpBackStateName"
IL_000c: callvirt !!0 NodeCanvas.Framework.Blackboard::GetVariableValue<System.String>(System.String)
IL_0011: stfld System.String TheForestOfLove.CoyotesOralMovie::currentJumpBackStateName
IL_0016: ldarg.0
IL_0017: ldarg.0
IL_0018: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.CoyotesOralMovie::blackboard
IL_001d: ldstr "jumpAheadStateName"
IL_0022: callvirt !!0 NodeCanvas.Framework.Blackboard::GetVariableValue<System.String>(System.String)
IL_0027: stfld System.String TheForestOfLove.CoyotesOralMovie::currentJumpAheadStateName
IL_002c: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMParamCanAdvance() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.CoyotesOralMovie::blackboard
IL_0006: ldstr "canAdvance"
IL_000b: ldc.i4.0
IL_000c: box System.Boolean
IL_0011: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0016: pop
IL_0017: ldarg.0
IL_0018: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.CoyotesOralMovie::fsm
IL_001d: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0022: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMParamCanAdvance(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMParamCanAdvance()
IL_0006: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.CoyotesOralMovie::blackboard
IL_0006: ldstr "canAdvance"
IL_000b: ldc.i4.0
IL_000c: box System.Boolean
IL_0011: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0016: pop
IL_0017: ldarg.0
IL_0018: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.CoyotesOralMovie::blackboard
IL_001d: ldstr "advanceTrigger"
IL_0022: ldc.i4.0
IL_0023: box System.Boolean
IL_0028: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_002d: pop
IL_002e: ldarg.0
IL_002f: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.CoyotesOralMovie::fsm
IL_0034: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0039: ldarg.0
IL_003a: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.CoyotesOralMovie::movieWrapper
IL_003f: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_0044: ldarg.0
IL_0045: ldc.i4.0
IL_0046: stfld System.Boolean TheForestOfLove.CoyotesOralMovie::showNextButtonWhenCanAdvance
IL_004b: ldarg.0
IL_004c: ldc.i4.0
IL_004d: stfld System.Int32 TheForestOfLove.CoyotesOralMovie::runningClipMinLoops
IL_0052: ldarg.0
IL_0053: ldc.i4.0
IL_0054: stfld System.Int32 TheForestOfLove.CoyotesOralMovie::runningClipCurrentLoops
IL_0059: ldarg.0
IL_005a: call System.Void TheForestOfLove.CoyotesOralMovie::ClearAnimatorTriggers()
IL_005f: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::SetFSMAdvanceTrigger() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.CoyotesOralMovie::waitingOnConversation
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.CoyotesOralMovie::blackboard
IL_000f: ldstr "advanceTrigger"
IL_0014: ldc.i4.1
IL_0015: box System.Boolean
IL_001a: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_001f: pop
IL_0020: ldarg.0
IL_0021: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.CoyotesOralMovie::fsm
IL_0026: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_002b: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTrigger() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.CoyotesOralMovie::blackboard
IL_0006: ldstr "advanceTrigger"
IL_000b: ldc.i4.0
IL_000c: box System.Boolean
IL_0011: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0016: pop
IL_0017: ldarg.0
IL_0018: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.CoyotesOralMovie::fsm
IL_001d: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0022: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::SetClaireBTreeTriggerName(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.CoyotesOralMovie::claireBehaviorTree
IL_0006: callvirt System.Boolean NodeCanvas.Framework.GraphOwner::get_isRunning()
IL_000b: brtrue.s IL_0018
IL_000d: ldarg.0
IL_000e: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.CoyotesOralMovie::claireBehaviorTree
IL_0013: callvirt System.Void NodeCanvas.Framework.GraphOwner::StartBehaviour()
IL_0018: ldarg.0
IL_0019: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.CoyotesOralMovie::claireBehaviorTree
IL_001e: callvirt NodeCanvas.Framework.IBlackboard NodeCanvas.Framework.GraphOwner::get_blackboard()
IL_0023: callvirt System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable> NodeCanvas.Framework.IBlackboard::get_variables()
IL_0028: ldstr "triggerName"
IL_002d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable>::get_Item(!0)
IL_0032: ldarg.1
IL_0033: callvirt System.Void NodeCanvas.Framework.Variable::set_value(System.Object)
IL_0038: ldarg.0
IL_0039: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.CoyotesOralMovie::claireBehaviorTree
IL_003e: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0043: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::SetVioletBTreeTriggerName(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.CoyotesOralMovie::violetBehaviorTree
IL_0006: callvirt System.Boolean NodeCanvas.Framework.GraphOwner::get_isRunning()
IL_000b: brtrue.s IL_0018
IL_000d: ldarg.0
IL_000e: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.CoyotesOralMovie::violetBehaviorTree
IL_0013: callvirt System.Void NodeCanvas.Framework.GraphOwner::StartBehaviour()
IL_0018: ldarg.0
IL_0019: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.CoyotesOralMovie::violetBehaviorTree
IL_001e: callvirt NodeCanvas.Framework.IBlackboard NodeCanvas.Framework.GraphOwner::get_blackboard()
IL_0023: callvirt System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable> NodeCanvas.Framework.IBlackboard::get_variables()
IL_0028: ldstr "triggerName"
IL_002d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable>::get_Item(!0)
IL_0032: ldarg.1
IL_0033: callvirt System.Void NodeCanvas.Framework.Variable::set_value(System.Object)
IL_0038: ldarg.0
IL_0039: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.CoyotesOralMovie::violetBehaviorTree
IL_003e: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0043: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateIdle_SharedPre() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesClaire
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesViolet
IL_0022: ldc.r4 1
IL_0027: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cockLoops
IL_0032: ldc.r4 1
IL_0037: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_003c: ldarg.0
IL_003d: ldstr "main"
IL_0042: call System.Void TheForestOfLove.CoyotesOralMovie::SetClaireBTreeTriggerName(System.String)
IL_0047: ldarg.0
IL_0048: ldstr "main"
IL_004d: call System.Void TheForestOfLove.CoyotesOralMovie::SetVioletBTreeTriggerName(System.String)
IL_0052: ldarg.0
IL_0053: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesClaire
IL_0058: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_005d: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0062: ldstr "main"
IL_0067: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006c: ldarg.0
IL_006d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesViolet
IL_0072: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0077: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_007c: ldstr "main"
IL_0081: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0086: ldarg.0
IL_0087: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cockLoops
IL_008c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0091: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0096: ldstr "main"
IL_009b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00a0: ldarg.0
IL_00a1: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_00a6: ldarg.0
IL_00a7: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesClaire
IL_00ac: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00b1: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_00b6: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_00bb: ldarg.0
IL_00bc: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_00c2: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00c7: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00cc: ldarg.0
IL_00cd: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_00d2: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00d7: ldarg.0
IL_00d8: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_00dd: ldstr "Coyotes_Idles_Claire_Idle"
IL_00e2: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00e7: ldarg.0
IL_00e8: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_00ed: ldstr "Coyotes_Idles_Claire_Idle_Blink"
IL_00f2: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00f7: ldarg.0
IL_00f8: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_00fd: ldstr "Coyotes_Idles_Claire_Idle_Happy"
IL_0102: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0107: ldarg.0
IL_0108: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_010d: ldstr "Coyotes_Idles_Claire_Idle_Pout"
IL_0112: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0117: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStatePreScene() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.CoyotesOralMovie::awakened
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_000e: brtrue.s IL_0018
IL_0010: ldarg.0
IL_0011: ldfld System.Boolean TheForestOfLove.CoyotesOralMovie::debugSkipConvos
IL_0016: brfalse.s IL_0026
IL_0018: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_001d: brfalse.s IL_005b
IL_001f: ldsfld System.Boolean Globals::allowDialogueInStartMenu
IL_0024: brfalse.s IL_005b
IL_0026: ldarg.0
IL_0027: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::blackOverlay
IL_002c: ldc.r4 1
IL_0031: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0036: ldarg.0
IL_0037: call System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateIdle_SharedPre()
IL_003c: ldarg.0
IL_003d: ldc.i4.1
IL_003e: stfld System.Boolean TheForestOfLove.CoyotesOralMovie::waitingOnConversation
IL_0043: ldc.r4 0.5
IL_0048: ldarg.0
IL_0049: ldftn System.Void TheForestOfLove.CoyotesOralMovie::<OnFSMStatePreScene>b__108_0()
IL_004f: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0054: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0059: br.s IL_00a4
IL_005b: ldarg.0
IL_005c: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::blackOverlay
IL_0061: ldc.r4 0
IL_0066: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_006b: ldarg.0
IL_006c: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.CoyotesOralMovie::blackboard
IL_0071: ldstr "canAdvance"
IL_0076: ldc.i4.1
IL_0077: box System.Boolean
IL_007c: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0081: pop
IL_0082: ldarg.0
IL_0083: ldfld NodeCanvas.Framework.Blackboard TheForestOfLove.CoyotesOralMovie::blackboard
IL_0088: ldstr "advanceTrigger"
IL_008d: ldc.i4.1
IL_008e: box System.Boolean
IL_0093: callvirt NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)
IL_0098: pop
IL_0099: ldarg.0
IL_009a: ldfld NodeCanvas.StateMachines.FSMOwner TheForestOfLove.CoyotesOralMovie::fsm
IL_009f: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_00a4: ldarg.0
IL_00a5: call System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateIdle_SharedPost()
IL_00aa: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateIdlePostCum() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateIdle_SharedPre()
IL_0006: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_000b: brtrue.s IL_0015
IL_000d: ldarg.0
IL_000e: ldfld System.Boolean TheForestOfLove.CoyotesOralMovie::debugSkipConvos
IL_0013: brfalse.s IL_0023
IL_0015: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_001a: brfalse.s IL_0094
IL_001c: ldsfld System.Boolean Globals::allowDialogueInStartMenu
IL_0021: brfalse.s IL_0094
IL_0023: ldarg.0
IL_0024: ldc.i4.1
IL_0025: stfld System.Boolean TheForestOfLove.CoyotesOralMovie::waitingOnConversation
IL_002a: ldarg.0
IL_002b: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.CoyotesOralMovie::movieDialogueManager
IL_0030: ldstr "Movies_CoyotesOral_Dialogue"
IL_0035: ldstr "Claire"
IL_003a: ldarg.0
IL_003b: ldfld System.Int32 TheForestOfLove.CoyotesOralMovie::currentRound
IL_0040: ldc.i4.1
IL_0041: beq.s IL_004a
IL_0043: ldstr "end_round_two"
IL_0048: br.s IL_004f
IL_004a: ldstr "end_round_one"
IL_004f: ldarg.0
IL_0050: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.CoyotesOralMovie::dialogueUi
IL_0055: callvirt System.Void TheForestOfLove.MovieDialogueManager::StartDialogue(System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI)
IL_005a: ldarg.0
IL_005b: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.CoyotesOralMovie::movieDialogueManager
IL_0060: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.MovieDialogueManager::onDialogueFinished
IL_0065: ldarg.0
IL_0066: ldftn System.Void TheForestOfLove.CoyotesOralMovie::OnDialogueFinished()
IL_006c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0071: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0076: ldarg.0
IL_0077: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.CoyotesOralMovie::movieDialogueManager
IL_007c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.MovieDialogueManager::onDialogueFinished
IL_0081: ldarg.0
IL_0082: ldftn System.Void TheForestOfLove.CoyotesOralMovie::AutoAdvanceAfterDialogue()
IL_0088: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_008d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0092: br.s IL_00ad
IL_0094: ldarg.0
IL_0095: ldc.i4.1
IL_0096: stfld System.Boolean TheForestOfLove.CoyotesOralMovie::showNextButtonWhenCanAdvance
IL_009b: ldarg.0
IL_009c: ldarg.0
IL_009d: ldftn System.Void TheForestOfLove.CoyotesOralMovie::OnCallback_EndScene()
IL_00a3: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00a8: stfld System.Action TheForestOfLove.CoyotesOralMovie::onAdvanceActionOverride
IL_00ad: ldarg.0
IL_00ae: call System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateIdle_SharedPost()
IL_00b3: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateClaireLickIntro() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "claire_lick_intro"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0042: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0047: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_004c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0051: ldarg.0
IL_0052: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_0058: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_005d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0068: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_006d: ldarg.0
IL_006e: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0073: ldstr "Coyotes_MainScene_Claire_Lick_T"
IL_0078: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_007d: ldarg.0
IL_007e: call System.Void TheForestOfLove.CoyotesOralMovie::TickAllLayerAnimators()
IL_0083: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateClaireLick() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "claire_lick"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0042: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0047: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_004c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0051: ldarg.0
IL_0052: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_0058: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_005d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0068: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_006d: ldarg.0
IL_006e: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0073: ldstr "Coyotes_MainScene_Claire_Lick"
IL_0078: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_007d: ldarg.0
IL_007e: ldarg.0
IL_007f: ldfld System.Int32 TheForestOfLove.CoyotesOralMovie::minLoopsClaireLick
IL_0084: stfld System.Int32 TheForestOfLove.CoyotesOralMovie::runningClipMinLoops
IL_0089: ldarg.0
IL_008a: ldc.i4.1
IL_008b: stfld System.Boolean TheForestOfLove.CoyotesOralMovie::showNextButtonWhenCanAdvance
IL_0090: ldarg.0
IL_0091: call System.Void TheForestOfLove.CoyotesOralMovie::TickAllLayerAnimators()
IL_0096: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateClaireFinish() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "claire_finish"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0042: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0047: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_004c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0051: ldarg.0
IL_0052: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_0058: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_005d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0068: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_006d: ldarg.0
IL_006e: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0073: ldstr "Coyotes_MainScene_Claire_End_T"
IL_0078: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_007d: ldarg.0
IL_007e: call System.Void TheForestOfLove.CoyotesOralMovie::TickAllLayerAnimators()
IL_0083: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateVioletLickIntro() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "violet_lick_intro"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0042: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0047: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_004c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0051: ldarg.0
IL_0052: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_0058: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_005d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0068: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_006d: ldarg.0
IL_006e: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0073: ldstr "Coyotes_MainScene_Violet_Lick_T"
IL_0078: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_007d: ldarg.0
IL_007e: call System.Void TheForestOfLove.CoyotesOralMovie::TickAllLayerAnimators()
IL_0083: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateVioletLick() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "violet_lick"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0042: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0047: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_004c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0051: ldarg.0
IL_0052: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_0058: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_005d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0068: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_006d: ldarg.0
IL_006e: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0073: ldstr "Coyotes_MainScene_Violet_Lick"
IL_0078: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_007d: ldarg.0
IL_007e: ldarg.0
IL_007f: ldfld System.Int32 TheForestOfLove.CoyotesOralMovie::minLoopsVioletLick
IL_0084: stfld System.Int32 TheForestOfLove.CoyotesOralMovie::runningClipMinLoops
IL_0089: ldarg.0
IL_008a: ldc.i4.1
IL_008b: stfld System.Boolean TheForestOfLove.CoyotesOralMovie::showNextButtonWhenCanAdvance
IL_0090: ldarg.0
IL_0091: call System.Void TheForestOfLove.CoyotesOralMovie::TickAllLayerAnimators()
IL_0096: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateVioletFinish() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "violet_finish"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0042: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0047: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_004c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0051: ldarg.0
IL_0052: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_0058: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_005d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0068: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_006d: ldarg.0
IL_006e: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0073: ldstr "Coyotes_MainScene_Violet_End_T"
IL_0078: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_007d: ldarg.0
IL_007e: call System.Void TheForestOfLove.CoyotesOralMovie::TickAllLayerAnimators()
IL_0083: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateBothLickIntro() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "both_lick_intro"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0042: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0047: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_004c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0051: ldarg.0
IL_0052: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_0058: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_005d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0068: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_006d: ldarg.0
IL_006e: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0073: ldstr "Coyotes_MainScene_Both_Lick_T"
IL_0078: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_007d: ldarg.0
IL_007e: call System.Void TheForestOfLove.CoyotesOralMovie::TickAllLayerAnimators()
IL_0083: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateBothLick() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "both_lick"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0042: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0047: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_004c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0051: ldarg.0
IL_0052: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_0058: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_005d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0068: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_006d: ldarg.0
IL_006e: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0073: ldstr "Coyotes_MainScene_Both_Lick"
IL_0078: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_007d: ldarg.0
IL_007e: ldarg.0
IL_007f: ldfld System.Int32 TheForestOfLove.CoyotesOralMovie::minLoopsBothLick
IL_0084: stfld System.Int32 TheForestOfLove.CoyotesOralMovie::runningClipMinLoops
IL_0089: ldarg.0
IL_008a: ldc.i4.1
IL_008b: stfld System.Boolean TheForestOfLove.CoyotesOralMovie::showNextButtonWhenCanAdvance
IL_0090: ldarg.0
IL_0091: call System.Void TheForestOfLove.CoyotesOralMovie::TickAllLayerAnimators()
IL_0096: ldarg.0
IL_0097: ldnull
IL_0098: stfld System.Action TheForestOfLove.CoyotesOralMovie::onAdvanceActionOverride
IL_009d: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateBothFinish() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0022: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_002c: ldstr "both_finish"
IL_0031: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0036: ldarg.0
IL_0037: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0042: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0047: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_004c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0051: ldarg.0
IL_0052: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_0058: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_005d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0068: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_006d: ldarg.0
IL_006e: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0073: ldstr "Coyotes_MainScene_Both_End_T"
IL_0078: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_007d: ldarg.0
IL_007e: call System.Void TheForestOfLove.CoyotesOralMovie::TickAllLayerAnimators()
IL_0083: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateCumDuringLicking() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cum
IL_0022: ldc.r4 1
IL_0027: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cum
IL_0032: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0037: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_003c: ldstr "during_licking"
IL_0041: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0046: ldarg.0
IL_0047: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_004c: ldarg.0
IL_004d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cum
IL_0052: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0057: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_005c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipEnded
IL_0061: ldarg.0
IL_0062: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_0068: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_006d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0072: ldarg.0
IL_0073: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0078: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_007d: ldarg.0
IL_007e: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0083: ldstr "Coyotes_Cum_During_Licking"
IL_0088: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_008d: ldarg.0
IL_008e: call System.Void TheForestOfLove.CoyotesOralMovie::TickAllLayerAnimators()
IL_0093: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateCumEndLicking() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cum
IL_0022: ldc.r4 1
IL_0027: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::mainScene
IL_0032: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0037: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_003c: ldstr "both_finish"
IL_0041: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0046: ldarg.0
IL_0047: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cum
IL_004c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0051: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0056: ldstr "end_licking"
IL_005b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0060: ldarg.0
IL_0061: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_0066: ldarg.0
IL_0067: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cum
IL_006c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0071: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_0076: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipEnded
IL_007b: ldarg.0
IL_007c: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_0082: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0087: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_008c: ldarg.0
IL_008d: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_0092: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_0097: ldarg.0
IL_0098: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_009d: ldstr "Coyotes_Cum_End_Licking"
IL_00a2: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00a7: ldarg.0
IL_00a8: call System.Void TheForestOfLove.CoyotesOralMovie::TickAllLayerAnimators()
IL_00ad: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnFSMStateCumPostLicking() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.CoyotesOralMovie::ClearFSMAdvanceTriggers()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CoyotesOralMovie::HideAllLayers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesClaire
IL_0012: ldc.r4 1
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesViolet
IL_0022: ldc.r4 1
IL_0027: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cockLoops
IL_0032: ldc.r4 1
IL_0037: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cum
IL_0042: ldc.r4 1
IL_0047: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_004c: ldarg.0
IL_004d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesClaire
IL_0052: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0057: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_005c: ldstr "main"
IL_0061: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0066: ldarg.0
IL_0067: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesViolet
IL_006c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0071: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0076: ldstr "main"
IL_007b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0080: ldarg.0
IL_0081: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cockLoops
IL_0086: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_008b: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0090: ldstr "post_licking"
IL_0095: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_009a: ldarg.0
IL_009b: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cum
IL_00a0: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00a5: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_00aa: ldstr "post_licking"
IL_00af: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00b4: ldarg.0
IL_00b5: call System.Void TheForestOfLove.CoyotesOralMovie::UnsubscribeAllLayerEventListeners()
IL_00ba: ldarg.0
IL_00bb: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::cum
IL_00c0: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00c5: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_00ca: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_00cf: ldarg.0
IL_00d0: ldftn System.Void TheForestOfLove.CoyotesOralMovie::SetFSMParamCanAdvance(System.String)
IL_00d6: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00db: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00e0: ldarg.0
IL_00e1: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_00e6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_00eb: ldarg.0
IL_00ec: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CoyotesOralMovie::onlyAdvanceOnTheseClips
IL_00f1: ldstr "Coyotes_Cum_Post_Licking"
IL_00f6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00fb: ldarg.0
IL_00fc: call System.Void TheForestOfLove.CoyotesOralMovie::TickAllLayerAnimators()
IL_0101: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnCallback_ClaireWinsRound1() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "happy"
IL_0006: call System.Void TheForestOfLove.CoyotesOralMovie::SetClaireBTreeTriggerName(System.String)
IL_000b: ldarg.0
IL_000c: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesClaire
IL_0011: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0016: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_001b: ldstr "happy"
IL_0020: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0025: ldarg.0
IL_0026: ldstr "pout"
IL_002b: call System.Void TheForestOfLove.CoyotesOralMovie::SetVioletBTreeTriggerName(System.String)
IL_0030: ldarg.0
IL_0031: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesViolet
IL_0036: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_003b: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0040: ldstr "pout"
IL_0045: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_004a: ldarg.0
IL_004b: call System.Void TheForestOfLove.CoyotesOralMovie::ClearDialogueText()
IL_0050: ret
METHOD System.Void TheForestOfLove.CoyotesOralMovie::OnCallback_VioletWinsRound1() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "pout"
IL_0006: call System.Void TheForestOfLove.CoyotesOralMovie::SetClaireBTreeTriggerName(System.String)
IL_000b: ldarg.0
IL_000c: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesClaire
IL_0011: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0016: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_001b: ldstr "pout"
IL_0020: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0025: ldarg.0
IL_0026: ldstr "happy"
IL_002b: call System.Void TheForestOfLove.CoyotesOralMovie::SetVioletBTreeTriggerName(System.String)
IL_0030: ldarg.0
IL_0031: ldfld UnityEngine.CanvasGroup TheForestOfLove.CoyotesOralMovie::idlesViolet
IL_0036: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_003b: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0040: ldstr "happy"
IL_0045: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_004a: ldarg.0
IL_004b: call System.Void TheForestOfLove.CoyotesOralMovie::ClearDialogueText()
IL_0050: ret
