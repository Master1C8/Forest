TYPE TheForestOfLove.CutsceneManager
METHOD System.Void TheForestOfLove.CutsceneManager::EndCinematicMode()
IL_0000: ldsfld TheForestOfLove.LetterboxCameraController TheForestOfLove.LetterboxCameraController::current
IL_0005: callvirt System.Void TheForestOfLove.LetterboxCameraController::EndCinematicMode()
IL_000a: ret
