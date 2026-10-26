using Febucci.UI;
using PixelCrushers.DialogueSystem;
using TheForestOfLove.Audio;
using TheForestOfLove.Narrative;
using TheForestOfLove.Services;

namespace TheForestOfLove;

public class CustomTypewriterEffectTextMeshPro : TypewriterByCharacter
{
	private bool isThisInstanceRegistered;

	public string CurrentVisibleText { get; private set; }

	private void Awake()
	{
		RegisterServices();
		CurrentVisibleText = string.Empty;
	}

	private void OnDestroy()
	{
		UnregisterServices();
	}

	private new void OnEnable()
	{
		base.OnEnable();
		RegisterServices();
		onTypewriterStart.AddListener(OnTypewriterStart);
		onTextDisappeared.AddListener(OnTextDisappeared);
		onCharacterVisible.AddListener(OnCharacterVisible);
	}

	private new void OnDisable()
	{
		base.OnDisable();
		UnregisterServices();
		onTypewriterStart.RemoveListener(OnTypewriterStart);
		onTextDisappeared.RemoveListener(OnTextDisappeared);
		onCharacterVisible.RemoveListener(OnCharacterVisible);
	}

	private void RegisterServices()
	{
		if (!isThisInstanceRegistered)
		{
			isThisInstanceRegistered = true;
			ServiceLocator.Register(this);
		}
	}

	private void UnregisterServices()
	{
		if (isThisInstanceRegistered)
		{
			isThisInstanceRegistered = false;
			ServiceLocator.Unregister(this);
		}
	}

	private void OnTypewriterStart()
	{
		CurrentVisibleText = string.Empty;
	}

	private void OnTextDisappeared()
	{
		CurrentVisibleText = string.Empty;
	}

	private void OnCharacterVisible(char character)
	{
		CurrentVisibleText += character;
		PlayCharacterAudio(character);
	}

	protected void PlayCharacterAudio(char character)
	{
		if (!string.IsNullOrWhiteSpace(string.Empty + character) && DialogueService.IsDialoguePlaying)
		{
			SoundManager.PlayTypewriterSound(DialogueService.CurrentActorDbName);
		}
	}

	private void StopTypewriterAndClearText_Internal()
	{
		StopShowingText();
		if (base.TextAnimator != null)
		{
			base.TextAnimator.SetText(string.Empty, hideText: true);
		}
	}

	public static void StopTypewriterAndClearText()
	{
		CustomTypewriterEffectTextMeshPro customTypewriterEffectTextMeshPro = ServiceLocator.Get<CustomTypewriterEffectTextMeshPro>();
		if (customTypewriterEffectTextMeshPro != null)
		{
			customTypewriterEffectTextMeshPro.StopTypewriterAndClearText_Internal();
		}
	}

	public static void FastForwardTextOrAdvanceDialogue()
	{
		CustomTypewriterEffectTextMeshPro customTypewriterEffectTextMeshPro = ServiceLocator.Get<CustomTypewriterEffectTextMeshPro>();
		if (customTypewriterEffectTextMeshPro != null)
		{
			customTypewriterEffectTextMeshPro.FastForwardTextOrAdvanceDialogue_Internal();
		}
	}

	public void FastForwardTextOrAdvanceDialogue_Internal()
	{
		if (DialogueService.IsDialoguePlaying)
		{
			base.transform.parent.GetComponentInChildren<StandardUISubtitlePanel>().continueButton.onClick.Invoke();
		}
	}

	public static bool IsTyping()
	{
		CustomTypewriterEffectTextMeshPro customTypewriterEffectTextMeshPro = ServiceLocator.Get<CustomTypewriterEffectTextMeshPro>();
		if (customTypewriterEffectTextMeshPro != null)
		{
			return customTypewriterEffectTextMeshPro.isShowingText;
		}
		return false;
	}
}
You are not using the latest version of the tool, please update.
Latest version is '11.1.0.9782' (yours is '9.1.0.7988')
