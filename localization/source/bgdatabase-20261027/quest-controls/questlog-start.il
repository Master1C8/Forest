TYPE TheForestOfLove.QuestLog
METHOD System.Void TheForestOfLove.QuestLog::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldc.i4.0
IL_0007: stloc.0
IL_0008: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Services.Persistence.DataService::GetQuests()
IL_000d: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Quest>::GetEnumerator()
IL_0012: stloc.1
IL_0013: br IL_009f
IL_0018: ldloc.1
IL_0019: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Quest>::get_Current()
IL_001e: stloc.2
IL_001f: ldloc.2
IL_0020: ldfld System.Boolean TheForestOfLove.Narrative.Quest::isHiddenInQuestLog
IL_0025: brtrue.s IL_009f
IL_0027: ldarg.0
IL_0028: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog::questNameTemplateSelected
IL_002d: ldarg.0
IL_002e: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog::questNamesContainer
IL_0033: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0038: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_003d: ldarg.0
IL_003e: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog::questNameTemplateActive
IL_0043: ldarg.0
IL_0044: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog::questNamesContainer
IL_0049: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_004e: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0053: stloc.3
IL_0054: ldarg.0
IL_0055: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog::questNameTemplateCompleted
IL_005a: ldarg.0
IL_005b: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog::questNamesContainer
IL_0060: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0065: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_006a: stloc.s V_4
IL_006c: ldloc.3
IL_006d: ldloc.s V_4
IL_006f: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_0074: ldloc.2
IL_0075: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_007a: newobj System.Void TheForestOfLove.QuestLog/QuestLabel::.ctor(UnityEngine.GameObject,UnityEngine.GameObject,UnityEngine.GameObject,System.String)
IL_007f: stloc.s V_5
IL_0081: ldarg.0
IL_0082: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::questLabels
IL_0087: ldloc.s V_5
IL_0089: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Add(!0)
IL_008e: ldloc.s V_5
IL_0090: ldloc.2
IL_0091: ldfld System.String TheForestOfLove.Narrative.Quest::title
IL_0096: callvirt System.Void TheForestOfLove.QuestLog/QuestLabel::SetText(System.String)
IL_009b: ldloc.0
IL_009c: ldc.i4.1
IL_009d: add
IL_009e: stloc.0
IL_009f: ldloc.1
IL_00a0: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_00a5: brtrue IL_0018
IL_00aa: leave.s IL_00b6
IL_00ac: ldloc.1
IL_00ad: brfalse.s IL_00b5
IL_00af: ldloc.1
IL_00b0: callvirt System.Void System.IDisposable::Dispose()
IL_00b5: endfinally
IL_00b6: ldarg.0
IL_00b7: call System.Void TheForestOfLove.QuestLog::RefreshQuestLabels()
IL_00bc: ldarg.0
IL_00bd: ldc.i4.0
IL_00be: call System.Void TheForestOfLove.QuestLog::set_visible(System.Boolean)
IL_00c3: ldarg.0
IL_00c4: call !!0 UnityEngine.Component::GetComponent<UnityEngine.CanvasGroup>()
IL_00c9: ldc.r4 0
IL_00ce: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_00d3: ret
