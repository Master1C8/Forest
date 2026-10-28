TYPE MelodyPhotoFlipbookUI
METHOD System.Void MelodyPhotoFlipbookUI::FlipNextAP() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean MelodyPhotoFlipbookUI::isAnimating
IL_0007: ldarg.0
IL_0008: ldfld System.Int32 MelodyPhotoFlipbookUI::currentIndex
IL_000d: ldc.i4.1
IL_000e: add
IL_000f: ldarg.0
IL_0010: ldfld System.Collections.Generic.List`1<UnityEngine.Sprite> MelodyPhotoFlipbookUI::unlockedSprites
IL_0015: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.Sprite>::get_Count()
IL_001a: rem
IL_001b: stloc.0
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.UI.Image MelodyPhotoFlipbookUI::bottomImage
IL_0022: ldarg.0
IL_0023: ldfld System.Collections.Generic.List`1<UnityEngine.Sprite> MelodyPhotoFlipbookUI::unlockedSprites
IL_0028: ldloc.0
IL_0029: callvirt !0 System.Collections.Generic.List`1<UnityEngine.Sprite>::get_Item(System.Int32)
IL_002e: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_0033: ldarg.0
IL_0034: ldfld UnityEngine.UI.Image MelodyPhotoFlipbookUI::bottomImage
IL_0039: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_003e: callvirt System.Void UnityEngine.Transform::SetAsFirstSibling()
IL_0043: ldarg.0
IL_0044: ldfld UnityEngine.UI.Image MelodyPhotoFlipbookUI::dummy1Back
IL_0049: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_004e: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0053: brfalse.s IL_006b
IL_0055: ldarg.0
IL_0056: ldfld UnityEngine.UI.Image MelodyPhotoFlipbookUI::dummy1Back
IL_005b: ldarg.0
IL_005c: ldfld UnityEngine.UI.Image MelodyPhotoFlipbookUI::bottomImage
IL_0061: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0066: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_006b: ldarg.0
IL_006c: ldfld AnimationCreator.Core.AnimationPlayer MelodyPhotoFlipbookUI::animationPlayer
IL_0071: ldstr "FlipNext"
IL_0076: callvirt System.Void AnimationCreator.Core.AnimationPlayer::Play(System.String)
IL_007b: ret
METHOD System.Void MelodyPhotoFlipbookUI::FlipPrevAP() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean MelodyPhotoFlipbookUI::isAnimating
IL_0007: ldarg.0
IL_0008: ldfld System.Int32 MelodyPhotoFlipbookUI::currentIndex
IL_000d: ldc.i4.1
IL_000e: sub
IL_000f: ldarg.0
IL_0010: ldfld System.Collections.Generic.List`1<UnityEngine.Sprite> MelodyPhotoFlipbookUI::unlockedSprites
IL_0015: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.Sprite>::get_Count()
IL_001a: add
IL_001b: ldarg.0
IL_001c: ldfld System.Collections.Generic.List`1<UnityEngine.Sprite> MelodyPhotoFlipbookUI::unlockedSprites
IL_0021: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.Sprite>::get_Count()
IL_0026: rem
IL_0027: stloc.0
IL_0028: ldarg.0
IL_0029: ldfld UnityEngine.UI.Image MelodyPhotoFlipbookUI::bottomImage
IL_002e: ldarg.0
IL_002f: ldfld System.Collections.Generic.List`1<UnityEngine.Sprite> MelodyPhotoFlipbookUI::unlockedSprites
IL_0034: ldloc.0
IL_0035: callvirt !0 System.Collections.Generic.List`1<UnityEngine.Sprite>::get_Item(System.Int32)
IL_003a: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_003f: ldarg.0
IL_0040: ldfld UnityEngine.UI.Image MelodyPhotoFlipbookUI::bottomImage
IL_0045: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_004a: callvirt System.Void UnityEngine.Transform::SetAsFirstSibling()
IL_004f: ldarg.0
IL_0050: ldfld AnimationCreator.Core.AnimationPlayer MelodyPhotoFlipbookUI::animationPlayer
IL_0055: ldstr "FlipPrev"
IL_005a: callvirt System.Void AnimationCreator.Core.AnimationPlayer::Play(System.String)
IL_005f: ret
