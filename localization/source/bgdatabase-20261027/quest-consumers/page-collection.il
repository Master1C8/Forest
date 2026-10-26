TYPE TheForestOfLove.StormQuestPageCollectionUIController
METHOD System.Void TheForestOfLove.StormQuestPageCollectionUIController::OnCollectedPage() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4 420
IL_0006: call TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Services.Persistence.DataService::GetInventoryItemByItemType(TheForestOfLove.Inventory.InventoryItemType)
IL_000b: ldfld System.Int32 TheForestOfLove.Inventory.InventoryItem::quantity
IL_0010: stfld System.Int32 TheForestOfLove.StormQuestPageCollectionUIController::currentPageCount
IL_0015: ldarg.0
IL_0016: ldarg.0
IL_0017: ldfld System.Int32 TheForestOfLove.StormQuestPageCollectionUIController::currentPageCount
IL_001c: ldc.i4.0
IL_001d: cgt
IL_001f: stfld System.Boolean TheForestOfLove.StormQuestPageCollectionUIController::collectedAnyPages
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldfld System.Int32 TheForestOfLove.StormQuestPageCollectionUIController::currentPageCount
IL_002b: ldc.i4.7
IL_002c: clt
IL_002e: ldc.i4.0
IL_002f: ceq
IL_0031: stfld System.Boolean TheForestOfLove.StormQuestPageCollectionUIController::collectedEnoughPages
IL_0036: ldarg.0
IL_0037: ldfld System.Boolean TheForestOfLove.StormQuestPageCollectionUIController::collectedEnoughPages
IL_003c: brfalse.s IL_004f
IL_003e: ldstr "act3_thestorm_collected_enough_pages"
IL_0043: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0048: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnCollectedAllTheFlyingPages_StormQuest()
IL_004d: br.s IL_005d
IL_004f: ldarg.0
IL_0050: ldfld System.Int32 TheForestOfLove.StormQuestPageCollectionUIController::currentPageCount
IL_0055: ldc.i4.1
IL_0056: bne.un.s IL_005d
IL_0058: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnCollectedFirstPage_StormQuest()
IL_005d: ldarg.0
IL_005e: ldfld UnityEngine.Transform TheForestOfLove.StormQuestPageCollectionUIController::labelsContainer
IL_0063: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0068: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_006d: stloc.0
IL_006e: ldc.i4.0
IL_006f: stloc.1
IL_0070: br.s IL_009c
IL_0072: ldloc.0
IL_0073: ldloc.1
IL_0074: ldelem.ref
IL_0075: ldarg.0
IL_0076: ldflda System.Int32 TheForestOfLove.StormQuestPageCollectionUIController::currentPageCount
IL_007b: call System.String System.Int32::ToString()
IL_0080: ldstr "/"
IL_0085: ldc.i4.7
IL_0086: stloc.2
IL_0087: ldloca.s V_2
IL_0089: call System.String System.Int32::ToString()
IL_008e: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0093: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0098: ldloc.1
IL_0099: ldc.i4.1
IL_009a: add
IL_009b: stloc.1
IL_009c: ldloc.1
IL_009d: ldloc.0
IL_009e: ldlen
IL_009f: conv.i4
IL_00a0: blt.s IL_0072
IL_00a2: ret
