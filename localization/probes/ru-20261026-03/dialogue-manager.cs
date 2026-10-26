using System;
using UnityEngine;

namespace PixelCrushers.DialogueSystem;

public static class DialogueManager
{
	private static DialogueSystemController m_instance;

	public static DialogueSystemController instance
	{
		get
		{
			if (m_instance == null)
			{
				m_instance = UnityEngine.Object.FindObjectOfType<DialogueSystemController>();
			}
			return m_instance;
		}
	}

	public static bool hasInstance => instance != null;

	public static DatabaseManager databaseManager
	{
		get
		{
			if (!hasInstance)
			{
				return null;
			}
			return instance.databaseManager;
		}
	}

	public static DialogueDatabase masterDatabase
	{
		get
		{
			if (!hasInstance)
			{
				return null;
			}
			return instance.masterDatabase;
		}
	}

	public static IDialogueUI dialogueUI
	{
		get
		{
			if (!(instance != null))
			{
				return null;
			}
			return instance.dialogueUI;
		}
		set
		{
			instance.dialogueUI = value;
		}
	}

	public static DisplaySettings displaySettings
	{
		get
		{
			if (!hasInstance)
			{
				return null;
			}
			return instance.displaySettings;
		}
	}

	public static bool isConversationActive
	{
		get
		{
			if (!hasInstance)
			{
				return false;
			}
			return instance.isConversationActive;
		}
	}

	public static bool allowSimultaneousConversations
	{
		get
		{
			if (!hasInstance)
			{
				return false;
			}
			return instance.allowSimultaneousConversations;
		}
	}

	public static bool interruptActiveConversations
	{
		get
		{
			if (!hasInstance)
			{
				return false;
			}
			return instance.interruptActiveConversations;
		}
	}

	public static IsDialogueEntryValidDelegate isDialogueEntryValid
	{
		get
		{
			if (!hasInstance)
			{
				return null;
			}
			return instance.isDialogueEntryValid;
		}
		set
		{
			instance.isDialogueEntryValid = value;
		}
	}

	public static Action customResponseTimeoutHandler
	{
		get
		{
			if (!hasInstance)
			{
				return null;
			}
			return instance.customResponseTimeoutHandler;
		}
		set
		{
			instance.customResponseTimeoutHandler = value;
		}
	}

	public static GetInputButtonDownDelegate getInputButtonDown
	{
		get
		{
			if (!hasInstance)
			{
				return null;
			}
			return instance.getInputButtonDown;
		}
		set
		{
			instance.getInputButtonDown = value;
		}
	}

	public static Transform currentActor
	{
		get
		{
			if (!hasInstance)
			{
				return null;
			}
			return instance.currentActor;
		}
	}

	public static Transform currentConversant
	{
		get
		{
			if (!hasInstance)
			{
				return null;
			}
			return instance.currentConversant;
		}
	}

	public static ConversationState currentConversationState
	{
		get
		{
			if (!hasInstance)
			{
				return null;
			}
			return instance.currentConversationState;
		}
	}

	public static string lastConversationStarted
	{
		get
		{
			if (!hasInstance)
			{
				return string.Empty;
			}
			return instance.lastConversationStarted;
		}
	}

	public static int lastConversationID
	{
		get
		{
			if (!hasInstance)
			{
				return -1;
			}
			return instance.lastConversationID;
		}
	}

	public static ConversationController conversationController
	{
		get
		{
			if (!hasInstance)
			{
				return null;
			}
			return instance.conversationController;
		}
	}

	public static ConversationModel conversationModel
	{
		get
		{
			if (!hasInstance)
			{
				return null;
			}
			return instance.conversationModel;
		}
	}

	public static ConversationView conversationView
	{
		get
		{
			if (!hasInstance)
			{
				return null;
			}
			return instance.conversationView;
		}
	}

	public static DialogueDebug.DebugLevel debugLevel
	{
		get
		{
			if (!hasInstance)
			{
				return DialogueDebug.level;
			}
			return instance.debugLevel;
		}
		set
		{
			if (hasInstance)
			{
				instance.debugLevel = value;
			}
			DialogueDebug.level = value;
		}
	}

	public static bool allowLuaExceptions
	{
		get
		{
			if (!hasInstance)
			{
				return false;
			}
			return instance.allowLuaExceptions;
		}
		set
		{
			instance.allowLuaExceptions = value;
		}
	}

	public static DialogueSystemController Instance => instance;

	public static bool HasInstance => hasInstance;

	public static DatabaseManager DatabaseManager => databaseManager;

	public static DialogueDatabase MasterDatabase => masterDatabase;

	public static IDialogueUI DialogueUI
	{
		get
		{
			return dialogueUI;
		}
		set
		{
			dialogueUI = value;
		}
	}

	public static DisplaySettings DisplaySettings => displaySettings;

	public static bool IsConversationActive => isConversationActive;

	public static bool AllowSimultaneousConversations => allowSimultaneousConversations;

