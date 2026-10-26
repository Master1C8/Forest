TYPE TheForestOfLove.ItemGetNotification
METHOD System.Void TheForestOfLove.ItemGetNotification::ShowInventoryItemNotification(TheForestOfLove.Inventory.InventoryItemType) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.ItemGetNotification::get_visible()
IL_0006: brtrue.s IL_001a
IL_0008: ldarg.1
IL_0009: ldc.i4.s 40
IL_000b: beq.s IL_001a
IL_000d: ldarg.1
IL_000e: ldc.i4.s 50
IL_0010: beq.s IL_001a
IL_0012: ldarg.1
IL_0013: ldc.i4 180
IL_0018: bne.un.s IL_001b
IL_001a: ret
IL_001b: ldarg.1
IL_001c: call TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Services.Persistence.DataService::GetInventoryItemByItemType(TheForestOfLove.Inventory.InventoryItemType)
IL_0021: stloc.0
IL_0022: call System.Boolean TheForestOfLove.QuestTriggerHelper::InVsliceStoryInstance()
IL_0027: brfalse.s IL_0042
IL_0029: ldarg.0
IL_002a: ldarg.0
IL_002b: ldfld UnityEngine.GameObject TheForestOfLove.ItemGetNotification::inventoryItemPrefabVslice
IL_0030: ldarg.0
IL_0031: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::messageContainer
IL_0036: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_003b: stfld UnityEngine.GameObject TheForestOfLove.ItemGetNotification::inventoryItemNotificationInstance
IL_0040: br.s IL_0059
IL_0042: ldarg.0
IL_0043: ldarg.0
IL_0044: ldfld UnityEngine.GameObject TheForestOfLove.ItemGetNotification::inventoryItemPrefab
IL_0049: ldarg.0
IL_004a: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::messageContainer
IL_004f: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0054: stfld UnityEngine.GameObject TheForestOfLove.ItemGetNotification::inventoryItemNotificationInstance
IL_0059: ldarg.0
IL_005a: ldc.i4.1
IL_005b: stfld System.Boolean TheForestOfLove.ItemGetNotification::showingInventoryItemNotification
IL_0060: ldstr "You got {0}!"
IL_0065: ldloc.0
IL_0066: ldfld System.String TheForestOfLove.Inventory.InventoryItem::notificationPhrase
IL_006b: call System.String System.String::Format(System.String,System.Object)
IL_0070: stloc.1
IL_0071: ldarg.0
IL_0072: ldfld UnityEngine.GameObject TheForestOfLove.ItemGetNotification::inventoryItemNotificationInstance
IL_0077: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<UnityEngine.UI.Image>()
IL_007c: stloc.2
IL_007d: ldc.i4.0
IL_007e: stloc.3
IL_007f: br.s IL_0099
IL_0081: ldloc.2
IL_0082: ldloc.3
IL_0083: ldelem.ref
IL_0084: dup
IL_0085: ldloc.0
IL_0086: ldfld UnityEngine.Sprite TheForestOfLove.Inventory.InventoryItem::sprite
IL_008b: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_0090: callvirt System.Void UnityEngine.UI.Graphic::SetNativeSize()
IL_0095: ldloc.3
IL_0096: ldc.i4.1
IL_0097: add
IL_0098: stloc.3
IL_0099: ldloc.3
IL_009a: ldloc.2
IL_009b: ldlen
IL_009c: conv.i4
IL_009d: blt.s IL_0081
IL_009f: ldarg.0
IL_00a0: ldfld UnityEngine.GameObject TheForestOfLove.ItemGetNotification::inventoryItemNotificationInstance
IL_00a5: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_00aa: stloc.s V_4
IL_00ac: ldc.i4.0
IL_00ad: stloc.3
IL_00ae: br.s IL_00be
IL_00b0: ldloc.s V_4
IL_00b2: ldloc.3
IL_00b3: ldelem.ref
IL_00b4: ldloc.1
IL_00b5: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_00ba: ldloc.3
IL_00bb: ldc.i4.1
IL_00bc: add
IL_00bd: stloc.3
IL_00be: ldloc.3
IL_00bf: ldloc.s V_4
IL_00c1: ldlen
IL_00c2: conv.i4
IL_00c3: blt.s IL_00b0
IL_00c5: ldarg.0
IL_00c6: call System.Void TheForestOfLove.ItemGetNotification::StartNotification()
IL_00cb: ret
