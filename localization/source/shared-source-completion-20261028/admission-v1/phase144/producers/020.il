TYPE TheForestOfLove.BunnyCuckMoviePeter
METHOD System.String TheForestOfLove.BunnyCuckMoviePeter::GetTriggerNameFromLoopNumber(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldc.i4.1
IL_0002: sub
IL_0003: switch IL_0018,IL_001e,IL_0024,IL_002a
IL_0018: ldstr "fapping"
IL_001d: ret
IL_001e: ldstr "harder"
IL_0023: ret
IL_0024: ldstr "cumming"
IL_0029: ret
IL_002a: ldstr "idle"
IL_002f: ret
METHOD System.Void TheForestOfLove.BunnyCuckMoviePeter::SetBlinkBTreeTriggerName(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.BunnyCuckMoviePeter::blinkBTree
IL_0006: callvirt System.Boolean NodeCanvas.Framework.GraphOwner::get_isRunning()
IL_000b: brtrue.s IL_0018
IL_000d: ldarg.0
IL_000e: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.BunnyCuckMoviePeter::blinkBTree
IL_0013: callvirt System.Void NodeCanvas.Framework.GraphOwner::StartBehaviour()
IL_0018: ldarg.0
IL_0019: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.BunnyCuckMoviePeter::blinkBTree
IL_001e: callvirt NodeCanvas.Framework.IBlackboard NodeCanvas.Framework.GraphOwner::get_blackboard()
IL_0023: callvirt System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable> NodeCanvas.Framework.IBlackboard::get_variables()
IL_0028: ldstr "triggerName"
IL_002d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable>::get_Item(!0)
IL_0032: ldarg.1
IL_0033: callvirt System.Void NodeCanvas.Framework.Variable::set_value(System.Object)
IL_0038: ldarg.0
IL_0039: ldfld NodeCanvas.BehaviourTrees.BehaviourTreeOwner TheForestOfLove.BunnyCuckMoviePeter::blinkBTree
IL_003e: callvirt System.Void NodeCanvas.Framework.GraphOwner::UpdateBehaviour()
IL_0043: ret
