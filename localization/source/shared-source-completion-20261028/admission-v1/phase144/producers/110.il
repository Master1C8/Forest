TYPE TheForestOfLove.MasterLog
METHOD System.Void TheForestOfLove.MasterLog::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldarg.0
IL_0007: ldarg.0
IL_0008: ldc.i4.3
IL_0009: dup
IL_000a: stloc.1
IL_000b: stfld TheForestOfLove.MasterLogPage TheForestOfLove.MasterLog::currentDisplayedPage
IL_0010: ldloc.1
IL_0011: call System.Void TheForestOfLove.MasterLog::set_currentPage(TheForestOfLove.MasterLogPage)
IL_0016: ldtoken TheForestOfLove.MasterLogPage
IL_001b: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0020: call System.String[] System.Enum::GetNames(System.Type)
IL_0025: stloc.0
IL_0026: ldarg.0
IL_0027: ldloc.0
IL_0028: ldlen
IL_0029: conv.i4
IL_002a: stfld System.Int32 TheForestOfLove.MasterLog::totalNumPages
IL_002f: ldarg.0
IL_0030: ldarg.0
IL_0031: ldfld System.Int32 TheForestOfLove.MasterLog::totalNumPages
IL_0036: newarr UnityEngine.GameObject
IL_003b: stfld UnityEngine.GameObject[] TheForestOfLove.MasterLog::pageLabels
IL_0040: ldc.i4.0
IL_0041: stloc.2
IL_0042: br.s IL_006f
IL_0044: ldstr "Canvas/Container/Labels/{0}"
IL_0049: ldloc.0
IL_004a: ldloc.2
IL_004b: ldelem.ref
IL_004c: call System.String System.String::Format(System.String,System.Object)
IL_0051: stloc.3
IL_0052: ldarg.0
IL_0053: ldfld UnityEngine.GameObject[] TheForestOfLove.MasterLog::pageLabels
IL_0058: ldloc.2
IL_0059: ldarg.0
IL_005a: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_005f: ldloc.3
IL_0060: callvirt UnityEngine.Transform UnityEngine.Transform::Find(System.String)
IL_0065: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_006a: stelem.ref
IL_006b: ldloc.2
IL_006c: ldc.i4.1
IL_006d: add
IL_006e: stloc.2
IL_006f: ldloc.2
IL_0070: ldarg.0
IL_0071: ldfld System.Int32 TheForestOfLove.MasterLog::totalNumPages
IL_0076: blt.s IL_0044
IL_0078: ldarg.0
IL_0079: call System.Void TheForestOfLove.MasterLog::UpdateVisiblePageLabel()
IL_007e: ldarg.0
IL_007f: ldarg.0
IL_0080: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0085: ldstr "Canvas/Container/Controls/ControlsL"
IL_008a: callvirt UnityEngine.Transform UnityEngine.Transform::Find(System.String)
IL_008f: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_0094: stfld UnityEngine.Animator TheForestOfLove.MasterLog::animatorControlsL
IL_0099: ldarg.0
IL_009a: ldarg.0
IL_009b: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00a0: ldstr "Canvas/Container/Controls/ControlsR"
IL_00a5: callvirt UnityEngine.Transform UnityEngine.Transform::Find(System.String)
IL_00aa: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_00af: stfld UnityEngine.Animator TheForestOfLove.MasterLog::animatorControlsR
IL_00b4: ldarg.0
IL_00b5: ldarg.0
IL_00b6: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00bb: ldstr "Canvas/Container/Placeholders"
IL_00c0: callvirt UnityEngine.Transform UnityEngine.Transform::Find(System.String)
IL_00c5: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_00ca: stfld UnityEngine.Animator TheForestOfLove.MasterLog::placeholdersAnimator
IL_00cf: ldarg.0
IL_00d0: ldarg.0
IL_00d1: ldfld UnityEngine.Animator TheForestOfLove.MasterLog::placeholdersAnimator
IL_00d6: callvirt !!0 UnityEngine.Component::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_00db: stfld TheForestOfLove.AnimationStateEventListener TheForestOfLove.MasterLog::placeholdersEventListener
IL_00e0: ldarg.0
IL_00e1: ldfld TheForestOfLove.AnimationStateEventListener TheForestOfLove.MasterLog::placeholdersEventListener
IL_00e6: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipStarted
IL_00eb: ldarg.0
IL_00ec: ldftn System.Void TheForestOfLove.MasterLog::OnAnimationClipStarted(System.String)
IL_00f2: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00f7: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00fc: ldarg.0
IL_00fd: ldc.i4.3
IL_00fe: newarr UnityEngine.GameObject
IL_0103: stfld UnityEngine.GameObject[] TheForestOfLove.MasterLog::placeholderObjects
IL_0108: ldarg.0
IL_0109: ldfld UnityEngine.GameObject[] TheForestOfLove.MasterLog::placeholderObjects
IL_010e: ldc.i4.0
IL_010f: ldarg.0
IL_0110: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0115: ldstr "Canvas/Container/Placeholders/Left"
IL_011a: callvirt UnityEngine.Transform UnityEngine.Transform::Find(System.String)
IL_011f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0124: stelem.ref
IL_0125: ldarg.0
IL_0126: ldfld UnityEngine.GameObject[] TheForestOfLove.MasterLog::placeholderObjects
IL_012b: ldc.i4.1
IL_012c: ldarg.0
IL_012d: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0132: ldstr "Canvas/Container/Placeholders/Center"
IL_0137: callvirt UnityEngine.Transform UnityEngine.Transform::Find(System.String)
IL_013c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0141: stelem.ref
IL_0142: ldarg.0
IL_0143: ldfld UnityEngine.GameObject[] TheForestOfLove.MasterLog::placeholderObjects
IL_0148: ldc.i4.2
IL_0149: ldarg.0
IL_014a: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_014f: ldstr "Canvas/Container/Placeholders/Right"
IL_0154: callvirt UnityEngine.Transform UnityEngine.Transform::Find(System.String)
IL_0159: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_015e: stelem.ref
IL_015f: ldarg.0
IL_0160: ldarg.0
IL_0161: ldfld TheForestOfLove.MasterLogPage TheForestOfLove.MasterLog::currentDisplayedPage
IL_0166: call System.Void TheForestOfLove.MasterLog::UpdatePlaceholderContents(TheForestOfLove.MasterLogPage)
IL_016b: ldarg.0
IL_016c: ldarg.0
IL_016d: ldc.i4.1
IL_016e: call !!0 UnityEngine.Component::GetComponentInChildren<PixelCrushers.UIPanel>(System.Boolean)
IL_0173: stfld PixelCrushers.UIPanel TheForestOfLove.MasterLog::masterLogUi
IL_0178: ldarg.0
IL_0179: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.CritterLog>()
IL_017e: stfld TheForestOfLove.CritterLog TheForestOfLove.MasterLog::critterLog
IL_0183: ldarg.0
IL_0184: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.QuestLog>()
IL_0189: stfld TheForestOfLove.QuestLog TheForestOfLove.MasterLog::questLog
IL_018e: ldarg.0
IL_018f: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.InventoryUi>()
IL_0194: stfld TheForestOfLove.InventoryUi TheForestOfLove.MasterLog::inventoryUi
IL_0199: ldarg.0
IL_019a: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MapUI>()
IL_019f: stfld TheForestOfLove.MapUI TheForestOfLove.MasterLog::mapUi
IL_01a4: ret
