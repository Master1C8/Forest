using TMPro;
using TheForestOfLove.Audio;
using TheForestOfLove.Core.SceneSetup;
using TheForestOfLove.Narrative;
using TheForestOfLove.Services.Persistence;
using TheForestOfLove.Services.SceneManagement;
using TheForestOfLove.UI;
using UnityEngine;
using UnityEngine.EventSystems;

namespace TheForestOfLove;

public class MainMenuController : MonoBehaviour
{
	public StartScreenMainMenu mainMenu;

	public StartScreenGalleryMenu galleryMenu;

	public OptionsMenu optionsMenu;

	public PlayMenu playMenu;

	public BugReportMenu bugReportMenu;

	public DelayedYesNoConfirmation quitConfirmation;

	public DelayedYesNoConfirmation deleteSavegameConfirmation;

	public DelayedYesNoConfirmation newgameConfirmation;

	public StartScreenThankYouPage thankYouPage;

	public GameObject StartLogo;

	public GameObject MainMenuBackground;

	public GameObject controlsButtonPleaseRefactorMe;

	public TMP_Text versionNumber;

	public static bool gameJustStarted = true;

	private string targetSceneName;

	private const string FASTFORWARD_MAGIC_STRING = "fastforward_magic_string";

	private Chapter fastforward_unlockStopPoint;

	public bool debugSuppressThankYouScreen;

	private bool showDemoThankYouScreen;

	private bool waitForInput;

	private Animator animator;

	public static bool showingSplashScreens { get; private set; }

	public bool fadingIn { get; private set; }

	public static bool galleryMenuOpen { get; private set; }

	private void Start()
	{
		animator = GetComponent<Animator>();
		fadingIn = true;
		playMenu.showContinueButton = SaveManager.HasSavedPlaySession;
		MovieRecord movieRecordByMovie = DataService.GetMovieRecordByMovie(Movie.BunnyHandjob);
		if (movieRecordByMovie != null && movieRecordByMovie.IsUnlocked && !debugSuppressThankYouScreen)
		{
			showDemoThankYouScreen = true;
			animator.SetBool("show_thank_you_screen", showDemoThankYouScreen);
		}
		mainMenu.onClickStart.AddListener(MainMenuPlay);
		mainMenu.onClickGallery.AddListener(ShowGalleryTutorial);
		mainMenu.onClickGallery.AddListener(MainMenuGallery);
		mainMenu.onClickOptions.AddListener(MainMenuOptions);
		mainMenu.onClickBugReport.AddListener(MainMenuBugReportMenu);
		mainMenu.onClickControls.AddListener(MainMenuControls);
		mainMenu.onClickQuit.AddListener(MainMenuQuit);
		mainMenu.onClickPatreon.AddListener(ShowPatreon);
		mainMenu.onClickWebsite.AddListener(ShowWebsite);
		playMenu.onClickStart.AddListener(PlayMenuStart);
		playMenu.onClickContinue.AddListener(PlayMenuContinue);
		playMenu.onClickFastForward.AddListener(PlayMenuFastForward);
		playMenu.onClickBack.AddListener(PlayMenuBack);
		newgameConfirmation.onClickYes.AddListener(NewgameConfirmationYes);
		newgameConfirmation.onClickNo.AddListener(NewgameConfirmationNo);
		galleryMenu.onExitGallery.AddListener(GalleryExit);
		galleryMenu.onExitGalleryShowTutorial.AddListener(GalleryExitShowTutorial);
		galleryMenu.onExitGalleryShowHint.AddListener(GalleryExitShowHint);
		optionsMenu.onClickBack.AddListener(OptionsMenuBack);
		optionsMenu.onClickDeleteSavegame.AddListener(ConfirmDeleteSavegame);
		bugReportMenu.onBack.AddListener(BugReportMenuBack);
		quitConfirmation.onClickYes.AddListener(QuitConfirmationYes);
		quitConfirmation.onClickYesDelayed.AddListener(Quit);
		quitConfirmation.onClickNo.AddListener(QuitConfirmationNo);
		deleteSavegameConfirmation.onClickYes.AddListener(DeleteSavegameConfirmationYes);
		deleteSavegameConfirmation.onClickNo.AddListener(DeleteSavegameConfirmationNo);
		thankYouPage.onClickPatreon.AddListener(ShowPatreon);
		thankYouPage.onClickWebsite.AddListener(ShowWebsite);
		thankYouPage.onClickMenu.AddListener(ThankYouPageMenu);
		if (gameJustStarted)
		{
			gameJustStarted = false;
			showingSplashScreens = true;
		}
		else
		{
			animator.SetTrigger("skip_splash_screens");
		}
		if (Globals.isFinishingSoftReset)
		{
			Globals.isFinishingSoftReset = false;
		}
		versionNumber.text = "v" + Application.version + ".1";
	}

