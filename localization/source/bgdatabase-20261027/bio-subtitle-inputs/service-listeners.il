TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.DialogueSystem.DialogueSystemEvents>()
IL_000b: dup
IL_000c: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_0011: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/TransformEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationStart
IL_0016: ldarg.0
IL_0017: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationStart(UnityEngine.Transform)
IL_001d: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Transform>::.ctor(System.Object,System.IntPtr)
IL_0022: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Transform>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0027: dup
IL_0028: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_002d: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/TransformEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onLinkedConversationStart
IL_0032: ldarg.0
IL_0033: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnLinkedConversationStart(UnityEngine.Transform)
IL_0039: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Transform>::.ctor(System.Object,System.IntPtr)
IL_003e: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Transform>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0043: dup
IL_0044: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_0049: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/TransformEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationEnd
IL_004e: ldarg.0
IL_004f: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationEnd(UnityEngine.Transform)
IL_0055: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Transform>::.ctor(System.Object,System.IntPtr)
IL_005a: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Transform>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_005f: dup
IL_0060: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_0065: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/TransformEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationCancelled
IL_006a: ldarg.0
IL_006b: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationCancelled(UnityEngine.Transform)
IL_0071: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Transform>::.ctor(System.Object,System.IntPtr)
IL_0076: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Transform>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_007b: dup
IL_007c: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_0081: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/SubtitleEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationLine
IL_0086: ldarg.0
IL_0087: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineBegin(PixelCrushers.DialogueSystem.Subtitle)
IL_008d: newobj System.Void UnityEngine.Events.UnityAction`1<PixelCrushers.DialogueSystem.Subtitle>::.ctor(System.Object,System.IntPtr)
IL_0092: callvirt System.Void UnityEngine.Events.UnityEvent`1<PixelCrushers.DialogueSystem.Subtitle>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0097: dup
IL_0098: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_009d: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/SubtitleEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationLineEnd
IL_00a2: ldarg.0
IL_00a3: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineEnd(PixelCrushers.DialogueSystem.Subtitle)
IL_00a9: newobj System.Void UnityEngine.Events.UnityAction`1<PixelCrushers.DialogueSystem.Subtitle>::.ctor(System.Object,System.IntPtr)
IL_00ae: callvirt System.Void UnityEngine.Events.UnityEvent`1<PixelCrushers.DialogueSystem.Subtitle>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00b3: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_00b8: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ResponsesEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationResponseMenu
IL_00bd: ldarg.0
IL_00be: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationResponseMenu(PixelCrushers.DialogueSystem.Response[])
IL_00c4: newobj System.Void UnityEngine.Events.UnityAction`1<PixelCrushers.DialogueSystem.Response[]>::.ctor(System.Object,System.IntPtr)
IL_00c9: callvirt System.Void UnityEngine.Events.UnityEvent`1<PixelCrushers.DialogueSystem.Response[]>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00ce: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::RemoveEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners()
IL_0006: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.DialogueSystem.DialogueSystemEvents>()
IL_000b: stloc.0
IL_000c: ldloc.0
IL_000d: ldnull
IL_000e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0013: brfalse IL_00dc
IL_0018: ldloc.0
IL_0019: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_001e: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/TransformEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationStart
IL_0023: ldarg.0
IL_0024: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationStart(UnityEngine.Transform)
IL_002a: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Transform>::.ctor(System.Object,System.IntPtr)
IL_002f: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Transform>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0034: ldloc.0
IL_0035: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_003a: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/TransformEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onLinkedConversationStart
IL_003f: ldarg.0
IL_0040: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnLinkedConversationStart(UnityEngine.Transform)
IL_0046: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Transform>::.ctor(System.Object,System.IntPtr)
IL_004b: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Transform>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0050: ldloc.0
IL_0051: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_0056: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/TransformEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationEnd
IL_005b: ldarg.0
IL_005c: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationEnd(UnityEngine.Transform)
IL_0062: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Transform>::.ctor(System.Object,System.IntPtr)
IL_0067: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Transform>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_006c: ldloc.0
IL_006d: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_0072: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/TransformEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationCancelled
IL_0077: ldarg.0
IL_0078: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationCancelled(UnityEngine.Transform)
IL_007e: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Transform>::.ctor(System.Object,System.IntPtr)
IL_0083: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Transform>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0088: ldloc.0
IL_0089: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_008e: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/SubtitleEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationLine
IL_0093: ldarg.0
IL_0094: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineBegin(PixelCrushers.DialogueSystem.Subtitle)
IL_009a: newobj System.Void UnityEngine.Events.UnityAction`1<PixelCrushers.DialogueSystem.Subtitle>::.ctor(System.Object,System.IntPtr)
IL_009f: callvirt System.Void UnityEngine.Events.UnityEvent`1<PixelCrushers.DialogueSystem.Subtitle>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00a4: ldloc.0
IL_00a5: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_00aa: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/SubtitleEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationLineEnd
IL_00af: ldarg.0
IL_00b0: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineEnd(PixelCrushers.DialogueSystem.Subtitle)
IL_00b6: newobj System.Void UnityEngine.Events.UnityAction`1<PixelCrushers.DialogueSystem.Subtitle>::.ctor(System.Object,System.IntPtr)
IL_00bb: callvirt System.Void UnityEngine.Events.UnityEvent`1<PixelCrushers.DialogueSystem.Subtitle>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00c0: ldloc.0
IL_00c1: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_00c6: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ResponsesEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationResponseMenu
IL_00cb: ldarg.0
IL_00cc: ldftn System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationResponseMenu(PixelCrushers.DialogueSystem.Response[])
IL_00d2: newobj System.Void UnityEngine.Events.UnityAction`1<PixelCrushers.DialogueSystem.Response[]>::.ctor(System.Object,System.IntPtr)
IL_00d7: callvirt System.Void UnityEngine.Events.UnityEvent`1<PixelCrushers.DialogueSystem.Response[]>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00dc: ret
