TYPE TheForestOfLove.Narrative.DialogueService BASE TheForestOfLove.Core.BaseBehavior
FIELD PixelCrushers.DialogueSystem.DialogueSystemTrigger TheForestOfLove.Narrative.DialogueService::dialogueSystemTrigger
FIELD UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueStart
FIELD UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onLinkedDialogueStart
FIELD UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueFinish
FIELD UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueCancel
FIELD UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueEndFinishOrCancel
FIELD UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBegin
FIELD UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginDetailed
FIELD UnityEngine.Events.UnityEvent`1<System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBegin_AnyPassthruTitledLine
FIELD UnityEngine.Events.UnityEvent`1<System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBegin_AnyTextLine
FIELD UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginPlayer
FIELD UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginNarrator
FIELD UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginNpc
FIELD UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> TheForestOfLove.Narrative.DialogueService::onDialogueLineArcTriggerCheck
FIELD UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineEnd
FIELD UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle> TheForestOfLove.Narrative.DialogueService::onDialogueLineEndDetailed
FIELD UnityEngine.Events.UnityEvent`1<System.Collections.Generic.IEnumerable`1<System.String>> TheForestOfLove.Narrative.DialogueService::onDialogueResponseMenu
FIELD UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DialogueService::onConversationLineCurrentActorChanged
FIELD System.Boolean TheForestOfLove.Narrative.DialogueService::<IsDialoguePlaying>k__BackingField
FIELD System.Boolean TheForestOfLove.Narrative.DialogueService::<IsPlayerQuestionDialoguePlaying>k__BackingField
FIELD System.String TheForestOfLove.Narrative.DialogueService::<CurrentDialogueDbName>k__BackingField
FIELD TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::<CurrentDialogue>k__BackingField
FIELD System.String TheForestOfLove.Narrative.DialogueService::<CurrentDialoguePluginDbName>k__BackingField
FIELD System.String TheForestOfLove.Narrative.DialogueService::<CurrentArcName>k__BackingField
FIELD TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.DialogueService::<CurrentArc>k__BackingField
FIELD TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::<PrimaryActor>k__BackingField
FIELD TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::<InitialActor>k__BackingField
FIELD TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::<CurrentActor>k__BackingField
FIELD System.Boolean TheForestOfLove.Narrative.DialogueService::<IsPlayerResponseAvailable>k__BackingField
FIELD System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialogueService::responsesCache
FIELD System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::arcListCache
FIELD System.Boolean TheForestOfLove.Narrative.DialogueService::encounteredSpokenLineInCurrentDialogue
FIELD System.Int32 TheForestOfLove.Narrative.DialogueService::lastCurrentLineDialogueDbConversantId
FIELD PixelCrushers.DialogueSystem.OverrideDialogueUI TheForestOfLove.Narrative.DialogueService::overrideDialogueUI
FIELD System.String TheForestOfLove.Narrative.DialogueService::DYNAMIC_QUESTIONS_CONVO = system/dynamicConversation
FIELD System.String TheForestOfLove.Narrative.DialogueService::DYNAMIC_FASTTRAVEL_CONVO = system/fastTravel
FIELD System.String TheForestOfLove.Narrative.DialogueService::PASSTHROUGH_DIALOGUE_ENTRY = PASSTHROUGH
FIELD System.String TheForestOfLove.Narrative.DialogueService::DYNAMIC_ROOT = DYNAMICROOT
FIELD System.String TheForestOfLove.Narrative.DialogueService::DYNAMIC_QUESTIONS = DYNAMICQUESTIONS
FIELD System.String TheForestOfLove.Narrative.DialogueService::GENERIC_FAREWELL = GENERICFAREWELL
FIELD System.String TheForestOfLove.Narrative.DialogueService::FAST_TRAVEL_CANCEL = FASTTRAVELCANCEL
FIELD System.String TheForestOfLove.Narrative.DialogueService::FAST_TRAVEL_DYNAMIC_ROOT = FT_DYNAMIC_ROOT
FIELD System.String TheForestOfLove.Narrative.DialogueService::FAST_TRAVEL_CUSTOM_GREETING_ROOT = FT_CUSTOM_GREETING
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::IsDialoguePlaying()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::IsPlayerQuestionDialoguePlaying()
PROPERTY System.String TheForestOfLove.Narrative.DialogueService::CurrentDialogueDbName()
PROPERTY TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::CurrentDialogue()
PROPERTY System.String TheForestOfLove.Narrative.DialogueService::CurrentDialoguePluginDbName()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::HasCurrentDialogue()
PROPERTY System.String TheForestOfLove.Narrative.DialogueService::CurrentArcName()
PROPERTY TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.DialogueService::CurrentArc()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::HasCurrentArc()
PROPERTY System.String TheForestOfLove.Narrative.DialogueService::PrimaryActorDbName()
PROPERTY TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::PrimaryActor()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::HasPrimaryActor()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::IsPrimaryActorNarrator()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::IsPrimaryActorPlayer()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::IsPrimaryActorNpc()
PROPERTY System.String TheForestOfLove.Narrative.DialogueService::InitialActorDbName()
PROPERTY TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::InitialActor()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::HasInitialActor()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::IsInitialActorNarrator()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::IsInitialActorPlayer()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::IsInitialActorNpc()
PROPERTY System.String TheForestOfLove.Narrative.DialogueService::CurrentActorDbName()
PROPERTY TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::CurrentActor()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::HasCurrentActor()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::IsCurrentActorNarrator()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::IsCurrentActorPlayer()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::IsCurrentActorNpc()
PROPERTY System.Boolean TheForestOfLove.Narrative.DialogueService::IsPlayerResponseAvailable()
