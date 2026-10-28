TYPE TheForestOfLove.GalleryHintTutorial
METHOD System.Void TheForestOfLove.GalleryHintTutorial::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Narrative.Movie TheForestOfLove.StartScreenGalleryMenu::lastAttemptedMovie
IL_0005: call TheForestOfLove.Narrative.MovieRecord TheForestOfLove.Services.Persistence.DataService::GetMovieRecordByMovie(TheForestOfLove.Narrative.Movie)
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: brtrue.s IL_0011
IL_000e: ldnull
IL_000f: br.s IL_0017
IL_0011: ldloc.0
IL_0012: ldfld System.String TheForestOfLove.Narrative.MovieRecord::hintPhrase
IL_0017: stloc.1
IL_0018: ldloc.1
IL_0019: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_001e: brtrue.s IL_0033
IL_0020: ldstr "{0}

{1}"
IL_0025: ldsfld System.String TheForestOfLove.StartScreenGalleryMenu::lastAttemptedMovieIdentifierPhrase
IL_002a: ldloc.1
IL_002b: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0030: stloc.1
IL_0031: br.s IL_0039
IL_0033: ldstr "No hint available!"
IL_0038: stloc.1
IL_0039: ldarg.0
IL_003a: ldfld TMPro.TMP_Text TheForestOfLove.GalleryHintTutorial::labelRoot
IL_003f: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<TMPro.TMP_Text>()
IL_0044: stloc.2
IL_0045: ldc.i4.0
IL_0046: stloc.3
IL_0047: br.s IL_0056
IL_0049: ldloc.2
IL_004a: ldloc.3
IL_004b: ldelem.ref
IL_004c: ldloc.1
IL_004d: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0052: ldloc.3
IL_0053: ldc.i4.1
IL_0054: add
IL_0055: stloc.3
IL_0056: ldloc.3
IL_0057: ldloc.2
IL_0058: ldlen
IL_0059: conv.i4
IL_005a: blt.s IL_0049
IL_005c: ret
