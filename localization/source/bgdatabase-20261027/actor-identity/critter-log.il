TYPE TheForestOfLove.CritterLog
METHOD System.Void TheForestOfLove.CritterLog::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Services.Persistence.DataService::GetActors()
IL_000b: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Actor>::GetEnumerator()
IL_0010: stloc.0
IL_0011: br.s IL_0088
IL_0013: ldloc.0
IL_0014: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Actor>::get_Current()
IL_0019: stloc.1
IL_001a: ldloc.1
IL_001b: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isExcludedFromCritterLog
IL_0020: brtrue.s IL_0088
IL_0022: ldarg.0
IL_0023: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog::residentNameTemplateSelected
IL_0028: ldarg.0
IL_0029: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog::residentNamesContainer
IL_002e: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0033: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0038: stloc.2
IL_0039: ldarg.0
IL_003a: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog::residentNameTemplateEnabled
IL_003f: ldarg.0
IL_0040: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog::residentNamesContainer
IL_0045: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_004a: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_004f: stloc.3
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog::residentNameTemplateDisabled
IL_0056: ldarg.0
IL_0057: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog::residentNamesContainer
IL_005c: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0061: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0066: stloc.s V_4
IL_0068: ldloc.1
IL_0069: ldloc.2
IL_006a: ldloc.3
IL_006b: ldloc.s V_4
IL_006d: newobj System.Void TheForestOfLove.CritterLog/NamedResident::.ctor(TheForestOfLove.Narrative.Actor,UnityEngine.GameObject,UnityEngine.GameObject,UnityEngine.GameObject)
IL_0072: stloc.s V_5
IL_0074: ldarg.0
IL_0075: ldfld System.Collections.Generic.List`1<TheForestOfLove.CritterLog/NamedResident> TheForestOfLove.CritterLog::residentLabels
IL_007a: ldloc.s V_5
IL_007c: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.CritterLog/NamedResident>::Add(!0)
IL_0081: ldloc.s V_5
IL_0083: call System.Void TheForestOfLove.CritterLog::UpdateResidentLabelState(TheForestOfLove.CritterLog/NamedResident)
IL_0088: ldloc.0
IL_0089: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_008e: brtrue.s IL_0013
IL_0090: leave.s IL_009c
IL_0092: ldloc.0
IL_0093: brfalse.s IL_009b
IL_0095: ldloc.0
IL_0096: callvirt System.Void System.IDisposable::Dispose()
IL_009b: endfinally
IL_009c: ldarg.0
IL_009d: ldc.i4.0
IL_009e: call System.Void TheForestOfLove.CritterLog::SelectResidentLabel(System.Int32)
IL_00a3: ldarg.0
IL_00a4: ldc.i4.0
IL_00a5: call System.Void TheForestOfLove.CritterLog::set_visible(System.Boolean)
IL_00aa: ldarg.0
IL_00ab: call !!0 UnityEngine.Component::GetComponent<UnityEngine.CanvasGroup>()
IL_00b0: ldc.r4 0
IL_00b5: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_00ba: ret
METHOD System.Void TheForestOfLove.CritterLog::UpdateResidentLabelState(TheForestOfLove.CritterLog/NamedResident) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: callvirt TheForestOfLove.Narrative.Actor TheForestOfLove.CritterLog/NamedResident::get_actor()
IL_0007: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_000c: brtrue.s IL_0015
IL_000e: ldstr "???"
IL_0013: br.s IL_0020
IL_0015: ldarg.0
IL_0016: callvirt TheForestOfLove.Narrative.Actor TheForestOfLove.CritterLog/NamedResident::get_actor()
IL_001b: callvirt System.String TheForestOfLove.Narrative.Actor::get_NameplateName()
IL_0020: callvirt System.Void TheForestOfLove.CritterLog/NamedResident::SetText(System.String)
IL_0025: ldarg.0
IL_0026: callvirt TheForestOfLove.Narrative.Actor TheForestOfLove.CritterLog/NamedResident::get_actor()
IL_002b: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_0030: brtrue.s IL_0047
IL_0032: ldarg.0
IL_0033: callvirt TheForestOfLove.Narrative.Actor TheForestOfLove.CritterLog/NamedResident::get_actor()
IL_0038: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsEncounteredOnce()
IL_003d: brtrue.s IL_0047
IL_003f: ldarg.0
IL_0040: ldc.i4.2
IL_0041: callvirt System.Void TheForestOfLove.CritterLog/NamedResident::SetStatus(TheForestOfLove.CritterLog/NamedResidentStatus)
IL_0046: ret
IL_0047: ldarg.0
IL_0048: ldc.i4.1
IL_0049: callvirt System.Void TheForestOfLove.CritterLog/NamedResident::SetStatus(TheForestOfLove.CritterLog/NamedResidentStatus)
IL_004e: ret
