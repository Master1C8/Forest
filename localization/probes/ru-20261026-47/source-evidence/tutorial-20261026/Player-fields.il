TYPE TheForestOfLove.Player BASE TheForestOfLove.Gameplay.SpawnableActor
FIELD System.Boolean TheForestOfLove.Player::debugToggleLanternEquip
FIELD UnityEngine.ParticleSystem TheForestOfLove.Player::dustClouds
FIELD UnityEngine.ParticleSystem TheForestOfLove.Player::snowTracksL
FIELD UnityEngine.ParticleSystem TheForestOfLove.Player::snowTracksR
FIELD UnityEngine.ParticleSystem TheForestOfLove.Player::snowTracksLUp
FIELD UnityEngine.ParticleSystem TheForestOfLove.Player::snowTracksRUp
FIELD UnityEngine.ParticleSystem TheForestOfLove.Player::snowTracksH
FIELD UnityEngine.Vector2 TheForestOfLove.Player::speed
FIELD UnityEngine.Vector2 TheForestOfLove.Player::speedDeepWoods
FIELD UnityEngine.Vector2 TheForestOfLove.Player::speedSwimming
FIELD UnityEngine.Vector2 TheForestOfLove.Player::speedDashing
FIELD System.Single TheForestOfLove.Player::singleStepThreshold
FIELD System.Single TheForestOfLove.Player::singleStepThresholdThumbstick
FIELD System.Single TheForestOfLove.Player::idleThresholdMs
FIELD System.Single TheForestOfLove.Player::pointArrivalDelta
FIELD System.Single TheForestOfLove.Player::nudgeFactorWalking
FIELD System.Single TheForestOfLove.Player::nudgeFactorDashing
FIELD System.Single TheForestOfLove.Player::nudgeFactorSwimming
FIELD System.Single TheForestOfLove.Player::nudgeFactorWaypoints
FIELD System.Single TheForestOfLove.Player::currentNudgeFactor
FIELD UnityEngine.RuntimeAnimatorController TheForestOfLove.Player::defaultAnimatorController
FIELD UnityEngine.RuntimeAnimatorController TheForestOfLove.Player::sweaterAnimatorController
FIELD UnityEngine.RuntimeAnimatorController TheForestOfLove.Player::lanternAnimatorController
FIELD TheForestOfLove.SpriteRendererAlphaGroup TheForestOfLove.Player::lanternAlphaController
FIELD System.Single TheForestOfLove.Player::lanternAlphaDelayEquip
FIELD System.Single TheForestOfLove.Player::lanternAlphaDelayUnequip
FIELD System.Single TheForestOfLove.Player::lanternAlphaFadeTime
FIELD System.Boolean TheForestOfLove.Player::<sweaterEquipped>k__BackingField
FIELD System.Boolean TheForestOfLove.Player::<sweaterTransitioning>k__BackingField
FIELD System.Boolean TheForestOfLove.Player::<lanternEquipped>k__BackingField
FIELD System.Boolean TheForestOfLove.Player::<lanternTransitioning>k__BackingField
FIELD TheForestOfLove.PlayerSwimTransition TheForestOfLove.Player::playerSwimTransitionPrefab
FIELD TheForestOfLove.PlayerSwimTransition TheForestOfLove.Player::playerSwimTransition
FIELD TheForestOfLove.PlayerState TheForestOfLove.Player::<playerState>k__BackingField
FIELD TheForestOfLove.WaypointController TheForestOfLove.Player::<waypointController>k__BackingField
FIELD System.Boolean TheForestOfLove.Player::<canInteract>k__BackingField
FIELD TheForestOfLove.TerrainType TheForestOfLove.Player::defaultTerrainType
FIELD TheForestOfLove.TerrainType TheForestOfLove.Player::<currentTerrainType>k__BackingField
FIELD UnityEngine.Collider2D TheForestOfLove.Player::<footSensor>k__BackingField
FIELD UnityEngine.Transform TheForestOfLove.Player::woolSensor
FIELD UnityEngine.Transform TheForestOfLove.Player::windSensor
FIELD UnityEngine.Transform TheForestOfLove.Player::stormQuestPageCollectionSensor
FIELD System.Single TheForestOfLove.Player::timeBetweenStepSoundsWalking
FIELD System.Single TheForestOfLove.Player::timeBetweenSnowTracksWalking
FIELD System.Single TheForestOfLove.Player::stepSoundTimerStartPhase
FIELD System.Single TheForestOfLove.Player::snowTrackTimerStartPhase
FIELD System.Single TheForestOfLove.Player::timeSinceLastStepSound
FIELD System.Single TheForestOfLove.Player::timeSinceLastSnowTrack
FIELD TheForestOfLove.Player TheForestOfLove.Player::current
FIELD System.Boolean TheForestOfLove.Player::<isDashrollUnlocked>k__BackingField
FIELD System.Int32 TheForestOfLove.Player::maxConsecutiveDashes
FIELD System.Single TheForestOfLove.Player::dashCooldownTime
FIELD UnityEngine.Vector2 TheForestOfLove.Player::multiDashTimingThreshold
FIELD System.Boolean TheForestOfLove.Player::multiDashCurrentlyWithinTimingThreshold
FIELD System.Boolean TheForestOfLove.Player::multiDashIsQueued
FIELD System.Boolean TheForestOfLove.Player::isEligibleForMultiDash
FIELD System.Int32 TheForestOfLove.Player::currentUsedDashes
FIELD System.Single TheForestOfLove.Player::dashCooldownTimeRemaining
FIELD System.Single TheForestOfLove.Player::endDashEarlyTargetFrame
FIELD System.Single TheForestOfLove.Player::endDashEarlyTotalFrames
FIELD UnityEngine.Transform TheForestOfLove.Player::dashingMotionTransform
FIELD UnityEngine.Events.UnityEvent TheForestOfLove.Player::onDashrollStarted
FIELD UnityEngine.Events.UnityEvent TheForestOfLove.Player::onDashrollFinished
FIELD System.Boolean TheForestOfLove.Player::isSlashUnlockedDebug
FIELD System.Boolean TheForestOfLove.Player::<isSlashUnlocked>k__BackingField
FIELD System.Int32 TheForestOfLove.Player::maxConsecutiveSlashes
FIELD System.Single TheForestOfLove.Player::slashCooldownTime
FIELD UnityEngine.Vector2 TheForestOfLove.Player::multiSlashTimingThreshold
FIELD System.Boolean TheForestOfLove.Player::multiSlashCurrentlyWithinTimingThreshold
FIELD System.Boolean TheForestOfLove.Player::multiSlashIsQueued
FIELD System.Boolean TheForestOfLove.Player::isEligibleForMultiSlash
FIELD System.Int32 TheForestOfLove.Player::currentUsedSlashes
FIELD System.Single TheForestOfLove.Player::slashCooldownTimeRemaining
FIELD System.Single TheForestOfLove.Player::endSlashEarlyTargetFrame
FIELD System.Single TheForestOfLove.Player::endSlashEarlyTotalFrames
FIELD UnityEngine.Transform TheForestOfLove.Player::slashingMotionTransform
FIELD System.Single TheForestOfLove.Player::nudgeFactorSlashing
FIELD UnityEngine.Events.UnityEvent TheForestOfLove.Player::onSlashStarted
FIELD UnityEngine.Events.UnityEvent TheForestOfLove.Player::onSlashFinished
FIELD UnityEngine.Events.UnityEvent TheForestOfLove.Player::onSlashImpact
FIELD System.Boolean TheForestOfLove.Player::swimmingSuperStroke
FIELD UnityEngine.Vector3 TheForestOfLove.Player::swimmingSuperStrokeSpeed
FIELD System.Single TheForestOfLove.Player::swimmingSuperStrokeCommitThreshold
FIELD System.Single TheForestOfLove.Player::swimmingSuperStrokeResetThreshold
FIELD UnityEngine.Transform TheForestOfLove.Player::swimmingMotionTransform
FIELD System.Single TheForestOfLove.Player::swimmingNoInputCooldownTime
FIELD System.Single TheForestOfLove.Player::swimmingNoInputCooldownTimeRemaining
FIELD System.Boolean TheForestOfLove.Player::swimmingSynchronizeFreshInput
FIELD System.Int32 TheForestOfLove.Player::maxConsecutiveSuperStrokes
FIELD System.Single TheForestOfLove.Player::superStrokeCooldownTime
FIELD System.Int32 TheForestOfLove.Player::currentUsedSuperStrokes
FIELD System.Single TheForestOfLove.Player::superStrokeCooldownTimeRemaining
FIELD System.Boolean TheForestOfLove.Player::swimmingSuperStrokeJustReset
FIELD System.Boolean TheForestOfLove.Player::swimmingSuperStrokeAllowQueuing
FIELD UnityEngine.Vector2 TheForestOfLove.Player::swimmingSuperStrokeQueueThreshold
FIELD System.Single TheForestOfLove.Player::swimIdleThresholdMs
FIELD System.Single TheForestOfLove.Player::swimIdleTime
FIELD System.Boolean TheForestOfLove.Player::swimmingReadyForNewStrokeSound
FIELD System.Boolean TheForestOfLove.Player::swimFinishStroke
FIELD System.Single TheForestOfLove.Player::swimmingNormalizedTime
FIELD System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
FIELD System.Single TheForestOfLove.Player::idleTime
FIELD UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
FIELD UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
FIELD UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
FIELD UnityEngine.SpriteRenderer TheForestOfLove.Player::shadowSpriteRenderer
FIELD UnityEngine.SpriteRenderer TheForestOfLove.Player::syncedMainSpriteRenderer
FIELD UnityEngine.SpriteRenderer TheForestOfLove.Player::syncedLanternSpriteRenderer
FIELD UnityEngine.SpriteRenderer TheForestOfLove.Player::syncedReflectionSpriteRenderer
FIELD UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
FIELD System.Boolean TheForestOfLove.Player::enableMovement
FIELD UnityEngine.Vector3 TheForestOfLove.Player::lastNonzeroXAxisInput
FIELD System.Boolean TheForestOfLove.Player::flipAnimatorVectorY
FIELD System.Boolean TheForestOfLove.Player::delayAllowNewConversations
FIELD System.Single TheForestOfLove.Player::delayAllowNewConversationsElapsedSeconds
FIELD System.Single TheForestOfLove.Player::delayAllowNewConversationsThresholdSeconds
FIELD System.Boolean TheForestOfLove.Player::waitedOneUpdateToClearInput
FIELD UnityEngine.Vector2 TheForestOfLove.Player::lastFullAxis
FIELD System.String TheForestOfLove.Player::lastSetTrigger
FIELD System.String TheForestOfLove.Player::TRIGGER_WALK = trigger_walk
FIELD System.String TheForestOfLove.Player::TRIGGER_REST = trigger_rest
FIELD System.String TheForestOfLove.Player::TRIGGER_REST_INSTANTLY = trigger_rest_instantly
FIELD System.String TheForestOfLove.Player::TRIGGER_SLEEP_INTROFOREST = trigger_sleep_introforest
FIELD System.String TheForestOfLove.Player::TRIGGER_SLEEP = trigger_sleep
FIELD System.String TheForestOfLove.Player::TRIGGER_WAKEUP = trigger_wakeup
FIELD System.String TheForestOfLove.Player::TRIGGER_IDLE = trigger_idle
FIELD System.String TheForestOfLove.Player::TRIGGER_IDLE_BRACE = trigger_idle_brace
FIELD System.String TheForestOfLove.Player::TRIGGER_SWIMMING = trigger_swimming
FIELD System.String TheForestOfLove.Player::TRIGGER_SWIM_IDLE = trigger_swim_idle
FIELD System.String TheForestOfLove.Player::TRIGGER_DASHING = trigger_dashing
FIELD System.String TheForestOfLove.Player::TRIGGER_BELLRING = trigger_bellring
FIELD System.String TheForestOfLove.Player::TRIGGER_BELLRING_REDBELL = trigger_bellring_redbell
FIELD System.String TheForestOfLove.Player::TRIGGER_BELLRING_GREENBELL = trigger_bellring_greenbell
FIELD System.String TheForestOfLove.Player::TRIGGER_BELLRING_PURPLEBELL = trigger_bellring_purplebell
FIELD System.String TheForestOfLove.Player::TRIGGER_SLASHING = trigger_slash
FIELD System.String TheForestOfLove.Player::BOOL_USE_BONUS_SWIPE = use_bonus_swipe
FIELD System.Boolean TheForestOfLove.Player::dashingEnding
FIELD UnityEngine.Vector3 TheForestOfLove.Player::dashingInput
FIELD System.Boolean TheForestOfLove.Player::swimmingEnding
FIELD UnityEngine.Vector3 TheForestOfLove.Player::swimmingInput
FIELD System.Boolean TheForestOfLove.Player::slashingEnding
FIELD UnityEngine.Vector3 TheForestOfLove.Player::slashingInput
FIELD TheForestOfLove.AnimationStateEventListener TheForestOfLove.Player::animationStateEventListener
FIELD TheForestOfLove.AnimationStateEventListener TheForestOfLove.Player::lanternAnimationStateEventListener
FIELD System.Boolean TheForestOfLove.Player::enteringDoorway
FIELD UnityEngine.Color TheForestOfLove.Player::COLOR_WHITE_OPAQUE
FIELD UnityEngine.Color TheForestOfLove.Player::COLOR_WHITE_TRANSPARENT
FIELD System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::<SyncedAnimators>k__BackingField
FIELD System.Boolean TheForestOfLove.Player::manualToggleIdleBrace
FIELD TheForestOfLove.Direction TheForestOfLove.Player::animatorDirection
FIELD System.Boolean TheForestOfLove.Player::snowTracksLastL
PROPERTY System.Boolean TheForestOfLove.Player::sweaterEquipped()
PROPERTY System.Boolean TheForestOfLove.Player::sweaterTransitioning()
PROPERTY System.Boolean TheForestOfLove.Player::lanternEquipped()
PROPERTY System.Boolean TheForestOfLove.Player::lanternTransitioning()
PROPERTY TheForestOfLove.PlayerState TheForestOfLove.Player::playerState()
PROPERTY TheForestOfLove.WaypointController TheForestOfLove.Player::waypointController()
PROPERTY System.Boolean TheForestOfLove.Player::canInteract()
PROPERTY TheForestOfLove.TerrainType TheForestOfLove.Player::currentTerrainType()
PROPERTY UnityEngine.Collider2D TheForestOfLove.Player::footSensor()
PROPERTY System.Boolean TheForestOfLove.Player::IsDashing()
PROPERTY System.Boolean TheForestOfLove.Player::isDashrollUnlocked()
PROPERTY System.Boolean TheForestOfLove.Player::IsSlashing()
PROPERTY System.Boolean TheForestOfLove.Player::isSlashUnlocked()
PROPERTY System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::SyncedAnimators()
