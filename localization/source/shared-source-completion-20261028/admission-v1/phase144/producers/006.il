TYPE SoftSpriteMaskStrengthOnCollision2D
METHOD System.Void SoftSpriteMaskStrengthOnCollision2D::AnimateTo(System.Single,System.Single,DG.Tweening.Ease) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void SoftSpriteMaskStrengthOnCollision2D/<>c__DisplayClass21_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld SoftSpriteMaskStrengthOnCollision2D SoftSpriteMaskStrengthOnCollision2D/<>c__DisplayClass21_0::<>4__this
IL_000d: ldarg.0
IL_000e: ldfld SoftSpriteMask SoftSpriteMaskStrengthOnCollision2D::softMask
IL_0013: ldnull
IL_0014: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0019: brfalse.s IL_0037
IL_001b: ldstr "SoftSpriteMaskStrengthOnCollision2D: No SoftSpriteMask assigned on "
IL_0020: ldarg.0
IL_0021: call System.String UnityEngine.Object::get_name()
IL_0026: ldstr "."
IL_002b: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0030: ldarg.0
IL_0031: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_0036: ret
IL_0037: ldarg.0
IL_0038: call System.Void SoftSpriteMaskStrengthOnCollision2D::KillTween()
IL_003d: ldloc.0
IL_003e: ldarg.0
IL_003f: ldfld SoftSpriteMask SoftSpriteMaskStrengthOnCollision2D::softMask
IL_0044: ldfld System.Single SoftSpriteMask::strength
IL_0049: call System.Single UnityEngine.Mathf::Clamp01(System.Single)
IL_004e: stfld System.Single SoftSpriteMaskStrengthOnCollision2D/<>c__DisplayClass21_0::fromStrength
IL_0053: ldarg.2
IL_0054: ldc.r4 0
IL_0059: bgt.un.s IL_0070
IL_005b: ldarg.0
IL_005c: ldfld System.Boolean SoftSpriteMaskStrengthOnCollision2D::snapIfDurationZero
IL_0061: brfalse.s IL_0070
IL_0063: ldarg.0
IL_0064: ldfld SoftSpriteMask SoftSpriteMaskStrengthOnCollision2D::softMask
IL_0069: ldarg.1
IL_006a: stfld System.Single SoftSpriteMask::strength
IL_006f: ret
IL_0070: ldarg.0
IL_0071: ldloc.0
IL_0072: ldftn System.Single SoftSpriteMaskStrengthOnCollision2D/<>c__DisplayClass21_0::<AnimateTo>b__0()
IL_0078: newobj System.Void DG.Tweening.Core.DOGetter`1<System.Single>::.ctor(System.Object,System.IntPtr)
IL_007d: ldloc.0
IL_007e: ldftn System.Void SoftSpriteMaskStrengthOnCollision2D/<>c__DisplayClass21_0::<AnimateTo>b__1(System.Single)
IL_0084: newobj System.Void DG.Tweening.Core.DOSetter`1<System.Single>::.ctor(System.Object,System.IntPtr)
IL_0089: ldarg.1
IL_008a: ldc.r4 0
IL_008f: ldarg.2
IL_0090: call System.Single UnityEngine.Mathf::Max(System.Single,System.Single)
IL_0095: call DG.Tweening.Core.TweenerCore`3<System.Single,System.Single,DG.Tweening.Plugins.Options.FloatOptions> DG.Tweening.DOTween::To(DG.Tweening.Core.DOGetter`1<System.Single>,DG.Tweening.Core.DOSetter`1<System.Single>,System.Single,System.Single)
IL_009a: ldarg.3
IL_009b: call !!0 DG.Tweening.TweenSettingsExtensions::SetEase<DG.Tweening.Core.TweenerCore`3<System.Single,System.Single,DG.Tweening.Plugins.Options.FloatOptions>>(!!0,DG.Tweening.Ease)
IL_00a0: ldarg.0
IL_00a1: ldfld System.Boolean SoftSpriteMaskStrengthOnCollision2D::useUnscaledTime
IL_00a6: call !!0 DG.Tweening.TweenSettingsExtensions::SetUpdate<DG.Tweening.Core.TweenerCore`3<System.Single,System.Single,DG.Tweening.Plugins.Options.FloatOptions>>(!!0,System.Boolean)
IL_00ab: ldarg.0
IL_00ac: call !!0 DG.Tweening.TweenSettingsExtensions::SetTarget<DG.Tweening.Core.TweenerCore`3<System.Single,System.Single,DG.Tweening.Plugins.Options.FloatOptions>>(!!0,System.Object)
IL_00b1: stfld DG.Tweening.Tween SoftSpriteMaskStrengthOnCollision2D::_tween
IL_00b6: ret
METHOD System.Void SoftSpriteMaskStrengthOnCollision2D::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean SoftSpriteMaskStrengthOnCollision2D::useLayerMask
IL_0007: ldarg.0
IL_0008: ldc.i4.m1
IL_0009: call UnityEngine.LayerMask UnityEngine.LayerMask::op_Implicit(System.Int32)
IL_000e: stfld UnityEngine.LayerMask SoftSpriteMaskStrengthOnCollision2D::affectLayers
IL_0013: ldarg.0
IL_0014: ldstr ""
IL_0019: stfld System.String SoftSpriteMaskStrengthOnCollision2D::requiredTag
IL_001e: ldarg.0
IL_001f: ldc.r4 1
IL_0024: stfld System.Single SoftSpriteMaskStrengthOnCollision2D::targetStrength
IL_0029: ldarg.0
IL_002a: ldc.r4 0.25
IL_002f: stfld System.Single SoftSpriteMaskStrengthOnCollision2D::enterDuration
IL_0034: ldarg.0
IL_0035: ldc.r4 0.25
IL_003a: stfld System.Single SoftSpriteMaskStrengthOnCollision2D::exitDuration
IL_003f: ldarg.0
IL_0040: ldc.i4.6
IL_0041: stfld DG.Tweening.Ease SoftSpriteMaskStrengthOnCollision2D::enterEase
IL_0046: ldarg.0
IL_0047: ldc.i4.6
IL_0048: stfld DG.Tweening.Ease SoftSpriteMaskStrengthOnCollision2D::exitEase
IL_004d: ldarg.0
IL_004e: ldc.i4.1
IL_004f: stfld System.Boolean SoftSpriteMaskStrengthOnCollision2D::snapIfDurationZero
IL_0054: ldarg.0
IL_0055: call System.Void UnityEngine.MonoBehaviour::.ctor()
IL_005a: ret
