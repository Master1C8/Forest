using PixelCrushers.DialogueSystem;
using TMPro;
using TheForestOfLove.Core;
using TheForestOfLove.Events;
using TheForestOfLove.Narrative;
using TheForestOfLove.Services.Persistence;
using TheForestOfLove.Services.SceneManagement;
using UnityEngine;
using UnityEngine.UI;

namespace TheForestOfLove;

public class DialogueNameplateController : BaseBehavior
{
	public Transform nameplateRoot;

	public DialogueCanvasNarratorLayoutController dialogueCanvasNarratorLayoutController;

	private const string STANDARD_DIALOGUE_UI_HIERARCHY_PATH = "VN Template Standard Dialogue UI";

	public StandardDialogueUI standardDialogueUI;

	private CanvasGroup nameplateRootCanvasGroup;

	private string customNameplate;

	private bool customNameplateNextLineOnly;

	public TMP_Text dialogueBoxSubtitleTextTMPRO;

	public TMP_FontAsset fontMain;

	public TMP_FontAsset fontMouse;

	private bool setFontToMainNextLine;

	private bool setFontToMouseNextLine;

	private new void Awake()
	{
		base.Awake();
		nameplateRootCanvasGroup = nameplateRoot.gameObject.GetComponent<CanvasGroup>();
		nameplateRootCanvasGroup.alpha = 0f;
	}

	protected override void AddEventListeners()
	{
		base.AddEventListeners();
		GameEvents.onDialogueStart.AddListener(OnConversationStart_Handler);
		GameEvents.onDialogueEnd.AddListener(OnConversationEnd_Handler);
		DialogueService.onDialogueLineBeginDetailed.AddListener(OnConversationLine_Handler);
		NarrativeEvents.onArcTriggerUpdatePortraits.AddListener(OnConversationTriggerUpdatePortraits);
		NarrativeEvents.onChangeFont.AddListener(OnChangeFont);
	}

	protected override void RemoveEventListeners()
	{
		base.RemoveEventListeners();
		GameEvents.onDialogueStart.RemoveListener(OnConversationStart_Handler);
		GameEvents.onDialogueEnd.RemoveListener(OnConversationEnd_Handler);
		DialogueService.onDialogueLineBeginDetailed.RemoveListener(OnConversationLine_Handler);
		NarrativeEvents.onArcTriggerUpdatePortraits.RemoveListener(OnConversationTriggerUpdatePortraits);
		NarrativeEvents.onChangeFont.RemoveListener(OnChangeFont);
	}

	public void OnConversationStart_Handler()
	{
		if (standardDialogueUI.isOpen)
		{
			UpdateNameplate(null);
			ClearCustomNameplate();
			SetFontToMain();
		}
	}

	public void OnConversationEnd_Handler()
	{
		UpdateNameplate(null);
		ClearCustomNameplate();
		SetFontToMain();
	}

	public void OnConversationLine_Handler(TheForestOfLove.Narrative.Actor actor, Subtitle subtitle)
	{
		if (setFontToMainNextLine)
		{
			SetFontToMain();
		}
		else if (setFontToMouseNextLine)
		{
			SetFontToMouse();
		}
		if (standardDialogueUI.isOpen && (subtitle.sequence == null || !subtitle.sequence.ToLower().Contains("none")))
		{
			string actorDbName = actor?.dbName;
			UpdateNameplate(actorDbName);
		}
	}

	private void OnConversationTriggerUpdatePortraits(string command)
	{
		if (!Globals.DisableTriggeredEffects)
		{
			switch (command)
			{
			case "everyone":
				SetCustomNameplateNextLineOnly("(Everyone)");
				break;
			case "unison":
				SetCustomNameplateNextLineOnly("(Both)");
				break;
			}
		}
	}

	private void UpdateNameplate(string actorDbName)
	{
		if (!string.IsNullOrWhiteSpace(customNameplate))
		{
			nameplateRootCanvasGroup.alpha = 1f;
			Text[] componentsInChildren = nameplateRoot.GetComponentsInChildren<Text>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].text = customNameplate;
			}
			if (customNameplateNextLineOnly)
			{
				ClearCustomNameplate();
			}
		}
		else if (string.IsNullOrWhiteSpace(actorDbName))
		{
			nameplateRootCanvasGroup.alpha = 0f;
		}
		else if (actorDbName.ToLower().Contains("narrator"))
		{
			nameplateRootCanvasGroup.alpha = 0f;
		}
		else
		{
			if (actorDbName.ToLower().Contains("player"))
			{
				return;
			}
			TheForestOfLove.Narrative.Actor actorByDbName = DataService.GetActorByDbName(actorDbName);
			if (actorByDbName == null)
			{
				nameplateRootCanvasGroup.alpha = 0f;
				return;
			}
			nameplateRootCanvasGroup.alpha = 1f;
			string text = ((SceneHelper.inStartMenu || actorByDbName.IsIntroduced || QuestTriggerHelper.InAnyInstancedStory()) ? actorByDbName.NameplateName : "???");
			Text[] componentsInChildren = nameplateRoot.GetComponentsInChildren<Text>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].text = text;
			}
		}
	}

	public void SetCustomNameplateUntilCleared(string nameplate)
	{
		customNameplateNextLineOnly = false;
		customNameplate = nameplate;
	}

	public void SetCustomNameplateNextLineOnly(string nameplate)
	{
		customNameplateNextLineOnly = true;
		customNameplate = nameplate;
	}

	public void ClearCustomNameplate()
	{
		customNameplateNextLineOnly = false;
		customNameplate = null;
	}

	public void OnChangeFont(string fontName)
	{
		switch (fontName)
		{
		default:
			SetFontToMainNextLine();
			break;
		case "mouse":
			SetFontToMouseNextLine();
			break;
		}
	}

	private void SetFontToMainNextLine()
	{
		setFontToMainNextLine = true;
	}

	public void SetFontToMain()
	{
		setFontToMainNextLine = false;
		setFontToMouseNextLine = false;
		if (dialogueBoxSubtitleTextTMPRO != null)
		{
			dialogueBoxSubtitleTextTMPRO.text = string.Empty;
			dialogueBoxSubtitleTextTMPRO.font = fontMain;
			dialogueBoxSubtitleTextTMPRO.ForceMeshUpdate(ignoreActiveState: true, forceTextReparsing: true);
		}
	}

	private void SetFontToMouseNextLine()
	{
		setFontToMouseNextLine = true;
	}

	public void SetFontToMouse()
	{
		setFontToMainNextLine = false;
		setFontToMouseNextLine = false;
		if (dialogueBoxSubtitleTextTMPRO != null)
		{
			dialogueBoxSubtitleTextTMPRO.text = string.Empty;
			dialogueBoxSubtitleTextTMPRO.font = fontMouse;
			dialogueBoxSubtitleTextTMPRO.ForceMeshUpdate(ignoreActiveState: true, forceTextReparsing: true);
		}
	}
}
You are not using the latest version of the tool, please update.
Latest version is '11.1.0.9782' (yours is '9.1.0.7988')
