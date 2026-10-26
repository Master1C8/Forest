TYPE TheForestOfLove.Narrative.StoryManager
METHOD System.Void TheForestOfLove.Narrative.StoryManager::ResetQuestsWithTag(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0006: ldarg.1
IL_0007: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_000c: stloc.0
IL_000d: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Services.Persistence.DataService::GetQuests()
IL_0012: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Quest>::GetEnumerator()
IL_0017: stloc.1
IL_0018: br.s IL_0036
IL_001a: ldloc.1
IL_001b: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Quest>::get_Current()
IL_0020: stloc.2
IL_0021: ldloc.2
IL_0022: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Quest::enableWithTags
IL_0027: ldloc.0
IL_0028: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Contains(!0)
IL_002d: brfalse.s IL_0036
IL_002f: ldarg.0
IL_0030: ldloc.2
IL_0031: call System.Void TheForestOfLove.Narrative.StoryManager::ResetQuest(TheForestOfLove.Narrative.Quest)
IL_0036: ldloc.1
IL_0037: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_003c: brtrue.s IL_001a
IL_003e: leave.s IL_0051
IL_0040: ldloc.1
IL_0041: brfalse.s IL_0049
IL_0043: ldloc.1
IL_0044: callvirt System.Void System.IDisposable::Dispose()
IL_0049: endfinally
IL_004a: ldc.i4.0
IL_004b: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0050: endfinally
IL_0051: ret