	public static IsDialogueEntryValidDelegate IsDialogueEntryValid
	{
		get
		{
			return isDialogueEntryValid;
		}
		set
		{
			isDialogueEntryValid = value;
		}
	}

	public static GetInputButtonDownDelegate GetInputButtonDown
	{
		get
		{
			return getInputButtonDown;
		}
		set
		{
			getInputButtonDown = value;
		}
	}

	public static Transform CurrentActor => currentActor;

	public static Transform CurrentConversant => currentConversant;

	public static ConversationState CurrentConversationState => currentConversationState;

	public static string LastConversationStarted => lastConversationStarted;

	public static int LastConversationID => lastConversationID;

	public static ConversationController ConversationController => conversationController;

	public static ConversationModel ConversationModel => conversationModel;

	public static ConversationView ConversationView => conversationView;

	public static DialogueDebug.DebugLevel DebugLevel
	{
		get
		{
			return debugLevel;
		}
		set
		{
			debugLevel = value;
		}
	}

	public static bool AllowLuaExceptions
	{
		get
		{
			return allowLuaExceptions;
		}
		set
		{
			allowLuaExceptions = value;
		}
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
	private static void InitStaticVariables()
	{
		m_instance = null;
	}

	public static void SetLanguage(string language)
	{
		if (hasInstance)
		{
			instance.SetLanguage(language);
		}
	}

	public static void SetDialogueSystemInput(bool value)
	{
		if (hasInstance)
		{
			instance.SetDialogueSystemInput(value);
		}
	}

	public static bool IsDialogueSystemInputDisabled()
	{
		if (!hasInstance)
		{
			return true;
		}
		return instance.IsDialogueSystemInputDisabled();
	}

	public static void AddDatabase(DialogueDatabase database)
	{
		if (hasInstance)
		{
			instance.AddDatabase(database);
		}
	}

	public static void RemoveDatabase(DialogueDatabase database)
	{
		if (hasInstance)
		{
			instance.RemoveDatabase(database);
		}
	}

	public static void ResetDatabase(DatabaseResetOptions databaseResetOptions)
	{
		if (hasInstance)
		{
			instance.ResetDatabase(databaseResetOptions);
		}
	}

	public static void ResetDatabase()
	{
		if (hasInstance)
		{
			instance.ResetDatabase();
		}
	}

	public static void PreloadMasterDatabase()
	{
		if (hasInstance)
		{
			instance.PreloadMasterDatabase();
		}
	}

	public static void PreloadDialogueUI()
	{
		if (hasInstance)
		{
			instance.PreloadDialogueUI();
		}
	}

	public static bool ConversationHasValidEntry(string title, Transform actor, Transform conversant, int initialDialogueEntryID = -1)
	{
		if (!hasInstance)
		{
			return false;
		}
		return instance.ConversationHasValidEntry(title, actor, conversant, initialDialogueEntryID);
	}

	public static bool ConversationHasValidEntry(string title, Transform actor)
	{
		return ConversationHasValidEntry(title, actor, null);
	}

	public static bool ConversationHasValidEntry(string title)
	{
		return ConversationHasValidEntry(title, null, null);
	}

	public static void StartConversation(string title, Transform actor, Transform conversant, int initialDialogueEntryID)
	{
		if (hasInstance)
		{
			instance.StartConversation(title, actor, conversant, initialDialogueEntryID);
		}
	}

	public static void StartConversation(string title, Transform actor, Transform conversant)
	{
		if (hasInstance)
		{
			instance.StartConversation(title, actor, conversant);
		}
	}

	public static void StartConversation(string title, Transform actor)
	{
		if (hasInstance)
		{
			instance.StartConversation(title, actor);
		}
	}

	public static void StartConversation(string title)
	{
		if (hasInstance)
		{
			instance.StartConversation(title, null, null);
		}
	}

	public static void StopConversation()
	{
		if (hasInstance)
		{
			instance.StopConversation();
		}
	}

	public static void UpdateResponses()
	{
		if (hasInstance)
		{
			instance.UpdateResponses();
		}
	}

	public static void Bark(string conversationTitle, Transform speaker, Transform listener, BarkHistory barkHistory)
	{
		if (hasInstance)
		{
			instance.Bark(conversationTitle, speaker, listener, barkHistory);
		}
	}

	public static void Bark(string conversationTitle, Transform speaker, Transform listener)
	{
		if (hasInstance)
		{
			instance.Bark(conversationTitle, speaker, listener);
		}
	}

	public static void Bark(string conversationTitle, Transform speaker)
	{
		if (hasInstance)
		{
			instance.Bark(conversationTitle, speaker);
		}
	}

	public static void Bark(string conversationTitle, Transform speaker, BarkHistory barkHistory)
	{
		if (hasInstance)
		{
			instance.Bark(conversationTitle, speaker, barkHistory);
		}
	}

	public static void BarkString(string barkText, Transform speaker, Transform listener = null, string sequence = null)
	{
		if (hasInstance)
		{
			instance.BarkString(barkText, speaker, listener, sequence);
		}
	}

	public static float GetBarkDuration(string barkText)
	{
		if (!hasInstance)
		{
			return 0f;
		}
		return instance.GetBarkDuration(barkText);
	}

	public static void ShowAlert(string message, float duration)
	{
		if (hasInstance)
		{
			instance.ShowAlert(message, duration);
		}
	}

	public static void ShowAlert(string message)
	{
		if (hasInstance)
		{
			instance.ShowAlert(message);
		}
	}

	public static void CheckAlerts()
	{
		if (hasInstance)
		{
			instance.CheckAlerts();
		}
	}

	public static void HideAlert()
	{
		if (hasInstance)
		{
			instance.HideAlert();
		}
	}

	public static string GetLocalizedText(string s)
	{
		if (!hasInstance)
		{
			return s;
		}
		return instance.GetLocalizedText(s);
	}

	public static Sequencer PlaySequence(string sequence, Transform speaker, Transform listener, bool informParticipants, bool destroyWhenDone, string entrytag)
	{
		if (!hasInstance)
		{
			return null;
		}
		return instance.PlaySequence(sequence, speaker, listener, informParticipants, destroyWhenDone, entrytag);
	}

	public static Sequencer PlaySequence(string sequence, Transform speaker, Transform listener, bool informParticipants, bool destroyWhenDone)
	{
		if (!hasInstance)
		{
			return null;
		}
		return instance.PlaySequence(sequence, speaker, listener, informParticipants, destroyWhenDone);
	}

	public static Sequencer PlaySequence(string sequence, Transform speaker, Transform listener, bool informParticipants)
	{
		if (!hasInstance)
		{
			return null;
		}
		return instance.PlaySequence(sequence, speaker, listener, informParticipants);
	}

	public static Sequencer PlaySequence(string sequence, Transform speaker, Transform listener)
	{
		if (!hasInstance)
		{
			return null;
		}
		return instance.PlaySequence(sequence, speaker, listener);
	}

	public static Sequencer PlaySequence(string sequence)
	{
		if (!hasInstance)
		{
			return null;
		}
		return instance.PlaySequence(sequence);
	}

	public static void StopSequence(Sequencer sequencer)
	{
		instance.StopSequence(sequencer);
	}

	public static void Pause()
	{
		if (hasInstance)
		{
			instance.Pause();
		}
	}

	public static void Unpause()
	{
		if (hasInstance)
		{
			instance.Unpause();
		}
	}

	public static void UseDialogueUI(GameObject gameObject)
	{
		instance.UseDialogueUI(gameObject);
	}

	public static void SetDialoguePanel(bool show, bool immediate = false)
	{
		instance.SetDialoguePanel(show, immediate);
	}

	public static void SetPortrait(string actorName, string portraitName)
	{
		if (hasInstance)
		{
			instance.SetPortrait(actorName, portraitName);
		}
	}

	public static void AddLuaObserver(string luaExpression, LuaWatchFrequency frequency, LuaChangedDelegate luaChangedHandler)
	{
		if (hasInstance)
		{
			instance.AddLuaObserver(luaExpression, frequency, luaChangedHandler);
		}
	}

	public static void RemoveLuaObserver(string luaExpression, LuaWatchFrequency frequency, LuaChangedDelegate luaChangedHandler)
	{
		if (hasInstance)
		{
			instance.RemoveLuaObserver(luaExpression, frequency, luaChangedHandler);
		}
	}

	public static void RemoveAllObservers(LuaWatchFrequency frequency)
	{
		if (hasInstance)
		{
			instance.RemoveAllObservers(frequency);
		}
	}

	public static void RemoveAllObservers()
	{
		if (hasInstance)
		{
			instance.RemoveAllObservers();
		}
	}

	public static void RegisterAssetBundle(AssetBundle bundle)
	{
		if (hasInstance)
		{
			instance.RegisterAssetBundle(bundle);
		}
	}

	public static void UnregisterAssetBundle(AssetBundle bundle)
	{
		if (hasInstance)
		{
			instance.UnregisterAssetBundle(bundle);
		}
	}

	public static UnityEngine.Object LoadAsset(string name)
	{
		if (!hasInstance)
		{
			return null;
		}
		return instance.LoadAsset(name);
	}

	public static UnityEngine.Object LoadAsset(string name, Type type)
	{
		if (!hasInstance)
		{
			return null;
		}
		return instance.LoadAsset(name, type);
	}

	public static void LoadAsset(string name, Type type, AssetLoadedDelegate assetLoaded)
	{
		if (hasInstance)
		{
			instance.LoadAsset(name, type, assetLoaded);
		}
		else
		{
			assetLoaded?.Invoke(null);
		}
	}

	public static void UnloadAsset(object obj)
	{
		if (hasInstance)
		{
			instance.UnloadAsset(obj);
		}
	}

	public static void SendUpdateTracker()
	{
		if (hasInstance)
		{
			instance.BroadcastMessage("UpdateTracker", SendMessageOptions.DontRequireReceiver);
		}
	}
}
You are not using the latest version of the tool, please update.
Latest version is '11.1.0.9782' (yours is '9.1.0.7988')
