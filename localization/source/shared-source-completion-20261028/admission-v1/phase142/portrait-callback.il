TYPE TheForestOfLove.CustomPortraitsUi
METHOD System.Void TheForestOfLove.CustomPortraitsUi::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueStart
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnConversationStart_Handler(TheForestOfLove.Narrative.Dialogue)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_001c: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginDetailed
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnConversationLine_Handler(TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle)
IL_0028: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0032: ldsfld UnityEngine.Events.UnityEvent`1<System.Collections.Generic.IEnumerable`1<System.String>> TheForestOfLove.Narrative.DialogueService::onDialogueResponseMenu
IL_0037: ldarg.0
IL_0038: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnShowResponseOptions(System.Collections.Generic.IEnumerable`1<System.String>)
IL_003e: newobj System.Void UnityEngine.Events.UnityAction`1<System.Collections.Generic.IEnumerable`1<System.String>>::.ctor(System.Object,System.IntPtr)
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Collections.Generic.IEnumerable`1<System.String>>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0048: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnConversationEnd_Handler()
IL_0054: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_005e: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowGossipUI
IL_0063: ldarg.0
IL_0064: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnGossipUiOpened()
IL_006a: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_006f: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0074: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideGossipUI
IL_0079: ldarg.0
IL_007a: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnGossipUiClosed()
IL_0080: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0085: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_008a: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onArcTriggerUpdatePortraits
IL_008f: ldarg.0
IL_0090: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnConversationTriggerUpdatePortraits(System.String)
IL_0096: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_009b: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00a0: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onArcTriggerLeftAlignPortraits
IL_00a5: ldarg.0
IL_00a6: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnConversationTriggerLeftAlignPortraits(System.String)
IL_00ac: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00b1: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00b6: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onArcTriggerRightAlignPortraits
IL_00bb: ldarg.0
IL_00bc: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnConversationTriggerRightAlignPortraits(System.String)
IL_00c2: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00c7: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00cc: ret
METHOD System.Void TheForestOfLove.CustomPortraitsUi::RemoveEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners()
IL_0006: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueStart
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnConversationStart_Handler(TheForestOfLove.Narrative.Dialogue)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_001c: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginDetailed
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnConversationLine_Handler(TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle)
IL_0028: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::RemoveListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0032: ldsfld UnityEngine.Events.UnityEvent`1<System.Collections.Generic.IEnumerable`1<System.String>> TheForestOfLove.Narrative.DialogueService::onDialogueResponseMenu
IL_0037: ldarg.0
IL_0038: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnShowResponseOptions(System.Collections.Generic.IEnumerable`1<System.String>)
IL_003e: newobj System.Void UnityEngine.Events.UnityAction`1<System.Collections.Generic.IEnumerable`1<System.String>>::.ctor(System.Object,System.IntPtr)
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Collections.Generic.IEnumerable`1<System.String>>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0048: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnConversationEnd_Handler()
IL_0054: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_005e: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowGossipUI
IL_0063: ldarg.0
IL_0064: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnGossipUiOpened()
IL_006a: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_006f: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_0074: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideGossipUI
IL_0079: ldarg.0
IL_007a: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnGossipUiClosed()
IL_0080: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0085: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_008a: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onArcTriggerUpdatePortraits
IL_008f: ldarg.0
IL_0090: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnConversationTriggerUpdatePortraits(System.String)
IL_0096: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_009b: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00a0: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onArcTriggerLeftAlignPortraits
IL_00a5: ldarg.0
IL_00a6: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnConversationTriggerLeftAlignPortraits(System.String)
IL_00ac: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00b1: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00b6: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onArcTriggerRightAlignPortraits
IL_00bb: ldarg.0
IL_00bc: ldftn System.Void TheForestOfLove.CustomPortraitsUi::OnConversationTriggerRightAlignPortraits(System.String)
IL_00c2: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00c7: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00cc: ret
METHOD System.Void TheForestOfLove.CustomPortraitsUi::OnConversationTriggerLeftAlignPortraits(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean Globals::get_DisableTriggeredEffects()
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldarg.1
IL_0009: ldstr "Player"
IL_000e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0013: brfalse IL_00ce
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::portraitContainerLeft
IL_001e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0023: ldnull
IL_0024: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::portraitContainerLeft
IL_002f: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0034: ldarg.0
IL_0035: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::foregroundCanvasAnimator
IL_003a: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_003f: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0044: ldarg.0
IL_0045: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::portraitContainerRight
IL_004a: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_004f: ldnull
IL_0050: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0055: ldarg.0
IL_0056: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::portraitContainerRight
IL_005b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0060: ldarg.0
IL_0061: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::foregroundCanvasAnimator
IL_0066: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_006b: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0070: ldarg.0
IL_0071: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::backgroundContainerLeft
IL_0076: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_007b: ldnull
IL_007c: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0081: ldarg.0
IL_0082: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::backgroundContainerLeft
IL_0087: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_008c: ldarg.0
IL_008d: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundCanvasAnimator
IL_0092: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0097: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_009c: ldarg.0
IL_009d: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::backgroundContainerRight
IL_00a2: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00a7: ldnull
IL_00a8: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_00ad: ldarg.0
IL_00ae: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::backgroundContainerRight
IL_00b3: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00b8: ldarg.0
IL_00b9: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundCanvasAnimator
IL_00be: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00c3: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_00c8: ldc.i4.1
IL_00c9: call System.Void TheForestOfLove.ResponseOptionsUI::set_LeftAlignPlayerPortraits(System.Boolean)
IL_00ce: ldnull
IL_00cf: stloc.0
IL_00d0: ldarg.0
IL_00d1: ldfld UnityEngine.UI.Image TheForestOfLove.CustomPortraitsUi::portraitImageRight
IL_00d6: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_00db: ldnull
IL_00dc: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00e1: brtrue.s IL_00f6
IL_00e3: ldarg.0
IL_00e4: ldfld UnityEngine.UI.Image TheForestOfLove.CustomPortraitsUi::backgroundImageRight
IL_00e9: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_00ee: ldnull
IL_00ef: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00f4: brfalse.s IL_011f
IL_00f6: ldnull
IL_00f7: stloc.1
IL_00f8: ldnull
IL_00f9: stloc.2
IL_00fa: ldarg.0
IL_00fb: ldarg.0
IL_00fc: ldfld UnityEngine.UI.Image TheForestOfLove.CustomPortraitsUi::portraitImageRight
IL_0101: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0106: dup
IL_0107: brtrue.s IL_0115
IL_0109: pop
IL_010a: ldarg.0
IL_010b: ldfld UnityEngine.UI.Image TheForestOfLove.CustomPortraitsUi::backgroundImageRight
IL_0110: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0115: ldloca.s V_1
IL_0117: ldloca.s V_2
IL_0119: call TheForestOfLove.Narrative.Portrait TheForestOfLove.CustomPortraitsUi::FindSchemaBySprite(UnityEngine.Sprite,UnityEngine.Sprite&,UnityEngine.Sprite&)
IL_011e: stloc.0
IL_011f: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Portrait> TheForestOfLove.Services.Persistence.DataService::GetDialoguePortraits()
IL_0124: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Portrait>::GetEnumerator()
IL_0129: stloc.3
IL_012a: br.s IL_0185
IL_012c: ldloc.3
IL_012d: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Portrait>::get_Current()
IL_0132: stloc.s V_4
IL_0134: ldloc.s V_4
IL_0136: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_013b: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0140: ldarg.1
IL_0141: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0146: brfalse.s IL_0185
IL_0148: ldarg.0
IL_0149: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait> TheForestOfLove.CustomPortraitsUi::rightAlignedSchemas
IL_014e: ldloc.s V_4
IL_0150: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait>::Contains(!0)
IL_0155: brfalse.s IL_0185
IL_0157: ldarg.0
IL_0158: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait> TheForestOfLove.CustomPortraitsUi::rightAlignedSchemas
IL_015d: ldloc.s V_4
IL_015f: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait>::Remove(!0)
IL_0164: pop
IL_0165: ldloc.0
IL_0166: brfalse.s IL_0185
IL_0168: ldloc.0
IL_0169: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_016e: ldloc.s V_4
IL_0170: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_0175: bne.un.s IL_0185
IL_0177: ldnull
IL_0178: stloc.0
IL_0179: ldarg.0
IL_017a: call System.Void TheForestOfLove.CustomPortraitsUi::ClearPortraitRight()
IL_017f: ldarg.0
IL_0180: call System.Void TheForestOfLove.CustomPortraitsUi::ClearBackgroundRight()
IL_0185: ldloc.3
IL_0186: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_018b: brtrue.s IL_012c
IL_018d: leave.s IL_0199
IL_018f: ldloc.3
IL_0190: brfalse.s IL_0198
IL_0192: ldloc.3
IL_0193: callvirt System.Void System.IDisposable::Dispose()
IL_0198: endfinally
IL_0199: ret
METHOD System.Void TheForestOfLove.CustomPortraitsUi::OnConversationTriggerRightAlignPortraits(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean Globals::get_DisableTriggeredEffects()
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldarg.1
IL_0009: ldstr "Player"
IL_000e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0013: brfalse IL_00ce
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::portraitContainerRight
IL_001e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0023: ldnull
IL_0024: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::portraitContainerRight
IL_002f: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0034: ldarg.0
IL_0035: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::foregroundCanvasAnimator
IL_003a: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_003f: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0044: ldarg.0
IL_0045: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::portraitContainerLeft
IL_004a: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_004f: ldnull
IL_0050: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0055: ldarg.0
IL_0056: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::portraitContainerLeft
IL_005b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0060: ldarg.0
IL_0061: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::foregroundCanvasAnimator
IL_0066: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_006b: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0070: ldarg.0
IL_0071: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::backgroundContainerRight
IL_0076: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_007b: ldnull
IL_007c: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0081: ldarg.0
IL_0082: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::backgroundContainerRight
IL_0087: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_008c: ldarg.0
IL_008d: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundCanvasAnimator
IL_0092: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0097: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_009c: ldarg.0
IL_009d: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::backgroundContainerLeft
IL_00a2: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00a7: ldnull
IL_00a8: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_00ad: ldarg.0
IL_00ae: ldfld UnityEngine.Transform TheForestOfLove.CustomPortraitsUi::backgroundContainerLeft
IL_00b3: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00b8: ldarg.0
IL_00b9: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundCanvasAnimator
IL_00be: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00c3: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_00c8: ldc.i4.0
IL_00c9: call System.Void TheForestOfLove.ResponseOptionsUI::set_LeftAlignPlayerPortraits(System.Boolean)
IL_00ce: ldnull
IL_00cf: stloc.0
IL_00d0: ldarg.0
IL_00d1: ldfld UnityEngine.UI.Image TheForestOfLove.CustomPortraitsUi::portraitImageLeft
IL_00d6: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_00db: ldnull
IL_00dc: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00e1: brtrue.s IL_00f6
IL_00e3: ldarg.0
IL_00e4: ldfld UnityEngine.UI.Image TheForestOfLove.CustomPortraitsUi::backgroundImageLeft
IL_00e9: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_00ee: ldnull
IL_00ef: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00f4: brfalse.s IL_011f
IL_00f6: ldnull
IL_00f7: stloc.1
IL_00f8: ldnull
IL_00f9: stloc.2
IL_00fa: ldarg.0
IL_00fb: ldarg.0
IL_00fc: ldfld UnityEngine.UI.Image TheForestOfLove.CustomPortraitsUi::portraitImageLeft
IL_0101: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0106: dup
IL_0107: brtrue.s IL_0115
IL_0109: pop
IL_010a: ldarg.0
IL_010b: ldfld UnityEngine.UI.Image TheForestOfLove.CustomPortraitsUi::backgroundImageLeft
IL_0110: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0115: ldloca.s V_1
IL_0117: ldloca.s V_2
IL_0119: call TheForestOfLove.Narrative.Portrait TheForestOfLove.CustomPortraitsUi::FindSchemaBySprite(UnityEngine.Sprite,UnityEngine.Sprite&,UnityEngine.Sprite&)
IL_011e: stloc.0
IL_011f: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Portrait> TheForestOfLove.Services.Persistence.DataService::GetDialoguePortraits()
IL_0124: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Portrait>::GetEnumerator()
IL_0129: stloc.3
IL_012a: br.s IL_0184
IL_012c: ldloc.3
IL_012d: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Portrait>::get_Current()
IL_0132: stloc.s V_4
IL_0134: ldloc.s V_4
IL_0136: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_013b: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0140: ldarg.1
IL_0141: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0146: brfalse.s IL_0184
IL_0148: ldarg.0
IL_0149: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait> TheForestOfLove.CustomPortraitsUi::rightAlignedSchemas
IL_014e: ldloc.s V_4
IL_0150: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait>::Contains(!0)
IL_0155: brtrue.s IL_0184
IL_0157: ldarg.0
IL_0158: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait> TheForestOfLove.CustomPortraitsUi::rightAlignedSchemas
IL_015d: ldloc.s V_4
IL_015f: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait>::Add(!0)
IL_0164: ldloc.0
IL_0165: brfalse.s IL_0184
IL_0167: ldloc.0
IL_0168: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_016d: ldloc.s V_4
IL_016f: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_0174: bne.un.s IL_0184
IL_0176: ldnull
IL_0177: stloc.0
IL_0178: ldarg.0
IL_0179: call System.Void TheForestOfLove.CustomPortraitsUi::ClearPortraitLeft()
IL_017e: ldarg.0
IL_017f: call System.Void TheForestOfLove.CustomPortraitsUi::ClearBackgroundLeft()
IL_0184: ldloc.3
IL_0185: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_018a: brtrue.s IL_012c
IL_018c: leave.s IL_0198
IL_018e: ldloc.3
IL_018f: brfalse.s IL_0197
IL_0191: ldloc.3
IL_0192: callvirt System.Void System.IDisposable::Dispose()
IL_0197: endfinally
IL_0198: ret
