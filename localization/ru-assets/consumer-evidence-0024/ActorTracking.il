TYPE TheForestOfLove.Narrative.ActorTrackingService
METHOD System.Void TheForestOfLove.Narrative.ActorTrackingService::OnDialogueLineBegin(TheForestOfLove.Narrative.Actor,System.String)
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Narrative.ActorTrackingService::actorDbNamesCurrentDialogue
IL_0006: ldarg.1
IL_0007: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_000c: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0011: pop
IL_0012: ret
