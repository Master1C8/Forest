TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_0
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_0::<GenerateItems>b__0(TheForestOfLove.DB.InventoryItem) | attributes=Assembly, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: newobj System.Void TheForestOfLove.Inventory.InventoryItem::.ctor()
IL_000c: stfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0011: ldloc.0
IL_0012: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0017: ldarg.1
IL_0018: callvirt System.String TheForestOfLove.DB.InventoryItem::get_name()
IL_001d: stfld System.String TheForestOfLove.Inventory.InventoryItem::dbName
IL_0022: ldloc.0
IL_0023: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0028: ldarg.1
IL_0029: stfld TheForestOfLove.DB.InventoryItem TheForestOfLove.Inventory.InventoryItem::dbItem
IL_002e: ldloc.0
IL_002f: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0034: ldarg.1
IL_0035: callvirt System.String TheForestOfLove.DB.InventoryItem::get_savekey()
IL_003a: stfld System.String TheForestOfLove.Inventory.InventoryItem::savekey
IL_003f: ldloc.0
IL_0040: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0045: ldarg.1
IL_0046: callvirt TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.DB.InventoryItem::get_item_type()
IL_004b: stfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_0050: ldloc.0
IL_0051: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0056: ldarg.1
IL_0057: callvirt System.String TheForestOfLove.DB.InventoryItem::get_title()
IL_005c: stfld System.String TheForestOfLove.Inventory.InventoryItem::title
IL_0061: ldloc.0
IL_0062: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0067: ldarg.1
IL_0068: callvirt System.String TheForestOfLove.DB.InventoryItem::get_notification_phrase()
IL_006d: stfld System.String TheForestOfLove.Inventory.InventoryItem::notificationPhrase
IL_0072: ldloc.0
IL_0073: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0078: ldarg.1
IL_0079: callvirt System.String TheForestOfLove.DB.InventoryItem::get_description()
IL_007e: stfld System.String TheForestOfLove.Inventory.InventoryItem::description
IL_0083: ldloc.0
IL_0084: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0089: ldarg.1
IL_008a: callvirt System.Boolean TheForestOfLove.DB.InventoryItem::get_stackable()
IL_008f: stfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isStackable
IL_0094: ldloc.0
IL_0095: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_009a: ldarg.1
IL_009b: callvirt System.Boolean TheForestOfLove.DB.InventoryItem::get_inactive()
IL_00a0: stfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isInactive
IL_00a5: ldloc.0
IL_00a6: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_00ab: ldarg.1
IL_00ac: callvirt System.Boolean TheForestOfLove.DB.InventoryItem::get_achievement_item()
IL_00b1: stfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isAchievementItem
IL_00b6: ldloc.0
IL_00b7: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_00bc: ldarg.1
IL_00bd: callvirt System.Int32 TheForestOfLove.DB.InventoryItem::get_priority()
IL_00c2: stfld System.Int32 TheForestOfLove.Inventory.InventoryItem::priority
IL_00c7: ldloc.0
IL_00c8: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_00cd: ldarg.1
IL_00ce: callvirt System.Int32 TheForestOfLove.DB.InventoryItem::get_grid_location_x()
IL_00d3: conv.r4
IL_00d4: ldarg.1
IL_00d5: callvirt System.Int32 TheForestOfLove.DB.InventoryItem::get_grid_location_y()
IL_00da: conv.r4
IL_00db: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_00e0: stfld UnityEngine.Vector2 TheForestOfLove.Inventory.InventoryItem::gridLocation
IL_00e5: ldloc.0
IL_00e6: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_00eb: ldarg.1
IL_00ec: callvirt TheForestOfLove.Inventory.InventoryItemEquipLocation TheForestOfLove.DB.InventoryItem::get_equip_location()
IL_00f1: stfld TheForestOfLove.Inventory.InventoryItemEquipLocation TheForestOfLove.Inventory.InventoryItem::equipLocation
IL_00f6: ldloc.0
IL_00f7: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_00fc: ldarg.1
IL_00fd: callvirt UnityEngine.Vector2 TheForestOfLove.DB.InventoryItem::get_sprite_offset()
IL_0102: stfld UnityEngine.Vector2 TheForestOfLove.Inventory.InventoryItem::spriteOffset
IL_0107: ldloc.0
IL_0108: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_010d: ldarg.1
IL_010e: callvirt UnityEngine.Vector2 TheForestOfLove.DB.InventoryItem::get_sprite_scale()
IL_0113: stfld UnityEngine.Vector2 TheForestOfLove.Inventory.InventoryItem::spriteScale
IL_0118: ldarg.1
IL_0119: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.InventoryItem::get_enable_with_tags()
IL_011e: brfalse.s IL_0176
IL_0120: ldarg.1
IL_0121: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.InventoryItem::get_enable_with_tags()
IL_0126: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_012b: stloc.3
IL_012c: br.s IL_015d
IL_012e: ldloca.s V_3
IL_0130: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_0135: stloc.s V_4
IL_0137: ldarg.0
IL_0138: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_0::manifest
IL_013d: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_0142: ldloc.s V_4
IL_0144: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_0149: stloc.s V_5
IL_014b: ldloc.0
IL_014c: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0151: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Inventory.InventoryItem::enableWithTags
IL_0156: ldloc.s V_5
IL_0158: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_015d: ldloca.s V_3
IL_015f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_0164: brtrue.s IL_012e
IL_0166: leave.s IL_0176
IL_0168: ldloca.s V_3
IL_016a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_0170: callvirt System.Void System.IDisposable::Dispose()
IL_0175: endfinally
IL_0176: newobj System.Void TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.Sprite>::.ctor()
IL_017b: stloc.1
IL_017c: ldloc.1
IL_017d: call BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.InventoryItem::get__sprite()
IL_0182: ldarg.1
IL_0183: callvirt System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_0188: callvirt System.String BansheeGz.BGDatabase.BGFieldUnityAssetA`1<UnityEngine.Sprite>::GetAddressablesAddress(System.Int32)
IL_018d: callvirt System.Void TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.Sprite>::SetAssetKey(System.String)
IL_0192: ldloc.1
IL_0193: ldloc.0
IL_0194: ldftn System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::<GenerateItems>b__1(UnityEngine.Sprite)
IL_019a: newobj System.Void System.Action`1<UnityEngine.Sprite>::.ctor(System.Object,System.IntPtr)
IL_019f: callvirt System.Void TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.Sprite>::SetCallback(System.Action`1<T>)
IL_01a4: ldloc.0
IL_01a5: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_01aa: ldloc.1
IL_01ab: stfld TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.Sprite> TheForestOfLove.Inventory.InventoryItem::spriteAssetLoader
IL_01b0: ldarg.0
IL_01b1: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_0::manifest
IL_01b6: ldfld System.Collections.Generic.List`1<TheForestOfLove.Utility.IAddressableAssetLoader> TheForestOfLove.Narrative.DataManifest::addressableAssets
IL_01bb: ldloc.1
IL_01bc: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Utility.IAddressableAssetLoader>::Add(!0)
IL_01c1: newobj System.Void TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.RuntimeAnimatorController>::.ctor()
IL_01c6: stloc.2
IL_01c7: ldloc.2
IL_01c8: call BansheeGz.BGDatabase.BGFieldUnityObject TheForestOfLove.DB.InventoryItem::get__spriteAnimator()
IL_01cd: ldarg.1
IL_01ce: callvirt System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_01d3: callvirt System.String BansheeGz.BGDatabase.BGFieldUnityAssetA`1<UnityEngine.Object>::GetAddressablesAddress(System.Int32)
IL_01d8: callvirt System.Void TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.RuntimeAnimatorController>::SetAssetKey(System.String)
IL_01dd: ldloc.2
IL_01de: ldloc.0
IL_01df: ldftn System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::<GenerateItems>b__2(UnityEngine.RuntimeAnimatorController)
IL_01e5: newobj System.Void System.Action`1<UnityEngine.RuntimeAnimatorController>::.ctor(System.Object,System.IntPtr)
IL_01ea: callvirt System.Void TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.RuntimeAnimatorController>::SetCallback(System.Action`1<T>)
IL_01ef: ldloc.0
IL_01f0: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_01f5: ldloc.2
IL_01f6: stfld TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.RuntimeAnimatorController> TheForestOfLove.Inventory.InventoryItem::spriteAnimatorAssetLoader
IL_01fb: ldarg.0
IL_01fc: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_0::manifest
IL_0201: ldfld System.Collections.Generic.List`1<TheForestOfLove.Utility.IAddressableAssetLoader> TheForestOfLove.Narrative.DataManifest::addressableAssets
IL_0206: ldloc.2
IL_0207: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Utility.IAddressableAssetLoader>::Add(!0)
IL_020c: ldarg.0
IL_020d: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_0::manifest
IL_0212: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItems
IL_0217: ldloc.0
IL_0218: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_021d: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::Add(!0)
IL_0222: ldarg.0
IL_0223: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_0::manifest
IL_0228: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByDbName
IL_022d: ldloc.0
IL_022e: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0233: ldfld System.String TheForestOfLove.Inventory.InventoryItem::dbName
IL_0238: ldloc.0
IL_0239: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_023e: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Inventory.InventoryItem>::Add(!0,!1)
IL_0243: ldarg.0
IL_0244: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_0::manifest
IL_0249: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.InventoryItem,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByDbItem
IL_024e: ldloc.0
IL_024f: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0254: ldfld TheForestOfLove.DB.InventoryItem TheForestOfLove.Inventory.InventoryItem::dbItem
IL_0259: ldloc.0
IL_025a: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_025f: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.InventoryItem,TheForestOfLove.Inventory.InventoryItem>::Add(!0,!1)
IL_0264: ldarg.0
IL_0265: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_0::manifest
IL_026a: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsBySavekey
IL_026f: ldloc.0
IL_0270: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0275: ldfld System.String TheForestOfLove.Inventory.InventoryItem::savekey
IL_027a: ldloc.0
IL_027b: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0280: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Inventory.InventoryItem>::Add(!0,!1)
IL_0285: ldarg.0
IL_0286: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_0::manifest
IL_028b: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Inventory.InventoryItemType,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByItemType
IL_0290: ldloc.0
IL_0291: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_0296: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_029b: ldloc.0
IL_029c: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass14_1::item
IL_02a1: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Inventory.InventoryItemType,TheForestOfLove.Inventory.InventoryItem>::Add(!0,!1)
IL_02a6: ret
