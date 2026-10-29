TYPE TheForestOfLove.UIPanelController
METHOD System.Boolean TheForestOfLove.UIPanelController::get_isOpen() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.UIPanel TheForestOfLove.UIPanelController::uiPanel
IL_0006: callvirt System.Boolean PixelCrushers.UIPanel::get_isOpen()
IL_000b: ret
METHOD System.Void TheForestOfLove.UIPanelController::Open() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.UIPanel TheForestOfLove.UIPanelController::uiPanel
IL_0006: callvirt System.Void PixelCrushers.UIPanel::Open()
IL_000b: ret
METHOD System.Void TheForestOfLove.UIPanelController::OnOpen() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ret
