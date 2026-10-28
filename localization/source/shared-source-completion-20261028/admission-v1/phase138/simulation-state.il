TYPE TheForestOfLove.DevTools.SimulateGameplayVariables
METHOD System.Void TheForestOfLove.DevTools.SimulateGameplayVariables::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: stsfld TheForestOfLove.DevTools.SimulateGameplayVariables TheForestOfLove.DevTools.SimulateGameplayVariables::instance
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.UI.Text TheForestOfLove.DevTools.SimulateGameplayVariables::currentSceneLabel
IL_000c: ldsfld System.String TheForestOfLove.DevTools.SimulateGameplayVariables::currentSimScene
IL_0011: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0016: ret
METHOD System.Void TheForestOfLove.DevTools.SimulateGameplayVariables::ChangeSimulatedScene(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld System.String TheForestOfLove.DevTools.SimulateGameplayVariables::currentSimScene
IL_0005: stsfld System.String TheForestOfLove.DevTools.SimulateGameplayVariables::lastSimScene
IL_000a: ldarg.0
IL_000b: stsfld System.String TheForestOfLove.DevTools.SimulateGameplayVariables::currentSimScene
IL_0010: ldsfld TheForestOfLove.DevTools.SimulateGameplayVariables TheForestOfLove.DevTools.SimulateGameplayVariables::instance
IL_0015: ldfld UnityEngine.UI.Text TheForestOfLove.DevTools.SimulateGameplayVariables::currentSceneLabel
IL_001a: ldsfld System.String TheForestOfLove.DevTools.SimulateGameplayVariables::currentSimScene
IL_001f: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0024: ret
