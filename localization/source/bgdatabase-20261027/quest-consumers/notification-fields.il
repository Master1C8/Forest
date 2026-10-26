TYPE TheForestOfLove.QuestUpdatedUI BASE TheForestOfLove.Core.BaseBehavior
FIELD System.String TheForestOfLove.QuestUpdatedUI::PATH_TOP_LEVEL_ANIMATOR = UiContainer/AnimatorContainer
FIELD System.String TheForestOfLove.QuestUpdatedUI::PATH_OLD_STEP_TEXT_CONTAINER = UiContainer/AnimatorContainer/OldObjTextContainer
FIELD System.String TheForestOfLove.QuestUpdatedUI::PATH_NEW_STEP_TEXT_CONTAINER = UiContainer/AnimatorContainer/NewObjTextContainer
FIELD System.String TheForestOfLove.QuestUpdatedUI::PATH_CHECKMARK_ANIMATOR = UiContainer/Checkmark
FIELD System.String TheForestOfLove.QuestUpdatedUI::ANIMATOR_TRIGGER_SHOW = show
FIELD System.String TheForestOfLove.QuestUpdatedUI::ANIMATOR_TRIGGER_HIDE = hide
FIELD System.String TheForestOfLove.QuestUpdatedUI::ANIMATOR_CLIPNAME_PLAYING = QuestUpdated_Playing
FIELD UnityEngine.Animator TheForestOfLove.QuestUpdatedUI::animator
FIELD TheForestOfLove.AnimationStateEventListener TheForestOfLove.QuestUpdatedUI::animationStateEventListener
FIELD UnityEngine.Animator TheForestOfLove.QuestUpdatedUI::checkmarkAnimator
FIELD System.Collections.Generic.List`1<UnityEngine.UI.Text> TheForestOfLove.QuestUpdatedUI::oldStepLabels
FIELD System.Collections.Generic.List`1<UnityEngine.UI.Text> TheForestOfLove.QuestUpdatedUI::newStepLabels
FIELD System.Collections.Generic.Queue`1<TheForestOfLove.QuestUpdatedUI/QuestUpdateNode> TheForestOfLove.QuestUpdatedUI::queuedNotifications
FIELD System.Boolean TheForestOfLove.QuestUpdatedUI::visible
FIELD System.Boolean TheForestOfLove.QuestUpdatedUI::isNextQueuedNotificationScheduled
