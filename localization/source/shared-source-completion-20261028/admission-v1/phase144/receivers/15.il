TYPE TheForestOfLove.QuestUpdatedUI
METHOD System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Queue`1<TheForestOfLove.QuestUpdatedUI/QuestUpdateNode> TheForestOfLove.QuestUpdatedUI::queuedNotifications
IL_0006: newobj System.Void TheForestOfLove.QuestUpdatedUI/QuestUpdateNode::.ctor()
IL_000b: dup
IL_000c: ldarg.1
IL_000d: stfld System.String TheForestOfLove.QuestUpdatedUI/QuestUpdateNode::previousStepText
IL_0012: dup
IL_0013: ldarg.2
IL_0014: stfld System.String TheForestOfLove.QuestUpdatedUI/QuestUpdateNode::currentStepText
IL_0019: callvirt System.Void System.Collections.Generic.Queue`1<TheForestOfLove.QuestUpdatedUI/QuestUpdateNode>::Enqueue(!0)
IL_001e: ret
