TYPE UnityEngine.Object
METHOD System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: call System.Boolean UnityEngine.Object::CompareBaseObjects(UnityEngine.Object,UnityEngine.Object)
IL_0008: ldc.i4.0
IL_0009: ceq
IL_000b: stloc.0
IL_000c: br.s IL_000e
IL_000e: ldloc.0
IL_000f: ret
TYPE UnityEngine.UI.Image
METHOD UnityEngine.Sprite UnityEngine.UI.Image::get_sprite() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Sprite UnityEngine.UI.Image::m_Sprite
IL_0006: ret
TYPE UnityEngine.WaitForEndOfFrame
METHOD System.Void UnityEngine.WaitForEndOfFrame::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void UnityEngine.YieldInstruction::.ctor()
IL_0006: nop
IL_0007: ret
TYPE PixelCrushers.DialogueSystem.Tools
METHOD System.Void PixelCrushers.DialogueSystem.Tools::SetGameObjectActive(UnityEngine.Component,System.Boolean) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_0015
IL_0009: ldarg.0
IL_000a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_000f: ldarg.1
IL_0010: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0015: ret
