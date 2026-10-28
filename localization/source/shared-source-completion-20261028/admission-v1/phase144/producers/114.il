TYPE TheForestOfLove.Narrative.Arc
METHOD System.Void TheForestOfLove.Narrative.Arc::SetStatusSkipped() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.Narrative.Arc::isSkipDisallowed
IL_0006: brfalse.s IL_001d
IL_0008: ldstr "unskippable arc was just skipped "
IL_000d: ldarg.0
IL_000e: ldfld System.String TheForestOfLove.Narrative.Arc::generatedName
IL_0013: call System.String System.String::Concat(System.String,System.String)
IL_0018: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_001d: ldarg.0
IL_001e: call TheForestOfLove.Narrative.ArcStatus TheForestOfLove.Narrative.Arc::get_status()
IL_0023: ldc.i4 200
IL_0028: bne.un.s IL_0040
IL_002a: call System.Boolean Globals::get_DevCommandActive()
IL_002f: brtrue.s IL_0040
IL_0031: ldsfld System.Boolean Globals::isChapterSelect
IL_0036: brtrue.s IL_0040
IL_0038: ldsfld System.Boolean Globals::isCheatCode
IL_003d: brtrue.s IL_0040
IL_003f: ret
IL_0040: ldarg.0
IL_0041: call TheForestOfLove.Narrative.ArcStatus TheForestOfLove.Narrative.Arc::get_status()
IL_0046: stloc.0
IL_0047: ldarg.0
IL_0048: ldc.i4 200
IL_004d: call TheForestOfLove.Narrative.ArcStatusRecord TheForestOfLove.Services.Persistence.DataService::GetArcStatusRecordByStatus(TheForestOfLove.Narrative.ArcStatus)
IL_0052: stfld TheForestOfLove.Narrative.ArcStatusRecord TheForestOfLove.Narrative.Arc::statusRecord
IL_0057: ldsfld TheForestOfLove.Events.ArcEvent TheForestOfLove.Events.NarrativeEvents::onArcStatusSkipped
IL_005c: ldarg.0
IL_005d: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Arc>::Invoke(!0)
IL_0062: ldsfld TheForestOfLove.Events.ArcStatusEvent TheForestOfLove.Events.NarrativeEvents::onArcStatusUpdated
IL_0067: ldarg.0
IL_0068: ldloc.0
IL_0069: ldarg.0
IL_006a: call TheForestOfLove.Narrative.ArcStatus TheForestOfLove.Narrative.Arc::get_status()
IL_006f: callvirt System.Void UnityEngine.Events.UnityEvent`3<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.ArcStatus,TheForestOfLove.Narrative.ArcStatus>::Invoke(!0,!1,!2)
IL_0074: ret
