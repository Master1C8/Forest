TYPE TheForestOfLove.GameVersionHelper
METHOD System.Nullable`1<System.Int32> TheForestOfLove.GameVersionHelper::LoadGameVersionKeyForApplicationVersionKey(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "GameVersion/"
IL_0005: call !!0[] UnityEngine.Resources::LoadAll<TheForestOfLove.GameVersionKeySettings>(System.String)
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: brfalse.s IL_0014
IL_000e: ldloc.0
IL_000f: ldlen
IL_0010: conv.i4
IL_0011: ldc.i4.1
IL_0012: beq.s IL_001e
IL_0014: ldloca.s V_2
IL_0016: initobj System.Nullable`1<System.Int32>
IL_001c: ldloc.2
IL_001d: ret
IL_001e: ldloc.0
IL_001f: ldc.i4.0
IL_0020: ldelem.ref
IL_0021: stloc.1
IL_0022: ldloc.1
IL_0023: ldfld System.String[] TheForestOfLove.GameVersionKeySettings::applicationVersionKeys
IL_0028: brfalse.s IL_0056
IL_002a: ldloc.1
IL_002b: ldfld System.String[] TheForestOfLove.GameVersionKeySettings::applicationVersionKeys
IL_0030: ldlen
IL_0031: brfalse.s IL_0056
IL_0033: ldloc.1
IL_0034: ldfld System.Int32[] TheForestOfLove.GameVersionKeySettings::gameVersionKeys
IL_0039: brfalse.s IL_0056
IL_003b: ldloc.1
IL_003c: ldfld System.Int32[] TheForestOfLove.GameVersionKeySettings::gameVersionKeys
IL_0041: ldlen
IL_0042: brfalse.s IL_0056
IL_0044: ldloc.1
IL_0045: ldfld System.String[] TheForestOfLove.GameVersionKeySettings::applicationVersionKeys
IL_004a: ldlen
IL_004b: conv.i4
IL_004c: ldloc.1
IL_004d: ldfld System.Int32[] TheForestOfLove.GameVersionKeySettings::gameVersionKeys
IL_0052: ldlen
IL_0053: conv.i4
IL_0054: beq.s IL_006a
IL_0056: ldstr "game version settings scriptable object has missing or asymmetric arrays"
IL_005b: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0060: ldloca.s V_2
IL_0062: initobj System.Nullable`1<System.Int32>
IL_0068: ldloc.2
IL_0069: ret
IL_006a: ldc.i4.0
IL_006b: stloc.3
IL_006c: br.s IL_0090
IL_006e: ldloc.1
IL_006f: ldfld System.String[] TheForestOfLove.GameVersionKeySettings::applicationVersionKeys
IL_0074: ldloc.3
IL_0075: ldelem.ref
IL_0076: ldarg.0
IL_0077: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_007c: brfalse.s IL_008c
IL_007e: ldloc.1
IL_007f: ldfld System.Int32[] TheForestOfLove.GameVersionKeySettings::gameVersionKeys
IL_0084: ldloc.3
IL_0085: ldelem.i4
IL_0086: newobj System.Void System.Nullable`1<System.Int32>::.ctor(!0)
IL_008b: ret
IL_008c: ldloc.3
IL_008d: ldc.i4.1
IL_008e: add
IL_008f: stloc.3
IL_0090: ldloc.3
IL_0091: ldloc.1
IL_0092: ldfld System.String[] TheForestOfLove.GameVersionKeySettings::applicationVersionKeys
IL_0097: ldlen
IL_0098: conv.i4
IL_0099: blt.s IL_006e
IL_009b: ldstr "game version settings missing entry for application version "
IL_00a0: ldarg.0
IL_00a1: call System.String System.String::Concat(System.String,System.String)
IL_00a6: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_00ab: ldloca.s V_2
IL_00ad: initobj System.Nullable`1<System.Int32>
IL_00b3: ldloc.2
IL_00b4: ret
METHOD System.Void TheForestOfLove.GameVersionHelper::Save() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Save()
IL_0006: call System.String TheForestOfLove.GameVersionHelper::GetApplicationVersion_MajorVersionOnly()
IL_000b: call System.Nullable`1<System.Int32> TheForestOfLove.GameVersionHelper::LoadGameVersionKeyForApplicationVersionKey(System.String)
IL_0010: stloc.0
IL_0011: ldstr "last_saved_game_version"
IL_0016: ldloca.s V_0
IL_0018: call System.Boolean System.Nullable`1<System.Int32>::get_HasValue()
IL_001d: brtrue.s IL_0022
IL_001f: ldnull
IL_0020: br.s IL_0031
IL_0022: ldloca.s V_0
IL_0024: call !0 System.Nullable`1<System.Int32>::get_Value()
IL_0029: stloc.1
IL_002a: ldloca.s V_1
IL_002c: call System.String System.Int32::ToString()
IL_0031: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0036: ret
METHOD System.String TheForestOfLove.GameVersionHelper::GetApplicationVersion_MajorVersionOnly() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.String UnityEngine.Application::get_version()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldc.i4.s 46
IL_0009: callvirt System.Int32 System.String::LastIndexOf(System.Char)
IL_000e: stloc.1
IL_000f: ldloc.0
IL_0010: callvirt System.Int32 System.String::get_Length()
IL_0015: ldloc.0
IL_0016: ldstr "."
IL_001b: ldstr ""
IL_0020: callvirt System.String System.String::Replace(System.String,System.String)
IL_0025: callvirt System.Int32 System.String::get_Length()
IL_002a: sub
IL_002b: stloc.2
IL_002c: ldloc.1
IL_002d: ldc.i4.m1
IL_002e: beq.s IL_0034
IL_0030: ldloc.2
IL_0031: ldc.i4.2
IL_0032: bge.s IL_0036
IL_0034: ldloc.0
IL_0035: ret
IL_0036: ldloc.0
IL_0037: ldc.i4.0
IL_0038: ldloc.1
IL_0039: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_003e: ret
METHOD System.Boolean TheForestOfLove.GameVersionHelper::HasShownOosNotificationForGameVersionKey(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "oos_notification_"
IL_0005: ldarga.s gameVersionKey
IL_0007: call System.String System.Int32::ToString()
IL_000c: call System.String System.String::Concat(System.String,System.String)
IL_0011: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_0016: ldnull
IL_0017: cgt.un
IL_0019: ret
METHOD System.Void TheForestOfLove.GameVersionHelper::SaveOosNotificationFlagForGameVersionKey(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "oos_notification_"
IL_0005: ldarga.s gameVersionKey
IL_0007: call System.String System.Int32::ToString()
IL_000c: call System.String System.String::Concat(System.String,System.String)
IL_0011: ldstr "true"
IL_0016: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_001b: ret
