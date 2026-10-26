TYPE TheForestOfLove.PlayMenu
METHOD System.Void TheForestOfLove.PlayMenu::OnClickStart()
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: call System.Void TheForestOfLove.PlayMenu::set_lastClickedFastForward(System.Boolean)
IL_0007: ldc.i4 200
IL_000c: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0011: ldarg.0
IL_0012: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PlayMenu::onClickStart
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_001c: ret
METHOD System.Void TheForestOfLove.PlayMenu::InitFastForwardDestinationUI()
IL_0000: ldc.i4.0
IL_0001: stloc.2
IL_0002: br.s IL_0026
IL_0004: ldarg.0
IL_0005: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_000a: ldloc.2
IL_000b: ldarg.0
IL_000c: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinations
IL_0011: ldloc.2
IL_0012: ldelem.ref
IL_0013: stelem.ref
IL_0014: ldarg.0
IL_0015: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_001a: ldloc.2
IL_001b: ldelem.ref
IL_001c: ldc.i4.1
IL_001d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0022: ldloc.2
IL_0023: ldc.i4.1
IL_0024: add
IL_0025: stloc.2
IL_0026: ldloc.2
IL_0027: ldarg.0
IL_0028: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinations
IL_002d: ldlen
IL_002e: conv.i4
IL_002f: blt.s IL_0004
IL_0031: ldarg.0
IL_0032: ldarg.0
IL_0033: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsAbove
IL_0038: stfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsAboveParallel
IL_003d: ldarg.0
IL_003e: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsAboveParallel
IL_0043: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0048: ldc.i4.1
IL_0049: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_004e: ldarg.0
IL_004f: ldarg.0
IL_0050: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsBelow
IL_0055: stfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsBelowParallel
IL_005a: ldarg.0
IL_005b: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsBelowParallel
IL_0060: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0065: ldc.i4.1
IL_0066: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_006b: ldarg.0
IL_006c: ldfld UnityEngine.GameObject TheForestOfLove.PlayMenu::fastForwardControls
IL_0071: ldc.i4.1
IL_0072: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0077: ldarg.0
IL_0078: call !!0 UnityEngine.Component::GetComponentInParent<TheForestOfLove.PlayMenu>()
IL_007d: stloc.0
IL_007e: ldloc.0
IL_007f: ldfld UnityEngine.UI.Selectable TheForestOfLove.PlayMenu::startButton
IL_0084: callvirt UnityEngine.UI.Navigation UnityEngine.UI.Selectable::get_navigation()
IL_0089: stloc.1
IL_008a: ldloca.s V_1
IL_008c: ldloc.0
IL_008d: ldfld UnityEngine.GameObject TheForestOfLove.PlayMenu::fastForwardDestination
IL_0092: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.UI.Selectable>()
IL_0097: call System.Void UnityEngine.UI.Navigation::set_selectOnDown(UnityEngine.UI.Selectable)
IL_009c: ldloc.0
IL_009d: ldfld UnityEngine.UI.Selectable TheForestOfLove.PlayMenu::startButton
IL_00a2: ldloc.1
IL_00a3: callvirt System.Void UnityEngine.UI.Selectable::set_navigation(UnityEngine.UI.Navigation)
IL_00a8: ldloc.0
IL_00a9: ldfld UnityEngine.UI.Button TheForestOfLove.PlayMenu::backButton
IL_00ae: callvirt UnityEngine.UI.Navigation UnityEngine.UI.Selectable::get_navigation()
IL_00b3: stloc.1
IL_00b4: ldloca.s V_1
IL_00b6: ldloc.0
IL_00b7: ldfld UnityEngine.GameObject TheForestOfLove.PlayMenu::fastForwardDestination
IL_00bc: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.UI.Selectable>()
IL_00c1: call System.Void UnityEngine.UI.Navigation::set_selectOnUp(UnityEngine.UI.Selectable)
IL_00c6: ldloc.0
IL_00c7: ldfld UnityEngine.UI.Button TheForestOfLove.PlayMenu::backButton
IL_00cc: ldloc.1
IL_00cd: callvirt System.Void UnityEngine.UI.Selectable::set_navigation(UnityEngine.UI.Navigation)
IL_00d2: ret
METHOD System.Void TheForestOfLove.PlayMenu::UpdateFastForwardDestinationUI()
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.PlayMenu::InitFastForwardDestinationUI()
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_000c: stloc.1
IL_000d: ldc.i4.0
IL_000e: stloc.2
IL_000f: br.s IL_0029
IL_0011: ldloc.1
IL_0012: ldloc.2
IL_0013: ldelem.ref
IL_0014: stloc.3
IL_0015: ldloc.3
IL_0016: ldnull
IL_0017: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001c: brfalse.s IL_0025
IL_001e: ldloc.3
IL_001f: ldc.i4.0
IL_0020: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0025: ldloc.2
IL_0026: ldc.i4.1
IL_0027: add
IL_0028: stloc.2
IL_0029: ldloc.2
IL_002a: ldloc.1
IL_002b: ldlen
IL_002c: conv.i4
IL_002d: blt.s IL_0011
IL_002f: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Chapter>::.ctor()
IL_0034: stloc.0
IL_0035: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Services.Persistence.DataService::GetGlobalChapterRecords()
IL_003a: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord>::GetEnumerator()
IL_003f: stloc.s V_4
IL_0041: br.s IL_0071
IL_0043: ldloc.s V_4
IL_0045: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.ChapterRecord>::get_Current()
IL_004a: stloc.s V_5
IL_004c: ldloc.s V_5
IL_004e: callvirt System.Boolean TheForestOfLove.Narrative.ChapterRecord::get_IsUnlocked()
IL_0053: brfalse.s IL_0071
IL_0055: ldloc.0
IL_0056: ldloc.s V_5
IL_0058: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_005d: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Chapter>::Contains(!0)
IL_0062: brtrue.s IL_0071
IL_0064: ldloc.0
IL_0065: ldloc.s V_5
IL_0067: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_006c: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Chapter>::Add(!0)
IL_0071: ldloc.s V_4
IL_0073: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0078: brtrue.s IL_0043
IL_007a: leave.s IL_0088
IL_007c: ldloc.s V_4
IL_007e: brfalse.s IL_0087
IL_0080: ldloc.s V_4
IL_0082: callvirt System.Void System.IDisposable::Dispose()
IL_0087: endfinally
IL_0088: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_008d: brfalse.s IL_00ea
IL_008f: ldarg.0
IL_0090: call System.Boolean TheForestOfLove.PlayMenu::get_showContinueButton()
IL_0095: brfalse.s IL_00ea
IL_0097: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Services.Persistence.DataService::GetChapterRecords()
IL_009c: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord>::GetEnumerator()
IL_00a1: stloc.s V_4
IL_00a3: br.s IL_00d3
IL_00a5: ldloc.s V_4
IL_00a7: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.ChapterRecord>::get_Current()
IL_00ac: stloc.s V_6
IL_00ae: ldloc.s V_6
IL_00b0: callvirt System.Boolean TheForestOfLove.Narrative.ChapterRecord::get_IsUnlocked()
IL_00b5: brfalse.s IL_00d3
IL_00b7: ldloc.0
IL_00b8: ldloc.s V_6
IL_00ba: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_00bf: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Chapter>::Contains(!0)
IL_00c4: brtrue.s IL_00d3
IL_00c6: ldloc.0
IL_00c7: ldloc.s V_6
IL_00c9: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_00ce: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Chapter>::Add(!0)
IL_00d3: ldloc.s V_4
IL_00d5: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_00da: brtrue.s IL_00a5
IL_00dc: leave.s IL_00ea
IL_00de: ldloc.s V_4
IL_00e0: brfalse.s IL_00e9
IL_00e2: ldloc.s V_4
IL_00e4: callvirt System.Void System.IDisposable::Dispose()
IL_00e9: endfinally
IL_00ea: ldsfld System.Boolean Globals::enableAllChapters
IL_00ef: brtrue.s IL_0115
IL_00f1: ldloc.0
IL_00f2: ldc.i4 2100
IL_00f7: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Chapter>::Contains(!0)
IL_00fc: brtrue.s IL_0115
IL_00fe: ldarg.0
IL_00ff: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_0104: ldc.i4.2
IL_0105: ldelem.ref
IL_0106: ldc.i4.0
IL_0107: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_010c: ldarg.0
IL_010d: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_0112: ldc.i4.2
IL_0113: ldnull
IL_0114: stelem.ref
IL_0115: ldsfld System.Boolean Globals::enableAllChapters
IL_011a: brtrue.s IL_0140
IL_011c: ldloc.0
IL_011d: ldc.i4 1000
IL_0122: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Chapter>::Contains(!0)
IL_0127: brtrue.s IL_0140
IL_0129: ldarg.0
IL_012a: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_012f: ldc.i4.1
IL_0130: ldelem.ref
IL_0131: ldc.i4.0
IL_0132: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0137: ldarg.0
IL_0138: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_013d: ldc.i4.1
IL_013e: ldnull
IL_013f: stelem.ref
IL_0140: ldsfld System.Boolean Globals::enableAllChapters
IL_0145: brtrue.s IL_016b
IL_0147: ldloc.0
IL_0148: ldc.i4 200
IL_014d: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Chapter>::Contains(!0)
IL_0152: brtrue.s IL_016b
IL_0154: ldarg.0
IL_0155: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_015a: ldc.i4.0
IL_015b: ldelem.ref
IL_015c: ldc.i4.0
IL_015d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0162: ldarg.0
IL_0163: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_0168: ldc.i4.0
IL_0169: ldnull
IL_016a: stelem.ref
IL_016b: ldarg.0
IL_016c: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_0171: ldc.i4.0
IL_0172: ldelem.ref
IL_0173: ldnull
IL_0174: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0179: brtrue.s IL_018b
IL_017b: ldarg.0
IL_017c: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_0181: ldc.i4.1
IL_0182: ldelem.ref
IL_0183: ldnull
IL_0184: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0189: brfalse.s IL_01d7
IL_018b: ldarg.0
IL_018c: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsAboveParallel
IL_0191: ldnull
IL_0192: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0197: brfalse.s IL_01aa
IL_0199: ldarg.0
IL_019a: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsAboveParallel
IL_019f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_01a4: ldc.i4.0
IL_01a5: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_01aa: ldarg.0
IL_01ab: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsBelowParallel
IL_01b0: ldnull
IL_01b1: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_01b6: brfalse.s IL_01c9
IL_01b8: ldarg.0
IL_01b9: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsBelowParallel
IL_01be: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_01c3: ldc.i4.0
IL_01c4: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_01c9: ldarg.0
IL_01ca: ldnull
IL_01cb: stfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsAboveParallel
IL_01d0: ldarg.0
IL_01d1: ldnull
IL_01d2: stfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsBelowParallel
IL_01d7: ldarg.0
IL_01d8: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_01dd: ldc.i4.0
IL_01de: ldelem.ref
IL_01df: ldnull
IL_01e0: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_01e5: brfalse IL_0273
IL_01ea: ldarg.0
IL_01eb: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_01f0: ldc.i4.1
IL_01f1: ldelem.ref
IL_01f2: ldnull
IL_01f3: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_01f8: brfalse.s IL_0273
IL_01fa: ldarg.0
IL_01fb: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_0200: ldc.i4.2
IL_0201: ldelem.ref
IL_0202: ldnull
IL_0203: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0208: brfalse.s IL_0273
IL_020a: ldarg.0
IL_020b: ldfld UnityEngine.GameObject TheForestOfLove.PlayMenu::fastForwardControls
IL_0210: ldc.i4.0
IL_0211: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0216: ldarg.0
IL_0217: call !!0 UnityEngine.Component::GetComponentInParent<TheForestOfLove.PlayMenu>()
IL_021c: stloc.s V_7
IL_021e: ldloc.s V_7
IL_0220: ldfld UnityEngine.UI.Selectable TheForestOfLove.PlayMenu::startButton
IL_0225: callvirt UnityEngine.UI.Navigation UnityEngine.UI.Selectable::get_navigation()
IL_022a: stloc.s V_8
IL_022c: ldloca.s V_8
IL_022e: ldloc.s V_7
IL_0230: ldfld UnityEngine.UI.Button TheForestOfLove.PlayMenu::backButton
IL_0235: call System.Void UnityEngine.UI.Navigation::set_selectOnDown(UnityEngine.UI.Selectable)
IL_023a: ldloc.s V_7
IL_023c: ldfld UnityEngine.UI.Selectable TheForestOfLove.PlayMenu::startButton
IL_0241: ldloc.s V_8
IL_0243: callvirt System.Void UnityEngine.UI.Selectable::set_navigation(UnityEngine.UI.Navigation)
IL_0248: ldloc.s V_7
IL_024a: ldfld UnityEngine.UI.Button TheForestOfLove.PlayMenu::backButton
IL_024f: callvirt UnityEngine.UI.Navigation UnityEngine.UI.Selectable::get_navigation()
IL_0254: stloc.s V_8
IL_0256: ldloca.s V_8
IL_0258: ldloc.s V_7
IL_025a: ldfld UnityEngine.UI.Selectable TheForestOfLove.PlayMenu::startButton
IL_025f: call System.Void UnityEngine.UI.Navigation::set_selectOnUp(UnityEngine.UI.Selectable)
IL_0264: ldloc.s V_7
IL_0266: ldfld UnityEngine.UI.Button TheForestOfLove.PlayMenu::backButton
IL_026b: ldloc.s V_8
IL_026d: callvirt System.Void UnityEngine.UI.Selectable::set_navigation(UnityEngine.UI.Navigation)
IL_0272: ret
IL_0273: ldarg.0
IL_0274: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_0279: ldarg.0
IL_027a: call System.Int32 TheForestOfLove.PlayMenu::get_currentFastForwardDestinationIndex()
IL_027f: ldc.i4.0
IL_0280: ldarg.0
IL_0281: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_0286: ldlen
IL_0287: conv.i4
IL_0288: ldc.i4.1
IL_0289: sub
IL_028a: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_028f: ldelem.ref
IL_0290: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_0295: ldc.i4.1
IL_0296: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_029b: ldarg.0
IL_029c: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsAboveParallel
IL_02a1: ldnull
IL_02a2: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_02a7: brfalse.s IL_02ea
IL_02a9: ldarg.0
IL_02aa: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsAboveParallel
IL_02af: ldarg.0
IL_02b0: ldfld System.Boolean TheForestOfLove.PlayMenu::selectedFFDControls
IL_02b5: brfalse.s IL_02e0
IL_02b7: ldarg.0
IL_02b8: call System.Int32 TheForestOfLove.PlayMenu::get_currentFastForwardDestinationIndex()
IL_02bd: ldarg.0
IL_02be: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_02c3: ldlen
IL_02c4: conv.i4
IL_02c5: ldc.i4.1
IL_02c6: sub
IL_02c7: bge.s IL_02e0
IL_02c9: ldarg.0
IL_02ca: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_02cf: ldarg.0
IL_02d0: call System.Int32 TheForestOfLove.PlayMenu::get_currentFastForwardDestinationIndex()
IL_02d5: ldc.i4.1
IL_02d6: add
IL_02d7: ldelem.ref
IL_02d8: ldnull
IL_02d9: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_02de: brtrue.s IL_02e3
IL_02e0: ldc.i4.0
IL_02e1: br.s IL_02e4
IL_02e3: ldc.i4.1
IL_02e4: conv.r4
IL_02e5: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_02ea: ldarg.0
IL_02eb: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsBelowParallel
IL_02f0: ldnull
IL_02f1: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_02f6: brfalse.s IL_0319
IL_02f8: ldarg.0
IL_02f9: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsBelowParallel
IL_02fe: ldarg.0
IL_02ff: ldfld System.Boolean TheForestOfLove.PlayMenu::selectedFFDControls
IL_0304: brfalse.s IL_030f
IL_0306: ldarg.0
IL_0307: call System.Int32 TheForestOfLove.PlayMenu::get_currentFastForwardDestinationIndex()
IL_030c: ldc.i4.0
IL_030d: bgt.s IL_0312
IL_030f: ldc.i4.0
IL_0310: br.s IL_0313
IL_0312: ldc.i4.1
IL_0313: conv.r4
IL_0314: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0319: ret
METHOD System.Void TheForestOfLove.PlayMenu::OnClickFastForwardDestination()
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.PlayMenu::set_lastClickedFastForward(System.Boolean)
IL_0007: ldc.i4.s 100
IL_0009: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PlayMenu::onClickFastForward
IL_0014: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0019: ret
METHOD System.Void TheForestOfLove.PlayMenu::OnClickScaleFactorUp()
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.PlayMenu::waitFramesToClearInput
IL_0006: ldc.i4.0
IL_0007: ble.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.2
IL_000c: stfld System.Int32 TheForestOfLove.PlayMenu::waitFramesToClearInput
IL_0011: ldarg.0
IL_0012: ldc.i4.1
IL_0013: stfld System.Boolean TheForestOfLove.PlayMenu::selectedFFDControls
IL_0018: ldarg.0
IL_0019: call System.Int32 TheForestOfLove.PlayMenu::get_currentFastForwardDestinationIndex()
IL_001e: stloc.0
IL_001f: ldarg.0
IL_0020: ldarg.0
IL_0021: call System.Int32 TheForestOfLove.PlayMenu::get_currentFastForwardDestinationIndex()
IL_0026: ldc.i4.1
IL_0027: add
IL_0028: stloc.1
IL_0029: ldarg.0
IL_002a: ldloc.1
IL_002b: call System.Void TheForestOfLove.PlayMenu::set_currentFastForwardDestinationIndex(System.Int32)
IL_0030: ldloc.1
IL_0031: ldc.i4.0
IL_0032: ldarg.0
IL_0033: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_0038: ldlen
IL_0039: conv.i4
IL_003a: ldc.i4.1
IL_003b: sub
IL_003c: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_0041: call System.Void TheForestOfLove.PlayMenu::set_currentFastForwardDestinationIndex(System.Int32)
IL_0046: ldarg.0
IL_0047: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_004c: ldarg.0
IL_004d: call System.Int32 TheForestOfLove.PlayMenu::get_currentFastForwardDestinationIndex()
IL_0052: ldelem.ref
IL_0053: ldnull
IL_0054: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0059: brfalse.s IL_0062
IL_005b: ldarg.0
IL_005c: ldloc.0
IL_005d: call System.Void TheForestOfLove.PlayMenu::set_currentFastForwardDestinationIndex(System.Int32)
IL_0062: ldarg.0
IL_0063: ldc.i4.0
IL_0064: call System.Void TheForestOfLove.PlayMenu::set_lastClickedFastForward(System.Boolean)
IL_0069: ldarg.0
IL_006a: call System.Void TheForestOfLove.PlayMenu::UpdateFastForwardDestinationUI()
IL_006f: ldarg.0
IL_0070: ldc.i4.1
IL_0071: stfld System.Boolean TheForestOfLove.PlayMenu::needToReselectFFDBaseOption
IL_0076: ldc.i4.s 100
IL_0078: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_007d: ret
METHOD System.Void TheForestOfLove.PlayMenu::OnClickScaleFactorDown()
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.PlayMenu::waitFramesToClearInput
IL_0006: ldc.i4.0
IL_0007: ble.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.2
IL_000c: stfld System.Int32 TheForestOfLove.PlayMenu::waitFramesToClearInput
IL_0011: ldarg.0
IL_0012: ldc.i4.1
IL_0013: stfld System.Boolean TheForestOfLove.PlayMenu::selectedFFDControls
IL_0018: ldarg.0
IL_0019: call System.Int32 TheForestOfLove.PlayMenu::get_currentFastForwardDestinationIndex()
IL_001e: stloc.0
IL_001f: ldarg.0
IL_0020: ldarg.0
IL_0021: call System.Int32 TheForestOfLove.PlayMenu::get_currentFastForwardDestinationIndex()
IL_0026: ldc.i4.1
IL_0027: sub
IL_0028: stloc.1
IL_0029: ldarg.0
IL_002a: ldloc.1
IL_002b: call System.Void TheForestOfLove.PlayMenu::set_currentFastForwardDestinationIndex(System.Int32)
IL_0030: ldloc.1
IL_0031: ldc.i4.0
IL_0032: ldarg.0
IL_0033: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_0038: ldlen
IL_0039: conv.i4
IL_003a: ldc.i4.1
IL_003b: sub
IL_003c: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_0041: call System.Void TheForestOfLove.PlayMenu::set_currentFastForwardDestinationIndex(System.Int32)
IL_0046: ldarg.0
IL_0047: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_004c: ldarg.0
IL_004d: call System.Int32 TheForestOfLove.PlayMenu::get_currentFastForwardDestinationIndex()
IL_0052: ldelem.ref
IL_0053: ldnull
IL_0054: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0059: brfalse.s IL_0062
IL_005b: ldarg.0
IL_005c: ldloc.0
IL_005d: call System.Void TheForestOfLove.PlayMenu::set_currentFastForwardDestinationIndex(System.Int32)
IL_0062: ldarg.0
IL_0063: ldc.i4.0
IL_0064: call System.Void TheForestOfLove.PlayMenu::set_lastClickedFastForward(System.Boolean)
IL_0069: ldarg.0
IL_006a: call System.Void TheForestOfLove.PlayMenu::UpdateFastForwardDestinationUI()
IL_006f: ldarg.0
IL_0070: ldc.i4.1
IL_0071: stfld System.Boolean TheForestOfLove.PlayMenu::needToReselectFFDBaseOption
IL_0076: ldc.i4.s 100
IL_0078: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_007d: ret
