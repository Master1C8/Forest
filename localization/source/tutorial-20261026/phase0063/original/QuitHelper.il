TYPE TheForestOfLove.QuitHelper
METHOD System.Void TheForestOfLove.QuitHelper::Quit() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.DeploymentHelper::get_IsUnityEditor()
IL_0005: brtrue.s IL_0020
IL_0007: call System.Boolean TheForestOfLove.DeploymentHelper::get_IsUnityStandalone()
IL_000c: brfalse.s IL_0014
IL_000e: call System.Void UnityEngine.Application::Quit()
IL_0013: ret
IL_0014: call System.Boolean TheForestOfLove.DeploymentHelper::get_IsUnityAndroid()
IL_0019: brfalse.s IL_0020
IL_001b: call System.Void UnityEngine.Application::Quit()
IL_0020: ret
