TYPE TheForestOfLove.StartScreenGalleryMenu
METHOD System.Void TheForestOfLove.StartScreenGalleryMenu::ShowDefaultStorySelectionText() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.StartScreenGalleryMenuMovie[] TheForestOfLove.StartScreenGalleryMenu::storyOptions
IL_0006: ldlen
IL_0007: conv.i4
IL_0008: stloc.0
IL_0009: ldarg.0
IL_000a: call System.Boolean TheForestOfLove.StartScreenGalleryMenu::get_IsGlitchRascalPart1StoryUnlocked()
IL_000f: brtrue.s IL_0015
IL_0011: ldloc.0
IL_0012: ldc.i4.1
IL_0013: sub
IL_0014: stloc.0
IL_0015: ldarg.0
IL_0016: call System.Boolean TheForestOfLove.StartScreenGalleryMenu::get_IsMabelCumJarEasterEggStoryUnlocked()
IL_001b: brtrue.s IL_0021
IL_001d: ldloc.0
IL_001e: ldc.i4.1
IL_001f: sub
IL_0020: stloc.0
IL_0021: ldarg.0
IL_0022: ldfld TheForestOfLove.StartScreenGalleryMenuMovie TheForestOfLove.StartScreenGalleryMenu::storyLastSelected
IL_0027: ldnull
IL_0028: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_002d: brfalse.s IL_0051
IL_002f: ldarg.0
IL_0030: ldstr "Stories
<size=12>({0}/{1} unlocked)</size>"
IL_0035: ldarg.0
IL_0036: ldfld System.Int32 TheForestOfLove.StartScreenGalleryMenu::storiesUnlockedCount
IL_003b: box System.Int32
IL_0040: ldloc.0
IL_0041: box System.Int32
IL_0046: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_004b: call System.Void TheForestOfLove.StartScreenGalleryMenu::SetStorySelectionText(System.String)
IL_0050: ret
IL_0051: ldarg.0
IL_0052: ldstr "Stories"
IL_0057: call System.Void TheForestOfLove.StartScreenGalleryMenu::SetStorySelectionText(System.String)
IL_005c: ret
METHOD System.Void TheForestOfLove.StartScreenGalleryMenu::UpdateStorySelectionText(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.StartScreenGalleryMenuMovie[] TheForestOfLove.StartScreenGalleryMenu::storyOptions
IL_0006: ldlen
IL_0007: conv.i4
IL_0008: stloc.0
IL_0009: ldarg.0
IL_000a: call System.Boolean TheForestOfLove.StartScreenGalleryMenu::get_IsGlitchRascalPart1StoryUnlocked()
IL_000f: brtrue.s IL_0015
IL_0011: ldloc.0
IL_0012: ldc.i4.1
IL_0013: sub
IL_0014: stloc.0
IL_0015: ldarg.0
IL_0016: call System.Boolean TheForestOfLove.StartScreenGalleryMenu::get_IsMabelCumJarEasterEggStoryUnlocked()
IL_001b: brtrue.s IL_0021
IL_001d: ldloc.0
IL_001e: ldc.i4.1
IL_001f: sub
IL_0020: stloc.0
IL_0021: ldarg.0
IL_0022: ldstr "Stories
<size=12>({0}/{1} unlocked)</size>"
IL_0027: ldarg.0
IL_0028: ldfld System.Int32 TheForestOfLove.StartScreenGalleryMenu::storiesUnlockedCount
IL_002d: box System.Int32
IL_0032: ldloc.0
IL_0033: box System.Int32
IL_0038: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_003d: call System.Void TheForestOfLove.StartScreenGalleryMenu::SetStorySelectionText(System.String)
IL_0042: ret
METHOD System.Void TheForestOfLove.StartScreenGalleryMenu::ShowDefaultMovieSelectionText() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.StartScreenGalleryMenuMovie TheForestOfLove.StartScreenGalleryMenu::movieLastSelected
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_0037
IL_000e: ldarg.0
IL_000f: ldstr "Movies
<size=12>({0}/{1} unlocked)</size>"
IL_0014: ldarg.0
IL_0015: ldfld System.Int32 TheForestOfLove.StartScreenGalleryMenu::moviesUnlockedCount
IL_001a: box System.Int32
IL_001f: ldarg.0
IL_0020: ldfld TheForestOfLove.StartScreenGalleryMenuMovie[] TheForestOfLove.StartScreenGalleryMenu::movieOptions
IL_0025: ldlen
IL_0026: conv.i4
IL_0027: box System.Int32
IL_002c: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0031: call System.Void TheForestOfLove.StartScreenGalleryMenu::SetMovieSelectionText(System.String)
IL_0036: ret
IL_0037: ldarg.0
IL_0038: ldstr "Movies"
IL_003d: call System.Void TheForestOfLove.StartScreenGalleryMenu::SetMovieSelectionText(System.String)
IL_0042: ret
METHOD System.Void TheForestOfLove.StartScreenGalleryMenu::UpdateMovieSelectionText(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "Movies
<size=12>({0}/{1} unlocked)</size>"
IL_0006: ldarg.0
IL_0007: ldfld System.Int32 TheForestOfLove.StartScreenGalleryMenu::moviesUnlockedCount
IL_000c: box System.Int32
IL_0011: ldarg.0
IL_0012: ldfld TheForestOfLove.StartScreenGalleryMenuMovie[] TheForestOfLove.StartScreenGalleryMenu::movieOptions
IL_0017: ldlen
IL_0018: conv.i4
IL_0019: box System.Int32
IL_001e: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0023: call System.Void TheForestOfLove.StartScreenGalleryMenu::SetMovieSelectionText(System.String)
IL_0028: ret
METHOD System.String TheForestOfLove.StartScreenGalleryMenu::BuildLastAttemptedMovieIdentifierPhrase(System.Boolean,System.Int32,System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_0016
IL_0003: ldstr "Movie {0}"
IL_0008: ldarg.2
IL_0009: ldc.i4.1
IL_000a: add
IL_000b: box System.Int32
IL_0010: call System.String System.String::Format(System.String,System.Object)
IL_0015: ret
IL_0016: ldstr "Story {0}"
IL_001b: ldarg.3
IL_001c: ldc.i4.1
IL_001d: add
IL_001e: box System.Int32
IL_0023: call System.String System.String::Format(System.String,System.Object)
IL_0028: ret
