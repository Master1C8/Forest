TYPE TheForestOfLove.Core.BaseBehavior
METHOD System.Void TheForestOfLove.Core.BaseBehavior::Start() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.Core.BaseBehavior::set_isStarted(System.Boolean)
IL_0007: ldarg.0
IL_0008: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners_Internal()
IL_000d: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::OnDestroy() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.Core.BaseBehavior::set_isDestroyed(System.Boolean)
IL_0007: ldarg.0
IL_0008: call System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners_Internal()
IL_000d: ldarg.0
IL_000e: call System.Void TheForestOfLove.Core.BaseBehavior::UnregisterServices_Internal()
IL_0013: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::RegisterServices() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::UnregisterServices() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ret
