TYPE BansheeGz.BGDatabase.BGRepo
METHOD BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::get_I() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld System.Boolean BansheeGz.BGDatabase.BGRepo::DefaultRepoLoaded
IL_0005: brtrue.s IL_000c
IL_0007: call System.Void BansheeGz.BGDatabase.BGRepo::Load()
IL_000c: ldsfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::instance
IL_0011: ret
METHOD System.Void BansheeGz.BGDatabase.BGRepo::Load() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldnull
IL_0001: call System.Void BansheeGz.BGDatabase.BGRepo::Load(BansheeGz.BGDatabase.BGRepoLoadingContext)
IL_0006: ret
METHOD System.Void BansheeGz.BGDatabase.BGRepo::Load(BansheeGz.BGDatabase.BGRepoLoadingContext) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean BansheeGz.BGDatabase.BGRepo::isLoading
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldstr "Database should be loaded on main thread"
IL_000d: call System.Void BansheeGz.BGDatabase.BGMainThreadRunner::EnsureMainThread(System.String)
IL_0012: ldsfld System.Boolean BansheeGz.BGDatabase.BGRepo::DefaultRepoLoaded
IL_0017: brtrue.s IL_0029
IL_0019: ldsfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::instance
IL_001e: callvirt BansheeGz.BGDatabase.BGRepoEvents BansheeGz.BGDatabase.BGRepo::get_Events()
IL_0023: ldc.i4.1
IL_0024: callvirt System.Void BansheeGz.BGDatabase.BGRepoEvents::set_On(System.Boolean)
IL_0029: ldc.i4.1
IL_002a: stsfld System.Boolean BansheeGz.BGDatabase.BGRepo::DefaultRepoLoaded
IL_002f: ldnull
IL_0030: call System.Void BansheeGz.BGDatabase.BGRepo::set_DefaultRepoErrorOnLoad(System.String)
IL_0035: ldc.i4.1
IL_0036: stsfld System.Boolean BansheeGz.BGDatabase.BGRepo::isLoading
IL_003b: call System.Void BansheeGz.BGDatabase.BGRepo::FireOnBeforeLoad()
IL_0040: ldnull
IL_0041: stloc.0
IL_0042: ldc.i4.0
IL_0043: stloc.1
IL_0044: br.s IL_007d
IL_0046: ldsfld BansheeGz.BGDatabase.BGLoaderForRepo[] BansheeGz.BGDatabase.BGRepo::Loaders
IL_004b: ldloc.1
IL_004c: ldelem.ref
IL_004d: stloc.2
IL_004e: ldloc.2
IL_004f: ldsfld BansheeGz.BGDatabase.BGRepoCustomLoaderModel BansheeGz.BGDatabase.BGRepo::defaultRepoCustomLoaderModel
IL_0054: brfalse.s IL_0067
IL_0056: ldsfld BansheeGz.BGDatabase.BGRepoCustomLoaderModel BansheeGz.BGDatabase.BGRepo::defaultRepoCustomLoaderModel
IL_005b: callvirt BansheeGz.BGDatabase.BGRepoCustomLoaderModel/DatabaseResource BansheeGz.BGDatabase.BGRepoCustomLoaderModel::get_MainDatabaseResource()
IL_0060: newobj System.Void BansheeGz.BGDatabase.BGLoaderForRepo/LoadRequest::.ctor(BansheeGz.BGDatabase.BGRepoCustomLoaderModel/DatabaseResource)
IL_0065: br.s IL_0068
IL_0067: ldnull
IL_0068: callvirt System.Byte[] BansheeGz.BGDatabase.BGLoaderForRepo::Load(BansheeGz.BGDatabase.BGLoaderForRepo/LoadRequest)
IL_006d: stloc.0
IL_006e: ldloc.0
IL_006f: brfalse.s IL_0079
IL_0071: ldloc.2
IL_0072: stsfld BansheeGz.BGDatabase.BGLoaderForRepo BansheeGz.BGDatabase.BGRepo::defaultRepoLoader
IL_0077: br.s IL_0087
IL_0079: ldloc.1
IL_007a: ldc.i4.1
IL_007b: add
IL_007c: stloc.1
IL_007d: ldloc.1
IL_007e: ldsfld BansheeGz.BGDatabase.BGLoaderForRepo[] BansheeGz.BGDatabase.BGRepo::Loaders
IL_0083: ldlen
IL_0084: conv.i4
IL_0085: blt.s IL_0046
IL_0087: ldloc.0
IL_0088: brtrue.s IL_009a
IL_008a: ldstr "Can not load database from all possible locations. More info: http://www.bansheegz.com/BGDatabase/Setup/"
IL_008f: ldc.i4.0
IL_0090: call System.Void BansheeGz.BGDatabase.BGRepo::NoLuck(System.String,System.Boolean)
IL_0095: br IL_012b
IL_009a: ldsfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::instance
IL_009f: ldloc.0
IL_00a0: callvirt System.Void BansheeGz.BGDatabase.BGRepo::Load(System.Byte[])
IL_00a5: ldsfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::instance
IL_00aa: ldsfld BansheeGz.BGDatabase.BGLoaderForRepo BansheeGz.BGDatabase.BGRepo::defaultRepoLoader
IL_00af: callvirt System.Void BansheeGz.BGDatabase.BGRepo::set_RepoLoader(BansheeGz.BGDatabase.BGLoaderForRepo)
IL_00b4: ldsfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::instance
IL_00b9: call System.String BansheeGz.BGDatabase.BGRepo::get_DefaultRepoAssetPath()
IL_00be: callvirt System.Void BansheeGz.BGDatabase.BGRepo::set_RepoAssetPath(System.String)
IL_00c3: call System.Boolean UnityEngine.Application::get_isEditor()
IL_00c8: brfalse.s IL_012b
IL_00ca: ldsfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::instance
IL_00cf: callvirt BansheeGz.BGDatabase.BGRepoAddons BansheeGz.BGDatabase.BGRepo::get_Addons()
IL_00d4: callvirt System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGAddon> BansheeGz.BGDatabase.BGRepoAddons::get_Addons()
IL_00d9: dup
IL_00da: ldsfld System.Comparison`1<BansheeGz.BGDatabase.BGAddon> BansheeGz.BGDatabase.BGRepo/<>c::<>9__84_0
IL_00df: dup
IL_00e0: brtrue.s IL_00f9
IL_00e2: pop
IL_00e3: ldsfld BansheeGz.BGDatabase.BGRepo/<>c BansheeGz.BGDatabase.BGRepo/<>c::<>9
IL_00e8: ldftn System.Int32 BansheeGz.BGDatabase.BGRepo/<>c::<Load>b__84_0(BansheeGz.BGDatabase.BGAddon,BansheeGz.BGDatabase.BGAddon)
IL_00ee: newobj System.Void System.Comparison`1<BansheeGz.BGDatabase.BGAddon>::.ctor(System.Object,System.IntPtr)
IL_00f3: dup
IL_00f4: stsfld System.Comparison`1<BansheeGz.BGDatabase.BGAddon> BansheeGz.BGDatabase.BGRepo/<>c::<>9__84_0
IL_00f9: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGAddon>::Sort(System.Comparison`1<!0>)
IL_00fe: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGAddon>::GetEnumerator()
IL_0103: stloc.3
IL_0104: br.s IL_0112
IL_0106: ldloca.s V_3
IL_0108: call !0 System.Collections.Generic.List`1/Enumerator<BansheeGz.BGDatabase.BGAddon>::get_Current()
IL_010d: callvirt System.Void BansheeGz.BGDatabase.BGAddon::OnMainDatabaseLoad()
IL_0112: ldloca.s V_3
IL_0114: call System.Boolean System.Collections.Generic.List`1/Enumerator<BansheeGz.BGDatabase.BGAddon>::MoveNext()
IL_0119: brtrue.s IL_0106
IL_011b: leave.s IL_012b
IL_011d: ldloca.s V_3
IL_011f: constrained. System.Collections.Generic.List`1/Enumerator<BansheeGz.BGDatabase.BGAddon>
IL_0125: callvirt System.Void System.IDisposable::Dispose()
IL_012a: endfinally
IL_012b: leave.s IL_017b
IL_012d: stloc.s V_4
IL_012f: ldloc.s V_4
IL_0131: callvirt System.String System.Exception::get_Message()
IL_0136: dup
IL_0137: brtrue.s IL_0146
IL_0139: pop
IL_013a: ldloc.s V_4
IL_013c: callvirt System.Type System.Exception::GetType()
IL_0141: callvirt System.String System.Type::get_FullName()
IL_0146: ldc.i4.1
IL_0147: call System.Void BansheeGz.BGDatabase.BGRepo::NoLuck(System.String,System.Boolean)
IL_014c: ldloc.s V_4
IL_014e: call System.Void UnityEngine.Debug::LogException(System.Exception)
IL_0153: leave.s IL_017b
IL_0155: ldarg.0
IL_0156: brfalse.s IL_016b
IL_0158: ldarg.0
IL_0159: ldfld System.Action BansheeGz.BGDatabase.BGRepoLoadingContext::OnBeforeFiringOnLoad
IL_015e: brfalse.s IL_016b
IL_0160: ldarg.0
IL_0161: ldfld System.Action BansheeGz.BGDatabase.BGRepoLoadingContext::OnBeforeFiringOnLoad
IL_0166: callvirt System.Void System.Action::Invoke()
IL_016b: nop
IL_016c: call System.Void BansheeGz.BGDatabase.BGRepo::FireOnLoad()
IL_0171: leave.s IL_017a
IL_0173: ldc.i4.0
IL_0174: stsfld System.Boolean BansheeGz.BGDatabase.BGRepo::isLoading
IL_0179: endfinally
IL_017a: endfinally
IL_017b: ret
METHOD System.Void BansheeGz.BGDatabase.BGRepo::Load(System.Byte[]) | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void BansheeGz.BGDatabase.BGRepo/<>c__DisplayClass88_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo/<>c__DisplayClass88_0::<>4__this
IL_000d: ldarg.0
IL_000e: ldfld BansheeGz.BGDatabase.BGRepoAddons BansheeGz.BGDatabase.BGRepo::repoAddons
IL_0013: callvirt System.Void BansheeGz.BGDatabase.BGRepoAddons::Clear()
IL_0018: ldloc.0
IL_0019: ldsfld BansheeGz.BGDatabase.BGRepo/RepoReaderI BansheeGz.BGDatabase.BGRepo::Reader
IL_001e: ldarg.1
IL_001f: callvirt BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo/RepoReaderI::Read(System.Byte[])
IL_0024: stfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo/<>c__DisplayClass88_0::repo
IL_0029: ldarg.0
IL_002a: call BansheeGz.BGDatabase.BGRepoEvents BansheeGz.BGDatabase.BGRepo::get_Events()
IL_002f: ldloc.0
IL_0030: ldftn System.Void BansheeGz.BGDatabase.BGRepo/<>c__DisplayClass88_0::<Load>b__0()
IL_0036: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_003b: callvirt System.Void BansheeGz.BGDatabase.BGRepoEvents::WithEventsDisabled(System.Action)
IL_0040: ldloc.0
IL_0041: ldfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo/<>c__DisplayClass88_0::repo
IL_0046: ldfld BansheeGz.BGDatabase.BGLazyLoaderRepoI BansheeGz.BGDatabase.BGRepo::LazyLoader
IL_004b: brtrue.s IL_0062
IL_004d: ldarg.0
IL_004e: ldloc.0
IL_004f: ldfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo/<>c__DisplayClass88_0::repo
IL_0054: call System.Void BansheeGz.BGDatabase.BGRepo::MergeOnLoad(BansheeGz.BGDatabase.BGRepo)
IL_0059: ldarg.0
IL_005a: ldnull
IL_005b: stfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::loadedRepo
IL_0060: br.s IL_0074
IL_0062: ldarg.0
IL_0063: call System.Void BansheeGz.BGDatabase.BGRepo::ClearInternal()
IL_0068: ldarg.0
IL_0069: ldloc.0
IL_006a: ldfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo/<>c__DisplayClass88_0::repo
IL_006f: stfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::loadedRepo
IL_0074: call System.Boolean UnityEngine.Application::get_isPlaying()
IL_0079: brfalse.s IL_0096
IL_007b: ldarg.0
IL_007c: ldfld BansheeGz.BGDatabase.BGRepoAddons BansheeGz.BGDatabase.BGRepo::repoAddons
IL_0081: callvirt System.Boolean BansheeGz.BGDatabase.BGRepoAddons::Has<BansheeGz.BGDatabase.BGAddonSaveLoad>()
IL_0086: brfalse.s IL_0096
IL_0088: ldarg.0
IL_0089: ldnull
IL_008a: stfld BansheeGz.BGDatabase.BGMTService BansheeGz.BGDatabase.BGRepo::mtService
IL_008f: ldarg.0
IL_0090: call BansheeGz.BGDatabase.BGMTService BansheeGz.BGDatabase.BGRepo::get_MTService()
IL_0095: pop
IL_0096: ldarg.0
IL_0097: call BansheeGz.BGDatabase.BGRepoEvents BansheeGz.BGDatabase.BGRepo::get_Events()
IL_009c: callvirt System.Boolean BansheeGz.BGDatabase.BGRepoEvents::get_On()
IL_00a1: brfalse.s IL_00ae
IL_00a3: ldarg.0
IL_00a4: call BansheeGz.BGDatabase.BGRepoEvents BansheeGz.BGDatabase.BGRepo::get_Events()
IL_00a9: callvirt System.Void BansheeGz.BGDatabase.BGRepoEvents::FireFullChange()
IL_00ae: ret
