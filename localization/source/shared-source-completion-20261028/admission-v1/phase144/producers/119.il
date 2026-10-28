TYPE TheForestOfLove.Narrative.InstancedStoryController
METHOD System.Void TheForestOfLove.Narrative.InstancedStoryController::Shared_Setup(System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.StoryManager>()
IL_0005: stloc.0
IL_0006: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.InstancedStoryController::TAGS_ALL_ADVENTURES
IL_000b: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_0010: stloc.1
IL_0011: br.s IL_0029
IL_0013: ldloca.s V_1
IL_0015: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_001a: stloc.2
IL_001b: ldloc.0
IL_001c: ldloc.2
IL_001d: callvirt System.Void TheForestOfLove.Narrative.StoryManager::ResetConversationsWithTag(System.String)
IL_0022: ldloc.0
IL_0023: ldloc.2
IL_0024: callvirt System.Void TheForestOfLove.Narrative.StoryManager::ResetQuestsWithTag(System.String)
IL_0029: ldloca.s V_1
IL_002b: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_0030: brtrue.s IL_0013
IL_0032: leave.s IL_0042
IL_0034: ldloca.s V_1
IL_0036: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_003c: callvirt System.Void System.IDisposable::Dispose()
IL_0041: endfinally
IL_0042: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0047: dup
IL_0048: ldstr "Instanced Event"
IL_004d: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0052: dup
IL_0053: ldarg.0
IL_0054: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0059: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.InstancedStoryController::TAGS_ALL_ADVENTURES
IL_005e: call System.Void TheForestOfLove.Narrative.NarrativeActions::UpdateTags(System.Collections.Generic.List`1<System.String>,System.Collections.Generic.List`1<System.String>)
IL_0063: ret
METHOD System.Void TheForestOfLove.Narrative.InstancedStoryController::BotbStart() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass34_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.Adventure::adventuresByStoryType
IL_000c: ldc.i4.s 100
IL_000e: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::get_Item(!0)
IL_0013: stfld TheForestOfLove.Narrative.Adventure TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass34_0::story
IL_0018: ldstr "Instanced Event Blessing of the Bells"
IL_001d: call System.Void TheForestOfLove.Narrative.InstancedStoryController::Shared_Setup(System.String)
IL_0022: ldnull
IL_0023: ldftn System.Void TheForestOfLove.Narrative.InstancedStoryController::BotbStart_PostLoad()
IL_0029: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_002e: stsfld System.Action TheForestOfLove.Narrative.InstancedStoryController::onNextSceneLoaded
IL_0033: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0038: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_003d: ldc.r4 1.5
IL_0042: ldloc.0
IL_0043: ldftn System.Void TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass34_0::<BotbStart>b__0()
IL_0049: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_004e: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0053: ret
METHOD System.Void TheForestOfLove.Narrative.InstancedStoryController::BootyLineupMalesStart() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass41_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.Adventure::adventuresByStoryType
IL_000c: ldc.i4 200
IL_0011: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::get_Item(!0)
IL_0016: stfld TheForestOfLove.Narrative.Adventure TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass41_0::story
IL_001b: ldstr "Instanced Event Booty Lineup Males"
IL_0020: call System.Void TheForestOfLove.Narrative.InstancedStoryController::Shared_Setup(System.String)
IL_0025: ldnull
IL_0026: ldftn System.Void TheForestOfLove.Narrative.InstancedStoryController::BootyLineupMalesStart_PostLoad()
IL_002c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0031: stsfld System.Action TheForestOfLove.Narrative.InstancedStoryController::onNextSceneLoaded
IL_0036: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_003b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0040: ldc.r4 1.5
IL_0045: ldloc.0
IL_0046: ldftn System.Void TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass41_0::<BootyLineupMalesStart>b__0()
IL_004c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0051: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0056: ret
METHOD System.Void TheForestOfLove.Narrative.InstancedStoryController::BootyLineupFemalesStart() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass47_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.Adventure::adventuresByStoryType
IL_000c: ldc.i4 300
IL_0011: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::get_Item(!0)
IL_0016: stfld TheForestOfLove.Narrative.Adventure TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass47_0::story
IL_001b: ldstr "Instanced Event Booty Lineup Females"
IL_0020: call System.Void TheForestOfLove.Narrative.InstancedStoryController::Shared_Setup(System.String)
IL_0025: ldnull
IL_0026: ldftn System.Void TheForestOfLove.Narrative.InstancedStoryController::BootyLineupFemalesStart_PostLoad()
IL_002c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0031: stsfld System.Action TheForestOfLove.Narrative.InstancedStoryController::onNextSceneLoaded
IL_0036: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_003b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0040: ldc.r4 1.5
IL_0045: ldloc.0
IL_0046: ldftn System.Void TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass47_0::<BootyLineupFemalesStart>b__0()
IL_004c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0051: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0056: ret
METHOD System.Void TheForestOfLove.Narrative.InstancedStoryController::MaverickSideHustleStart() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass53_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.Adventure::adventuresByStoryType
IL_000c: ldc.i4 400
IL_0011: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::get_Item(!0)
IL_0016: stfld TheForestOfLove.Narrative.Adventure TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass53_0::story
IL_001b: ldstr "Instanced Event Maverick Side Hustle"
IL_0020: call System.Void TheForestOfLove.Narrative.InstancedStoryController::Shared_Setup(System.String)
IL_0025: ldnull
IL_0026: ldftn System.Void TheForestOfLove.Narrative.InstancedStoryController::MaverickSideHustleStart_PostLoad()
IL_002c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0031: stsfld System.Action TheForestOfLove.Narrative.InstancedStoryController::onNextSceneLoaded
IL_0036: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_003b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0040: ldc.r4 1.5
IL_0045: ldloc.0
IL_0046: ldftn System.Void TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass53_0::<MaverickSideHustleStart>b__0()
IL_004c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0051: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0056: ret
METHOD System.Void TheForestOfLove.Narrative.InstancedStoryController::SeasonsGreetingsStart() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass61_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.Adventure::adventuresByStoryType
IL_000c: ldc.i4 500
IL_0011: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::get_Item(!0)
IL_0016: stfld TheForestOfLove.Narrative.Adventure TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass61_0::story
IL_001b: ldstr "Instanced Event Seasons Greetings"
IL_0020: call System.Void TheForestOfLove.Narrative.InstancedStoryController::Shared_Setup(System.String)
IL_0025: ldnull
IL_0026: ldftn System.Void TheForestOfLove.Narrative.InstancedStoryController::SeasonsGreetingsStart_PostLoad()
IL_002c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0031: stsfld System.Action TheForestOfLove.Narrative.InstancedStoryController::onNextSceneLoaded
IL_0036: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_003b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0040: ldc.r4 1.5
IL_0045: ldloc.0
IL_0046: ldftn System.Void TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass61_0::<SeasonsGreetingsStart>b__0()
IL_004c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0051: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0056: ret
METHOD System.Void TheForestOfLove.Narrative.InstancedStoryController::VsliceStart() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass69_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.Adventure::adventuresByStoryType
IL_000c: ldc.i4 600
IL_0011: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::get_Item(!0)
IL_0016: stfld TheForestOfLove.Narrative.Adventure TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass69_0::story
IL_001b: ldstr "Instanced Event Vslice"
IL_0020: call System.Void TheForestOfLove.Narrative.InstancedStoryController::Shared_Setup(System.String)
IL_0025: ldnull
IL_0026: ldftn System.Void TheForestOfLove.Narrative.InstancedStoryController::VsliceStart_PostLoad()
IL_002c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0031: stsfld System.Action TheForestOfLove.Narrative.InstancedStoryController::onNextSceneLoaded
IL_0036: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_003b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0040: ldc.r4 1.5
IL_0045: ldloc.0
IL_0046: ldftn System.Void TheForestOfLove.Narrative.InstancedStoryController/<>c__DisplayClass69_0::<VsliceStart>b__0()
IL_004c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0051: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0056: ret
METHOD System.Void TheForestOfLove.Narrative.InstancedStoryController::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "Instanced Event"
IL_000b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0010: dup
IL_0011: ldstr "Instanced Event Blessing of the Bells"
IL_0016: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_001b: dup
IL_001c: ldstr "Instanced Event Booty Lineup Males"
IL_0021: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0026: dup
IL_0027: ldstr "Instanced Event Booty Lineup Females"
IL_002c: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0031: dup
IL_0032: ldstr "Instanced Event Seasons Greetings"
IL_0037: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_003c: dup
IL_003d: ldstr "Instanced Event Maverick Side Hustle"
IL_0042: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0047: dup
IL_0048: ldstr "Instanced Event Vslice"
IL_004d: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0052: stsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.InstancedStoryController::TAGS_ALL_ADVENTURES
IL_0057: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_005c: dup
IL_005d: ldstr "BlessingOfTheBells_History"
IL_0062: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0067: dup
IL_0068: ldstr "BlessingOfTheBells_Mabel"
IL_006d: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0072: stsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.InstancedStoryController::BotbAllowedQuestDbNames
IL_0077: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_007c: dup
IL_007d: ldstr "BootyLineUpQuest"
IL_0082: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0087: stsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.InstancedStoryController::BootyLineupMalesAllowedQuestDbNames
IL_008c: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0091: dup
IL_0092: ldstr "BootyLineUpFemalesQuest"
IL_0097: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_009c: stsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.InstancedStoryController::BootyLineupFemalesAllowedQuestDbNames
IL_00a1: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00a6: dup
IL_00a7: ldstr "MaverickSideHustleQuest"
IL_00ac: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00b1: stsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.InstancedStoryController::MaverickSideHustleAllowedQuestDbNames
IL_00b6: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00bb: dup
IL_00bc: ldstr "SeasonsGreetingsQuest"
IL_00c1: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00c6: stsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.InstancedStoryController::SeasonsGreetingsAllowedQuestDbNames
IL_00cb: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00d0: dup
IL_00d1: ldstr "Vslice_BunnyQuest"
IL_00d6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00db: dup
IL_00dc: ldstr "Vslice_BearQuest"
IL_00e1: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00e6: dup
IL_00e7: ldstr "Vslice_BeaverQuest"
IL_00ec: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00f1: dup
IL_00f2: ldstr "Vslice_MouseQuest"
IL_00f7: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00fc: dup
IL_00fd: ldstr "Vslice_OtterQuest"
IL_0102: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0107: stsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.InstancedStoryController::VsliceAllowedQuestDbNames
IL_010c: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::.ctor()
IL_0111: dup
IL_0112: ldc.i4 270
IL_0117: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_011c: dup
IL_011d: ldc.i4 280
IL_0122: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_0127: dup
IL_0128: ldc.i4 290
IL_012d: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_0132: dup
IL_0133: ldc.i4 300
IL_0138: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_013d: dup
IL_013e: ldc.i4 310
IL_0143: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_0148: dup
IL_0149: ldc.i4 320
IL_014e: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_0153: dup
IL_0154: ldc.i4 330
IL_0159: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_015e: stsfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.InstancedStoryController::VsliceItems
IL_0163: ret
