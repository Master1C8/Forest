TYPE SoftSpriteMaskStrengthOnCollision2D
METHOD System.Boolean SoftSpriteMaskStrengthOnCollision2D::Qualifies(UnityEngine.Collider2D) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_000b
IL_0009: ldc.i4.0
IL_000a: ret
IL_000b: ldarg.0
IL_000c: ldfld System.Boolean SoftSpriteMaskStrengthOnCollision2D::useLayerMask
IL_0011: brfalse.s IL_0035
IL_0013: ldc.i4.1
IL_0014: ldarg.1
IL_0015: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001a: callvirt System.Int32 UnityEngine.GameObject::get_layer()
IL_001f: ldc.i4.s 31
IL_0021: and
IL_0022: shl
IL_0023: stloc.0
IL_0024: ldarg.0
IL_0025: ldflda UnityEngine.LayerMask SoftSpriteMaskStrengthOnCollision2D::affectLayers
IL_002a: call System.Int32 UnityEngine.LayerMask::get_value()
IL_002f: ldloc.0
IL_0030: and
IL_0031: brtrue.s IL_0035
IL_0033: ldc.i4.0
IL_0034: ret
IL_0035: ldarg.0
IL_0036: ldfld System.String SoftSpriteMaskStrengthOnCollision2D::requiredTag
IL_003b: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0040: brtrue.s IL_0052
IL_0042: ldarg.1
IL_0043: ldarg.0
IL_0044: ldfld System.String SoftSpriteMaskStrengthOnCollision2D::requiredTag
IL_0049: callvirt System.Boolean UnityEngine.Component::CompareTag(System.String)
IL_004e: brtrue.s IL_0052
IL_0050: ldc.i4.0
IL_0051: ret
IL_0052: ldc.i4.1
IL_0053: ret
