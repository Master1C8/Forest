TYPE TheForestOfLove.PennyScarlettCloacaFistingStory
TYPE TheForestOfLove.PennyScarlettCloacaFistingStory
METHOD System.Void TheForestOfLove.PennyScarlettCloacaFistingStory::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MovieDialogueManager>()
IL_0006: stfld TheForestOfLove.MovieDialogueManager TheForestOfLove.PennyScarlettCloacaFistingStory::movieDialogueManager
IL_000b: ldarg.0
IL_000c: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.PennyScarlettCloacaFistingStory::movieDialogueManager
IL_0011: callvirt System.Void TheForestOfLove.MovieDialogueManager::ResetAll()
IL_0016: ldarg.0
IL_0017: ldarg.0
IL_0018: call !!0 UnityEngine.Component::GetComponentInParent<TheForestOfLove.MovieWrapper>()
IL_001d: stfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_0028: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.MovieWrapper::onSceneStarted
IL_002d: ldarg.0
IL_002e: ldftn System.Void TheForestOfLove.PennyScarlettCloacaFistingStory::OnSceneStarted()
IL_0034: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0039: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_003e: ldarg.0
IL_003f: ldarg.0
IL_0040: call !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_0045: stfld UnityEngine.Animator TheForestOfLove.PennyScarlettCloacaFistingStory::movieAnimator
IL_004a: ldarg.0
IL_004b: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_0050: ldarg.0
IL_0051: ldfld System.Single TheForestOfLove.PennyScarlettCloacaFistingStory::fadeInSeconds
IL_0056: callvirt System.Void TheForestOfLove.MovieWrapper::set_fadeSeconds(System.Single)
IL_005b: ldarg.0
IL_005c: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_0061: callvirt System.Void TheForestOfLove.MovieWrapper::MovieCanStart()
IL_0066: ldarg.0
IL_0067: ldc.i4.1
IL_0068: stfld System.Boolean TheForestOfLove.PennyScarlettCloacaFistingStory::awakened
IL_006d: ret
METHOD System.Void TheForestOfLove.PennyScarlettCloacaFistingStory::OnSceneStarted() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0005: brfalse.s IL_0015
IL_0007: ldsfld System.Boolean Globals::allowDialogueInStartMenu
IL_000c: brtrue.s IL_0015
IL_000e: ldarg.0
IL_000f: call System.Void TheForestOfLove.PennyScarlettCloacaFistingStory::OnDialogueFinished()
IL_0014: ret
IL_0015: ldc.r4 1
IL_001a: ldarg.0
IL_001b: ldftn System.Void TheForestOfLove.PennyScarlettCloacaFistingStory::<OnSceneStarted>b__11_0()
IL_0021: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0026: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_002b: ret
METHOD System.Void TheForestOfLove.PennyScarlettCloacaFistingStory::OnDialogueFinished() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.PennyScarlettCloacaFistingStory::movieDialogueManager
IL_0006: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.MovieDialogueManager::onDialogueFinished
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.PennyScarlettCloacaFistingStory::OnDialogueFinished()
IL_0012: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_001c: ldarg.0
IL_001d: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.PennyScarlettCloacaFistingStory::movieDialogueManager
IL_0022: callvirt System.Void TheForestOfLove.MovieDialogueManager::ResetAll()
IL_0027: ldarg.0
IL_0028: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_002d: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_0032: ldarg.0
IL_0033: ldc.i4.1
IL_0034: stfld System.Boolean TheForestOfLove.PennyScarlettCloacaFistingStory::showTheSceneByItselfBeforeOutro
IL_0039: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_003e: brfalse.s IL_004e
IL_0040: ldsfld System.Boolean Globals::allowDialogueInStartMenu
IL_0045: brtrue.s IL_004e
IL_0047: ldarg.0
IL_0048: ldc.i4.0
IL_0049: stfld System.Boolean TheForestOfLove.PennyScarlettCloacaFistingStory::showTheSceneByItselfBeforeOutro
IL_004e: ldsfld System.Boolean Globals::isDialogueSkip
IL_0053: brfalse.s IL_007c
IL_0055: ldarg.0
IL_0056: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_005b: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_0060: ldarg.0
IL_0061: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_0066: callvirt System.Void TheForestOfLove.MovieWrapper::PlayOutro()
IL_006b: ldarg.0
IL_006c: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_0071: ldarg.0
IL_0072: ldfld System.Single TheForestOfLove.PennyScarlettCloacaFistingStory::fadeOutSeconds
IL_0077: callvirt System.Void TheForestOfLove.MovieWrapper::set_fadeSeconds(System.Single)
IL_007c: ret
METHOD System.Void TheForestOfLove.PennyScarlettCloacaFistingStory::AdvanceMovie() | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.PennyScarlettCloacaFistingStory::movieDialogueManager
IL_0006: callvirt System.Boolean TheForestOfLove.MovieDialogueManager::get_dialogueStarted()
IL_000b: brfalse.s IL_0026
IL_000d: ldarg.0
IL_000e: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.PennyScarlettCloacaFistingStory::movieDialogueManager
IL_0013: callvirt System.Boolean TheForestOfLove.MovieDialogueManager::get_dialogueFinished()
IL_0018: brtrue.s IL_0026
IL_001a: ldarg.0
IL_001b: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_0020: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_0025: ret
IL_0026: ldarg.0
IL_0027: ldfld System.Boolean TheForestOfLove.PennyScarlettCloacaFistingStory::showTheSceneByItselfBeforeOutro
IL_002c: brfalse.s IL_0057
IL_002e: ldarg.0
IL_002f: ldc.i4.0
IL_0030: stfld System.Boolean TheForestOfLove.PennyScarlettCloacaFistingStory::showTheSceneByItselfBeforeOutro
IL_0035: ldarg.0
IL_0036: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_003b: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_0040: ldc.r4 1
IL_0045: ldarg.0
IL_0046: ldftn System.Void TheForestOfLove.PennyScarlettCloacaFistingStory::<AdvanceMovie>b__13_0()
IL_004c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0051: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0056: ret
IL_0057: ldarg.0
IL_0058: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.PennyScarlettCloacaFistingStory::movieDialogueManager
IL_005d: callvirt System.Boolean TheForestOfLove.MovieDialogueManager::get_dialoguePlaying()
IL_0062: brtrue.s IL_0098
IL_0064: ldarg.0
IL_0065: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_006a: callvirt System.Boolean TheForestOfLove.MovieWrapper::get_isNextButtonVisible()
IL_006f: brfalse.s IL_0098
IL_0071: ldarg.0
IL_0072: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_0077: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_007c: ldarg.0
IL_007d: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_0082: callvirt System.Void TheForestOfLove.MovieWrapper::PlayOutro()
IL_0087: ldarg.0
IL_0088: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_008d: ldarg.0
IL_008e: ldfld System.Single TheForestOfLove.PennyScarlettCloacaFistingStory::fadeOutSeconds
IL_0093: callvirt System.Void TheForestOfLove.MovieWrapper::set_fadeSeconds(System.Single)
IL_0098: ret
METHOD System.Void TheForestOfLove.PennyScarlettCloacaFistingStory::<OnSceneStarted>b__11_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.PennyScarlettCloacaFistingStory::movieDialogueManager
IL_0006: ldstr "Movies_PennyScarlettCloacaFistingStory_Dialogue"
IL_000b: ldstr "Penny"
IL_0010: ldnull
IL_0011: ldarg.0
IL_0012: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.PennyScarlettCloacaFistingStory::dialogueUi
IL_0017: callvirt System.Void TheForestOfLove.MovieDialogueManager::StartDialogue(System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI)
IL_001c: ldarg.0
IL_001d: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.PennyScarlettCloacaFistingStory::movieDialogueManager
IL_0022: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.MovieDialogueManager::onDialogueFinished
IL_0027: ldarg.0
IL_0028: ldftn System.Void TheForestOfLove.PennyScarlettCloacaFistingStory::OnDialogueFinished()
IL_002e: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0033: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0038: ldarg.0
IL_0039: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_003e: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_0043: ret
METHOD System.Void TheForestOfLove.PennyScarlettCloacaFistingStory::<AdvanceMovie>b__13_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.PennyScarlettCloacaFistingStory::movieWrapper
IL_0006: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_000b: ret
