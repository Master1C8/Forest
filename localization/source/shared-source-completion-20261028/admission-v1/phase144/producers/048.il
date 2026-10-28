TYPE TheForestOfLove.Core.SceneSetup.DbAddressableAssetsPreloader
METHOD System.Void TheForestOfLove.Core.SceneSetup.DbAddressableAssetsPreloader::EnsureDefaultTags() | attributes=Family, HideBySig | impl=IL
IL_0000: ldstr "Main"
IL_0005: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_000a: brtrue.s IL_002d
IL_000c: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0011: dup
IL_0012: ldstr "Main"
IL_0017: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_001c: dup
IL_001d: ldstr "Main Act 1"
IL_0022: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0027: ldnull
IL_0028: call System.Void TheForestOfLove.Narrative.NarrativeActions::UpdateTags(System.Collections.Generic.List`1<System.String>,System.Collections.Generic.List`1<System.String>)
IL_002d: ret
