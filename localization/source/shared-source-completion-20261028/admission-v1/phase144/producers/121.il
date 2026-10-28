TYPE TheForestOfLove.Narrative.StoryManager
METHOD System.Void TheForestOfLove.Narrative.StoryManager::ForgetUnplayedSecondaryConversationArcs(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_0006: stloc.0
IL_0007: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.ActorTrackingService>()
IL_000c: stloc.1
IL_000d: ldloc.1
IL_000e: ldnull
IL_000f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0014: brfalse.s IL_002c
IL_0016: ldstr "actor tracking service not initialized for actor "
IL_001b: ldloc.0
IL_001c: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0021: call System.String System.String::Concat(System.String,System.String)
IL_0026: call System.Void UnityEngine.Debug::Log(System.Object)
IL_002b: ret
IL_002c: ldloc.1
IL_002d: callvirt System.Void TheForestOfLove.Narrative.ActorTrackingService::ForgetSecondaryConversations()
IL_0032: ret
METHOD System.Void TheForestOfLove.Narrative.StoryManager::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "Charlotte"
IL_000b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0010: stsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.StoryManager::DatesAlwaysPrioritizeSpecificCritters
IL_0015: ldnull
IL_0016: stsfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::selectedDateDialogue
IL_001b: ldc.i4.0
IL_001c: stsfld System.Boolean TheForestOfLove.Narrative.StoryManager::isPennyInvolvedInDate
IL_0021: ret
