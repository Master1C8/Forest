TYPE TheForestOfLove.Services.Persistence.QuicksaveFileHelper
METHOD System.Boolean TheForestOfLove.Services.Persistence.QuicksaveFileHelper::DebugArchiveSavestate_Intermediate(System.String,ES3Settings) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldstr "tfol.savegame"
IL_0005: ldarg.1
IL_0006: call System.Boolean ES3::FileExists(System.String,ES3Settings)
IL_000b: brtrue.s IL_0011
IL_000d: ldc.i4.0
IL_000e: stloc.0
IL_000f: leave.s IL_0055
IL_0011: ldarg.0
IL_0012: ldarg.1
IL_0013: call System.Boolean ES3::FileExists(System.String,ES3Settings)
IL_0018: brfalse.s IL_0021
IL_001a: ldarg.0
IL_001b: ldarg.1
IL_001c: call System.Void ES3::DeleteFile(System.String,ES3Settings)
IL_0021: ldstr "tfol.savegame"
IL_0026: ldarg.0
IL_0027: ldarg.1
IL_0028: ldarg.1
IL_0029: call System.Void ES3::CopyFile(System.String,System.String,ES3Settings,ES3Settings)
IL_002e: ldc.i4.1
IL_002f: stloc.0
IL_0030: leave.s IL_0055
IL_0032: ldstr "EasySave Copy Failed!"
IL_0037: call System.Void UnityEngine.Debug::Log(System.Object)
IL_003c: dup
IL_003d: callvirt System.String System.Exception::get_Message()
IL_0042: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0047: callvirt System.String System.Exception::get_StackTrace()
IL_004c: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0051: leave.s IL_0053
IL_0053: ldc.i4.0
IL_0054: ret
IL_0055: ldloc.0
IL_0056: ret
METHOD System.Boolean TheForestOfLove.Services.Persistence.QuicksaveFileHelper::DebugRestoreSavestate_Intermediate(System.String,ES3Settings) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Boolean ES3::FileExists(System.String,ES3Settings)
IL_0007: brtrue.s IL_000d
IL_0009: ldc.i4.0
IL_000a: stloc.0
IL_000b: leave.s IL_0059
IL_000d: ldstr "tfol.savegame"
IL_0012: ldarg.1
IL_0013: call System.Boolean ES3::FileExists(System.String,ES3Settings)
IL_0018: brfalse.s IL_0025
IL_001a: ldstr "tfol.savegame"
IL_001f: ldarg.1
IL_0020: call System.Void ES3::DeleteFile(System.String,ES3Settings)
IL_0025: ldarg.0
IL_0026: ldstr "tfol.savegame"
IL_002b: ldarg.1
IL_002c: ldarg.1
IL_002d: call System.Void ES3::CopyFile(System.String,System.String,ES3Settings,ES3Settings)
IL_0032: ldc.i4.1
IL_0033: stloc.0
IL_0034: leave.s IL_0059
IL_0036: ldstr "EasySave Copy Failed!"
IL_003b: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0040: dup
IL_0041: callvirt System.String System.Exception::get_Message()
IL_0046: call System.Void UnityEngine.Debug::Log(System.Object)
IL_004b: callvirt System.String System.Exception::get_StackTrace()
IL_0050: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0055: leave.s IL_0057
IL_0057: ldc.i4.1
IL_0058: ret
IL_0059: ldloc.0
IL_005a: ret
