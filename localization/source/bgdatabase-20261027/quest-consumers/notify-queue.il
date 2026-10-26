TYPE TheForestOfLove.QuestUpdatedUI
METHOD System.Void TheForestOfLove.QuestUpdatedUI::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldarg.0
IL_0007: ldarg.0
IL_0008: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_000d: ldstr "UiContainer/AnimatorContainer"
IL_0012: callvirt UnityEngine.Transform UnityEngine.Transform::Find(System.String)
IL_0017: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_001c: stfld UnityEngine.Animator TheForestOfLove.QuestUpdatedUI::animator
IL_0021: ldarg.0
IL_0022: ldarg.0
IL_0023: ldfld UnityEngine.Animator TheForestOfLove.QuestUpdatedUI::animator
IL_0028: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_002d: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_0032: stfld TheForestOfLove.AnimationStateEventListener TheForestOfLove.QuestUpdatedUI::animationStateEventListener
IL_0037: ldarg.0
IL_0038: ldfld TheForestOfLove.AnimationStateEventListener TheForestOfLove.QuestUpdatedUI::animationStateEventListener
IL_003d: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipEnded
IL_0042: ldarg.0
IL_0043: ldftn System.Void TheForestOfLove.QuestUpdatedUI::Animator_OnClipEnded(System.String)
IL_0049: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_004e: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0053: ldarg.0
IL_0054: ldfld System.Collections.Generic.List`1<UnityEngine.UI.Text> TheForestOfLove.QuestUpdatedUI::oldStepLabels
IL_0059: ldarg.0
IL_005a: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_005f: ldstr "UiContainer/AnimatorContainer/OldObjTextContainer"
IL_0064: callvirt UnityEngine.Transform UnityEngine.Transform::Find(System.String)
IL_0069: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_006e: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.UI.Text>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_0073: ldarg.0
IL_0074: ldfld System.Collections.Generic.List`1<UnityEngine.UI.Text> TheForestOfLove.QuestUpdatedUI::newStepLabels
IL_0079: ldarg.0
IL_007a: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_007f: ldstr "UiContainer/AnimatorContainer/NewObjTextContainer"
IL_0084: callvirt UnityEngine.Transform UnityEngine.Transform::Find(System.String)
IL_0089: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_008e: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.UI.Text>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_0093: ldarg.0
IL_0094: ldarg.0
IL_0095: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_009a: ldstr "UiContainer/Checkmark"
IL_009f: callvirt UnityEngine.Transform UnityEngine.Transform::Find(System.String)
IL_00a4: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_00a9: stfld UnityEngine.Animator TheForestOfLove.QuestUpdatedUI::checkmarkAnimator
IL_00ae: ret
METHOD System.Void TheForestOfLove.QuestUpdatedUI::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.QuestUpdatedUI::isNextQueuedNotificationScheduled
IL_0006: brtrue.s IL_002e
IL_0008: ldarg.0
IL_0009: call System.Boolean TheForestOfLove.QuestUpdatedUI::CanShowNextQueuedNotification()
IL_000e: brfalse.s IL_002e
IL_0010: ldarg.0
IL_0011: ldc.i4.1
IL_0012: stfld System.Boolean TheForestOfLove.QuestUpdatedUI::isNextQueuedNotificationScheduled
IL_0017: ldc.r4 0.5
IL_001c: ldarg.0
IL_001d: ldftn System.Void TheForestOfLove.QuestUpdatedUI::TryShowNextQueuedNotification()
IL_0023: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0028: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_002d: ret
IL_002e: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0033: brfalse.s IL_0051
IL_0035: ldarg.0
IL_0036: ldfld System.Boolean TheForestOfLove.QuestUpdatedUI::visible
IL_003b: brfalse.s IL_0051
IL_003d: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0042: brtrue.s IL_0051
IL_0044: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isItemGetAchievementOpen()
IL_0049: brtrue.s IL_0051
IL_004b: ldarg.0
IL_004c: call System.Void TheForestOfLove.QuestUpdatedUI::HideNotification()
IL_0051: ret
METHOD System.Boolean TheForestOfLove.QuestUpdatedUI::CanShowNextQueuedNotification() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0005: brtrue.s IL_001e
IL_0007: ldarg.0
IL_0008: ldfld System.Boolean TheForestOfLove.QuestUpdatedUI::visible
IL_000d: brtrue.s IL_001e
IL_000f: ldarg.0
IL_0010: ldfld System.Collections.Generic.Queue`1<TheForestOfLove.QuestUpdatedUI/QuestUpdateNode> TheForestOfLove.QuestUpdatedUI::queuedNotifications
IL_0015: callvirt System.Int32 System.Collections.Generic.Queue`1<TheForestOfLove.QuestUpdatedUI/QuestUpdateNode>::get_Count()
IL_001a: ldc.i4.0
IL_001b: cgt
IL_001d: ret
IL_001e: ldc.i4.0
IL_001f: ret
METHOD System.Void TheForestOfLove.QuestUpdatedUI::ClearQueuedNotifications() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Queue`1<TheForestOfLove.QuestUpdatedUI/QuestUpdateNode> TheForestOfLove.QuestUpdatedUI::queuedNotifications
IL_0006: callvirt System.Void System.Collections.Generic.Queue`1<TheForestOfLove.QuestUpdatedUI/QuestUpdateNode>::Clear()
IL_000b: ret
METHOD System.Void TheForestOfLove.QuestUpdatedUI::TryShowNextQueuedNotification() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Boolean TheForestOfLove.QuestUpdatedUI::isNextQueuedNotificationScheduled
IL_0007: ldarg.0
IL_0008: call System.Boolean TheForestOfLove.QuestUpdatedUI::CanShowNextQueuedNotification()
IL_000d: brtrue.s IL_0010
IL_000f: ret
IL_0010: ldarg.0
IL_0011: ldfld System.Collections.Generic.Queue`1<TheForestOfLove.QuestUpdatedUI/QuestUpdateNode> TheForestOfLove.QuestUpdatedUI::queuedNotifications
IL_0016: callvirt !0 System.Collections.Generic.Queue`1<TheForestOfLove.QuestUpdatedUI/QuestUpdateNode>::Dequeue()
IL_001b: stloc.0
IL_001c: ldarg.0
IL_001d: ldfld System.Collections.Generic.List`1<UnityEngine.UI.Text> TheForestOfLove.QuestUpdatedUI::oldStepLabels
IL_0022: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.UI.Text>::GetEnumerator()
IL_0027: stloc.1
IL_0028: br.s IL_003c
IL_002a: ldloca.s V_1
IL_002c: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.UI.Text>::get_Current()
IL_0031: ldloc.0
IL_0032: ldfld System.String TheForestOfLove.QuestUpdatedUI/QuestUpdateNode::previousStepText
IL_0037: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_003c: ldloca.s V_1
IL_003e: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.UI.Text>::MoveNext()
IL_0043: brtrue.s IL_002a
IL_0045: leave.s IL_0055
IL_0047: ldloca.s V_1
IL_0049: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.UI.Text>
IL_004f: callvirt System.Void System.IDisposable::Dispose()
IL_0054: endfinally
IL_0055: ldarg.0
IL_0056: ldfld System.Collections.Generic.List`1<UnityEngine.UI.Text> TheForestOfLove.QuestUpdatedUI::newStepLabels
IL_005b: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.UI.Text>::GetEnumerator()
IL_0060: stloc.1
IL_0061: br.s IL_0075
IL_0063: ldloca.s V_1
IL_0065: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.UI.Text>::get_Current()
IL_006a: ldloc.0
IL_006b: ldfld System.String TheForestOfLove.QuestUpdatedUI/QuestUpdateNode::currentStepText
IL_0070: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0075: ldloca.s V_1
IL_0077: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.UI.Text>::MoveNext()
IL_007c: brtrue.s IL_0063
IL_007e: leave.s IL_008e
IL_0080: ldloca.s V_1
IL_0082: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.UI.Text>
IL_0088: callvirt System.Void System.IDisposable::Dispose()
IL_008d: endfinally
IL_008e: ldarg.0
IL_008f: call System.Void TheForestOfLove.QuestUpdatedUI::ResetAnimatorTriggers()
IL_0094: ldarg.0
IL_0095: ldfld UnityEngine.Animator TheForestOfLove.QuestUpdatedUI::animator
IL_009a: ldstr "show"
IL_009f: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00a4: ldloc.0
IL_00a5: ldfld System.String TheForestOfLove.QuestUpdatedUI/QuestUpdateNode::previousStepText
IL_00aa: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_00af: brtrue.s IL_00c1
IL_00b1: ldarg.0
IL_00b2: ldfld UnityEngine.Animator TheForestOfLove.QuestUpdatedUI::checkmarkAnimator
IL_00b7: ldstr "show"
IL_00bc: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00c1: ldarg.0
IL_00c2: ldc.i4.1
IL_00c3: stfld System.Boolean TheForestOfLove.QuestUpdatedUI::visible
IL_00c8: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowQuestUpdateNotification
IL_00cd: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00d2: ret
