TYPE TheForestOfLove.RascalSoloBearStory
METHOD System.Void TheForestOfLove.RascalSoloBearStory::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_000c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onAdvanceMoment
IL_0011: ldarg.0
IL_0012: ldftn System.Void TheForestOfLove.RascalSoloBearStory::OnAdvanceMoment()
IL_0018: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_001d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0028: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.GeneralStoryUIController::onDialogueLine
IL_002d: ldarg.0
IL_002e: ldftn System.Void TheForestOfLove.RascalSoloBearStory::OnDialogueLine(System.String)
IL_0034: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0039: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_003e: ldarg.0
IL_003f: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0044: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.GeneralStoryUIController::onDialogueEmptyWithTitledLine
IL_0049: ldarg.0
IL_004a: ldftn System.Void TheForestOfLove.RascalSoloBearStory::OnDialogueEmptyWithTitledLine(System.String)
IL_0050: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0055: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_005a: ldarg.0
IL_005b: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0060: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onInitialBlankScreenDialogueMoment
IL_0065: ldarg.0
IL_0066: ldftn System.Void TheForestOfLove.RascalSoloBearStory::OnInitialDialogueMoment()
IL_006c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0071: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0076: ret
