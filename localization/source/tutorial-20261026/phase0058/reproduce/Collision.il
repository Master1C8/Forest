TYPE TheForestOfLove.CollisionEventListener
METHOD System.Void TheForestOfLove.CollisionEventListener::OnTriggerEnter2D(UnityEngine.Collider2D) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Collider2DEvent TheForestOfLove.CollisionEventListener::onTriggerEnter2D
IL_0006: ldarg.1
IL_0007: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Collider2D>::Invoke(!0)
IL_000c: ret
METHOD System.Void TheForestOfLove.CollisionEventListener::OnTriggerStay2D(UnityEngine.Collider2D) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Collider2DEvent TheForestOfLove.CollisionEventListener::onTriggerStay2D
IL_0006: ldarg.1
IL_0007: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Collider2D>::Invoke(!0)
IL_000c: ret
METHOD System.Void TheForestOfLove.CollisionEventListener::OnTriggerExit2D(UnityEngine.Collider2D) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Collider2DEvent TheForestOfLove.CollisionEventListener::onTriggerExit2D
IL_0006: ldarg.1
IL_0007: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Collider2D>::Invoke(!0)
IL_000c: ret