	private void Update()
	{
		if (MovieManager.isPlayingMovie && InputHelper.IsPauseButtonDown)
		{
			return;
		}
		if ((InputHelper.IsBackButtonDown || InputHelper.IsPauseButtonDown) && !quitConfirmation.clickedYes)
		{
			if (optionsMenu.isOpen)
			{
				optionsMenu.OnClickBack();
			}
			else if (quitConfirmation.isOpen)
			{
				quitConfirmation.OnClickNo();
			}
			else if (thankYouPage.isOpen)
			{
				thankYouPage.menuButton.Select();
			}
			else if (newgameConfirmation.isOpen)
			{
				newgameConfirmation.OnClickNo();
			}
			else if (playMenu.isOpen)
			{
				playMenu.OnClickBack();
			}
		}
		if (showingSplashScreens)
		{
			if (InputHelper.AnyKeyDown || Input.anyKeyDown)
			{
				animator.SetTrigger("show_next_splash_screen");
			}
		}
		else if ((!showDemoThankYouScreen || debugSuppressThankYouScreen) && waitForInput && (InputHelper.AnyKeyDown || Input.anyKeyDown))
		{
			FinishShowingMenu();
		}
	}

	private void DeleteLocalSavestate()
	{
		if (SaveManager.HasSavedPlaySession)
		{
			SaveManager.DeleteSavedPlaySession();
			playMenu.HideContinueButton();
			DbAddressableAssetsPreloader.LoadGameplayAddressableAssets();
		}
	}

	private void FinishShowingMenu()
	{
		StartLogo.SetActive(value: true);
		mainMenu.Open(preventInitialSelection: true);
		animator.SetTrigger("fade_to_menu");
		SoundManager.Play(SoundEffect.Select);
		waitForInput = false;
	}

	public void ShowPatreon()
	{
		Application.OpenURL("https://www.patreon.com/CarrotsCritters");
	}

	public void ShowWebsite()
	{
		Application.OpenURL("https://www.theforestoflove.com/");
	}

	public void OnBeginStartCanvasFadeIn()
	{
		MusicManager.Play();
	}

	public void OnStartCanvasFadedIn()
	{
		fadingIn = false;
		waitForInput = true;
		showingSplashScreens = false;
	}

	public void OnThankYouPageFadedIn()
	{
		thankYouPage.SelectDefaultControl();
	}

	public void OnThankYouPageFadedOut()
	{
		animator.SetTrigger("fade_to_menu");
	}

	public void OnMainMenuFadedIn()
	{
		mainMenu.SelectDefaultControl();
	}

	public void OnMainMenuFadedOut()
	{
		LoadOverworld();
	}

	public void HideLogo()
	{
		animator.SetTrigger("hide_logo");
	}

	public void ShowLogo()
	{
		animator.SetTrigger("show_logo");
	}

	private void LoadOverworld()
	{
		if (targetSceneName == "fastforward_magic_string")
		{
			ChapterRecord chapterRecordByChapter = DataService.GetChapterRecordByChapter(fastforward_unlockStopPoint);
			ChapterSelectUI.DoChapterSelect(fastforward_unlockStopPoint, chapterRecordByChapter.respawnInScene);
		}
		else
		{
			SceneHelper.LoadSoftResetScene("ChapterSelect");
		}
	}

