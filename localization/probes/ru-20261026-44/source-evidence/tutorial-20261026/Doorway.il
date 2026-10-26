TYPE TheForestOfLove.Doorway
METHOD System.Void TheForestOfLove.Doorway::OnTriggerEnter2D(UnityEngine.Collider2D)
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.Doorway::transitioning
IL_0006: brtrue.s IL_0010
IL_0008: ldarg.0
IL_0009: call System.Boolean UnityEngine.Behaviour::get_enabled()
IL_000e: brtrue.s IL_0011
IL_0010: ret
IL_0011: ldarg.1
IL_0012: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0017: ldstr "Player"
IL_001c: callvirt System.Boolean UnityEngine.GameObject::CompareTag(System.String)
IL_0021: brfalse.s IL_005f
IL_0023: ldarg.0
IL_0024: ldc.i4.1
IL_0025: stfld System.Boolean TheForestOfLove.Doorway::transitioning
IL_002a: ldarg.0
IL_002b: ldfld System.Single TheForestOfLove.Doorway::secondsBeforeTravel
IL_0030: ldc.r4 1E-45
IL_0035: ble.un.s IL_004f
IL_0037: ldarg.0
IL_0038: ldfld System.Single TheForestOfLove.Doorway::secondsBeforeTravel
IL_003d: ldarg.0
IL_003e: ldftn System.Void TheForestOfLove.Doorway::<OnTriggerEnter2D>b__6_0()
IL_0044: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0049: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_004e: ret
IL_004f: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.GameEvents::onEnteringDoorway
IL_0054: ldarg.0
IL_0055: ldfld System.String TheForestOfLove.Doorway::sceneName
IL_005a: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_005f: ret
METHOD System.Void TheForestOfLove.Doorway::<OnTriggerEnter2D>b__6_0()
IL_0000: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.GameEvents::onEnteringDoorway
IL_0005: ldarg.0
IL_0006: ldfld System.String TheForestOfLove.Doorway::sceneName
IL_000b: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_0010: ret
