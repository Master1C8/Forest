TYPE TheForestOfLove.InstancedStoryOverlayUI
METHOD System.Void TheForestOfLove.InstancedStoryOverlayUI::OnInstancedStoryStarted(TheForestOfLove.Narrative.Adventure) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.InstancedStoryOverlayUI::get_visible()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.1
IL_000b: call System.Void TheForestOfLove.InstancedStoryOverlayUI::set_visible(System.Boolean)
IL_0010: ldarg.0
IL_0011: ldc.r4 0
IL_0016: stfld System.Single TheForestOfLove.InstancedStoryOverlayUI::timeSinceLastReminder
IL_001b: ldarg.0
IL_001c: ldarg.1
IL_001d: callvirt System.String TheForestOfLove.Narrative.Adventure::get_Title()
IL_0022: ldc.i4.0
IL_0023: call System.Void TheForestOfLove.InstancedStoryOverlayUI::BeginNotification(System.String,System.Boolean)
IL_0028: ret
METHOD System.Void TheForestOfLove.InstancedStoryOverlayUI::OnInstancedStoryAbandoned(TheForestOfLove.Narrative.Adventure) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.InstancedStoryOverlayUI::get_visible()
IL_0006: brtrue.s IL_003d
IL_0008: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InstancedStoryOverlayUI::onNotificationStarted_AutoClearListeners
IL_000d: dup
IL_000e: brtrue.s IL_0013
IL_0010: pop
IL_0011: br.s IL_0018
IL_0013: call System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0018: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InstancedStoryOverlayUI::onNotificationStarted_AutoClearListeners
IL_001d: callvirt System.Void UnityEngine.Events.UnityEventBase::RemoveAllListeners()
IL_0022: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InstancedStoryOverlayUI::onNotificationFinished_AutoClearListeners
IL_0027: dup
IL_0028: brtrue.s IL_002d
IL_002a: pop
IL_002b: br.s IL_0032
IL_002d: call System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0032: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InstancedStoryOverlayUI::onNotificationFinished_AutoClearListeners
IL_0037: callvirt System.Void UnityEngine.Events.UnityEventBase::RemoveAllListeners()
IL_003c: ret
IL_003d: ldarg.0
IL_003e: ldc.i4.0
IL_003f: call System.Void TheForestOfLove.InstancedStoryOverlayUI::set_visible(System.Boolean)
IL_0044: ldarg.0
IL_0045: ldc.r4 0
IL_004a: stfld System.Single TheForestOfLove.InstancedStoryOverlayUI::timeSinceLastReminder
IL_004f: ldarg.0
IL_0050: ldstr "<size=10>Adventure Abandoned</size>
"
IL_0055: ldarg.1
IL_0056: callvirt System.String TheForestOfLove.Narrative.Adventure::get_Title()
IL_005b: call System.String System.String::Concat(System.String,System.String)
IL_0060: call System.Void TheForestOfLove.InstancedStoryOverlayUI::EndNotification(System.String)
IL_0065: ret
METHOD System.Void TheForestOfLove.InstancedStoryOverlayUI::OnInstancedStoryCompleted(TheForestOfLove.Narrative.Adventure) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.InstancedStoryOverlayUI::get_visible()
IL_0006: brtrue.s IL_003d
IL_0008: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InstancedStoryOverlayUI::onNotificationStarted_AutoClearListeners
IL_000d: dup
IL_000e: brtrue.s IL_0013
IL_0010: pop
IL_0011: br.s IL_0018
IL_0013: call System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0018: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InstancedStoryOverlayUI::onNotificationStarted_AutoClearListeners
IL_001d: callvirt System.Void UnityEngine.Events.UnityEventBase::RemoveAllListeners()
IL_0022: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InstancedStoryOverlayUI::onNotificationFinished_AutoClearListeners
IL_0027: dup
IL_0028: brtrue.s IL_002d
IL_002a: pop
IL_002b: br.s IL_0032
IL_002d: call System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0032: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InstancedStoryOverlayUI::onNotificationFinished_AutoClearListeners
IL_0037: callvirt System.Void UnityEngine.Events.UnityEventBase::RemoveAllListeners()
IL_003c: ret
IL_003d: ldarg.0
IL_003e: ldc.i4.0
IL_003f: call System.Void TheForestOfLove.InstancedStoryOverlayUI::set_visible(System.Boolean)
IL_0044: ldarg.0
IL_0045: ldc.r4 0
IL_004a: stfld System.Single TheForestOfLove.InstancedStoryOverlayUI::timeSinceLastReminder
IL_004f: ldarg.0
IL_0050: ldstr "<size=10>Adventure Completed</size>
"
IL_0055: ldarg.1
IL_0056: callvirt System.String TheForestOfLove.Narrative.Adventure::get_Title()
IL_005b: call System.String System.String::Concat(System.String,System.String)
IL_0060: call System.Void TheForestOfLove.InstancedStoryOverlayUI::EndNotification(System.String)
IL_0065: ret
