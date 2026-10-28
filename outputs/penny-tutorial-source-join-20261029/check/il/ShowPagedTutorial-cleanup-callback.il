TYPE TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0
METHOD System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<ShowPagedTutorial>b__3() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_003f
IL_000e: ldarg.0
IL_000f: ldfld TheForestOfLove.ItemGetNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<>4__this
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_001a: ldfld UnityEngine.Animator[] TheForestOfLove.PagedTutorial::nav
IL_001f: ldarg.0
IL_0020: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_0025: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_002a: call System.Void TheForestOfLove.ItemGetNotification::ReparentTutorialNav(UnityEngine.Animator[],UnityEngine.Transform)
IL_002f: ldarg.0
IL_0030: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_0035: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_003a: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_003f: ret
