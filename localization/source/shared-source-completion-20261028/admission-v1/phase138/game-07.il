TYPE TheForestOfLove.DevConsoleCommands/MiscCommands
METHOD System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::RestartGame() | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: call System.Void TheForestOfLove.Services.Persistence.SaveManager::DeleteSavedPlaySession()
IL_0005: ldstr "ChapterSelect"
IL_000a: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadSoftResetScene(System.String)
IL_000f: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0014: callvirt System.Void SickDev.DevConsole.DevConsole::Close()
IL_0019: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::SaveState() | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0005: brfalse.s IL_001c
IL_0007: ldstr "quicksave blocked by menu or event, try again later"
IL_000c: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0011: ldc.i4 300
IL_0016: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_001b: ret
IL_001c: call System.Void TheForestOfLove.Services.Persistence.SaveManager::ManualSave()
IL_0021: ldstr "tfol.quicksave.savegame"
IL_0026: call System.Boolean TheForestOfLove.Services.Persistence.QuicksaveFileHelper::DebugArchiveSavestate(System.String)
IL_002b: brfalse.s IL_004c
IL_002d: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0032: callvirt System.Void SickDev.DevConsole.DevConsole::Close()
IL_0037: ldstr "archived current savestate"
IL_003c: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0041: ldc.i4 200
IL_0046: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_004b: ret
IL_004c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0051: ldstr "savestate could not be archived. does a savegame exist?"
IL_0056: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_005b: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::LoadState() | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0005: brfalse.s IL_001c
IL_0007: ldstr "quickload blocked by menu or event, try again later"
IL_000c: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0011: ldc.i4 300
IL_0016: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_001b: ret
IL_001c: ldstr "tfol.quicksave.savegame"
IL_0021: call System.Boolean TheForestOfLove.Services.Persistence.QuicksaveFileHelper::DebugRestoreSavestate(System.String)
IL_0026: brfalse.s IL_0047
IL_0028: ldstr "ChapterSelect"
IL_002d: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadSoftResetScene(System.String)
IL_0032: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0037: callvirt System.Void SickDev.DevConsole.DevConsole::Close()
IL_003c: ldstr "restored archived savestate"
IL_0041: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0046: ret
IL_0047: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_004c: ldstr "savestate could not be restored. does a restore point exist?"
IL_0051: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_0056: ret