	private void Quit()
	{
		SaveManager.SilentSaveGlobalDataOnly();
		QuitHelper.Quit();
	}

	private void MainMenuPlay()
	{
		mainMenu.Hide();
		playMenu.Open();
	}

	private void NewgameConfirmationYes()
	{
		if (playMenu.lastClickedFastForward)
		{
			DeleteLocalSavestate();
			DeleteGlobalSavestate();
			FastForwardGame();
		}
		else
		{
			DeleteLocalSavestate();
			DeleteGlobalSavestate();
			StartNewGame();
		}
		newgameConfirmation.Close();
		playMenu.Close();
	}

	private void NewgameConfirmationNo()
	{
		newgameConfirmation.Close();
		playMenu.Open();
	}

	private void PlayMenuStart()
	{
		if (playMenu.showContinueButton)
		{
			playMenu.Hide();
			newgameConfirmation.Open();
		}
		else
		{
			DeleteLocalSavestate();
			DeleteGlobalSavestate();
			StartNewGame();
		}
	}

	private void PlayMenuContinue()
	{
		ContinueSavedGame();
	}

	private void PlayMenuFastForward()
	{
		if (playMenu.showContinueButton)
		{
			playMenu.Hide();
			newgameConfirmation.Open();
		}
		else
		{
			FastForwardGame();
		}
	}

	private void PlayMenuBack()
	{
		playMenu.Close();
		mainMenu.Open();
	}

	private void StartNewGame()
	{
		EventSystem.current.SetSelectedGameObject(null);
		animator.SetTrigger("fade_out");
		MusicManager.MuteMusic();
		targetSceneName = null;
		QuestTriggerHelper.SetTrigger("act2_newgame_skip");
	}

	private void ContinueSavedGame()
	{
		EventSystem.current.SetSelectedGameObject(null);
		animator.SetTrigger("fade_out");
		TouchInputHelper touchInputHelper = Object.FindObjectOfType<TouchInputHelper>();
		if (touchInputHelper != null)
		{
			touchInputHelper.IsStartMenuLoadingGameHackPLZFIX = true;
		}
		MusicManager.MuteMusic();
	}

	private void FastForwardGame()
	{
		switch (playMenu.currentFastForwardDestinationIndex)
		{
		default:
			fastforward_unlockStopPoint = Chapter.Latest;
			QuestTriggerHelper.SetTrigger("act2_newgame_skip");
			break;
		case 0:
			fastforward_unlockStopPoint = Chapter.Act1_BunnyhouseAndIntro;
			QuestTriggerHelper.SetTrigger("act2_newgame_skip");
			break;
		case 1:
			fastforward_unlockStopPoint = Chapter.Act1_FULL;
			break;
		case 2:
			fastforward_unlockStopPoint = Chapter.Act2_AfterCapstone;
			break;
		}
		targetSceneName = "fastforward_magic_string";
		EventSystem.current.SetSelectedGameObject(null);
		animator.SetTrigger("fade_out");
		MusicManager.MuteMusic();
	}

	private void ShowGalleryTutorial()
	{
		if (!TutorialHelper.HasPlayedTutorial(Tutorial.Gallery))
		{
			mainMenu.Hide();
			TutorialHelper.StartTutorial(Tutorial.Gallery, MainMenuGallery);
			StartLogo.SetActive(value: false);
		}
	}

	private void MainMenuGallery()
	{
		if (TutorialHelper.HasPlayedTutorial(Tutorial.Gallery))
		{
			mainMenu.Hide();
			galleryMenu.Open();
			galleryMenuOpen = true;
			StartLogo.SetActive(value: false);
			MainMenuBackground.SetActive(value: false);
		}
	}

	private void MainMenuGalleryReturnFromHint()
	{
		mainMenu.Hide();
		galleryMenu.UnsuspendForHint();
		galleryMenuOpen = true;
		StartLogo.SetActive(value: false);
		MainMenuBackground.SetActive(value: false);
	}

	private void MainMenuOptions()
	{
		mainMenu.Hide();
		optionsMenu.Open();
	}

