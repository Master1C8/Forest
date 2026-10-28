TYPE TheForestOfLove.GameplayLogManager
METHOD System.Void TheForestOfLove.GameplayLogManager::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_0006: call System.Collections.Generic.IEnumerable`1<GameplayLogHistory> TheForestOfLove.Services.Persistence.DataService::GetLogHistory()
IL_000b: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<GameplayLogHistory>::GetEnumerator()
IL_0010: stloc.0
IL_0011: br.s IL_002c
IL_0013: ldloc.0
IL_0014: callvirt !0 System.Collections.Generic.IEnumerator`1<GameplayLogHistory>::get_Current()
IL_0019: stloc.1
IL_001a: ldarg.0
IL_001b: ldloc.1
IL_001c: ldfld System.String GameplayLogHistory::message
IL_0021: ldloc.1
IL_0022: ldfld System.Single GameplayLogHistory::timeUnlocked
IL_0027: call System.Void TheForestOfLove.GameplayLogManager::AddLogHistory(System.String,System.Single)
IL_002c: ldloc.0
IL_002d: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0032: brtrue.s IL_0013
IL_0034: leave.s IL_0040
IL_0036: ldloc.0
IL_0037: brfalse.s IL_003f
IL_0039: ldloc.0
IL_003a: callvirt System.Void System.IDisposable::Dispose()
IL_003f: endfinally
IL_0040: ret
METHOD System.Collections.Generic.IEnumerable`1<GameplayLogHistory> TheForestOfLove.GameplayLogManager::GetLogHistory() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.GameplayLogManager>()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldnull
IL_0008: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000d: brfalse.s IL_0016
IL_000f: ldloc.0
IL_0010: ldfld System.Collections.Generic.Queue`1<GameplayLogHistory> TheForestOfLove.GameplayLogManager::logHistory
IL_0015: ret
IL_0016: newobj System.Void System.Collections.Generic.List`1<GameplayLogHistory>::.ctor()
IL_001b: ret
