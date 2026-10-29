TYPE TheForestOfLove.ItemGetNotification
METHOD System.Void TheForestOfLove.ItemGetNotification::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.ItemGetNotification::get_visible()
IL_0006: brfalse IL_0099
IL_000b: ldarg.0
IL_000c: ldarg.0
IL_000d: ldfld System.Single TheForestOfLove.ItemGetNotification::currentOpenTime
IL_0012: call System.Single UnityEngine.Time::get_deltaTime()
IL_0017: add
IL_0018: stfld System.Single TheForestOfLove.ItemGetNotification::currentOpenTime
IL_001d: ldarg.0
IL_001e: ldfld System.Boolean TheForestOfLove.ItemGetNotification::showingInventoryItemNotification
IL_0023: brfalse.s IL_0099
IL_0025: ldarg.0
IL_0026: ldfld System.Single TheForestOfLove.ItemGetNotification::currentOpenTime
IL_002b: ldarg.0
IL_002c: ldfld System.Single TheForestOfLove.ItemGetNotification::minimumOpenTime
IL_0031: blt.un.s IL_0099
IL_0033: ldc.i4.0
IL_0034: stloc.0
IL_0035: call System.Boolean TheForestOfLove.InputHelper::get_IsSubmitButtonDown()
IL_003a: brfalse.s IL_0040
IL_003c: ldc.i4.1
IL_003d: stloc.0
IL_003e: br.s IL_0050
IL_0040: call System.Boolean TheForestOfLove.InputHelper::get_IsPauseButtonDown()
IL_0045: brtrue.s IL_004e
IL_0047: call System.Boolean TheForestOfLove.InputHelper::get_IsBackButtonDown()
IL_004c: brfalse.s IL_0050
IL_004e: ldc.i4.1
IL_004f: stloc.0
IL_0050: ldloc.0
IL_0051: brfalse.s IL_0099
IL_0053: newobj System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass54_0::.ctor()
IL_0058: stloc.1
IL_0059: ldarg.0
IL_005a: call System.Void TheForestOfLove.ItemGetNotification::HideNotification()
IL_005f: ldc.i4 200
IL_0064: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0069: ldarg.0
IL_006a: ldc.i4.0
IL_006b: stfld System.Boolean TheForestOfLove.ItemGetNotification::showingInventoryItemNotification
IL_0070: ldloc.1
IL_0071: ldarg.0
IL_0072: ldfld UnityEngine.GameObject TheForestOfLove.ItemGetNotification::inventoryItemNotificationInstance
IL_0077: stfld UnityEngine.GameObject TheForestOfLove.ItemGetNotification/<>c__DisplayClass54_0::obj
IL_007c: ldarg.0
IL_007d: ldnull
IL_007e: stfld UnityEngine.GameObject TheForestOfLove.ItemGetNotification::inventoryItemNotificationInstance
IL_0083: ldc.r4 2
IL_0088: ldloc.1
IL_0089: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass54_0::<Update>b__0()
IL_008f: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0094: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0099: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_009e: brtrue.s IL_00a6
IL_00a0: ldarg.0
IL_00a1: call System.Void TheForestOfLove.ItemGetNotification::ShowItemGetNotification()
IL_00a6: ret