	private void MainMenuControls()
	{
		mainMenu.Hide();
		EventSystem.current.SetSelectedGameObject(null);
		TutorialHelper.StartTutorial(Tutorial.Control, FinishShowingOptionalControlsTutorial);
	}

	private void FinishShowingOptionalControlsTutorial()
	{
		mainMenu.Open();
		mainMenu.SetCurrentSelected(controlsButtonPleaseRefactorMe);
	}

	private void MainMenuQuit()
	{
		mainMenu.Hide();
		quitConfirmation.Open();
	}

	private void GalleryExit()
	{
		StartLogo.SetActive(value: true);
		MainMenuBackground.SetActive(value: true);
		galleryMenu.Close();
		galleryMenuOpen = false;
		mainMenu.Open();
	}

	private void GalleryExitShowTutorial()
	{
		galleryMenu.Close();
		galleryMenuOpen = false;
		MainMenuBackground.SetActive(value: true);
		TutorialHelper.StartTutorial(Tutorial.Gallery, MainMenuGallery);
	}

	private void GalleryExitShowHint()
	{
		galleryMenu.SuspendForHint();
		galleryMenuOpen = false;
		MainMenuBackground.SetActive(value: true);
		TutorialHelper.StartTutorial(Tutorial.GalleryHint, MainMenuGalleryReturnFromHint);
	}

	private void OptionsMenuBack()
	{
		optionsMenu.Close();
		GlobalGeneralData globalGeneralData = DataService.GetGlobalGeneralData();
		globalGeneralData.effectsVolumeValue = optionsMenu.volumeController.EffectsVolumeValue;
		globalGeneralData.musicVolumeValue = optionsMenu.volumeController.MusicVolumeValue;
		globalGeneralData.isFullscreen = WindowController.IsFullscreen;
		globalGeneralData.enableFullscreenStretch = WindowController.EnableFullscreenStretch;
		globalGeneralData.windowScalingIndex = WindowController.WindowScalingIndex;
		SaveManager.SilentSaveGlobalDataOnly();
		mainMenu.Open();
	}

	private void MainMenuBugReportMenu()
	{
		StartLogo.SetActive(value: false);
		MainMenuBackground.SetActive(value: false);
		mainMenu.Hide();
		bugReportMenu.Open();
	}

	private void BugReportMenuBack()
	{
		StartLogo.SetActive(value: true);
		MainMenuBackground.SetActive(value: true);
		bugReportMenu.Close();
		mainMenu.Open();
	}

	private void ThankYouPageMenu()
	{
		thankYouPage.Close();
		mainMenu.Open();
		StartLogo.SetActive(value: true);
		animator.SetTrigger("fade_out_thank_you_screen");
	}

	private void QuitConfirmationYes()
	{
		MusicManager.MuteMusic();
	}

	private void QuitConfirmationNo()
	{
		quitConfirmation.Close();
		mainMenu.Open();
	}

	private void ConfirmDeleteSavegame()
	{
		optionsMenu.Hide();
		deleteSavegameConfirmation.Open();
	}

	private void DeleteGlobalSavestate()
	{
		DataService.ForgetGlobalMovieUnlocks();
		DataService.ForgetGlobalChapterUnlocks();
		DataService.RegenerateManifest();
		SaveManager.SilentSaveGlobalDataOnly();
		Globals.enableAllChapters = false;
	}

	private void DeleteSavegameConfirmationYes()
	{
		DeleteLocalSavestate();
		DeleteGlobalSavestate();
		deleteSavegameConfirmation.Close();
		optionsMenu.Close();
		optionsMenu.Open();
		optionsMenu.OnSavegameDeletedCallback();
		playMenu.showContinueButton = false;
		playMenu.HideContinueButton();
	}

	private void DeleteSavegameConfirmationNo()
	{
		deleteSavegameConfirmation.Close();
		optionsMenu.Open();
	}
}
You are not using the latest version of the tool, please update.
Latest version is '11.1.0.9782' (yours is '9.1.0.7988')
