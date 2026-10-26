using TheForestOfLove.Audio;
using TheForestOfLove.Cameras;
using TheForestOfLove.Core;
using TheForestOfLove.Core.Timing;
using TheForestOfLove.Events;
using TheForestOfLove.Events.TriggerHandlers;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace TheForestOfLove;

public class IntroForestCutscene : BaseBehavior
{
	public float fadeinSeconds;

	public float fadeoutSeconds;

	public Sprite sleepSprite;

	public CameraSettings initialCameraSettings;

	private float oldPlayerIdleThresholdMs;

	private float newPlayerIdleThresholdMs = 999f;

	private int cameraSettingsId;

	private new void Start()
	{
		base.Start();
		StartCutscene();
	}

	protected override void AddEventListeners()
	{
		base.AddEventListeners();
		Player.current.waypointController.onWaypointsAdded.AddListener(OnWaypointsAdded);
		Player.current.waypointController.onWaypointArrived.AddListener(OnWaypointArrived);
		Player.current.waypointController.onWaitTimeElapsed.AddListener(OnWaypointWaitTimeElapsed);
		Player.current.waypointController.onWaypointsFollowed.AddListener(OnWaypointsFollowed);
	}

	protected override void RemoveEventListeners()
	{
		base.RemoveEventListeners();
		if (Player.current != null)
		{
			Player.current.waypointController.onWaypointsAdded.RemoveListener(OnWaypointsAdded);
			Player.current.waypointController.onWaypointArrived.RemoveListener(OnWaypointArrived);
			Player.current.waypointController.onWaitTimeElapsed.RemoveListener(OnWaypointWaitTimeElapsed);
			Player.current.waypointController.onWaypointsFollowed.RemoveListener(OnWaypointsFollowed);
		}
	}

	private void OnWaypointArrived(Waypoint waypoint)
	{
		if (!string.IsNullOrWhiteSpace(waypoint.title))
		{
			QuestConversationHelper.targetConversationName = "NewGame_Intro";
			QuestConversationHelper.targetActorName = "Scarlett";
			QuestConversationHelper.preferredConversantActorName = "Narrator";
			switch (waypoint.title)
			{
			case "double_take":
				QuestConversationHelper.targetDialogueArcName = "red_double_take";
				QuestConversationHelper.StartConversation();
				break;
			case "familiar_rock":
				QuestConversationHelper.targetDialogueArcName = "red_recognizes_rock";
				QuestConversationHelper.usePreferredDirection = true;
				QuestConversationHelper.preferredPlayerDirection = Direction.Right;
				QuestConversationHelper.StartConversation();
				break;
			case "familiar_tree":
				QuestConversationHelper.targetDialogueArcName = "red_recognizes_tree";
				QuestConversationHelper.StartConversation();
				break;
			case "slow1":
				Player.current.speed *= 0.25f;
				QuestConversationHelper.targetDialogueArcName = "red_feeling_woozy";
				QuestConversationHelper.StartConversation();
				break;
			}
		}
	}

	private void OnWaypointWaitTimeElapsed(Waypoint waypoint)
	{
		string title = waypoint.title;
		if (title != null && title == "sleep")
		{
			Player.current.SleepIntroForest();
			CutsceneManager.FadeToBlack(fadeoutSeconds, EndCutscene);
		}
	}

	private void OnWaypointsAdded()
	{
	}

	private void OnWaypointsFollowed()
	{
	}

	private void StartCutscene()
	{
		CutsceneManager.InstantCinematicMode();
		oldPlayerIdleThresholdMs = Player.current.idleThresholdMs;
		Player.current.idleThresholdMs = newPlayerIdleThresholdMs;
		GameEvents.onCutsceneStart.Invoke();
		CutsceneManager.FadeFromBlack(2.5f, delegate
		{
			TimerHelper.StartTimer(2f, delegate
			{
				Player.current.waypointController.SetWaypoints(base.transform);
				TimerHelper.StartTimer(1f, delegate
				{
					cameraSettingsId = CameraController.current.PushSettingsAndLock(initialCameraSettings, applySpeedRelatedSettingsImmediately: true);
				});
			});
		});
	}

	private void EndCutscene()
	{
		CutsceneManager.ConstantBlack();
		TriggerHandlerAct1.OnFinishIntroForestCutscene();
		TimerHelper.StartTimer(0.5f, delegate
		{
			SoundManager.Play(SoundEffect.PennyCaw);
			MusicManager.FadeToVolume(0f, 2f);
			TimerHelper.StartTimer(2.25f, delegate
			{
				GameEvents.onCutsceneEnd.Invoke();
				SceneManager.LoadScene("BunnyHouse");
			});
		});
	}
}
You are not using the latest version of the tool, please update.
Latest version is '11.1.0.9782' (yours is '9.1.0.7988')
