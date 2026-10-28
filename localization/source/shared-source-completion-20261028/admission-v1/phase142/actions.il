TYPE TheForestOfLove.Narrative.NarrativeActions
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteDialogue(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByDbName(System.String)
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteDialogue(TheForestOfLove.Narrative.Dialogue)
IL_000b: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteDialogue(TheForestOfLove.Narrative.Dialogue) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Void TheForestOfLove.Narrative.Dialogue::SetStatusCompleted()
IL_0006: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::IntroduceActor(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::IntroduceActor(TheForestOfLove.Narrative.Actor)
IL_000b: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::IntroduceActor(TheForestOfLove.Narrative.Actor) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Void TheForestOfLove.Narrative.Actor::Introduce()
IL_0006: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::EncounterActor(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::EncounterActor(TheForestOfLove.Narrative.Actor)
IL_000b: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::EncounterActor(TheForestOfLove.Narrative.Actor) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Void TheForestOfLove.Narrative.Actor::Encounter()
IL_0006: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::LeftAlignActorPortraitsCurrentDialogue(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onArcTriggerLeftAlignPortraits
IL_0005: ldarg.0
IL_0006: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_000b: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::RightAlignActorPortraitsCurrentDialogue(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onArcTriggerRightAlignPortraits
IL_0005: ldarg.0
IL_0006: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_000b: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::ChangeFont(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onChangeFont
IL_0005: ldarg.0
IL_0006: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_000b: ret
