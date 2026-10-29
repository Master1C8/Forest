TYPE TheForestOfLove.BugReportMenu
METHOD System.Void TheForestOfLove.BugReportMenu::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.UIPanelMenu::Start()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.BugReportMenu::InitBugReportForm()
IL_000c: ldarg.0
IL_000d: call System.Void TheForestOfLove.BugReportMenu::ConfigureForEverythingElse()
IL_0012: ret
METHOD System.Void TheForestOfLove.BugReportMenu::OnEnable() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.SneakyInputFieldOSKTranslator TheForestOfLove.BugReportMenu::bugReportHelper
IL_0006: callvirt UnityEngine.Events.UnityEvent TheForestOfLove.SneakyInputFieldOSKTranslator::get_onGlitchRascalCodeActivation()
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.BugReportMenu::OnGlitchRascalCodeActivationTyped()
IL_0012: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_001c: ldarg.0
IL_001d: ldfld TheForestOfLove.SneakyInputFieldOSKTranslator TheForestOfLove.BugReportMenu::bugReportHelper
IL_0022: ldfld TheForestOfLove.UserInput.OSKKeyboardManager TheForestOfLove.SneakyInputFieldOSKTranslator::keyboardManager
IL_0027: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.UserInput.OSKKeyboardManager::onAlphabetKeyboardPendingActive
IL_002c: ldarg.0
IL_002d: ldftn System.Void TheForestOfLove.BugReportMenu::OnAlphabetKeyboardPendingActive()
IL_0033: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0038: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_003d: ldarg.0
IL_003e: ldfld TheForestOfLove.SneakyInputFieldOSKTranslator TheForestOfLove.BugReportMenu::bugReportHelper
IL_0043: ldfld TheForestOfLove.UserInput.OSKKeyboardManager TheForestOfLove.SneakyInputFieldOSKTranslator::keyboardManager
IL_0048: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.UserInput.OSKKeyboardManager::onAlphabetKeyboardReady
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.BugReportMenu::OnAlphabetKeyboardReady()
IL_0054: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_005e: ldarg.0
IL_005f: ldfld TheForestOfLove.SneakyInputFieldOSKTranslator TheForestOfLove.BugReportMenu::bugReportHelper
IL_0064: ldfld TheForestOfLove.UserInput.OSKKeyboardManager TheForestOfLove.SneakyInputFieldOSKTranslator::keyboardManager
IL_0069: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.UserInput.OSKKeyboardManager::onSymbolKeyboardPendingActive
IL_006e: ldarg.0
IL_006f: ldftn System.Void TheForestOfLove.BugReportMenu::OnSymbolKeyboardPendingActive()
IL_0075: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_007a: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_007f: ldarg.0
IL_0080: ldfld TheForestOfLove.SneakyInputFieldOSKTranslator TheForestOfLove.BugReportMenu::bugReportHelper
IL_0085: ldfld TheForestOfLove.UserInput.OSKKeyboardManager TheForestOfLove.SneakyInputFieldOSKTranslator::keyboardManager
IL_008a: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.UserInput.OSKKeyboardManager::onSymbolKeyboardReady
IL_008f: ldarg.0
IL_0090: ldftn System.Void TheForestOfLove.BugReportMenu::OnSymbolKeyboardReady()
IL_0096: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_009b: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00a0: ldarg.0
IL_00a1: call System.Void TheForestOfLove.BugReportMenu::InitBugReportForm()
IL_00a6: ret
METHOD System.Void TheForestOfLove.BugReportMenu::InitBugReportForm() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: call System.Void TheForestOfLove.BugReportMenu::set_IsInKeyboardMode(System.Boolean)
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::landingPageInstructions
IL_000c: ldc.i4.1
IL_000d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0012: ldarg.0
IL_0013: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::inputTextParentContainer
IL_0018: ldc.i4.1
IL_0019: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_001e: ldarg.0
IL_001f: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::textAreaPlaceholder
IL_0024: ldc.i4.0
IL_0025: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_002a: ldarg.0
IL_002b: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::controlsWhenNotTyping
IL_0030: ldc.i4.1
IL_0031: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0036: ldarg.0
IL_0037: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::cancelReportConfirmationPanel
IL_003c: ldc.i4.0
IL_003d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0042: ldarg.0
IL_0043: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::submitReportConfirmationPanel
IL_0048: ldc.i4.0
IL_0049: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_004e: ldarg.0
IL_004f: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::warnSubmitEmptyReportPanel
IL_0054: ldc.i4.0
IL_0055: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_005a: ldarg.0
IL_005b: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::reportSubmittedSuccessPanel
IL_0060: ldc.i4.0
IL_0061: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0066: ldarg.0
IL_0067: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::reportSubmittedDisabledPanel
IL_006c: ldc.i4.0
IL_006d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0072: ldarg.0
IL_0073: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::systemInfoPanel
IL_0078: ldc.i4.1
IL_0079: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_007e: ldarg.0
IL_007f: ldfld UnityEngine.Animator TheForestOfLove.BugReportMenu::systemInfoPanelAnimator
IL_0084: ldc.r4 6.6666665
IL_0089: callvirt System.Void UnityEngine.Animator::set_speed(System.Single)
IL_008e: ldarg.0
IL_008f: ldfld UnityEngine.Animator TheForestOfLove.BugReportMenu::systemInfoPanelAnimator
IL_0094: ldstr "reset"
IL_0099: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_009e: ldarg.0
IL_009f: ldc.i4.0
IL_00a0: stfld System.Boolean TheForestOfLove.BugReportMenu::systemInfoPanelSelected
IL_00a5: ldarg.0
IL_00a6: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::virtualKeyboardPanel
IL_00ab: ldc.i4.0
IL_00ac: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00b1: ldarg.0
IL_00b2: ldfld TheForestOfLove.SneakyInputFieldOSKTranslator TheForestOfLove.BugReportMenu::bugReportHelper
IL_00b7: callvirt System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::ClearInputText()
IL_00bc: ldarg.0
IL_00bd: call System.Void TheForestOfLove.BugReportMenu::InitSystemInfoDetailLevelControls()
IL_00c2: ret
METHOD System.Void TheForestOfLove.BugReportMenu::InitSystemInfoDetailLevelControls() | attributes=Private, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Services.Persistence.GlobalGeneralData TheForestOfLove.Services.Persistence.DataService::GetGlobalGeneralData()
IL_0005: ldfld System.Int32 TheForestOfLove.Services.Persistence.GlobalGeneralData::bugReportToolPreferredSystemInfoDetailLevel
IL_000a: ldc.i4.0
IL_000b: bge.s IL_0022
IL_000d: ldarg.0
IL_000e: call TheForestOfLove.Services.Persistence.GlobalGeneralData TheForestOfLove.Services.Persistence.DataService::GetGlobalGeneralData()
IL_0013: ldfld System.Int32 TheForestOfLove.Services.Persistence.GlobalGeneralData::bugReportToolPreferredSystemInfoDetailLevel
IL_0018: ldc.i4.1
IL_0019: add
IL_001a: neg
IL_001b: stfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0020: br.s IL_0029
IL_0022: ldarg.0
IL_0023: ldc.i4.m1
IL_0024: stfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0029: ldc.i4.0
IL_002a: stloc.0
IL_002b: br.s IL_00a4
IL_002d: ldarg.0
IL_002e: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0033: ldc.i4.0
IL_0034: blt.s IL_0066
IL_0036: ldarg.0
IL_0037: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_003c: ldloc.0
IL_003d: bne.un.s IL_0056
IL_003f: ldarg.0
IL_0040: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_0045: ldloc.0
IL_0046: ldelem.ref
IL_0047: ldc.i4.1
IL_0048: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_004d: ldarg.0
IL_004e: ldloc.0
IL_004f: stfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0054: br.s IL_00a0
IL_0056: ldarg.0
IL_0057: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_005c: ldloc.0
IL_005d: ldelem.ref
IL_005e: ldc.i4.0
IL_005f: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0064: br.s IL_00a0
IL_0066: ldarg.0
IL_0067: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_006c: ldloc.0
IL_006d: ldelem.ref
IL_006e: ldarg.0
IL_006f: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::systemInfoDefaultDetailLevel
IL_0074: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0079: brfalse.s IL_0092
IL_007b: ldarg.0
IL_007c: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_0081: ldloc.0
IL_0082: ldelem.ref
IL_0083: ldc.i4.1
IL_0084: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0089: ldarg.0
IL_008a: ldloc.0
IL_008b: stfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0090: br.s IL_00a0
IL_0092: ldarg.0
IL_0093: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_0098: ldloc.0
IL_0099: ldelem.ref
IL_009a: ldc.i4.0
IL_009b: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00a0: ldloc.0
IL_00a1: ldc.i4.1
IL_00a2: add
IL_00a3: stloc.0
IL_00a4: ldloc.0
IL_00a5: ldarg.0
IL_00a6: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_00ab: ldlen
IL_00ac: conv.i4
IL_00ad: blt IL_002d
IL_00b2: ldarg.0
IL_00b3: ldfld UnityEngine.CanvasGroup TheForestOfLove.BugReportMenu::systemInfoControlMoreOptionsLeft
IL_00b8: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00bd: ldc.i4.1
IL_00be: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00c3: ldarg.0
IL_00c4: ldfld UnityEngine.CanvasGroup TheForestOfLove.BugReportMenu::systemInfoControlMoreOptionsRight
IL_00c9: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00ce: ldc.i4.1
IL_00cf: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00d4: ldarg.0
IL_00d5: ldfld UnityEngine.CanvasGroup TheForestOfLove.BugReportMenu::systemInfoControlMoreOptionsLeft
IL_00da: ldarg.0
IL_00db: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_00e0: ldc.i4.0
IL_00e1: bgt.s IL_00ea
IL_00e3: ldc.r4 0
IL_00e8: br.s IL_00ef
IL_00ea: ldc.r4 1
IL_00ef: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_00f4: ldarg.0
IL_00f5: ldfld UnityEngine.CanvasGroup TheForestOfLove.BugReportMenu::systemInfoControlMoreOptionsRight
IL_00fa: ldarg.0
IL_00fb: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0100: ldarg.0
IL_0101: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_0106: ldlen
IL_0107: conv.i4
IL_0108: ldc.i4.1
IL_0109: sub
IL_010a: blt.s IL_0113
IL_010c: ldc.r4 0
IL_0111: br.s IL_0118
IL_0113: ldc.r4 1
IL_0118: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_011d: ldarg.0
IL_011e: ldfld UnityEngine.CanvasGroup TheForestOfLove.BugReportMenu::systemInfoControlMoreOptionsLeft
IL_0123: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0128: ldc.i4.0
IL_0129: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_012e: ldarg.0
IL_012f: ldfld UnityEngine.CanvasGroup TheForestOfLove.BugReportMenu::systemInfoControlMoreOptionsRight
IL_0134: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0139: ldc.i4.0
IL_013a: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_013f: ret
METHOD System.Void TheForestOfLove.BugReportMenu::ConfigureForWebGL() | attributes=Private, HideBySig | impl=IL
IL_0000: ret
METHOD System.Void TheForestOfLove.BugReportMenu::ConfigureForAndroid() | attributes=Private, HideBySig | impl=IL
IL_0000: ret
METHOD System.Void TheForestOfLove.BugReportMenu::ConfigureForOSX() | attributes=Private, HideBySig | impl=IL
IL_0000: ret
METHOD System.Void TheForestOfLove.BugReportMenu::ConfigureForEverythingElse() | attributes=Private, HideBySig | impl=IL
IL_0000: ret
METHOD System.Void TheForestOfLove.BugReportMenu::OnSelectSystemInfoControl() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.BugReportMenu::systemInfoPanelSelected
IL_0006: brtrue.s IL_0059
IL_0008: ldarg.0
IL_0009: ldc.i4.1
IL_000a: stfld System.Boolean TheForestOfLove.BugReportMenu::systemInfoPanelSelected
IL_000f: ldarg.0
IL_0010: ldfld UnityEngine.Animator TheForestOfLove.BugReportMenu::systemInfoPanelAnimator
IL_0015: ldstr "show"
IL_001a: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_001f: ldarg.0
IL_0020: ldfld UnityEngine.CanvasGroup TheForestOfLove.BugReportMenu::systemInfoControlMoreOptionsLeft
IL_0025: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_002a: ldc.i4.1
IL_002b: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0030: ldarg.0
IL_0031: ldfld UnityEngine.CanvasGroup TheForestOfLove.BugReportMenu::systemInfoControlMoreOptionsRight
IL_0036: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_003b: ldc.i4.1
IL_003c: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0041: ldarg.0
IL_0042: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::landingPageInstructions
IL_0047: ldc.i4.0
IL_0048: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_004d: ldarg.0
IL_004e: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::inputTextParentContainer
IL_0053: ldc.i4.0
IL_0054: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0059: ldarg.0
IL_005a: call System.Void TheForestOfLove.BugReportMenu::UpdateSystemInfoText()
IL_005f: ret
METHOD System.Void TheForestOfLove.BugReportMenu::OnSystemInfoControlLeft() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.BugReportMenu::waitFramesToClearInput
IL_0006: ldc.i4.0
IL_0007: ble.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.2
IL_000c: stfld System.Int32 TheForestOfLove.BugReportMenu::waitFramesToClearInput
IL_0011: ldarg.0
IL_0012: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0017: ldc.i4.0
IL_0018: ble.s IL_0066
IL_001a: ldarg.0
IL_001b: ldarg.0
IL_001c: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0021: ldc.i4.1
IL_0022: sub
IL_0023: stfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0028: ldarg.0
IL_0029: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_002e: stloc.0
IL_002f: ldc.i4.0
IL_0030: stloc.1
IL_0031: br.s IL_0040
IL_0033: ldloc.0
IL_0034: ldloc.1
IL_0035: ldelem.ref
IL_0036: ldc.i4.0
IL_0037: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_003c: ldloc.1
IL_003d: ldc.i4.1
IL_003e: add
IL_003f: stloc.1
IL_0040: ldloc.1
IL_0041: ldloc.0
IL_0042: ldlen
IL_0043: conv.i4
IL_0044: blt.s IL_0033
IL_0046: ldarg.0
IL_0047: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_004c: ldarg.0
IL_004d: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0052: ldelem.ref
IL_0053: ldc.i4.1
IL_0054: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0059: ldarg.0
IL_005a: call System.Void TheForestOfLove.BugReportMenu::UpdateSystemInfoText()
IL_005f: ldc.i4.s 100
IL_0061: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0066: ldarg.0
IL_0067: ldfld UnityEngine.CanvasGroup TheForestOfLove.BugReportMenu::systemInfoControlMoreOptionsLeft
IL_006c: ldarg.0
IL_006d: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0072: ldc.i4.0
IL_0073: bgt.s IL_007c
IL_0075: ldc.r4 0
IL_007a: br.s IL_0081
IL_007c: ldc.r4 1
IL_0081: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0086: ldarg.0
IL_0087: ldfld UnityEngine.CanvasGroup TheForestOfLove.BugReportMenu::systemInfoControlMoreOptionsRight
IL_008c: ldarg.0
IL_008d: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0092: ldarg.0
IL_0093: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_0098: ldlen
IL_0099: conv.i4
IL_009a: ldc.i4.1
IL_009b: sub
IL_009c: blt.s IL_00a5
IL_009e: ldc.r4 0
IL_00a3: br.s IL_00aa
IL_00a5: ldc.r4 1
IL_00aa: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_00af: ldarg.0
IL_00b0: ldc.i4.1
IL_00b1: stfld System.Boolean TheForestOfLove.BugReportMenu::needToReselectSystemInfoBaseControl
IL_00b6: ret
METHOD System.Void TheForestOfLove.BugReportMenu::OnSystemInfoControlRight() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.BugReportMenu::waitFramesToClearInput
IL_0006: ldc.i4.0
IL_0007: ble.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.2
IL_000c: stfld System.Int32 TheForestOfLove.BugReportMenu::waitFramesToClearInput
IL_0011: ldarg.0
IL_0012: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0017: ldarg.0
IL_0018: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_001d: ldlen
IL_001e: conv.i4
IL_001f: ldc.i4.1
IL_0020: sub
IL_0021: bge.s IL_006f
IL_0023: ldarg.0
IL_0024: ldarg.0
IL_0025: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_002a: ldc.i4.1
IL_002b: add
IL_002c: stfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0031: ldarg.0
IL_0032: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_0037: stloc.0
IL_0038: ldc.i4.0
IL_0039: stloc.1
IL_003a: br.s IL_0049
IL_003c: ldloc.0
IL_003d: ldloc.1
IL_003e: ldelem.ref
IL_003f: ldc.i4.0
IL_0040: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0045: ldloc.1
IL_0046: ldc.i4.1
IL_0047: add
IL_0048: stloc.1
IL_0049: ldloc.1
IL_004a: ldloc.0
IL_004b: ldlen
IL_004c: conv.i4
IL_004d: blt.s IL_003c
IL_004f: ldarg.0
IL_0050: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_0055: ldarg.0
IL_0056: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_005b: ldelem.ref
IL_005c: ldc.i4.1
IL_005d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0062: ldarg.0
IL_0063: call System.Void TheForestOfLove.BugReportMenu::UpdateSystemInfoText()
IL_0068: ldc.i4.s 100
IL_006a: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_006f: ldarg.0
IL_0070: ldfld UnityEngine.CanvasGroup TheForestOfLove.BugReportMenu::systemInfoControlMoreOptionsLeft
IL_0075: ldarg.0
IL_0076: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_007b: ldc.i4.0
IL_007c: bgt.s IL_0085
IL_007e: ldc.r4 0
IL_0083: br.s IL_008a
IL_0085: ldc.r4 1
IL_008a: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_008f: ldarg.0
IL_0090: ldfld UnityEngine.CanvasGroup TheForestOfLove.BugReportMenu::systemInfoControlMoreOptionsRight
IL_0095: ldarg.0
IL_0096: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_009b: ldarg.0
IL_009c: ldfld UnityEngine.GameObject[] TheForestOfLove.BugReportMenu::systemInfoDetailLevels
IL_00a1: ldlen
IL_00a2: conv.i4
IL_00a3: ldc.i4.1
IL_00a4: sub
IL_00a5: blt.s IL_00ae
IL_00a7: ldc.r4 0
IL_00ac: br.s IL_00b3
IL_00ae: ldc.r4 1
IL_00b3: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_00b8: ldarg.0
IL_00b9: ldc.i4.1
IL_00ba: stfld System.Boolean TheForestOfLove.BugReportMenu::needToReselectSystemInfoBaseControl
IL_00bf: ret
METHOD System.Void TheForestOfLove.BugReportMenu::UpdateSystemInfoText() | attributes=Private, HideBySig | impl=IL
IL_0000: ldnull
IL_0001: stloc.0
IL_0002: ldnull
IL_0003: stloc.1
IL_0004: ldarg.0
IL_0005: ldfld TheForestOfLove.SneakyInputFieldOSKTranslator TheForestOfLove.BugReportMenu::bugReportHelper
IL_000a: ldloca.s V_0
IL_000c: ldloca.s V_1
IL_000e: ldarg.0
IL_000f: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0014: callvirt System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::UpdateSystemInfo(System.String&,System.String&,System.Int32)
IL_0019: ldarg.0
IL_001a: ldfld TMPro.TMP_Text TheForestOfLove.BugReportMenu::systemInfoPanelColumnLeft
IL_001f: ldloc.0
IL_0020: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0025: ldarg.0
IL_0026: ldfld TMPro.TMP_Text TheForestOfLove.BugReportMenu::systemInfoPanelColumnRight
IL_002b: ldloc.1
IL_002c: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0031: ret
METHOD System.Void TheForestOfLove.BugReportMenu::OnClickEditText() | attributes=Public, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: call System.Void TheForestOfLove.BugReportMenu::set_IsInKeyboardMode(System.Boolean)
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::textAreaPlaceholder
IL_000c: ldc.i4.1
IL_000d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0012: call System.Void TheForestOfLove.TouchInputHelper::ForceHideUi()
IL_0017: ldc.i4.1
IL_0018: call System.Void Itelisoft.KOF.TheKingOfJoysticks::set_DisableJoystickInput(System.Boolean)
IL_001d: ldc.i4.1
IL_001e: call System.Void UnityEngine.Cursor::set_visible(System.Boolean)
IL_0023: ldc.i4 200
IL_0028: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_002d: ldarg.0
IL_002e: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::controlsWhenNotTyping
IL_0033: ldc.i4.0
IL_0034: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0039: ldarg.0
IL_003a: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::virtualKeyboardPanel
IL_003f: ldc.i4.1
IL_0040: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0045: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_004a: ldnull
IL_004b: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0050: ret
METHOD System.Void TheForestOfLove.BugReportMenu::OnFinishedAnyKeyboardDataEntry() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: call System.Void TheForestOfLove.BugReportMenu::set_IsInKeyboardMode(System.Boolean)
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::textAreaPlaceholder
IL_000c: ldc.i4.0
IL_000d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0012: ldc.i4.0
IL_0013: call System.Void Itelisoft.KOF.TheKingOfJoysticks::set_DisableJoystickInput(System.Boolean)
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::controlsWhenNotTyping
IL_001e: ldc.i4.1
IL_001f: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0024: call System.Boolean TheForestOfLove.UI.WindowController::get_IsFullscreen()
IL_0029: ldc.i4.0
IL_002a: ceq
IL_002c: call System.Void UnityEngine.Cursor::set_visible(System.Boolean)
IL_0031: ldc.i4 300
IL_0036: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_003b: ldarg.0
IL_003c: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::editTextButton
IL_0041: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.UI.Button>()
IL_0046: callvirt System.Void UnityEngine.UI.Selectable::Select()
IL_004b: ldarg.0
IL_004c: ldftn System.Void TheForestOfLove.BugReportMenu::<OnFinishedAnyKeyboardDataEntry>b__91_0()
IL_0052: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0057: call System.Void TheForestOfLove.Core.Timing.TimerHelper::NextUpdate(System.Action)
IL_005c: ret
METHOD System.Void TheForestOfLove.BugReportMenu::OnClickSubmitReport() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::controlsWhenNotTyping
IL_0006: ldc.i4.0
IL_0007: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld TMPro.TMP_InputField TheForestOfLove.BugReportMenu::bugReportText
IL_0012: callvirt System.String TMPro.TMP_InputField::get_text()
IL_0017: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_001c: brfalse.s IL_0056
IL_001e: ldarg.0
IL_001f: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::warnSubmitEmptyReportPanel
IL_0024: ldc.i4.1
IL_0025: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_002a: ldarg.0
IL_002b: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::warnSubmitEmptyReportOkButton
IL_0030: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.UI.Button>()
IL_0035: callvirt System.Void UnityEngine.UI.Selectable::Select()
IL_003a: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_003f: ldnull
IL_0040: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0045: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_004a: ldarg.0
IL_004b: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::warnSubmitEmptyReportOkButton
IL_0050: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0055: ret
IL_0056: ldarg.0
IL_0057: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::submitReportConfirmationPanel
IL_005c: ldc.i4.1
IL_005d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0062: ldarg.0
IL_0063: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::submitReportConfirmationNo
IL_0068: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.UI.Button>()
IL_006d: callvirt System.Void UnityEngine.UI.Selectable::Select()
IL_0072: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0077: ldnull
IL_0078: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_007d: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0082: ldarg.0
IL_0083: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::submitReportConfirmationNo
IL_0088: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_008d: ret
METHOD System.Void TheForestOfLove.BugReportMenu::OnClickSubmitReportConfirmationYes() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::submitReportConfirmationPanel
IL_0006: ldc.i4.0
IL_0007: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::reportSubmittedSuccessPanel
IL_0012: ldc.i4.1
IL_0013: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::inputTextParentContainer
IL_001e: ldc.i4.0
IL_001f: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0024: ldc.i4 200
IL_0029: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_002e: ldarg.0
IL_002f: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::reportSubmittedSuccessOkButton
IL_0034: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.SelectableUiControl>()
IL_0039: callvirt System.Void TheForestOfLove.SelectableUiControl::SuppressSoundsUntilNextUpdate()
IL_003e: ldarg.0
IL_003f: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::reportSubmittedSuccessOkButton
IL_0044: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.UI.Button>()
IL_0049: callvirt System.Void UnityEngine.UI.Selectable::Select()
IL_004e: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0053: ldnull
IL_0054: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0059: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_005e: ldarg.0
IL_005f: ldfld UnityEngine.GameObject TheForestOfLove.BugReportMenu::reportSubmittedSuccessOkButton
IL_0064: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0069: ldarg.0
IL_006a: ldfld TheForestOfLove.SneakyInputFieldOSKTranslator TheForestOfLove.BugReportMenu::bugReportHelper
IL_006f: ldarg.0
IL_0070: ldfld System.Int32 TheForestOfLove.BugReportMenu::currentSystemInfoDetailLevel
IL_0075: callvirt System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::SubmitBugReport(System.Int32)
IL_007a: ret
