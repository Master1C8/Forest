TYPE TheForestOfLove.Narrative.Actor
METHOD System.Void TheForestOfLove.Narrative.Actor::Introduce() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: call System.Boolean TheForestOfLove.Narrative.Actor::get_IsEncounteredOnce()
IL_000f: ldc.i4.0
IL_0010: ceq
IL_0012: ldarg.0
IL_0013: ldc.i4.1
IL_0014: call System.Void TheForestOfLove.Narrative.Actor::set_IsEncounteredOnce(System.Boolean)
IL_0019: ldarg.0
IL_001a: ldc.i4.1
IL_001b: call System.Void TheForestOfLove.Narrative.Actor::set_IsIntroduced(System.Boolean)
IL_0020: ldarg.0
IL_0021: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0026: brfalse.s IL_006d
IL_0028: ldarg.0
IL_0029: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_002e: ldarg.0
IL_002f: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0034: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioSpeciesKeyword
IL_0039: callvirt System.Boolean TheForestOfLove.Narrative.BioDetail::TryUnlockKeyword(TheForestOfLove.Narrative.BioKeyword)
IL_003e: pop
IL_003f: ldarg.0
IL_0040: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0045: ldarg.0
IL_0046: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_004b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioAgeKeyword
IL_0050: callvirt System.Boolean TheForestOfLove.Narrative.BioDetail::TryUnlockKeyword(TheForestOfLove.Narrative.BioKeyword)
IL_0055: pop
IL_0056: ldarg.0
IL_0057: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_005c: ldarg.0
IL_005d: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0062: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioRoleKeyword
IL_0067: callvirt System.Boolean TheForestOfLove.Narrative.BioDetail::TryUnlockKeyword(TheForestOfLove.Narrative.BioKeyword)
IL_006c: pop
IL_006d: brfalse.s IL_007a
IL_006f: ldsfld TheForestOfLove.Events.ActorEvent TheForestOfLove.Events.NarrativeEvents::onActorFirstEncountered
IL_0074: ldarg.0
IL_0075: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Actor>::Invoke(!0)
IL_007a: ldsfld TheForestOfLove.Events.ActorEvent TheForestOfLove.Events.NarrativeEvents::onActorIntroduced
IL_007f: ldarg.0
IL_0080: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Actor>::Invoke(!0)
IL_0085: ret
