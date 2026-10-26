using System;
using UnityEngine;

namespace PixelCrushers.DialogueSystem;

public abstract class AbstractDialogueUI : MonoBehaviour, IDialogueUI
{
	private bool m_hasOpenedBefore;

	public abstract AbstractUIRoot uiRootControls { get; }

	public abstract AbstractDialogueUIControls dialogueControls { get; }

	public abstract AbstractUIQTEControls qteControls { get; }

	public abstract AbstractUIAlertControls alertControls { get; }

	public bool isOpen { get; set; }

	public bool IsOpen
	{
		get
		{
			return isOpen;
		}
		set
		{
			isOpen = value;
		}
	}

	protected virtual bool AreNonDialogueControlsVisible
	{
		get
		{
			if (!alertControls.isVisible)
			{
				return qteControls.areVisible;
			}
			return true;
		}
	}

	public event EventHandler<SelectedResponseEventArgs> SelectedResponseHandler;

	public virtual void Awake()
	{
		isOpen = false;
		this.SelectedResponseHandler = null;
	}

	public virtual void Start()
	{
		if (uiRootControls == null || dialogueControls == null || qteControls == null || alertControls == null)
		{
			base.enabled = false;
			return;
		}
		uiRootControls.Show();
		if (!isOpen)
		{
			dialogueControls.Hide();
		}
		qteControls.Hide();
		if (!alertControls.isVisible)
		{
			alertControls.Hide();
		}
		if (isOpen)
		{
			Open();
		}
		if (!alertControls.isVisible && !isOpen)
		{
			uiRootControls.Hide();
		}
	}

	public virtual void Open()
	{
		m_hasOpenedBefore = true;
		dialogueControls.ShowPanel();
		uiRootControls.Show();
		isOpen = true;
	}

	public virtual void Close()
	{
		dialogueControls.Hide();
		if (!AreNonDialogueControlsVisible)
		{
			uiRootControls.Hide();
		}
		isOpen = false;
	}

	public virtual void ShowAlert(string message, float duration)
	{
		if (!isOpen)
		{
			if (!m_hasOpenedBefore)
			{
				dialogueControls.Hide();
			}
			uiRootControls.Show();
		}
		alertControls.ShowMessage(message, duration);
	}

	public virtual void HideAlert()
	{
		if (alertControls.isVisible)
		{
			alertControls.Hide();
			if (!isOpen && !qteControls.areVisible)
			{
				uiRootControls.Hide();
			}
		}
	}

	public virtual void Update()
	{
		if (alertControls.isVisible && alertControls.IsDone)
		{
			alertControls.Hide();
		}
	}

	public virtual void ShowSubtitle(Subtitle subtitle)
	{
		SetSubtitle(subtitle, value: true);
	}

	public virtual void HideSubtitle(Subtitle subtitle)
	{
		SetSubtitle(subtitle, value: false);
	}

	public virtual void ShowContinueButton(Subtitle subtitle)
	{
		GetSubtitleControls(subtitle)?.ShowContinueButton();
	}

	public virtual void HideContinueButton(Subtitle subtitle)
	{
		GetSubtitleControls(subtitle)?.HideContinueButton();
	}

	protected virtual void SetSubtitle(Subtitle subtitle, bool value)
	{
		AbstractUISubtitleControls subtitleControls = GetSubtitleControls(subtitle);
		if (subtitleControls != null)
		{
			if (value)
			{
				subtitleControls.ShowSubtitle(subtitle);
			}
			else
			{
				subtitleControls.Hide();
			}
		}
	}

	private AbstractUISubtitleControls GetSubtitleControls(Subtitle subtitle)
	{
		if (subtitle != null)
		{
			if (subtitle.speakerInfo.characterType != CharacterType.NPC)
			{
				return dialogueControls.pcSubtitleControls;
			}
			return dialogueControls.npcSubtitleControls;
		}
		return null;
	}

	public virtual void ShowResponses(Subtitle subtitle, Response[] responses, float timeout)
	{
		try
		{
			if (dialogueControls == null)
			{
				Debug.LogError("Dialogue System: In ShowResponses(): The dialogue UI's main dialogue controls field is not set.", this);
				return;
			}
			if (dialogueControls.responseMenuControls == null)
			{
				Debug.LogError("Dialogue System: In ShowResponses(): The dialogue UI's response menu controls field is not set.", this);
				return;
			}
			if (base.transform == null)
			{
				Debug.LogError("Dialogue System: In ShowResponses(): The dialogue UI's transform is null.", this);
				return;
			}
			dialogueControls.responseMenuControls.ShowResponses(subtitle, responses, base.transform);
			if (timeout > 0f)
			{
				dialogueControls.responseMenuControls.StartTimer(timeout);
			}
		}
		catch (NullReferenceException ex)
		{
			Debug.LogError("Dialogue System: In ShowResponses(): " + ex.Message);
		}
	}

	public virtual void HideResponses()
	{
		dialogueControls.responseMenuControls.Hide();
	}

	public virtual void ShowQTEIndicator(int index)
	{
		qteControls.ShowIndicator(index);
	}

	public virtual void HideQTEIndicator(int index)
	{
		qteControls.HideIndicator(index);
	}

	public virtual void OnClick(object data)
	{
		if (this.SelectedResponseHandler != null)
		{
			this.SelectedResponseHandler(this, new SelectedResponseEventArgs(data as Response));
		}
	}

	public virtual void OnContinue()
	{
		OnContinueAlert();
		OnContinueConversation();
	}

	public virtual void OnContinueAlert()
	{
		if (alertControls.isVisible)
		{
			HideAlert();
		}
	}

	public virtual void OnContinueConversation()
	{
		if (isOpen)
		{
			DialogueManager.instance.SendMessage("OnConversationContinue", this, SendMessageOptions.DontRequireReceiver);
		}
	}

	public virtual void SetPCPortrait(Sprite portraitSprite, string portraitName)
	{
		dialogueControls.responseMenuControls.SetPCPortrait(portraitSprite, portraitName);
	}

	[Obsolete("Use SetPCPortrait(Sprite,string) instead.")]
	public virtual void SetPCPortrait(Texture2D portraitTexture, string portraitName)
	{
		dialogueControls.responseMenuControls.SetPCPortrait(UITools.CreateSprite(portraitTexture), portraitName);
	}

	public virtual void SetActorPortraitSprite(string actorName, Sprite portraitSprite)
	{
		dialogueControls.npcSubtitleControls.SetActorPortraitSprite(actorName, portraitSprite);
		dialogueControls.pcSubtitleControls.SetActorPortraitSprite(actorName, portraitSprite);
		dialogueControls.responseMenuControls.SetActorPortraitSprite(actorName, portraitSprite);
	}

	public static Sprite GetValidPortraitSprite(string actorName, Sprite portraitSprite)
	{
		if (portraitSprite != null)
		{
			return portraitSprite;
		}
		return DialogueManager.masterDatabase.GetActor(actorName)?.GetPortraitSprite();
	}

	[Obsolete("Use GetValidPortraitSprite instead.")]
	public static Texture2D GetValidPortraitTexture(string actorName, Texture2D portraitTexture)
	{
		if (portraitTexture != null)
		{
			return portraitTexture;
		}
		return DialogueManager.masterDatabase.GetActor(actorName)?.portrait;
	}
}
You are not using the latest version of the tool, please update.
Latest version is '11.1.0.9782' (yours is '9.1.0.7988')
