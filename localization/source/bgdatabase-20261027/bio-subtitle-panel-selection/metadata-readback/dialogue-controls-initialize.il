TYPE PixelCrushers.DialogueSystem.StandardUIDialogueControls
METHOD System.Void PixelCrushers.DialogueSystem.StandardUIDialogueControls::Initialize() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.StandardUISubtitleControls PixelCrushers.DialogueSystem.StandardUIDialogueControls::m_standardSubtitleControls
IL_0006: ldarg.0
IL_0007: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel[] PixelCrushers.DialogueSystem.StandardUIDialogueControls::subtitlePanels
IL_000c: ldarg.0
IL_000d: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUIDialogueControls::defaultNPCSubtitlePanel
IL_0012: ldarg.0
IL_0013: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUIDialogueControls::defaultPCSubtitlePanel
IL_0018: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitleControls::Initialize(PixelCrushers.DialogueSystem.StandardUISubtitlePanel[],PixelCrushers.DialogueSystem.StandardUISubtitlePanel,PixelCrushers.DialogueSystem.StandardUISubtitlePanel)
IL_001d: ldarg.0
IL_001e: ldfld PixelCrushers.DialogueSystem.StandardUIResponseMenuControls PixelCrushers.DialogueSystem.StandardUIDialogueControls::m_standardMenuControls
IL_0023: ldarg.0
IL_0024: ldfld PixelCrushers.DialogueSystem.StandardUIMenuPanel[] PixelCrushers.DialogueSystem.StandardUIDialogueControls::menuPanels
IL_0029: ldarg.0
IL_002a: ldfld PixelCrushers.DialogueSystem.StandardUIMenuPanel PixelCrushers.DialogueSystem.StandardUIDialogueControls::defaultMenuPanel
IL_002f: ldarg.0
IL_0030: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIDialogueControls::useFirstResponseForMenuPortrait
IL_0035: callvirt System.Void PixelCrushers.DialogueSystem.StandardUIResponseMenuControls::Initialize(PixelCrushers.DialogueSystem.StandardUIMenuPanel[],PixelCrushers.DialogueSystem.StandardUIMenuPanel,System.Boolean)
IL_003a: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardUIDialogueControls::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean PixelCrushers.DialogueSystem.StandardUIDialogueControls::allowOpenSubtitlePanelsOnStartConversation
IL_0007: ldarg.0
IL_0008: ldc.i4.1
IL_0009: stfld System.Boolean PixelCrushers.DialogueSystem.StandardUIDialogueControls::waitForClose
IL_000e: ldarg.0
IL_000f: newobj System.Void PixelCrushers.DialogueSystem.StandardUISubtitleControls::.ctor()
IL_0014: stfld PixelCrushers.DialogueSystem.StandardUISubtitleControls PixelCrushers.DialogueSystem.StandardUIDialogueControls::m_standardSubtitleControls
IL_0019: ldarg.0
IL_001a: newobj System.Void PixelCrushers.DialogueSystem.StandardUIResponseMenuControls::.ctor()
IL_001f: stfld PixelCrushers.DialogueSystem.StandardUIResponseMenuControls PixelCrushers.DialogueSystem.StandardUIDialogueControls::m_standardMenuControls
IL_0024: ldarg.0
IL_0025: call System.Void PixelCrushers.DialogueSystem.AbstractDialogueUIControls::.ctor()
IL_002a: ret
