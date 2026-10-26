TYPE Itelisoft.KOF.TheKingOfJoysticks
METHOD System.Boolean Itelisoft.KOF.TheKingOfJoysticks::get_DisableJoystickInput()
IL_0000: ldsfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::<DisableJoystickInput>k__BackingField
IL_0005: ret
METHOD System.Void Itelisoft.KOF.TheKingOfJoysticks::Awake()
IL_0000: ldarg.0
IL_0001: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0006: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_000b: ret
METHOD System.Void Itelisoft.KOF.TheKingOfJoysticks::Start()
IL_0000: ldarg.0
IL_0001: call System.Void Itelisoft.KOF.TheKingOfJoysticks::HideJoystick()
IL_0006: ret
METHOD System.Void Itelisoft.KOF.TheKingOfJoysticks::LateUpdate()
IL_0000: call System.Boolean Itelisoft.KOF.TheKingOfJoysticks::get_DisableJoystickInput()
IL_0005: brfalse.s IL_0016
IL_0007: ldarg.0
IL_0008: ldfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::inUse
IL_000d: brfalse.s IL_0015
IL_000f: ldarg.0
IL_0010: call System.Void Itelisoft.KOF.TheKingOfJoysticks::EndUsingJoystick()
IL_0015: ret
IL_0016: ldarg.0
IL_0017: ldfld Itelisoft.KOF.TheKingOfJoysticks/UpdateBehaviour Itelisoft.KOF.TheKingOfJoysticks::_currentUpdateBehaviour
IL_001c: callvirt System.Void Itelisoft.KOF.TheKingOfJoysticks/UpdateBehaviour::Invoke()
IL_0021: ret
