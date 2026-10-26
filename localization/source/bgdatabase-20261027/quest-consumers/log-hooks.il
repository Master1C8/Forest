TYPE TheForestOfLove.QuestLog
METHOD System.Void TheForestOfLove.QuestLog::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldsfld TheForestOfLove.Events.QuestEvent TheForestOfLove.Events.GameEvents::onQuestLogUpdated
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.QuestLog::OnQuestLogUpdated(TheForestOfLove.Narrative.Quest)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Quest>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Quest>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_001c: ret
METHOD System.Void TheForestOfLove.QuestLog::RemoveEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners()
IL_0006: ldsfld TheForestOfLove.Events.QuestEvent TheForestOfLove.Events.GameEvents::onQuestLogUpdated
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.QuestLog::OnQuestLogUpdated(TheForestOfLove.Narrative.Quest)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Quest>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Quest>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_001c: ret
