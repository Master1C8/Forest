TYPE TheForestOfLove.Core.BaseBehavior
METHOD System.Void TheForestOfLove.Core.BaseBehavior::Awake() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.Core.BaseBehavior::set_isAwakened(System.Boolean)
IL_0007: ldarg.0
IL_0008: call System.Void TheForestOfLove.Core.BaseBehavior::RegisterServices_Internal()
IL_000d: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::OnEnable() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isAwakened()
IL_0006: brfalse.s IL_000e
IL_0008: ldarg.0
IL_0009: call System.Void TheForestOfLove.Core.BaseBehavior::RegisterServices_Internal()
IL_000e: ldarg.0
IL_000f: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isStarted()
IL_0014: brfalse.s IL_001c
IL_0016: ldarg.0
IL_0017: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners_Internal()
IL_001c: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::OnDisable() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners_Internal()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Core.BaseBehavior::UnregisterServices_Internal()
IL_000c: ret
