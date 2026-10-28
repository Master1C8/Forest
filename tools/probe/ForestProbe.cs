// Disposable runtime inspection bridge. Never include it in a player release.
using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using TMPro;
using PixelCrushers.DialogueSystem;

public sealed class ForestProbe : MonoBehaviour
{
    [Serializable] public sealed class TextRow {
        public string path, text, font; public float size; public bool overflow;
    }
    [Serializable] public sealed class ResponseRow {
        public string path, text, targetPath;
        public int conversationId, entryId;
        public bool visible, clickable;
    }
    [Serializable] public sealed class State {
        public string scene, dataPath, persistentDataPath, company, product, conversationState;
        public string narrativeDbName, narrativeArcName;
        public bool conversationActive;
        public bool typing;
        public string visibleTypewriterText;
        public int conversationId, entryId, tmpObjectCount;
        public string[] rendererDiagnostics;
        public string[] subtitleGlyphDiagnostics;
        public string[] settingsGlyphDiagnostics, settingsLayoutDiagnostics, settingsControlDiagnostics;
        public bool fullscreen, stretch; public int scaleIndex;
        public int width, height; public TextRow[] texts; public string[] buttons, components;
        public int displayWidth, displayHeight;
        public bool canScaleUp, canScaleDown;
        public string selectedControl;
        public string[] scaleEligibility, scaleControlState;
        // The runtime JsonUtility omits arrays of custom nested row types from
        // this external bridge DLL. Arrays of strings retain each scalar record.
        public int responseCount;
        public string[] responseRecords;
        public int frame;
        public float realtime, scaledTime, timeScale;
        public string[] introDiagnostics;
        public bool diagnosticsReady, dataServicePresent, manifestPresent;
        public int dataServiceInstance;
        public string[] notReady;
        public string tutorialCompletionRecord;
        public string tutorial181Record;
        public string tutorial181ControlRecord;
        public string bucky217Record, bucky141Record, bucky212EndRecord;
    }
    [Serializable] public sealed class TutorialCompletion {
        public string result, text, sourceText, panelPath, buttonPath, textPath, targetPath;
        public string listenerMethod, listenerTargetPath, sourceDestinations, pcDestinations, choiceMode;
        public int frame, conversationId, entryId, panelInstance, buttonInstance, textInstance;
        public bool typing, menuPresent, buttonActive, buttonEnabled, buttonInteractable, graphVerified;
    }
    private bool tutorial158Completed;
    private bool tutorial181Selected;
    private bool bucky217Selected;
    private UnityEngine.Events.UnityEvent<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,int,int> buckyLineEndSource;
    private Bucky212End bucky212End;
    [Serializable] public sealed class Bucky141Subtitle {
        public string choiceMode, sourceText;
        public int frame, conversationId, entryId, actorId, conversantId;
        public bool graphVerified;
    }
    [Serializable] public sealed class Bucky217Selection {
        public string result, choiceMode, text, path, targetPath, listenerMethod, listenerTargetPath;
        public string controllerType, listenerDeclaringType, declinedControllerType, declinedListenerDeclaringType;
        public int frame, conversationId, sourceId, destinationId, successorId, buttonInstance, controllerInstance;
        public int declinedButtonInstance, declinedControllerInstance;
        public bool typing, graphVerified, listenerVerified;
    }
    [Serializable] public sealed class Bucky212End {
        public string dbName, arc;
        public int frame, conversationId, entryId, count;
        public float realtime;
    }
    [Serializable] public sealed class Tutorial181Rejection {
        public string status="rejected", error;
    }
    [Serializable] public sealed class Tutorial181Control {
        public int matches, buttonInstance, controllerInstance, persistentListenerCount;
        public string controllerType, text, path, targetPath, buttonPath;
        public bool controllerEnabled, visible, clickable, buttonEnabled, buttonInteractable, sameTransform;
    }
    [Serializable] public sealed class Tutorial181Selection {
        public string result, choiceMode, text, path, targetPath, listenerMethod, listenerTargetPath;
        public int frame, conversationId, sourceId, destinationId, successorId, buttonInstance, controllerInstance;
        public bool typing, graphVerified, listenerVerified;
    }
    [Serializable] public sealed class NotebookRouteState {
        public string scene, company, product, dataPath, persistentDataPath;
        public string[] diagnostics;
    }
    [Serializable] public sealed class BuckyInteractionState {
        public string scene, company, product, dataPath, persistentDataPath, choiceMode;
        public int frame;
        public float realtime;
        public string[] diagnostics;
    }
    [Serializable] public sealed class ContinueReceipt {
        public string result;
        public bool active;
        public int expectedConversationId, expectedEntryId, actualConversationId, actualEntryId;
    }
    [Serializable] public sealed class FocusTrace {
        public string[] records; public bool limited;
    }
    private readonly List<string> focusRecords=new List<string>();
    private string lastFocusState;
    private float nextFocusRecord, focusStarted;
    private bool focusLimited;
    private string root;
    private float next;
    private int lifecycleSequence;
    private float nextLifecycleRecord;
    private string lifecycleCommand;
    [Serializable] public sealed class LifecycleRow {
        public int sequence, frame;
        public uint winPid;
        public float realtime;
        public string utc, kind, scene, command;
    }
    private bool? originalIgnoreUnfocused;
    private bool samplingKeyboard;
    private readonly List<string> keyboardSamples=new List<string>();
    [DllImport("user32.dll")] static extern bool GetKeyboardState([Out] byte[] keys);
    [DllImport("user32.dll")] static extern short GetAsyncKeyState(int key);
    [DllImport("kernel32.dll")] static extern uint GetCurrentProcessId();
    public static void Install() {
        Debug.Log("FOREST_STARTUP INSTALL_ENTER company=" + Application.companyName + " product=" + Application.productName);
        if (Application.companyName != "VNRevivalQA" || Application.productName != "ForestRuRendererProbe")
            throw new InvalidOperationException("QA bridge requires the isolated player identity.");
        Debug.Log("FOREST_STARTUP IDENTITY_ACCEPTED");
        var go = new GameObject("ForestRendererProbeBridge");
        DontDestroyOnLoad(go);
        Debug.Log("FOREST_STARTUP BEFORE_ADD_COMPONENT");
        go.AddComponent<ForestProbe>();
        Debug.Log("FOREST_STARTUP INSTALL_RETURN");
    }
    void Awake() {
        Debug.Log("FOREST_STARTUP AWAKE_ENTER");
        root = Path.GetFullPath(Path.Combine(Application.dataPath,"../.."));
        focusStarted=Time.realtimeSinceStartup;
        Application.focusChanged+=ObserveUnityFocusEvent;
        Application.quitting+=ObserveUnityQuitting;
        ObserveLifecycle("awake");
        ObserveFocus("awake","unknown");
        Debug.Log("FOREST_PROBE_READY " + root + " SAVES " + Application.persistentDataPath);
    }
    static string Address(Transform t) {
        var result=t.name; while(t.parent != null){t=t.parent;result=t.name+"/"+result;}return result;
    }
    void Update() {
        if(Time.realtimeSinceStartup < next) return;
        next=Time.realtimeSinceStartup+.2f;
        var command=Path.Combine(root,"command.txt");
        if(!File.Exists(command)) return;
        var text=File.ReadAllText(command).Trim();
        lifecycleCommand=text;
        ObserveLifecycle("command-read");
        File.Delete(command);
        try {
#if CHAPTER_GALLERY_PROBE
            if(text.StartsWith("cg-")) ChapterGalleryCommand(text.Substring(3));
            else
#endif
            if(text=="dump-focus") ObserveFocus("snapshot","unknown");
            else if(text=="dump") Dump();
            else if(text=="dump-save-continuation") DumpSaveContinuation();
            else if(text=="dump-intro") DumpIntro();
            else if(text=="dump-notebook") {
                var state=new NotebookRouteState{scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
                    company=Application.companyName,product=Application.productName,dataPath=Application.dataPath,
                    persistentDataPath=Application.persistentDataPath,diagnostics=NotebookRouteDiagnostics()};
                File.WriteAllText(Path.Combine(root,"notebook-route.json"),JsonUtility.ToJson(state,true));
            }
            else if(text=="dump-tutorial") {
                var state=new NotebookRouteState{scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
                    company=Application.companyName,product=Application.productName,dataPath=Application.dataPath,
                    persistentDataPath=Application.persistentDataPath,diagnostics=TutorialRouteDiagnostics()};
                File.WriteAllText(Path.Combine(root,"tutorial-route.json"),JsonUtility.ToJson(state,true));
            }
            else if(text=="dump-travel") {
                var state=new NotebookRouteState{scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
                    company=Application.companyName,product=Application.productName,dataPath=Application.dataPath,
                    persistentDataPath=Application.persistentDataPath,diagnostics=TravelRouteDiagnostics()};
                File.WriteAllText(Path.Combine(root,"travel-route.json"),JsonUtility.ToJson(state,true));
            }
            else if(text=="dump-bucky") {
                var state=new BuckyInteractionState{scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
                    company=Application.companyName,product=Application.productName,dataPath=Application.dataPath,
                    persistentDataPath=Application.persistentDataPath,choiceMode=TutorialChoiceMode,
                    frame=Time.frameCount,realtime=Time.realtimeSinceStartup,diagnostics=BuckyApproachDiagnostics()};
                File.WriteAllText(Path.Combine(root,"bucky-interaction.json"),JsonUtility.ToJson(state,true));
            }
            else if(text=="dump-bucky-completion") {
                var state=new BuckyInteractionState{scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
                    company=Application.companyName,product=Application.productName,dataPath=Application.dataPath,
                    persistentDataPath=Application.persistentDataPath,choiceMode=TutorialChoiceMode,
                    frame=Time.frameCount,realtime=Time.realtimeSinceStartup,diagnostics=BuckyCompletionDiagnostics()};
                File.WriteAllText(Path.Combine(root,"bucky-completion.json"),JsonUtility.ToJson(state,true));
            }
            else if(text=="qa-background-input") {
                if(originalIgnoreUnfocused.HasValue || !Rewired.ReInput.isReady)
                    throw new Exception("Background policy already changed or input not ready");
                originalIgnoreUnfocused=Rewired.ReInput.configuration.ignoreInputWhenAppNotInFocus;
                Rewired.ReInput.configuration.ignoreInputWhenAppNotInFocus=false;
                if(Rewired.ReInput.configuration.ignoreInputWhenAppNotInFocus)
                    throw new Exception("Public Rewired background policy did not apply");
            }
            else if(text=="restore-input-policy") RestoreInputPolicy();
            else if(text=="sample-keyboard-start") {
                if(samplingKeyboard)throw new Exception("Keyboard sample already active");
                keyboardSamples.Clear(); samplingKeyboard=true;
            }
            else if(text=="sample-keyboard-stop") {
                if(!samplingKeyboard)throw new Exception("No active keyboard sample");
                samplingKeyboard=false;
                File.WriteAllLines(Path.Combine(root,"keyboard-samples.txt"),keyboardSamples.ToArray());
            }
            else if(text=="sample-keyboard-snapshot") {
                if(!samplingKeyboard)throw new Exception("No active keyboard sample");
                File.WriteAllLines(Path.Combine(root,"keyboard-samples.txt"),keyboardSamples.ToArray());
            }
            else if(text=="quit") { RestoreInputPolicy(); Application.Quit(); }
            else if(text=="show-menu") {
                var controller=FindObjectOfType<TheForestOfLove.MainMenuController>();
                if(controller==null)throw new Exception("Main menu controller not active");
                controller.GetType().GetMethod("FinishShowingMenu",BindingFlags.Instance|BindingFlags.NonPublic).Invoke(controller,null);
            } else if(text=="complete-tutorial158") {
                if(tutorial158Completed)throw new Exception("Tutorial158 completion already acknowledged; no replay");
                Button button;
                var completion=ReadTutorialCompletion(out button);
                if(completion.typing)throw new Exception("Tutorial158 still typing; no completion");
                // A menu can open after the host sample. Never invoke a response
                // or Continue once the original choices are present.
                completion.result=completion.menuPresent?"menu-present":"applied";
                if(!completion.menuPresent)button.onClick.Invoke();
                tutorial158Completed=true;
                File.WriteAllText(Path.Combine(root,"completion158-receipt.json"),JsonUtility.ToJson(completion,true));
            } else if(text.StartsWith("select-tutorial181 ")) {
                if(tutorial181Selected)throw new Exception("Tutorial181 already selected; no replay");
                var parts=text.Substring(19).Split(' ');
                if(parts.Length!=2)throw new Exception("Expected observed frame and original button identity");
                int observedFrame=Int32.Parse(parts[0]), buttonId=Int32.Parse(parts[1]);
                Button button;
                var selection=ReadTutorial181(out button);
                if(observedFrame<=0 || observedFrame>selection.frame || selection.frame-observedFrame>120 ||
                   selection.buttonInstance!=buttonId)throw new Exception("Stale Tutorial181 menu/control");
                // Consume before invocation: an exception/unknown outcome never authorizes replay.
                tutorial181Selected=true;
                selection.result="submitted";
                File.WriteAllText(Path.Combine(root,"selection181-receipt.json"),JsonUtility.ToJson(selection,true));
                button.onClick.Invoke();
            } else if(text.StartsWith("select-bucky217 ")) {
                if(bucky217Selected)throw new Exception("Bucky217 already selected; no replay");
                var parts=text.Substring(16).Split(' ');
                if(parts.Length!=2)throw new Exception("Expected observed frame and original button identity");
                int observedFrame=Int32.Parse(parts[0]), buttonId=Int32.Parse(parts[1]);
                Button button;
                var selection=ReadBucky217(out button);
                if(observedFrame<=0 || observedFrame>selection.frame || selection.frame-observedFrame>120 ||
                   selection.buttonInstance!=buttonId)throw new Exception("Stale Bucky217 menu/control");
                // Consume before any listener/action side effect. Unknown outcome is not replay permission.
                bucky217Selected=true;
                buckyLineEndSource=TheForestOfLove.Narrative.DialogueService.onDialogueLineArcTriggerCheck;
                if(buckyLineEndSource==null)throw new Exception("Bucky original line-end event absent");
                buckyLineEndSource.AddListener(ObserveBucky212End);
                selection.result="submitted";
                File.WriteAllText(Path.Combine(root,"selection217-receipt.json"),JsonUtility.ToJson(selection,true));
                button.onClick.Invoke();
            } else if(text.StartsWith("continue-bound ")) {
                var parts=text.Substring(15).Split(' ');
                if(parts.Length!=2)throw new Exception("Expected conversation and source entry");
                int conversationId=Int32.Parse(parts[0]), entryId=Int32.Parse(parts[1]);
                if(conversationId==120 && entryId==158)throw new Exception("Tutorial158 requires guarded completion");
                var current=DialogueManager.currentConversationState;
                var entry=current==null || current.subtitle==null?null:current.subtitle.dialogueEntry;
                var receipt=new ContinueReceipt {active=DialogueManager.isConversationActive,
                    expectedConversationId=conversationId, expectedEntryId=entryId,
                    actualConversationId=entry==null?-1:entry.conversationID, actualEntryId=entry==null?-1:entry.id};
                // Original timed cutscenes can finish between an external dump
                // and dispatch. A stale command is a recorded no-op, never an
                // action on the successor conversation or a forced restart.
                bool matches=receipt.active && receipt.actualConversationId==conversationId && receipt.actualEntryId==entryId;
                if(matches)TheForestOfLove.CustomTypewriterEffectTextMeshPro.FastForwardTextOrAdvanceDialogue();
                receipt.result=matches?"applied":"stale";
                File.WriteAllText(Path.Combine(root,"continue-receipt.json"),JsonUtility.ToJson(receipt,true));
            } else if(text=="continue") {
                if(!DialogueManager.isConversationActive)throw new Exception("No active conversation");
                TheForestOfLove.CustomTypewriterEffectTextMeshPro.FastForwardTextOrAdvanceDialogue();
            }
            else if(text.StartsWith("response ")) {
                var parts=text.Substring(9).Split(' ');
                if(parts.Length!=3)throw new Exception("Expected source entry, conversation and destination entry");
                int sourceId=Int32.Parse(parts[0]), conversationId=Int32.Parse(parts[1]), entryId=Int32.Parse(parts[2]);
                if(conversationId==120 && sourceId==158)throw new Exception("Tutorial159/181 choices forbidden");
                var current=DialogueManager.currentConversationState;
                if(!DialogueManager.isConversationActive || current==null || current.subtitle==null ||
                   current.subtitle.dialogueEntry==null || current.subtitle.dialogueEntry.conversationID!=conversationId ||
                   current.subtitle.dialogueEntry.id!=sourceId)
                    throw new Exception("Response source changed");
                StandardUIResponseButton match=null;
                foreach(var b in Resources.FindObjectsOfTypeAll<StandardUIResponseButton>())
                    if(b.gameObject.scene.IsValid() && b.gameObject.activeInHierarchy && b.isVisible && b.isClickable) {
                        if(match!=null)throw new Exception("More than one live response; hold for source review");match=b;
                    }
                if(match==null || match.response==null || match.response.destinationEntry==null || match.target==null ||
                   match.response.destinationEntry.conversationID!=conversationId || match.response.destinationEntry.id!=entryId)
                    throw new Exception("Response does not match source-bound successor");
                match.button.onClick.Invoke();
            }
            else if(text=="probe-nameplate") {
                if(!DialogueManager.isConversationActive)throw new Exception("No active conversation");
                var controller=FindObjectOfType<TheForestOfLove.DialogueNameplateController>();
                if(controller==null)throw new Exception("No active nameplate controller");
                controller.SetCustomNameplateUntilCleared("Ёж Йй 123");
                controller.GetType().GetMethod("UpdateNameplate",BindingFlags.Instance|BindingFlags.NonPublic).Invoke(controller,new object[]{null});
            }
            else if(text.StartsWith("capture ")) {
                var name=text.Substring(8);
                if(Path.GetFileName(name)!=name || !name.EndsWith(".png")) throw new Exception("Invalid capture name");
                var path=Path.Combine(root,name);if(File.Exists(path)) throw new Exception("Capture already exists");
                StartCoroutine(Capture(path));
            } else if(text.StartsWith("select ")) {
                var path=text.Substring(7); Selectable match=null;
                foreach(var s in Resources.FindObjectsOfTypeAll<Selectable>())
                    if(s.gameObject.scene.IsValid() && s.gameObject.activeInHierarchy && s.IsInteractable() && Address(s.transform)==path) {
                        if(match!=null)throw new Exception("Duplicate active selectable");match=s;
                    }
                if(match==null || EventSystem.current==null)throw new Exception("No selectable/event system: "+path);
                EventSystem.current.SetSelectedGameObject(match.gameObject);
            } else if(text=="move-left" || text=="move-right") {
                var es=EventSystem.current;
                if(es==null || es.currentSelectedGameObject==null)throw new Exception("No selected control");
                var data=new AxisEventData(es){moveDir=text=="move-left"?MoveDirection.Left:MoveDirection.Right};
                if(!ExecuteEvents.Execute(es.currentSelectedGameObject,data,ExecuteEvents.moveHandler))
                    throw new Exception("No move handler");
            } else if(text.StartsWith("click ")) {
                var path=text.Substring(6);Button match=null;
                foreach(var b in Resources.FindObjectsOfTypeAll<Button>())
                    if(b.gameObject.activeInHierarchy && b.interactable && Address(b.transform)==path){
                        if(match!=null)throw new Exception("Duplicate active button");match=b;}
                if(match==null)throw new Exception("No matching active button: "+path);
                match.onClick.Invoke();
            } else if(text.StartsWith("menu ")) {
                var parts=text.Substring(5).Split(' ');
                bool savedContinue=parts.Length==2 && parts[0]=="PlayMenu" && parts[1]=="OnClickContinue";
                if(parts.Length!=2 || !(parts[0]=="StartScreenMainMenu" || parts[0]=="PlayMenu" || parts[0]=="OptionsMenu") ||
                   !(parts[1]=="OnClickStart" || parts[1]=="OnClickOptions" || parts[1]=="OnClickBack" || savedContinue))
                    throw new Exception("Unsupported menu command");
                if(savedContinue) {
                    if(!TheForestOfLove.Services.Persistence.SaveManager.HasSavedPlaySession ||
                       UnityEngine.SceneManagement.SceneManager.GetActiveScene().name!="StartMenu" ||
                       Globals.isChapterSelect || Globals.isCheatCode || DialogueManager.isConversationActive)
                        throw new Exception("Original saved Continue state unavailable");
                    int controls=0;
                    foreach(var b in Resources.FindObjectsOfTypeAll<Button>())
                        if(b.gameObject.scene.IsValid() && b.gameObject.activeInHierarchy && b.interactable &&
                           Address(b.transform)=="Canvas/PlayMenu/Controls/Continue")controls++;
                    if(controls!=1)throw new Exception("Exact original Continue control unavailable");
                }
                MonoBehaviour match=null;
                foreach(var b in Resources.FindObjectsOfTypeAll<MonoBehaviour>())
                    if(b!=null && b.gameObject.activeInHierarchy && b.GetType().Name==parts[0]){
                        if(match!=null)throw new Exception("Duplicate active menu");match=b;}
                if(match==null)throw new Exception("Menu not active");
                match.GetType().GetMethod(parts[1]).Invoke(match,null);
            } else throw new Exception("Unsupported command");
            File.AppendAllText(Path.Combine(root,"actions.log"),DateTime.UtcNow.ToString("O")+" OK "+text+"\n");
            ObserveLifecycle("command-ack");
        } catch(Exception ex) {
            File.AppendAllText(Path.Combine(root,"actions.log"),DateTime.UtcNow.ToString("O")+" FAIL "+text+" "+ex+"\n");
            ObserveLifecycle("command-fail");
            Debug.LogException(ex);
        } finally {
            lifecycleCommand=null;
        }
    }
    // Passive, bounded append-only scalars. Never register wantsToQuit (a veto),
    // call a source predicate/callback, or change focus, input or gameplay state.
    // Missing rows cannot prove a crash or the absence of an engine callback.
    void ObserveLifecycle(string kind) {
        if(root==null || lifecycleSequence>=4096)return;
        try {
            var row=new LifecycleRow{sequence=lifecycleSequence++,kind=kind,
                frame=Time.frameCount,realtime=Time.realtimeSinceStartup,
                winPid=GetCurrentProcessId(),utc=DateTime.UtcNow.ToString("O"),
                scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
                command=lifecycleCommand};
            if(lifecycleSequence==4096)row.kind="limit";
            File.AppendAllText(Path.Combine(root,"lifecycle.jsonl"),JsonUtility.ToJson(row)+"\n");
        } catch(Exception ex) {
            lifecycleSequence=4096;
            Debug.Log("FOREST_LIFECYCLE_IO_FAILED "+ex.GetType().Name);
        }
    }
    void ObserveUnityQuitting() { ObserveLifecycle("unity-quitting-event"); }
    void OnApplicationQuit() { ObserveLifecycle("mono-quit"); }
    void RestoreInputPolicy() {
        if(!originalIgnoreUnfocused.HasValue)return;
        var expected=originalIgnoreUnfocused.Value;
        Rewired.ReInput.configuration.ignoreInputWhenAppNotInFocus=expected;
        if(Rewired.ReInput.configuration.ignoreInputWhenAppNotInFocus!=expected)
            throw new Exception("Original input focus policy not restored");
        originalIgnoreUnfocused=null;
    }
    void OnDestroy() {
        ObserveLifecycle("destroy");
        Application.quitting-=ObserveUnityQuitting;
        Application.focusChanged-=ObserveUnityFocusEvent;
        if(buckyLineEndSource!=null)buckyLineEndSource.RemoveListener(ObserveBucky212End);
        RestoreInputPolicy();
    }
    // These handlers receive real engine/library events. They never call the
    // original callbacks, write watchers, or change window/input eligibility.
    void OnApplicationFocus(bool value) { ObserveFocus("mono-focus",value.ToString()); }
    void OnApplicationPause(bool value) { ObserveFocus("mono-pause",value.ToString()); }
    void ObserveUnityFocusEvent(bool value) { ObserveFocus("unity-event",value.ToString()); }
    void ObserveFocus(string kind,string callbackValue) {
        if(root==null || focusLimited)return;
        var state=" | focused="+Application.isFocused+
            " | runInBackground="+Application.runInBackground+
            " | scene="+UnityEngine.SceneManagement.SceneManager.GetActiveScene().name;
        try {
            var flags=BindingFlags.Static|BindingFlags.NonPublic;
            state+=" | rewiredCallbackCache="+typeof(Rewired.ReInput).GetField("cbmmwJPDGUhXqzzdtJQPbNHADIB",flags).GetValue(null);
            state+=Rewired.ReInput.isReady?" | ignoreUnfocused="+Rewired.ReInput.configuration.ignoreInputWhenAppNotInFocus+KeyboardEligibility():" | rewiredReady=False";
            state+=" | gameplay="+TheForestOfLove.Services.SceneManagement.SceneHelper.inGameplayScene+
                " | anyEvent="+TheForestOfLove.Events.GameStateManager.isAnyEventActive+
                " | conversation="+DialogueManager.isConversationActive;
        } catch(Exception ex) { state+=" | errorType="+ex.GetType().Name; }
        bool limit=focusRecords.Count>=1023 || Time.realtimeSinceStartup-focusStarted>=420f;
        if(kind=="late" && state==lastFocusState && Time.realtimeSinceStartup<nextFocusRecord && !limit)return;
        focusLimited=limit;
        lastFocusState=state; nextFocusRecord=Time.realtimeSinceStartup+1f;
        focusRecords.Add("focus | sequence="+focusRecords.Count+" | kind="+(limit?"limit":kind)+
            " | callbackValue="+callbackValue+" | frame="+Time.frameCount+
            " | realtime="+Time.realtimeSinceStartup+" | scaledTime="+Time.time+
            " | timeScale="+Time.timeScale+" | utc="+DateTime.UtcNow.ToString("O")+
            " | winPid="+GetCurrentProcessId()+state);
        // Event/heartbeat records stay in memory until an acknowledged snapshot.
        // LateUpdate must not truncate this file while the host reads that snapshot.
        if(kind=="snapshot" || limit)File.WriteAllText(Path.Combine(root,"focus-trace.json"),JsonUtility.ToJson(
            new FocusTrace{records=focusRecords.ToArray(),limited=focusLimited},true));
    }
    // Exact shipped getters/fields are pinned in native-focus-20261026. These
    // predicates only read the real eligibility state; never write focus/watchers.
    static string KeyboardEligibility() {
        var type=typeof(Rewired.ReInput);
        var flags=BindingFlags.Static|BindingFlags.Public|BindingFlags.NonPublic;
        var watchers=type.GetField("GGbNxxBRsPVtXooKvddzWaNspLr",flags).GetValue(null);
        Func<string,object> watcherValue=name=> {
            var watcher=ReadField(watchers,name);
            return watcher.GetType().GetProperty("value").GetValue(watcher,null);
        };
        return " | rewiredReady="+Rewired.ReInput.isReady+
            " | rewiredGlobalEnabled="+type.GetField("aLzbAjHdyinuPAkYilYZkIGyBOc",flags).GetValue(null)+
            " | rewiredFilter="+type.GetField("NPfefDCOwXSjdltUbdIpmiYqZmUC",flags).GetValue(null)+
            " | rewiredFocusWatcher="+watcherValue("QBAmVSgbZBPmppTHWYNgMiDCmXg")+
            " | rewiredOtherWatcher="+watcherValue("xIMFCrwXunWxoekBlleMmJYPdj")+
            " | rewiredInputAllowed="+type.GetProperty("inputAllowed",flags).GetValue(null,null)+
            " | rewiredKeyboardAllowed="+type.GetMethod("IsInputAllowed",flags).Invoke(null,new object[]{Rewired.ControllerType.Keyboard})+
            " | nativeKeyboard="+Rewired.ReInput.configuration.nativeKeyboardSupport+
            " | unityInput="+Rewired.ReInput.configuration.alwaysUseUnityInput;
    }
    // Public read-only map getters are pinned in gameplay-eligibility-20261026.
    // Observe the real InputHelper player; no map/controller replacement or writes.
    static string KeyboardMaps(Rewired.Player player) {
        if(player==null)return "null";
        // Scalar JSON only: JsonUtility has omitted external nested row arrays
        // in this shipped Unity player. Every emitted value here is int/bool.
        var maps=new List<string>();
        foreach(var map in player.controllers.maps.GetAllMaps(Rewired.ControllerType.Keyboard)) {
            var bindings=new List<string>();
            var submit=new List<string>();
            foreach(var binding in map.AllMaps)
                if(binding.actionId==0 || binding.actionId==1 || binding.actionId==2 || binding.actionId==18) {
                    string row="{\"action\":"+binding.actionId+",\"key\":"+(int)binding.keyCode+
                        ",\"type\":"+(int)binding.elementType+",\"range\":"+(int)binding.axisRange+
                        ",\"pole\":"+(int)binding.axisContribution+",\"invert\":"+(binding.invert?"true":"false")+
                        ",\"enabled\":"+(binding.enabled?"true":"false")+",\"modifier1\":"+(int)binding.modifierKey1+
                        ",\"modifier2\":"+(int)binding.modifierKey2+",\"modifier3\":"+(int)binding.modifierKey3+"}";
                    if(binding.actionId==0 || binding.actionId==1)bindings.Add(row); else submit.Add(row);
                }
            maps.Add("{\"source\":"+map.sourceMapId+",\"category\":"+map.categoryId+",\"layout\":"+map.layoutId+
                ",\"enabled\":"+(map.enabled?"true":"false")+",\"movement\":["+String.Join(",",bindings.ToArray())+
                "],\"submit\":["+String.Join(",",submit.ToArray())+"]}");
        }
        return "{\"maps\":["+String.Join(",",maps.ToArray())+"]}";
    }
    static string NaturalDoorTransition() {
        var matches=new List<TheForestOfLove.Doorway>();
        foreach(var door in Resources.FindObjectsOfTypeAll<TheForestOfLove.Doorway>())
            if(door.gameObject.scene.name=="BunnyHouse" &&
               DiagnosticValue(ReadField(door,"sceneName"))=="CentralForest" &&
               Address(door.transform).EndsWith("/Doorways/DoorwayToCentralForest",StringComparison.Ordinal))
                matches.Add(door);
        return matches.Count==1?DiagnosticValue(ReadField(matches[0],"transitioning")):
            (matches.Count==0?"absent":"ambiguous");
    }
    void LateUpdate() {
        if(Time.realtimeSinceStartup>=nextLifecycleRecord) {
            nextLifecycleRecord=Time.realtimeSinceStartup+1f;
            ObserveLifecycle("heartbeat");
        }
        ObserveFocus("late","unknown");
        if(!samplingKeyboard)return;
        if(keyboardSamples.Count>=1200){samplingKeyboard=false;throw new Exception("Keyboard sample exceeded bound");}
        var keys=new byte[256]; var valid=GetKeyboardState(keys);
        var keyboard=Rewired.ReInput.controllers.Keyboard;
        var helper=FindObjectOfType<TheForestOfLove.InputHelper>();
        var player=helper==null?null:ReadField(helper,"player") as Rewired.Player;
        var actor=FindObjectOfType<TheForestOfLove.Player>();
        var body=actor==null?null:actor.GetComponent<Rigidbody2D>();
        bool nativeArrowsUp=valid, asyncArrowsUp=true, rewiredArrowsUp=true, unityArrowsUp=true;
        bool nativeMovementUp=valid, asyncMovementUp=true, rewiredMovementUp=true, unityMovementUp=true;
        var nativeDown=new List<string>(); var asyncDown=new List<string>();
        var rewiredDown=new List<string>(); var unityDown=new List<string>();
        // Original action0/1 maps contain WASD as well as arrows. Observe all
        // eight keys before crediting idle; never release unrelated owner input.
        var nativeCodes=new[]{0x25,0x26,0x27,0x28,(int)'W',(int)'A',(int)'S',(int)'D'};
        var unityCodes=new[]{KeyCode.LeftArrow,KeyCode.UpArrow,KeyCode.RightArrow,KeyCode.DownArrow,
            KeyCode.W,KeyCode.A,KeyCode.S,KeyCode.D};
        for(int i=0;i<nativeCodes.Length;i++) {
            bool n=(keys[nativeCodes[i]]&128)!=0, a=(GetAsyncKeyState(nativeCodes[i])&0x8000)!=0;
            bool r=keyboard.GetKey(unityCodes[i]), u=Input.GetKey(unityCodes[i]);
            string label=unityCodes[i].ToString();
            if(n)nativeDown.Add(label); if(a)asyncDown.Add(label);
            if(r)rewiredDown.Add(label); if(u)unityDown.Add(label);
            nativeMovementUp &= !n; asyncMovementUp &= !a; rewiredMovementUp &= !r; unityMovementUp &= !u;
            if(i<4) { nativeArrowsUp &= !n; asyncArrowsUp &= !a; rewiredArrowsUp &= !r; unityArrowsUp &= !u; }
        }
        // Observe every original action2 key, including the Control alternatives.
        // These additional fields do not replace the accepted eight-key guards.
        bool nativeSubmitUp=valid, asyncSubmitUp=true, rewiredSubmitUp=true, unitySubmitUp=true;
        var nativeSubmitDown=new List<string>(); var asyncSubmitDown=new List<string>();
        var rewiredSubmitDown=new List<string>(); var unitySubmitDown=new List<string>();
        var submitNativeCodes=new[]{0x0d,0x20,0xa2,0xa3};
        var submitUnityCodes=new[]{KeyCode.Return,KeyCode.Space,KeyCode.LeftControl,KeyCode.RightControl};
        for(int i=0;i<submitNativeCodes.Length;i++) {
            bool n=(keys[submitNativeCodes[i]]&128)!=0, a=(GetAsyncKeyState(submitNativeCodes[i])&0x8000)!=0;
            bool r=keyboard.GetKey(submitUnityCodes[i]), u=Input.GetKey(submitUnityCodes[i]);
            string label=submitUnityCodes[i].ToString();
            if(n)nativeSubmitDown.Add(label); if(a)asyncSubmitDown.Add(label);
            if(r)rewiredSubmitDown.Add(label); if(u)unitySubmitDown.Add(label);
            nativeSubmitUp &= !n; asyncSubmitUp &= !a; rewiredSubmitUp &= !r; unitySubmitUp &= !u;
        }
        // Observe the real producer and public getters. Never feed these values back.
        keyboardSamples.Add("keyboard | frame="+Time.frameCount+" | scaledTime="+Time.time+
            " | timeScale="+Time.timeScale+" | time="+Time.realtimeSinceStartup+
            " | winPid="+GetCurrentProcessId()+" | focused="+Application.isFocused+
            " | ignoreUnfocused="+Rewired.ReInput.configuration.ignoreInputWhenAppNotInFocus+
            KeyboardEligibility()+
            " | nativeValid="+valid+" | nativeLeft="+((keys[0x25]&128)!=0)+
            " | asyncLeft="+((GetAsyncKeyState(0x25)&0x8000)!=0)+
            " | rewiredLeft="+keyboard.GetKey(KeyCode.LeftArrow)+
            " | keyboardEnabled="+keyboard.enabled+" | unityLeft="+Input.GetKey(KeyCode.LeftArrow)+
            " | player="+(player==null?"null":player.id+":"+player.name)+
            " | keyboardMaps="+KeyboardMaps(player)+
            " | actionAxes="+(player==null?"null":Vector(player.GetAxis2D(0,1)))+
            " | fullAxis="+Vector(TheForestOfLove.InputHelper.FullAxis)+
            " | nativeArrowsUp="+nativeArrowsUp+" | asyncArrowsUp="+asyncArrowsUp+
            " | rewiredArrowsUp="+rewiredArrowsUp+" | unityArrowsUp="+unityArrowsUp+
            " | nativeMovementUp="+nativeMovementUp+" | asyncMovementUp="+asyncMovementUp+
            " | rewiredMovementUp="+rewiredMovementUp+" | unityMovementUp="+unityMovementUp+
            " | nativeMovementDown="+String.Join(",",nativeDown.ToArray())+
            " | asyncMovementDown="+String.Join(",",asyncDown.ToArray())+
            " | rewiredMovementDown="+String.Join(",",rewiredDown.ToArray())+
            " | unityMovementDown="+String.Join(",",unityDown.ToArray())+
            " | nativeSubmitUp="+nativeSubmitUp+" | asyncSubmitUp="+asyncSubmitUp+
            " | rewiredSubmitUp="+rewiredSubmitUp+" | unitySubmitUp="+unitySubmitUp+
            " | nativeSubmitDown="+String.Join(",",nativeSubmitDown.ToArray())+
            " | asyncSubmitDown="+String.Join(",",asyncSubmitDown.ToArray())+
            " | rewiredSubmitDown="+String.Join(",",rewiredSubmitDown.ToArray())+
            " | unitySubmitDown="+String.Join(",",unitySubmitDown.ToArray())+
            " | rewiredAction2Held="+(player==null?"null":player.GetButton(2).ToString())+
            " | rewiredAction2Down="+(player==null?"null":player.GetButtonDown(2).ToString())+
            " | helperSubmitDown="+TheForestOfLove.InputHelper.IsSubmitButtonDown+
            " | unityReturnDown="+Input.GetKeyDown(KeyCode.Return)+
            " | scene="+UnityEngine.SceneManagement.SceneManager.GetActiveScene().name+
            " | routeDoorTransition="+NaturalDoorTransition()+
            " | gameplay="+TheForestOfLove.Services.SceneManagement.SceneHelper.inGameplayScene+
            " | anyEvent="+TheForestOfLove.Events.GameStateManager.isAnyEventActive+
            " | conversation="+DialogueManager.isConversationActive+
            " | dustin="+TheForestOfLove.Services.SceneManagement.SceneHelper.inDustinMinigame+
            " | glitch="+TheForestOfLove.Services.SceneManagement.SceneHelper.inGlitchRoom+
            " | actor="+ObjectAddress(actor)+" | body="+ObjectAddress(body)+
            " | actorPosition="+(actor==null?"null":Vector(actor.transform.position))+
            " | bodyPosition="+(body==null?"null":Vector(body.position))+
            " | bodyVelocity="+(body==null?"null":Vector(body.velocity))+
            " | movement="+(actor==null?"null":DiagnosticValue(ReadField(actor,"enableMovement")))+
            " | lanternTransition="+(actor!=null && actor.lanternTransitioning)+
            " | sweaterTransition="+(actor!=null && actor.sweaterTransitioning)+
            " | waypoints="+(actor==null || actor.waypointController==null?"absent":actor.waypointController.HasWaypoints.ToString()));
    }
    IEnumerator Capture(string path) {
        yield return new WaitForEndOfFrame();
        ScreenCapture.CaptureScreenshot(path);
        Debug.Log("FOREST_PROBE_CAPTURE " + path);
    }
    // Read original state only. In particular, never unlock chapters/triggers,
    // select a private destination index, or open MasterLog from this diagnostic.
    static string DiagnosticValue(object value) {
        if(value==null)return "null";
        var type=value.GetType();
        if(type.IsPrimitive || type.IsEnum || value is string)return value.ToString();
        var dbName=type.GetField("dbName",BindingFlags.Instance|BindingFlags.Public);
        return type.Name+(dbName==null?"":"("+dbName.GetValue(value)+")");
    }
    static object ReadField(object owner, string name) {
        if(owner==null)return null;
        var field=owner.GetType().GetField(name,BindingFlags.Instance|BindingFlags.Public|BindingFlags.NonPublic);
        if(field==null)throw new Exception("Unknown diagnostic field: "+owner.GetType().Name+"."+name);
        return field.GetValue(owner);
    }
    static string ObjectAddress(object value) {
        var component=value as Component;
        return component==null?DiagnosticValue(value):Address(component.transform)+"#"+component.GetInstanceID();
    }
    static string ListValues(IEnumerable values) {
        var rows=new List<string>();
        if(values!=null)foreach(var value in values) {
            if(rows.Count>=128)throw new Exception("Unexpected diagnostic collection size");
            rows.Add(DiagnosticValue(value));
        }
        return String.Join(",",rows.ToArray());
    }
    static string BuckyCallback(Delegate callback) {
        if(callback==null)return "null";
        return ObjectAddress(callback.Target)+"::"+callback.Method.DeclaringType.FullName+"::"+callback.Method.Name;
    }
    static string BuckyRuntimeListeners(UnityEngine.Events.UnityEventBase source) {
        var calls=typeof(UnityEngine.Events.UnityEventBase).GetField("m_Calls",BindingFlags.Instance|BindingFlags.NonPublic).GetValue(source);
        var runtime=ReadField(calls,"m_RuntimeCalls") as IList;
        if(runtime==null || runtime.Count>16)throw new Exception("Missing or unbounded Bucky collision listeners");
        var rows=new List<string>();
        foreach(var call in runtime) {
            var callback=ReadField(call,"Delegate") as Delegate;
            if(callback==null || callback.GetInvocationList().Length!=1)throw new Exception("Unknown Bucky collision callback");
            rows.Add(BuckyCallback(callback));
        }
        rows.Sort(StringComparer.Ordinal);
        return "persistent="+source.GetPersistentEventCount()+" | callbacks="+String.Join(",",rows.ToArray());
    }
    // Observe original fields and real physics contacts only. No availability,
    // callback invocation, control acquisition, dialogue dispatch or state writes.
    string[] BuckyInteractionDiagnostics() {
        const string actorPath="SpawnedContent/Critters/Bucky/Content/BuckyOnNorthShore(Clone)";
        var rows=new List<string>();
        TheForestOfLove.Gameplay.SpawnableActor actor=null;
        foreach(var item in Resources.FindObjectsOfTypeAll<TheForestOfLove.Gameplay.SpawnableActor>())
            if(item.gameObject.scene.IsValid() && Address(item.transform)==actorPath) {
                if(actor!=null)throw new Exception("Ambiguous Bucky actor");actor=item;
            }
        TheForestOfLove.InteractionUiController controller=null;
        foreach(var item in Resources.FindObjectsOfTypeAll<TheForestOfLove.InteractionUiController>())
            if(item.gameObject.scene.IsValid() && Address(item.transform)==actorPath+"/Interaction/InteractionUiController") {
                if(controller!=null)throw new Exception("Ambiguous Bucky controller");controller=item;
            }
        if(actor==null || controller==null)throw new Exception("Bucky actor/controller absent");
        var trigger=ReadField(controller,"dialogueInteractionTrigger") as TheForestOfLove.Interaction.DialogueInteractionTrigger;
        var ui=ReadField(controller,"interactionUi") as TheForestOfLove.InteractionUi;
        var listener=ReadField(controller,"collisionEventListener") as TheForestOfLove.CollisionEventListener;
        var settings=trigger==null?null:ReadField(trigger,"settings") as TheForestOfLove.DialogueSettings;
        var player=TheForestOfLove.Player.current;
        if(trigger==null || ui==null || listener==null || settings==null || player==null)
            throw new Exception("Missing loaded Bucky bindings/Player");
        var capsule=listener.GetComponent<CapsuleCollider2D>();
        var rootCollider=player.GetComponent<CircleCollider2D>();
        var body=player.GetComponent<Rigidbody2D>();
        if(capsule==null || rootCollider==null || body==null)throw new Exception("Missing loaded Bucky/Player physics");
        int controllerAuthority=(int)typeof(TheForestOfLove.InteractionUiController).GetField("authorityId",BindingFlags.Static|BindingFlags.NonPublic|BindingFlags.Public).GetValue(null);
        int triggerAuthority=(int)typeof(TheForestOfLove.Interaction.DialogueInteractionTrigger).GetField("authorityId",BindingFlags.Static|BindingFlags.NonPublic|BindingFlags.Public).GetValue(null);
        rows.Add("buckyGuards | gameplay="+TheForestOfLove.Services.SceneManagement.SceneHelper.inGameplayScene+
            " | anyEvent="+TheForestOfLove.Events.GameStateManager.isAnyEventActive+" | conversation="+DialogueManager.isConversationActive);
        rows.Add("buckyActor | path="+Address(actor.transform)+" | id="+actor.GetInstanceID()+" | gameObject="+actor.gameObject.GetInstanceID()+
            " | type="+actor.GetType().FullName+" | dbName="+actor.ActorDbName+" | active="+actor.gameObject.activeInHierarchy+
            " | enabled="+actor.enabled+" | position="+Vector(actor.transform.position));
        rows.Add("buckyController | path="+Address(controller.transform)+" | id="+controller.GetInstanceID()+
            " | gameObject="+controller.gameObject.GetInstanceID()+" | type="+controller.GetType().FullName+
            " | active="+controller.gameObject.activeInHierarchy+" | enabled="+controller.enabled+
            " | authorityId="+controllerAuthority+" | touching="+ReadField(controller,"isPlayerTouching")+
            " | available="+ListValues(ReadField(controller,"availableOptions") as IEnumerable)+
            " | disallowed="+ListValues(ReadField(controller,"disallowedOptions") as IEnumerable));
        rows.Add("buckyTrigger | path="+Address(trigger.transform)+" | id="+trigger.GetInstanceID()+
            " | gameObject="+trigger.gameObject.GetInstanceID()+" | type="+trigger.GetType().FullName+
            " | active="+trigger.gameObject.activeInHierarchy+" | enabled="+trigger.enabled+
            " | authorityId="+triggerAuthority+" | touching="+ReadField(trigger,"isPlayerTouching")+
            " | mode="+(int)trigger.interactionMode+" | triggered="+ReadField(trigger,"isTriggered")+
            " | cooldown="+ReadField(trigger,"cooldownLoopsRemaining")+" | blocked="+trigger.interactionBlocked+
            " | onCollision="+ReadField(trigger,"triggerOnCollision")+" | withoutUi="+ReadField(trigger,"allowTriggeringWithoutUi")+
            " | namedTrigger="+trigger.TriggerDbName+" | maxTimes="+ReadField(typeof(TheForestOfLove.Interaction.InteractionTrigger),trigger,"maxTimesTriggerable"));
        rows.Add("buckySettings | path="+Address(settings.transform)+" | id="+settings.GetInstanceID()+
            " | type="+settings.GetType().FullName+" | active="+settings.gameObject.activeInHierarchy+" | enabled="+settings.enabled+
            " | actor="+settings.ActorDbName+" | dialogue="+settings.DialogueDbName+" | arc="+settings.ArcDbName);
        int sharedUiCount=0;
        foreach(var item in Resources.FindObjectsOfTypeAll<TheForestOfLove.InteractionUi>())
            if(item.gameObject.scene.IsValid() && item.gameObject.activeInHierarchy)sharedUiCount++;
        var selected=ReadField(ui,"onOptionSelected") as Delegate;
        var selectedCallbacks=new List<string>();
        if(selected!=null)foreach(var callback in selected.GetInvocationList())selectedCallbacks.Add(BuckyCallback(callback));
        rows.Add("buckyUi | path="+Address(ui.transform)+" | id="+ui.GetInstanceID()+" | type="+ui.GetType().FullName+
            " | active="+ui.gameObject.activeInHierarchy+" | enabled="+ui.enabled+" | activeCount="+sharedUiCount+
            " | visible="+TheForestOfLove.InteractionUi.visible+" | locked="+ui.locked+" | selected="+(int)ui.currentSelectedOption+
            " | available="+ListValues(ReadField(ui,"availableOptions") as IEnumerable)+" | callbacks="+String.Join(",",selectedCallbacks.ToArray()));
        rows.Add("buckyBindings | actor="+System.Object.ReferenceEquals(ReadField(controller,"character"),actor)+
            " | listener="+System.Object.ReferenceEquals(ReadField(trigger,"collisionEventListener"),listener)+
            " | actorParent="+(controller.GetComponentInParent<TheForestOfLove.Gameplay.SpawnableActor>()==actor)+
            " | settingsObject="+(settings.gameObject==trigger.gameObject)+
            " | controllerDescendant="+controller.transform.IsChildOf(actor.transform)+
            " | triggerDescendant="+trigger.transform.IsChildOf(actor.transform)+
            " | listenerDescendant="+listener.transform.IsChildOf(actor.transform));
        rows.Add("buckyCollision | path="+Address(listener.transform)+" | id="+listener.GetInstanceID()+
            " | type="+listener.GetType().FullName+" | active="+listener.gameObject.activeInHierarchy+" | enabled="+listener.enabled+
            " | collider="+capsule.GetInstanceID()+" | colliderType="+capsule.GetType().FullName+" | colliderCount="+listener.GetComponents<Collider2D>().Length+
            " | colliderEnabled="+capsule.enabled+" | isTrigger="+capsule.isTrigger+" | size="+Vector(capsule.size)+
            " | offset="+Vector(capsule.offset)+" | scale="+Vector(capsule.transform.lossyScale)+
            " | boundsCenter="+Vector(capsule.bounds.center)+" | boundsSize="+Vector(capsule.bounds.size)+
            " | rootTouch="+capsule.IsTouching(rootCollider)+" | ignoredPair="+Physics2D.GetIgnoreCollision(capsule,rootCollider));
        rows.Add("buckyEnter | "+BuckyRuntimeListeners(listener.onTriggerEnter2D));
        rows.Add("buckyStay | "+BuckyRuntimeListeners(listener.onTriggerStay2D));
        rows.Add("buckyExit | "+BuckyRuntimeListeners(listener.onTriggerExit2D));
        rows.Add("buckyPlayer | path="+Address(player.transform)+" | id="+player.GetInstanceID()+" | type="+player.GetType().FullName+
            " | active="+player.gameObject.activeInHierarchy+" | enabled="+player.enabled+" | canInteract="+player.canInteract+
            " | body="+body.GetInstanceID()+" | bodyType="+body.bodyType+" | bodySimulated="+body.simulated+
            " | rootCollider="+rootCollider.GetInstanceID()+" | rootColliderEnabled="+rootCollider.enabled+
            " | rootIsTrigger="+rootCollider.isTrigger+" | rootTag="+rootCollider.gameObject.tag+
            " | position="+Vector(player.transform.position)+" | velocity="+Vector(body.velocity));
        return rows.ToArray();
    }
    string[] BuckyApproachDiagnostics() {
        // One real frame for both authority stores, Scarlett touch/release and
        // Bucky anatomy. The old tutorial dump has no frame/time fields.
        var rows=new List<string>(BuckyInteractionDiagnostics());
        rows.AddRange(TutorialRouteDiagnostics());
        var player=TheForestOfLove.Player.current;
        if(player==null)throw new Exception("Bucky motion Player missing");
        rows.Add("buckyMotion | movement="+ReadField(player,"enableMovement")+
            " | lanternTransition="+player.lanternTransitioning+" | sweaterTransition="+player.sweaterTransitioning+
            " | swim="+ObjectAddress(ReadField(player,"playerSwimTransition"))+
            " | waypoints="+(player.waypointController==null?"absent":player.waypointController.HasWaypoints.ToString())+
            " | speed="+Vector((Vector2)ReadField(player,"speed"))+
            " | currentSpeed="+Vector((Vector2)ReadField(player,"currentSpeed")));
        return rows.ToArray();
    }
    static object ReadField(Type declaringType, object owner, string name) {
        var field=declaringType.GetField(name,BindingFlags.Instance|BindingFlags.Public|BindingFlags.NonPublic|BindingFlags.DeclaredOnly);
        if(field==null)throw new Exception("Unknown declared diagnostic field: "+declaringType.Name+"."+name);
        return field.GetValue(owner);
    }
    static string Vector(Vector3 value) {
        return String.Format(System.Globalization.CultureInfo.InvariantCulture,"{0:R},{1:R},{2:R}",value.x,value.y,value.z);
    }
    static void TravelColliders(List<string> rows, Component owner) {
        foreach(var collider in owner.GetComponentsInChildren<Collider2D>(true)) {
            var body=collider.attachedRigidbody;
            rows.Add("travelCollider | owner="+owner.GetInstanceID()+" | id="+collider.GetInstanceID()+" | path="+Address(collider.transform)+
                " | type="+collider.GetType().Name+" | active="+collider.gameObject.activeInHierarchy+
                " | enabled="+collider.enabled+" | trigger="+collider.isTrigger+" | tag="+collider.gameObject.tag+
                " | layer="+collider.gameObject.layer+" | offset="+Vector(collider.offset)+
                " | boundsCenter="+Vector(collider.bounds.center)+" | boundsSize="+Vector(collider.bounds.size)+
                " | boundsMin="+Vector(collider.bounds.min)+" | boundsMax="+Vector(collider.bounds.max)+
                " | rigidbody="+ObjectAddress(body)+" | simulated="+(body!=null && body.simulated));
        }
        foreach(var body in owner.GetComponentsInChildren<Rigidbody2D>(true))
            rows.Add("travelBody | owner="+owner.GetInstanceID()+" | id="+body.GetInstanceID()+
                " | path="+Address(body.transform)+" | active="+body.gameObject.activeInHierarchy+
                " | layer="+body.gameObject.layer+" | type="+body.bodyType+" | simulated="+body.simulated+
                " | position="+Vector(body.position)+" | velocity="+Vector(body.velocity)+
                " | constraints="+body.constraints+" | gravityScale="+body.gravityScale+
                " | collisionDetection="+body.collisionDetectionMode+" | fullKinematicContacts="+body.useFullKinematicContacts);
    }
    // Original movement/joystick getters are pinned in travel-20261026. This
    // diagnostic never feeds input, changes focus, enables controls or moves objects.
    string[] TravelRouteDiagnostics() {
        var rows=new List<string>();
        rows.Add("travelGuards | gameplay="+TheForestOfLove.Services.SceneManagement.SceneHelper.inGameplayScene+
            " | anyEvent="+TheForestOfLove.Events.GameStateManager.isAnyEventActive+
            " | conversation="+DialogueManager.isConversationActive+" | focused="+Application.isFocused+
            " | runInBackground="+Application.runInBackground+" | axis="+Vector(TheForestOfLove.InputHelper.FullAxis));
        if(Rewired.ReInput.isReady)rows.Add("travelRewired | ignoreUnfocused="+Rewired.ReInput.configuration.ignoreInputWhenAppNotInFocus+
            " | keyboardEnabled="+Rewired.ReInput.controllers.Keyboard.enabled+KeyboardEligibility());
        foreach(var player in Resources.FindObjectsOfTypeAll<TheForestOfLove.Player>())
            if(player.gameObject.scene.IsValid()) {
                var waypoints=player.waypointController;
                var swim=ReadField(player,"playerSwimTransition");
                rows.Add("travelPlayer | id="+player.GetInstanceID()+" | path="+Address(player.transform)+
                    " | active="+player.gameObject.activeInHierarchy+" | enabled="+player.enabled+
                    " | position="+Vector(player.transform.position)+" | state="+player.playerState+
                    " | speed="+Vector((Vector2)ReadField(player,"speed"))+" | currentSpeed="+Vector((Vector2)ReadField(player,"currentSpeed"))+
                    " | movement="+ReadField(player,"enableMovement")+" | lanternTransition="+player.lanternTransitioning+
                    " | sweaterTransition="+player.sweaterTransitioning+" | swim="+ObjectAddress(swim)+
                    " | waypoints="+(waypoints==null?"absent":waypoints.HasWaypoints.ToString()));
                TravelColliders(rows,player);
                // Read-only native physics queries for each bounded route leg.
                // Never invoke collision/travel callbacks or move the cast shape.
                var root=player.GetComponent<CircleCollider2D>();
                if(root!=null && root.enabled && player.gameObject.activeInHierarchy) {
                    var filter=new ContactFilter2D(); filter.useTriggers=false;
                    filter.SetLayerMask(Physics2D.GetLayerCollisionMask(root.gameObject.layer));
                    foreach(var direction in new[]{Vector2.left,Vector2.down}) {
                        string label=direction.x<0?"left":"down";
                        var hits=new RaycastHit2D[128];
                        int count=root.Cast(direction,filter,hits,1.2f,true);
                        rows.Add("travelSweep | direction="+label+" | root="+root.GetInstanceID()+
                            " | distance=1.2 | count="+count+" | capacity="+hits.Length);
                        for(int i=0;i<count;i++) {
                            var other=hits[i].collider;
                            rows.Add("travelSweepHit | direction="+label+" | collider="+other.GetInstanceID()+
                                " | path="+Address(other.transform)+" | distance="+hits[i].distance+
                                " | ownChild="+other.transform.IsChildOf(player.transform)+
                                " | ignoredPair="+Physics2D.GetIgnoreCollision(root,other)+
                                " | trigger="+other.isTrigger+" | point="+Vector(hits[i].point));
                        }
                    }
                }
            }
        foreach(var door in Resources.FindObjectsOfTypeAll<TheForestOfLove.Doorway>())
            if(door.gameObject.scene.IsValid()) {
                rows.Add("travelDoor | id="+door.GetInstanceID()+" | path="+Address(door.transform)+
                    " | scene="+door.gameObject.scene.name+" | active="+door.gameObject.activeInHierarchy+
                    " | enabled="+door.enabled+" | destination="+ReadField(door,"sceneName")+
                    " | transitioning="+ReadField(door,"transitioning")+" | delay="+ReadField(door,"secondsBeforeTravel")+
                    " | position="+Vector(door.transform.position));
                TravelColliders(rows,door);
                // Read only loaded pair settings. These queries do not deliver
                // collision callbacks or establish that the Player can walk here.
                // The original spawner reparents Environment under SpawnedContent.
                // Bind loaded scene, destination and surviving Doorways/name suffix;
                // the serialized RootActivator path is not a runtime identity.
                if(door.gameObject.scene.name=="BunnyHouse" &&
                    DiagnosticValue(ReadField(door,"sceneName"))=="CentralForest" &&
                    Address(door.transform).EndsWith("/Doorways/DoorwayToCentralForest",StringComparison.Ordinal))
                    foreach(var player in Resources.FindObjectsOfTypeAll<TheForestOfLove.Player>())
                        if(player.gameObject.scene.IsValid() && player.gameObject.activeInHierarchy)
                            foreach(var playerCollider in player.GetComponentsInChildren<Collider2D>(true))
                                foreach(var doorCollider in door.GetComponentsInChildren<Collider2D>(true))
                                    if(playerCollider.enabled && playerCollider.gameObject.activeInHierarchy &&
                                       doorCollider.enabled && doorCollider.gameObject.activeInHierarchy) {
                                        var distance=playerCollider.Distance(doorCollider);
                                        rows.Add("travelPair | playerCollider="+playerCollider.GetInstanceID()+
                                            " | doorCollider="+doorCollider.GetInstanceID()+
                                            " | ignoredLayers="+Physics2D.GetIgnoreLayerCollision(playerCollider.gameObject.layer,doorCollider.gameObject.layer)+
                                            " | ignoredPair="+Physics2D.GetIgnoreCollision(playerCollider,doorCollider)+
                                            " | touching="+playerCollider.IsTouching(doorCollider)+
                                            " | boundsIntersect="+playerCollider.bounds.Intersects(doorCollider.bounds)+
                                            " | distanceValid="+distance.isValid+" | overlapped="+distance.isOverlapped+
                                            " | distance="+distance.distance+" | playerPoint="+Vector(distance.pointA)+
                                            " | doorPoint="+Vector(distance.pointB));
                                    }
            }
        foreach(var helper in Resources.FindObjectsOfTypeAll<TheForestOfLove.InputHelper>())
            if(helper.gameObject.scene.IsValid()) {
                var inputPlayer=ReadField(helper,"player") as Rewired.Player;
                rows.Add("travelInput | path="+Address(helper.transform)+" | active="+helper.gameObject.activeInHierarchy+
                    " | enabled="+helper.enabled+" | player="+(inputPlayer==null?"null":inputPlayer.id+":"+inputPlayer.name)+
                    " | keyboardMaps="+KeyboardMaps(inputPlayer)+
                    " | joystick="+ObjectAddress(ReadField(helper,"theKingOfJoysticks"))+
                    " | customController="+ObjectAddress(ReadField(helper,"kingOfJoysticksRewiredCustomController"))+
                    " | touch="+ObjectAddress(ReadField(helper,"touchInputHelper")));
            }
        int joysticks=0;
        foreach(var joystick in Resources.FindObjectsOfTypeAll<Itelisoft.KOF.TheKingOfJoysticks>())
            if(joystick.gameObject.scene.IsValid()) {
                joysticks++;
                rows.Add("travelJoystick | path="+Address(joystick.transform)+" | active="+joystick.gameObject.activeInHierarchy+
                    " | enabled="+joystick.enabled+" | inUse="+ReadField(joystick,"inUse")+
                    " | mouseMode="+ReadField(joystick,"mouseMode")+" | disabled="+Itelisoft.KOF.TheKingOfJoysticks.DisableJoystickInput);
            }
        rows.Add("travelJoystickCount | loaded="+joysticks);
        return rows.ToArray();
    }
    // Each getter below has read-only original IL pinned in tutorial-20261026.
    // Never call an oracle, CanTrigger, HasAvailableMessages or IsSatisfied here:
    // those availability paths can evaluate chance and change the later story.
    string[] IntroCleanupDiagnostics() {
        var rows=new List<string>();
        int introControllers=0,bedControllers=0,activeBedControllers=0;
        foreach(var cutscene in Resources.FindObjectsOfTypeAll<TheForestOfLove.IntroBunnyHouseCutscene>())
            if(cutscene.gameObject.scene.IsValid()) {
                introControllers++;
                rows.Add("introCutscene | path="+Address(cutscene.transform)+" | active="+cutscene.gameObject.activeInHierarchy+
                    " | stage="+ReadField(cutscene,"currentStage")+" | timerSet="+ReadField(cutscene,"timerSet")+
                    " | timerSeconds="+ReadField(cutscene,"timerSecondsRemaining"));
            }
        var trigger=TheForestOfLove.Services.Persistence.DataService.GetTriggerByName("Cutscene_IntroBunnyHouse");
        rows.Add("trigger | name=Cutscene_IntroBunnyHouse | count="+(trigger==null?"absent":DiagnosticValue(ReadField(trigger,"<CountActivated>k__BackingField"))));
        foreach(var controller in Resources.FindObjectsOfTypeAll<TheForestOfLove.InteractionUiController>())
            if(controller.gameObject.scene.IsValid() &&
               Address(controller.transform)=="SpawnedContent/Elements/Bed/Content/Bed(Clone)/Interaction/InteractionIconInspect") {
                bedControllers++;
                if(controller.gameObject.activeInHierarchy && controller.enabled)activeBedControllers++;
            }
        rows.Add("introCleanup | remainingControllers="+introControllers+" | bedControllers="+bedControllers+
            " | activeBedControllers="+activeBedControllers);
        return rows.ToArray();
    }
    string[] TutorialRouteDiagnostics() {
        var rows=new List<string>(IntroCleanupDiagnostics());
        rows.Add("guards | gameplay="+TheForestOfLove.Services.SceneManagement.SceneHelper.inGameplayScene+
            " | anyEvent="+TheForestOfLove.Events.GameStateManager.isAnyEventActive+
            " | conversation="+DialogueManager.isConversationActive);
        rows.Add("activeTags | values="+ListValues(TheForestOfLove.Services.Persistence.DataService.GetActiveTags()));
        foreach(var questName in new[]{"Act1_TutorialQuest","Act1_GossipQuest"}) {
            var quest=TheForestOfLove.Services.Persistence.DataService.GetQuestByDbName(questName);
            if(quest==null)throw new Exception("Missing original quest: "+questName);
            rows.Add("quest | name="+quest.dbName+" | status="+(int)quest.status+
                " | enableWithTags="+ListValues(quest.enableWithTags)+" | disableWithTags="+ListValues(quest.disableWithTags));
            foreach(var dialogue in quest.dialogues) {
                rows.Add("questDialogue | name="+dialogue.dbName+" | actor="+dialogue.primaryActorDbName+
                    " | initialActor="+dialogue.initialActorDbName+" | status="+(int)dialogue.status+
                    " | conversation="+(dialogue.pluginDbConversation==null?-1:dialogue.pluginDbConversation.id)+
                    " | type="+dialogue.dialogueType+" | first="+dialogue.isFirstDialogueInQuest+
                    " | last="+dialogue.isLastDialogueInQuest);
                foreach(var arc in dialogue.primaryArcs)
                    rows.Add("primaryArc | dialogue="+dialogue.dbName+" | suffix="+arc.pluginDbSuffix+
                        " | status="+(int)arc.status+" | entry="+(arc.pluginDbFirstDialogueEntry==null?-1:arc.pluginDbFirstDialogueEntry.id));
            }
        }
        foreach(var name in new[]{"Cutscene_IntroForest","intro_from_beaver","intro_from_mouse","intro_from_otter","give_sugar_to_bunny"}) {
            var trigger=TheForestOfLove.Services.Persistence.DataService.GetTriggerByName(name);
            // Read the backing field, including an explicit absent-record result.
            rows.Add("trigger | name="+name+" | count="+(trigger==null?"absent":DiagnosticValue(ReadField(trigger,"<CountActivated>k__BackingField"))));
        }
        foreach(var actor in Resources.FindObjectsOfTypeAll<TheForestOfLove.Gameplay.SpawnableActor>())
            if(actor.gameObject.scene.IsValid())
                rows.Add("actor | path="+Address(actor.transform)+" | id="+actor.GetInstanceID()+
                    " | dbName="+actor.ActorDbName+" | active="+actor.gameObject.activeInHierarchy+
                    " | position="+actor.transform.position);
        foreach(var controller in Resources.FindObjectsOfTypeAll<TheForestOfLove.InteractionUiController>())
            if(controller.gameObject.scene.IsValid()) {
                var actor=ReadField(controller,"character") as TheForestOfLove.Gameplay.SpawnableActor;
                var trigger=ReadField(controller,"dialogueInteractionTrigger") as TheForestOfLove.Interaction.DialogueInteractionTrigger;
                rows.Add("interaction | path="+Address(controller.transform)+" | id="+controller.GetInstanceID()+
                    " | active="+controller.gameObject.activeInHierarchy+" | enabled="+controller.enabled+
                    " | authority="+controller.isAuthority+" | playerTouching="+ReadField(controller,"isPlayerTouching")+
                    " | actor="+(actor==null?"null":actor.ActorDbName)+" | actorObject="+ObjectAddress(actor)+
                    " | ui="+ObjectAddress(ReadField(controller,"interactionUi"))+
                    " | trigger="+ObjectAddress(trigger)+" | options="+ListValues(ReadField(controller,"availableOptions") as IEnumerable)+
                    " | disallowed="+ListValues(ReadField(controller,"disallowedOptions") as IEnumerable));
                if(trigger!=null) {
                    var settings=ReadField(trigger,"settings") as TheForestOfLove.DialogueSettings;
                    rows.Add("interactionTrigger | owner="+controller.GetInstanceID()+" | active="+trigger.gameObject.activeInHierarchy+
                        " | authority="+((int)trigger.GetType().GetField("authorityId",BindingFlags.Static|BindingFlags.NonPublic|BindingFlags.Public).GetValue(null)==trigger.gameObject.GetInstanceID())+" | mode="+trigger.interactionMode+
                        " | touching="+ReadField(trigger,"isPlayerTouching")+" | triggered="+ReadField(trigger,"isTriggered")+
                        " | onCollision="+ReadField(trigger,"triggerOnCollision")+" | cooldown="+ReadField(trigger,"cooldownLoopsRemaining")+
                        " | actor="+(settings==null?"null":settings.ActorDbName)+
                        " | dialogue="+(settings==null?"null":settings.DialogueDbName)+" | arc="+(settings==null?"null":settings.ArcDbName));
                }
            }
        foreach(var ui in Resources.FindObjectsOfTypeAll<TheForestOfLove.InteractionUi>())
            if(ui.gameObject.scene.IsValid())
                rows.Add("interactionUi | path="+Address(ui.transform)+" | active="+ui.gameObject.activeInHierarchy+
                    " | visible="+TheForestOfLove.InteractionUi.visible+" | locked="+ui.locked+" | selected="+ui.currentSelectedOption+
                    " | available="+ListValues(ReadField(ui,"availableOptions") as IEnumerable));
        return rows.ToArray();
    }
    static void NotebookConditionFields(List<string> rows, object condition, string prefix, int depth) {
        if(condition==null)return;
        foreach(var field in condition.GetType().GetFields(BindingFlags.Instance|BindingFlags.Public|BindingFlags.NonPublic)) {
            var value=field.GetValue(condition); var values=value as IEnumerable;
            var key=prefix+field.Name;
            if(values!=null && !(value is string)) {
                var items=new List<string>();
                foreach(var item in values) {
                    if(items.Count>=64)throw new Exception("Unexpected notebook condition size");
                    items.Add(DiagnosticValue(item));
                }
                rows.Add("notebookCondition | field="+key+" | values="+String.Join(",",items.ToArray()));
            } else {
                rows.Add("notebookCondition | field="+key+" | value="+DiagnosticValue(value));
                if(depth>0 && value!=null && value.GetType().Namespace=="TheForestOfLove.Narrative.DialoguePreconditions")
                    NotebookConditionFields(rows,value,key+".",depth-1);
            }
        }
    }
    string[] NotebookRouteDiagnostics() {
        var rows=new List<string>();
        rows.Add("guards | gameplay="+TheForestOfLove.Services.SceneManagement.SceneHelper.inGameplayScene+
            " | dustin="+TheForestOfLove.Services.SceneManagement.SceneHelper.inDustinMinigame+
            " | glitch="+TheForestOfLove.Services.SceneManagement.SceneHelper.inGlitchRoom+
            " | anyEvent="+TheForestOfLove.Events.GameStateManager.isAnyEventActive+
            " | notebookLearned="+TheForestOfLove.QuestTriggerHelper.PlayerLearnedNotebook());
        foreach(var log in Resources.FindObjectsOfTypeAll<TheForestOfLove.MasterLog>())
            if(log.gameObject.scene.IsValid()) {
                var panel=(PixelCrushers.UIPanel)log.GetType().GetField("masterLogUi",BindingFlags.Instance|BindingFlags.NonPublic|BindingFlags.Public).GetValue(log);
                rows.Add("masterLog | path="+Address(log.transform)+" | active="+log.gameObject.activeInHierarchy+
                    " | open="+panel.isOpen+" | page="+log.currentPage);
            }
        foreach(var ui in Resources.FindObjectsOfTypeAll<TheForestOfLove.ChapterSelectUI>())
            if(ui.gameObject.scene.IsValid()) {
                var flags=BindingFlags.Instance|BindingFlags.NonPublic|BindingFlags.Public;
                var type=ui.GetType();
                var cg=(CanvasGroup)type.GetField("gossipUICanvasGroup",flags).GetValue(ui);
                rows.Add("chapterUi | path="+Address(ui.transform)+" | active="+ui.gameObject.activeInHierarchy+
                    " | visible="+TheForestOfLove.ChapterSelectUI.visible+" | locked="+ui.LockInteractions+
                    " | alpha="+(cg==null?"null":cg.alpha.ToString())+
                    " | selectedLabel="+type.GetField("itemLabelSelectedIndex",flags).GetValue(ui)+
                    " | selectedItem="+type.GetField("gossipItemSelectedIndex",flags).GetValue(ui)+
                    " | waitingForSubmitClear="+type.GetField("waitingForSubmitButtonToClear",flags).GetValue(ui));
                foreach(var item in (IEnumerable)type.GetField("gossipItems",flags).GetValue(ui)) {
                    var t=item.GetType();
                    rows.Add("chapterUiItem | chapter="+t.GetField("unlockStopPoint",flags).GetValue(item)+
                        " | text="+t.GetField("displayText",flags).GetValue(item)+
                        " | scene="+t.GetField("respawnInScene",flags).GetValue(item)+
                        " | spawn="+t.GetField("namedSpawnPoint",flags).GetValue(item));
                }
            }
        foreach(var chapter in TheForestOfLove.Services.Persistence.DataService.GetChapterRecords()) {
            var triggers=new List<string>();
            foreach(var trigger in chapter.unlockTriggers)triggers.Add(trigger.name);
            rows.Add("chapter | id="+(int)chapter.unlockStopPoint+" | title="+chapter.title+
                " | unlocked="+chapter.IsUnlocked+" | parent="+(chapter.parent==null?"null":((int)chapter.parent.unlockStopPoint).ToString())+
                " | scene="+chapter.respawnInScene+" | unlockTriggers="+String.Join(",",triggers.ToArray()));
        }
        foreach(var chapter in TheForestOfLove.Services.Persistence.DataService.GetGlobalChapterRecords())
            rows.Add("globalChapter | id="+(int)chapter.unlockStopPoint+" | unlocked="+chapter.IsUnlocked);
        var dialogue=TheForestOfLove.Services.Persistence.DataService.GetDialogueByPluginDbId(225);
        if(dialogue!=null) {
            rows.Add("notebookDialogue | dbName="+dialogue.dbName+" | actor="+DiagnosticValue(dialogue.primaryActor)+
                " | quest="+DiagnosticValue(dialogue.quest)+" | status="+dialogue.status);
            foreach(var condition in dialogue.preconditions) {
                // Read fields only: evaluating IsSatisfied can consume random chance.
                NotebookConditionFields(rows,condition,condition.GetType().Name+".",1);
            }
        }
        if(dialogue!=null)foreach(var trigger in dialogue.arcTriggers) {
            var named=trigger as TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger;
            if(named!=null && named.triggerPluginDbName=="notebook_unlocked")
                rows.Add("notebookTrigger | conversation="+named.GetConversationId()+" | entry="+named.GetDialogueEntryId()+
                    " | executed="+named.isExecuted+" | skipChapterSelect="+named.skipDuringChapterSelect);
        }
        foreach(var ticker in Resources.FindObjectsOfTypeAll<TheForestOfLove.InventoryInfoTicker>())
            if(ticker.gameObject.scene.IsValid()) {
                rows.Add("ticker | instance="+ticker.GetInstanceID()+" | path="+Address(ticker.transform)+
                    " | activeSelf="+ticker.gameObject.activeSelf+" | activeInHierarchy="+ticker.gameObject.activeInHierarchy+
                    " | enabled="+ticker.enabled+" | isActiveAndEnabled="+ticker.isActiveAndEnabled);
                foreach(var key in new[]{"itemTitleText","tickerText"}) {
                    var t=(Text)ticker.GetType().GetField(key,BindingFlags.Instance|BindingFlags.NonPublic|BindingFlags.Public).GetValue(ticker);
                    rows.Add("tickerText | controller="+ticker.GetInstanceID()+" | field="+key+" | path="+Address(t.transform)+
                        " | active="+t.gameObject.activeInHierarchy+" | enabled="+t.enabled+" | text="+t.text);
                }
            }
        return rows.ToArray();
    }
    List<ResponseRow> ReadResponses() {
        var responses=new List<ResponseRow>();
        foreach(var b in Resources.FindObjectsOfTypeAll<StandardUIResponseButton>())
            if(b.gameObject.scene.IsValid() && b.gameObject.activeInHierarchy && b.response!=null && b.response.destinationEntry!=null)
                responses.Add(new ResponseRow{path=Address(b.transform),text=b.text,
                    targetPath=b.target==null?"":Address(b.target),visible=b.isVisible,clickable=b.isClickable,
                    conversationId=b.response.destinationEntry.conversationID,entryId=b.response.destinationEntry.id});
        return responses;
    }
    const string TutorialUI="Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI";
    const string TutorialTextPanel=TutorialUI+"/Dialogue Panel/Text Panel";
    const string Tutorial158Text="So tell me. What is it you’re here for?";
    // Compile-time admission: resource strings never select or broaden the mode.
    const string TutorialChoiceMode =
#if SYNTHETIC_TUTORIAL_CHOICES
        "synthetic";
#else
        "original";
#endif
    static string TutorialChoiceText(int id) {
        if(id!=159 && id!=181)throw new Exception("Unapproved Tutorial choice ID");
#if SYNTHETIC_TUTORIAL_CHOICES
        return id==159?"Ёж Йй Щъ Ыь Эю Яя; 123 — Latin!":"Е\u0308 и\u0306; ё й. Съешь ещё этих булок!";
#else
        return id==159?"Well… uhh… You see…":"The love. Definitely the love.";
#endif
    }
    TutorialCompletion ReadTutorialCompletion(out Button button) {
        var current=DialogueManager.currentConversationState;
        var subtitle=current==null?null:current.subtitle;
        var entry=subtitle==null?null:subtitle.dialogueEntry;
        if(!DialogueManager.isConversationActive || entry==null || entry.conversationID!=120 || entry.id!=158 ||
           TheForestOfLove.Narrative.DialogueService.CurrentDialogueDbName!="TutorialQuest_IntroFromBunny" ||
           !String.IsNullOrEmpty(TheForestOfLove.Narrative.DialogueService.CurrentArcName) ||
           subtitle.formattedText==null || subtitle.formattedText.text!=Tutorial158Text ||
           entry.DialogueText!="[pic=3]"+Tutorial158Text || entry.ActorID!=2 || entry.ConversantID!=1 ||
           !String.IsNullOrEmpty(entry.conditionsString) || !String.IsNullOrEmpty(entry.userScript) ||
           !String.IsNullOrEmpty(entry.MenuText) || !String.IsNullOrEmpty(entry.Sequence) ||
           !String.IsNullOrEmpty(entry.ResponseMenuSequence) || (entry.onExecute!=null && entry.onExecute.GetPersistentEventCount()!=0))
            throw new Exception("Tutorial158 exact source/binding differs");
        if(entry.outgoingLinks==null || entry.outgoingLinks.Count!=2 || current.hasNPCResponse ||
           current.pcResponses==null || current.pcResponses.Length!=2)
            throw new Exception("Tutorial158 source/available destinations differ");
        var destinations=new HashSet<int>();
        foreach(var link in entry.outgoingLinks) {
            if(link.originConversationID!=120 || link.originDialogueID!=158 || link.destinationConversationID!=120 ||
               (link.destinationDialogueID!=159 && link.destinationDialogueID!=181) || link.isConnector || (int)link.priority!=2 ||
               !destinations.Add(link.destinationDialogueID))
                throw new Exception("Tutorial158 source links differ");
        }
        destinations.Clear();
        foreach(var response in current.pcResponses) {
            var target=response==null?null:response.destinationEntry;
            var expected=target==null?null:TutorialChoiceText(target.id);
            if(target==null || target.conversationID!=120 || (target.id!=159 && target.id!=181) ||
               !destinations.Add(target.id) || target.ActorID!=1 || target.ConversantID!=2 || target.isGroup ||
               target.DialogueText!=expected || !String.IsNullOrEmpty(target.MenuText) ||
               !String.IsNullOrEmpty(target.conditionsString) || !String.IsNullOrEmpty(target.userScript) ||
               !String.IsNullOrEmpty(target.Sequence) || !String.IsNullOrEmpty(target.ResponseMenuSequence) ||
               (target.onExecute!=null && target.onExecute.GetPersistentEventCount()!=0) ||
               response.formattedText==null || response.formattedText.text!=expected || response.formattedText.forceAuto)
                throw new Exception("Tutorial158 PC destination/text/conditions differ");
        }
        var rows=ReadResponses();
        bool menu=rows.Count!=0;
        if(menu) {
            destinations.Clear();
            foreach(var row in rows) {
                var expected=TutorialChoiceText(row.entryId);
                if(rows.Count!=2 || !row.visible || !row.clickable || row.conversationId!=120 ||
                   (row.entryId!=159 && row.entryId!=181) || !destinations.Add(row.entryId) || row.text!=expected ||
                   row.targetPath!=TutorialUI || row.path!=TutorialTextPanel+"/Response Menu Panel/Viewport/Content/Response: "+expected)
                    throw new Exception("Tutorial158 original response controls differ");
            }
        }
        StandardUISubtitlePanel panel=null;
        foreach(var p in Resources.FindObjectsOfTypeAll<StandardUISubtitlePanel>())
            if(p.gameObject.scene.IsValid() && Address(p.transform)==TutorialTextPanel+"/Subtitle Panel 0") {
                if(panel!=null)throw new Exception("Ambiguous Tutorial158 subtitle panel");panel=p;
            }
        if(panel==null || panel.continueButton==null || panel.subtitleText==null || panel.subtitleText.textMeshProUGUI==null)
            throw new Exception("Tutorial158 original subtitle control missing");
        button=panel.continueButton;
        var tmp=panel.subtitleText.textMeshProUGUI;
        var handler=button.GetComponent<TheForestOfLove.TextMeshProUIContinueButtonFastForward>();
        if(Address(button.transform)!=TutorialTextPanel+"/Continue Button" || Address(tmp.transform)!=TutorialTextPanel+"/Subtitle Text" ||
           handler==null || !handler.enabled || handler.febucciTypewriterEffect==null || handler.febucciTypewriterEffect.transform!=tmp.transform ||
           handler.hideContinueButtonOnContinue || !handler.continueSubtitlePanel || !handler.continueAlertPanel ||
           button.onClick.GetPersistentEventCount()!=1 || button.onClick.GetPersistentTarget(0)!=handler ||
           button.onClick.GetPersistentMethodName(0)!="OnFastForward")
            throw new Exception("Tutorial158 original Continue binding differs");
        if(!menu && (!panel.gameObject.activeInHierarchy || !panel.enabled || panel.currentSubtitle!=subtitle ||
           !button.gameObject.activeInHierarchy || !button.enabled || !button.IsInteractable()))
            throw new Exception("Tutorial158 original Continue not active/bound/interactable");
        return new TutorialCompletion{choiceMode=TutorialChoiceMode,frame=Time.frameCount,conversationId=120,entryId=158,text=subtitle.formattedText.text,
            sourceText=entry.DialogueText,panelPath=Address(panel.transform),buttonPath=Address(button.transform),textPath=Address(tmp.transform),
            targetPath=TutorialUI,listenerMethod="OnFastForward",listenerTargetPath=Address(handler.transform),
            sourceDestinations="120:159,120:181",pcDestinations="120:159,120:181",graphVerified=true,
            panelInstance=panel.GetInstanceID(),buttonInstance=button.GetInstanceID(),textInstance=tmp.GetInstanceID(),
            typing=TheForestOfLove.CustomTypewriterEffectTextMeshPro.IsTyping(),menuPresent=menu,
            buttonActive=button.gameObject.activeInHierarchy,buttonEnabled=button.enabled,buttonInteractable=button.IsInteractable()};
    }
    void ReadTutorialCompletionRecord(State state) {
        if(state.conversationActive && state.conversationId==120 && state.entryId==158) {
            Button button;
            state.tutorialCompletionRecord=JsonUtility.ToJson(ReadTutorialCompletion(out button));
            if(TutorialChoiceMode=="original" && !state.typing && ReadResponses().Count==2) {
                // Optional selection admission must not discard the established
                // read-only menu snapshot. Selection still independently fails closed.
                state.tutorial181ControlRecord=JsonUtility.ToJson(ReadTutorial181Control());
                try { state.tutorial181Record=JsonUtility.ToJson(ReadTutorial181(out button)); }
                catch(Exception ex) { state.tutorial181Record=JsonUtility.ToJson(new Tutorial181Rejection{error=ex.Message}); }
            }
        }
    }
    Tutorial181Control ReadTutorial181Control() {
        var result=new Tutorial181Control{persistentListenerCount=-1};
        foreach(var candidate in Resources.FindObjectsOfTypeAll<StandardUIResponseButton>())
            if(candidate.gameObject.scene.IsValid() && candidate.gameObject.activeInHierarchy && candidate.response!=null &&
               candidate.response.destinationEntry!=null && candidate.response.destinationEntry.id==181) {
                result.matches++;
                result.controllerType=candidate.GetType().FullName;result.controllerEnabled=candidate.enabled;
                result.controllerInstance=candidate.GetInstanceID();result.text=candidate.text;
                result.path=Address(candidate.transform);result.targetPath=candidate.target==null?"":Address(candidate.target);
                result.visible=candidate.isVisible;result.clickable=candidate.isClickable;
                var button=candidate.button;
                if(button!=null) {
                    result.buttonInstance=button.GetInstanceID();result.buttonPath=Address(button.transform);
                    result.buttonEnabled=button.enabled;result.buttonInteractable=button.IsInteractable();
                    result.sameTransform=button.transform==candidate.transform;
                    result.persistentListenerCount=button.onClick.GetPersistentEventCount();
                }
            }
        return result;
    }
    static void Tutorial181Entry(DialogueEntry entry, int id, string text, int actor, int conversant, int successor) {
        if(entry==null || entry.conversationID!=120 || entry.id!=id || entry.DialogueText!=text ||
           entry.ActorID!=actor || entry.ConversantID!=conversant || entry.isGroup ||
           !String.IsNullOrEmpty(entry.conditionsString) || !String.IsNullOrEmpty(entry.userScript) ||
           !String.IsNullOrEmpty(entry.MenuText) || !String.IsNullOrEmpty(entry.Sequence) ||
           !String.IsNullOrEmpty(entry.ResponseMenuSequence) ||
           (entry.onExecute!=null && entry.onExecute.GetPersistentEventCount()!=0) ||
           entry.outgoingLinks==null || entry.outgoingLinks.Count!=1)
            throw new Exception("Tutorial181 exact destination source differs");
        var link=entry.outgoingLinks[0];
        if(link.originConversationID!=120 || link.originDialogueID!=id || link.destinationConversationID!=120 ||
           link.destinationDialogueID!=successor || link.isConnector || (int)link.priority!=2)
            throw new Exception("Tutorial181 exact destination link differs");
    }
    Tutorial181Selection ReadTutorial181(out Button button) {
        if(TutorialChoiceMode!="original")throw new Exception("Tutorial181 requires original mode");
        Button unused;
        var completion=ReadTutorialCompletion(out unused);
        if(completion.typing || !completion.menuPresent)throw new Exception("Tutorial181 requires fresh non-typing menu");
        StandardUIResponseButton match=null;
        foreach(var candidate in Resources.FindObjectsOfTypeAll<StandardUIResponseButton>())
            if(candidate.gameObject.scene.IsValid() && candidate.gameObject.activeInHierarchy && candidate.response!=null &&
               candidate.response.destinationEntry!=null && candidate.response.destinationEntry.id==181) {
                if(match!=null)throw new Exception("Ambiguous Tutorial181 button");match=candidate;
            }
        const string label="The love. Definitely the love.";
        string path=TutorialTextPanel+"/Response Menu Panel/Viewport/Content/Response: "+label;
        // The original serialized MonoScript is the empty Wrappers subclass.
        // Keep exact-type admission; its inherited OnClick still declares the base.
        if(match==null || match.GetType()!=typeof(PixelCrushers.DialogueSystem.Wrappers.StandardUIResponseButton) || !match.enabled ||
           !match.isVisible || !match.isClickable || match.text!=label || Address(match.transform)!=path ||
           match.target==null || Address(match.target)!=TutorialUI || match.button==null ||
           match.button.transform!=match.transform || !match.button.enabled || !match.button.IsInteractable() ||
           match.button.onClick.GetPersistentEventCount()!=0)
            throw new Exception("Tutorial181 original response control differs");
        Tutorial181Entry(match.response.destinationEntry,181,label,1,2,182);
        Tutorial181Entry(DialogueManager.masterDatabase.GetDialogueEntry(120,182),182,"[pic=2]Hahaha!",2,1,183);
        // Original StandardUIResponseButton.Start installs one runtime OnClick
        // delegate. Read the real invocation list without preparing/replacing it.
        var calls=typeof(UnityEngine.Events.UnityEventBase).GetField("m_Calls",BindingFlags.Instance|BindingFlags.NonPublic).GetValue(match.button.onClick);
        var runtime=ReadField(calls,"m_RuntimeCalls") as IList;
        if(runtime==null || runtime.Count!=1)throw new Exception("Tutorial181 runtime listener count differs");
        var callback=ReadField(runtime[0],"Delegate") as Delegate;
        if(callback==null || callback.GetInvocationList().Length!=1 || !System.Object.ReferenceEquals(callback.Target,match) ||
           callback.Method.Name!="OnClick" || callback.Method.DeclaringType!=typeof(StandardUIResponseButton))
            throw new Exception("Tutorial181 runtime listener target differs");
        button=match.button;
        return new Tutorial181Selection{choiceMode=TutorialChoiceMode,frame=Time.frameCount,conversationId=120,
            sourceId=158,destinationId=181,successorId=182,text=label,path=path,targetPath=TutorialUI,
            listenerMethod="OnClick",listenerTargetPath=path,buttonInstance=button.GetInstanceID(),
            controllerInstance=match.GetInstanceID(),typing=false,graphVerified=true,listenerVerified=true};
    }
    // Exact source graph calls are produced by tools/prepare_bucky141.py.
    // BEGIN BUCKY141 GRAPH
    void Bucky141Graph() {
        Bucky141Entry(215,"","He… seems to be quitely snoring… Wake him up?",7,1,"",new int[]{216,217});
        Bucky141Entry(216,"","No",1,3,"",new int[]{});
        Bucky141Entry(217,"","Yes",1,3,"",new int[]{194});
        Bucky141Entry(194,"","[pic=3]Zzz… Zzz…",3,1,"",new int[]{195});
        Bucky141Entry(195,"","[pic=3]Zzz- H",3,1,"",new int[]{196});
        Bucky141Entry(196,"","[pic=2]uh~! Wha?",3,1,"",new int[]{197});
        Bucky141Entry(197,"","[pic=4]Oh-",3,1,"",new int[]{198});
        Bucky141Entry(198,"","[pic=1]Hello there!",3,1,"",new int[]{199});
        Bucky141Entry(199,"","[pic=1]You must be that new fella!",3,1,"",new int[]{200});
        Bucky141Entry(200,"","[pic=1]Good to see ya back on your paws!",3,1,"",new int[]{201});
        Bucky141Entry(201,"","The beaver lets out a long yawn.",7,1,"",new int[]{202});
        Bucky141Entry(202,"","[pic=2]Sorry - ya caught me in the middle of my afternoon nap!",3,1,"",new int[]{203});
        Bucky141Entry(203,"","[pic=1]Anyways, the name’s Barnaby Webbz!",3,1,"",new int[]{204});
        Bucky141Entry(204,"","[pic=2]But you can just call me Bucky!",3,1,"",new int[]{205});
        Bucky141Entry(205,"","[pic=4]And what’s your name, pal?",3,1,"",new int[]{206});
        Bucky141Entry(206,"","Rascal! Rascal Redtail.",1,3,"",new int[]{207});
        Bucky141Entry(207,"","[pic=1]The pleasure’s all mine Rascal!",3,1,"",new int[]{208});
        Bucky141Entry(208,"","[pic=4]I’m the town’s handyman!",3,1,"",new int[]{209});
        Bucky141Entry(209,"","[pic=1]Fixing, crafting, building, you name it!",3,1,"",new int[]{210});
        Bucky141Entry(210,"","[pic=1]If there’s anything ya need during your stay, don’t hesitate to ask!",3,1,"",new int[]{211});
        Bucky141Entry(211,"","[pic=2]Until then… I kinda wanna get back to my nap…",3,1,"",new int[]{212});
        Bucky141Entry(212,"","[pic=1]I’m sure I’ll be seeing ya again very soon!",3,1,"",new int[]{});
        Bucky141Entry(218,"PRIMARY","",3,1,"None()",new int[]{215});
        Bucky141Entry(192,"TRIGGER(intro_from_beaver)","",3,1,"None()",new int[]{212});
        Bucky141Entry(225,"FINISHSTEP","",3,1,"None()",new int[]{212});
        Bucky141Entry(235,"FINISHARC(p1)","",3,1,"None()",new int[]{212});
    }
    // END BUCKY141 GRAPH
    void Bucky141Entry(int id,string title,string text,int actor,int conversant,string sequence,int[] destinations) {
        var entry=DialogueManager.masterDatabase.GetDialogueEntry(141,id);
        if(entry==null || entry.conversationID!=141 || entry.id!=id || entry.Title!=title || entry.DialogueText!=text ||
           entry.ActorID!=actor || entry.ConversantID!=conversant || entry.isRoot || entry.isGroup || entry.delaySimStatus ||
           entry.falseConditionAction!="Block" || (int)entry.conditionPriority!=2 ||
           !String.IsNullOrEmpty(entry.conditionsString) || !String.IsNullOrEmpty(entry.userScript) ||
           !String.IsNullOrEmpty(entry.MenuText) || entry.Sequence!=sequence || !String.IsNullOrEmpty(entry.ResponseMenuSequence) ||
           (entry.onExecute!=null && entry.onExecute.GetPersistentEventCount()!=0) ||
           entry.outgoingLinks==null || entry.outgoingLinks.Count!=destinations.Length)
            throw new Exception("Bucky141 exact source/actor/control differs: "+id);
        for(int i=0;i<destinations.Length;i++) {
            var link=entry.outgoingLinks[i];
            if(link.originConversationID!=141 || link.originDialogueID!=id || link.destinationConversationID!=141 ||
               link.destinationDialogueID!=destinations[i] || link.isConnector || (int)link.priority!=2)
                throw new Exception("Bucky141 exact source link differs: "+id);
        }
    }
    Bucky141Subtitle ReadBucky141() {
        if(TutorialChoiceMode!="original" || !DialogueManager.isConversationActive ||
           TheForestOfLove.Narrative.DialogueService.CurrentDialogueDbName!="TutorialQuest_BeaverIntroduction" ||
           TheForestOfLove.Narrative.DialogueService.CurrentArcName!="p1" ||
           UnityEngine.SceneManagement.SceneManager.GetActiveScene().name!="CentralForest")
            throw new Exception("Bucky141 original narrative binding differs");
        var current=DialogueManager.currentConversationState;
        var subtitle=current==null?null:current.subtitle;
        var entry=subtitle==null?null:subtitle.dialogueEntry;
        if(entry==null || entry.conversationID!=141 || (entry.id!=215 && entry.id!=217 && (entry.id<194 || entry.id>212)))
            throw new Exception("Bucky141 unexpected current entry");
        Bucky141Graph();
        if(!System.Object.ReferenceEquals(entry,DialogueManager.masterDatabase.GetDialogueEntry(141,entry.id)))
            throw new Exception("Bucky141 current source entry identity differs");
        var expected=entry.DialogueText;
        if(expected.StartsWith("[pic="))expected=expected.Substring(expected.IndexOf(']')+1);
        if(subtitle.formattedText==null || subtitle.formattedText.text!=expected)
            throw new Exception("Bucky141 exact current subtitle differs");
        return new Bucky141Subtitle{choiceMode=TutorialChoiceMode,frame=Time.frameCount,conversationId=141,entryId=entry.id,
            sourceText=entry.DialogueText,actorId=entry.ActorID,conversantId=entry.ConversantID,graphVerified=true};
    }
    Bucky217Selection ReadBucky217(out Button button) {
        var source=ReadBucky141();
        if(source.entryId!=215 || TheForestOfLove.CustomTypewriterEffectTextMeshPro.IsTyping())
            throw new Exception("Bucky217 requires fresh non-typing215 menu");
        var responses=ReadResponses();
        if(responses.Count!=2 || DialogueManager.currentConversationState.pcResponses==null ||
           DialogueManager.currentConversationState.pcResponses.Length!=2)
            throw new Exception("Bucky217 exact two choices absent");
        var ids=new HashSet<int>();
        foreach(var response in DialogueManager.currentConversationState.pcResponses) {
            var entry=response.destinationEntry;
            if(entry==null || (entry.id!=216 && entry.id!=217) || !ids.Add(entry.id) ||
               !System.Object.ReferenceEquals(entry,DialogueManager.masterDatabase.GetDialogueEntry(141,entry.id)) ||
               response.formattedText==null || response.formattedText.text!=entry.DialogueText || response.formattedText.forceAuto)
                throw new Exception("Bucky217 exact PC source choices differ");
        }
        ids.Clear();
        foreach(var row in responses) {
            string label=row.entryId==216?"No":"Yes";
            if((row.entryId!=216 && row.entryId!=217) || !ids.Add(row.entryId) || row.conversationId!=141 ||
               row.text!=label || !row.visible || !row.clickable || row.targetPath!=TutorialUI ||
               row.path!=TutorialTextPanel+"/Response Menu Panel/Viewport/Content/Response: "+label)
                throw new Exception("Bucky217 original response rows differ");
        }
        StandardUIResponseButton chosen=null, declined=null;
        foreach(var candidate in Resources.FindObjectsOfTypeAll<StandardUIResponseButton>()) {
            if(!candidate.gameObject.scene.IsValid() || !candidate.gameObject.activeInHierarchy || candidate.response==null ||
               candidate.response.destinationEntry==null)continue;
            var entry=candidate.response.destinationEntry;
            string label=entry.id==216?"No":"Yes";
            string path=TutorialTextPanel+"/Response Menu Panel/Viewport/Content/Response: "+label;
            if(entry.conversationID!=141 || (entry.id!=216 && entry.id!=217) ||
               candidate.GetType()!=typeof(PixelCrushers.DialogueSystem.Wrappers.StandardUIResponseButton) ||
               !candidate.enabled || !candidate.isVisible || !candidate.isClickable || candidate.text!=label ||
               Address(candidate.transform)!=path || candidate.target==null || Address(candidate.target)!=TutorialUI ||
               candidate.button==null || candidate.button.transform!=candidate.transform || !candidate.button.enabled ||
               !candidate.button.IsInteractable() || candidate.button.onClick.GetPersistentEventCount()!=0 ||
               !System.Object.ReferenceEquals(entry,DialogueManager.masterDatabase.GetDialogueEntry(141,entry.id)) ||
               candidate.response.formattedText==null || candidate.response.formattedText.text!=label || candidate.response.formattedText.forceAuto)
                throw new Exception("Bucky217 original response control differs");
            // Both No and Yes must have the original empty wrapper and one inherited base OnClick.
            var calls=typeof(UnityEngine.Events.UnityEventBase).GetField("m_Calls",BindingFlags.Instance|BindingFlags.NonPublic).GetValue(candidate.button.onClick);
            var runtime=ReadField(calls,"m_RuntimeCalls") as IList;
            if(runtime==null || runtime.Count!=1)throw new Exception("Bucky217 runtime listener count differs");
            var callback=ReadField(runtime[0],"Delegate") as Delegate;
            if(callback==null || callback.GetInvocationList().Length!=1 || !System.Object.ReferenceEquals(callback.Target,candidate) ||
               callback.Method.Name!="OnClick" || callback.Method.DeclaringType!=typeof(StandardUIResponseButton))
                throw new Exception("Bucky217 runtime listener target differs");
            if(entry.id==217) {if(chosen!=null)throw new Exception("Ambiguous Bucky217 button");chosen=candidate;}
            else {if(declined!=null)throw new Exception("Ambiguous Bucky216 button");declined=candidate;}
        }
        if(chosen==null || declined==null || chosen==declined || chosen.button==declined.button)
            throw new Exception("Bucky217 original distinct buttons absent");
        button=chosen.button;
        string chosenPath=Address(chosen.transform);
        return new Bucky217Selection{choiceMode=TutorialChoiceMode,frame=Time.frameCount,conversationId=141,sourceId=215,
            destinationId=217,successorId=194,text="Yes",path=chosenPath,targetPath=TutorialUI,listenerMethod="OnClick",
            listenerTargetPath=chosenPath,buttonInstance=button.GetInstanceID(),controllerInstance=chosen.GetInstanceID(),
            declinedButtonInstance=declined.button.GetInstanceID(),declinedControllerInstance=declined.GetInstanceID(),
            controllerType=chosen.GetType().FullName,declinedControllerType=declined.GetType().FullName,
            listenerDeclaringType=typeof(StandardUIResponseButton).FullName,declinedListenerDeclaringType=typeof(StandardUIResponseButton).FullName,
            typing=false,graphVerified=true,listenerVerified=true};
    }
    void ObserveBucky212End(TheForestOfLove.Narrative.Dialogue dialogue,TheForestOfLove.Narrative.Arc arc,int conversationId,int entryId) {
        // Passive real original event callback; never dispatch, evaluate predicates or change narrative state.
        if(!bucky217Selected || conversationId!=141 || entryId!=212)return;
        bucky212End=new Bucky212End{dbName=dialogue==null?"":dialogue.dbName,arc=arc==null?"":arc.pluginDbSuffix,
            conversationId=conversationId,entryId=entryId,frame=Time.frameCount,realtime=Time.realtimeSinceStartup,
            count=bucky212End==null?1:bucky212End.count+1};
    }
    string[] BuckyCompletionDiagnostics() {
        var rows=new List<string>(TutorialRouteDiagnostics());
        rows.Add("buckyCompletion | notebookLearned="+TheForestOfLove.QuestTriggerHelper.PlayerLearnedNotebook()+
            " | observerArmed="+(buckyLineEndSource!=null)+" | lineEnd="+(bucky212End==null?"null":JsonUtility.ToJson(bucky212End)));
        var dialogue=TheForestOfLove.Services.Persistence.DataService.GetDialogueByDbName("TutorialQuest_BeaverIntroduction");
        if(dialogue==null)throw new Exception("Bucky completion dialogue absent");
        foreach(var trigger in dialogue.arcTriggers) {
            var named=trigger as TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger;
            rows.Add("buckyArcTrigger | type="+trigger.GetType().FullName+" | conversation="+trigger.GetConversationId()+
                " | entry="+trigger.GetDialogueEntryId()+" | executed="+trigger.isExecuted+
                " | namedTrigger="+(named==null?"":named.triggerPluginDbName));
        }
        var notebook=TheForestOfLove.Services.Persistence.DataService.GetDialogueByPluginDbId(225);
        if(notebook==null || notebook.dbName!="GossipQuest_GetTheNotebook")throw new Exception("Notebook completion dialogue differs");
        foreach(var trigger in notebook.arcTriggers) {
            var named=trigger as TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger;
            if(named!=null && named.triggerPluginDbName=="notebook_unlocked")
                rows.Add("buckyNotebookTrigger | conversation="+named.GetConversationId()+" | entry="+named.GetDialogueEntryId()+" | executed="+named.isExecuted);
        }
        return rows.ToArray();
    }
    void ReadBuckyRecords(State state) {
        state.bucky212EndRecord=bucky212End==null?"":JsonUtility.ToJson(bucky212End);
        if(!state.conversationActive || state.conversationId!=141)return;
        try {
            state.bucky141Record=JsonUtility.ToJson(ReadBucky141());
            if(state.entryId==215 && !state.typing && ReadResponses().Count!=0) {
                Button button;state.bucky217Record=JsonUtility.ToJson(ReadBucky217(out button));
            }
        } catch(Exception ex) {state.bucky141Record=JsonUtility.ToJson(new Tutorial181Rejection{error=ex.Message});}
    }
    void ReadConversation(State state) {
        state.conversationActive=DialogueManager.isConversationActive;
        // Read scalar state only; never serialize the conversation graph.
        if(state.conversationActive && DialogueManager.currentConversationState!=null) {
            var subtitle=DialogueManager.currentConversationState.subtitle;
            if(subtitle!=null) {
                state.conversationState=subtitle.formattedText==null?"":subtitle.formattedText.text;
                if(subtitle.dialogueEntry!=null) {
                    state.conversationId=subtitle.dialogueEntry.conversationID;
                    state.entryId=subtitle.dialogueEntry.id;
                }
            }
        }
    }
    void DumpIntro() {
        // Recheck on this game-thread command: service lifetime can change after
        // a preceding save sample. No manifest consumer runs on a scalar sample.
        var state=new State{scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
            dataPath=Application.dataPath,persistentDataPath=Application.persistentDataPath,
            company=Application.companyName,product=Application.productName,
            frame=Time.frameCount,realtime=Time.realtimeSinceStartup,scaledTime=Time.time,timeScale=Time.timeScale,
            responseRecords=new string[0],introDiagnostics=new string[0]};
        state.notReady=ContinuationReadiness(out state.dataServicePresent,out state.manifestPresent,out state.dataServiceInstance);
        state.diagnosticsReady=state.notReady.Length==0;
        if(state.diagnosticsReady) {
            var responses=ReadResponses();
            var rows=new List<string>();
            rows.Add("guards | gameplay="+TheForestOfLove.Services.SceneManagement.SceneHelper.inGameplayScene+
                " | dustin="+TheForestOfLove.Services.SceneManagement.SceneHelper.inDustinMinigame+
                " | glitch="+TheForestOfLove.Services.SceneManagement.SceneHelper.inGlitchRoom+
                " | anyEvent="+TheForestOfLove.Events.GameStateManager.isAnyEventActive);
            rows.AddRange(IntroCleanupDiagnostics());
            state.narrativeDbName=TheForestOfLove.Narrative.DialogueService.CurrentDialogueDbName;
            state.narrativeArcName=TheForestOfLove.Narrative.DialogueService.CurrentArcName;
            state.responseCount=responses.Count;
            state.responseRecords=responses.ConvertAll(row=>JsonUtility.ToJson(row)).ToArray();
            state.typing=TheForestOfLove.CustomTypewriterEffectTextMeshPro.IsTyping();
            state.introDiagnostics=rows.ToArray();
            ReadConversation(state);
            ReadTutorialCompletionRecord(state);
            ReadBuckyRecords(state);
        }
        File.WriteAllText(Path.Combine(root,"intro-state.json"),JsonUtility.ToJson(state,true));
    }
    void Dump() {
        var texts=new List<TextRow>();var buttons=new List<string>();var components=new List<string>();
        var responses=ReadResponses();
        var tmpObjects=Resources.FindObjectsOfTypeAll<TMP_Text>();
        var rendererDiagnostics=new List<string>();
        var subtitleGlyphDiagnostics=new List<string>();
        var settingsGlyphDiagnostics=new List<string>();
        var settingsLayoutDiagnostics=new List<string>();
        var settingsControlDiagnostics=new List<string>();
        var scaleEligibility=new List<string>();var scaleControlState=new List<string>();
        var wc=FindObjectOfType<TheForestOfLove.UI.WindowController>();
        if(wc!=null) {
            var flags=BindingFlags.Instance|BindingFlags.NonPublic|BindingFlags.Public;
            var slots=(IEnumerable)wc.GetType().GetField("windowSizeSettings",flags).GetValue(wc);
            int index=0;
            foreach(var slot in slots) {
                var t=slot.GetType();
                scaleEligibility.Add(index+" | width="+t.GetField("targetWidth",flags).GetValue(slot)+
                    " | height="+t.GetField("targetHeight",flags).GetValue(slot)+
                    " | eligible="+t.GetField("eligible",flags).GetValue(slot));index++;
            }
        }
        foreach(var cg in Resources.FindObjectsOfTypeAll<CanvasGroup>())
            if(cg.gameObject.scene.IsValid() && Address(cg.transform).StartsWith("Canvas/OptionsMenu/Controls/ScaleFactor"))
                scaleControlState.Add(Address(cg.transform)+" | alpha="+cg.alpha+" | interactable="+cg.interactable+" | blocksRaycasts="+cg.blocksRaycasts);
        foreach(var t in tmpObjects)
            if(t.gameObject.activeInHierarchy)
            {
                bool settings=t.gameObject.scene.IsValid() && Address(t.transform).StartsWith("Canvas/OptionsMenu/");
                if(settings) {
                    var r=t.rectTransform; var pos=r.position; var rect=r.rect;
                    settingsLayoutDiagnostics.Add(String.Format(System.Globalization.CultureInfo.InvariantCulture,
                        "{0} | text={1} | fontSize={2:R} | alignment={3} | color={4} | world=({5:R},{6:R}) | rect=({7:R},{8:R}) | anchorY=({9:R},{10:R}) | sizeDeltaY={11:R} | preferredHeight={12:R}",
                        Address(t.transform),t.text,t.fontSize,t.alignment,t.color,pos.x,pos.y,rect.width,rect.height,
                        r.anchorMin.y,r.anchorMax.y,r.sizeDelta.y,t.preferredHeight));
                }
                if(t.name=="Subtitle Text" || (settings && (t.text=="Off" || t.text=="On"))) {
                    // Measurement only: never mutate fonts, strings, meshes or typewriter state.
                    var info=t.textInfo;
                    for(int i=0;i<info.characterCount;i++) {
                        var ch=info.characterInfo[i]; if(ch.textElement==null)continue;
                        var g=ch.textElement.glyph; var metrics=g.metrics;
                        var world=t.transform.TransformPoint(new Vector3(ch.origin,ch.baseLine,0));
                        (settings?settingsGlyphDiagnostics:subtitleGlyphDiagnostics).Add(Address(t.transform)+" | "+String.Format(System.Globalization.CultureInfo.InvariantCulture,
                            "{0} | U+{1:X4} | glyph={2} | font={3} | face={4} | origin={5:R} | advance={6:R} | baseline={7:R} | scale={8:R} | bearing=({9:R},{10:R}) | size=({11:R},{12:R}) | glyphAdvance={13:R} | topLeft=({14:R},{15:R}) | bottomRight=({16:R},{17:R}) | worldOriginBaseline=({18:R},{19:R})",
                            i,(int)ch.character,g.index,ch.fontAsset==null?"":ch.fontAsset.name,
                            ch.fontAsset==null?"":ch.fontAsset.faceInfo.familyName,
                            ch.origin,ch.xAdvance,ch.baseLine,ch.scale,metrics.horizontalBearingX,metrics.horizontalBearingY,
                            metrics.width,metrics.height,metrics.horizontalAdvance,ch.topLeft.x,ch.topLeft.y,ch.bottomRight.x,ch.bottomRight.y,world.x,world.y));
                    }
                }
                texts.Add(new TextRow{path=Address(t.transform),text=t.text,font=t.font==null?"":t.font.name,size=t.fontSize,overflow=t.isTextOverflowing});
                rendererDiagnostics.Add(Address(t.transform)+" | "+t.GetType().FullName+" | "+t.text+" | font="+(t.font==null?"null":t.font.name)+" | overflow="+t.isTextOverflowing);
            }
        foreach(var t in Resources.FindObjectsOfTypeAll<Text>())
            if(t.gameObject.activeInHierarchy)
                rendererDiagnostics.Add(Address(t.transform)+" | UnityEngine.UI.Text | "+t.text+" | font="+(t.font==null?"null":t.font.name)+" | size="+t.fontSize+
                    " | style="+t.fontStyle+" | fontNames="+(t.font==null?"null":String.Join(",",t.font.fontNames))+
                    " | dynamic="+(t.font!=null && t.font.dynamic)+
                    " | hasCyrillicAndDigits="+(t.font!=null && t.font.HasCharacter('Ё') && t.font.HasCharacter('Й') && t.font.HasCharacter('1'))+
                    " | hasYo="+(t.font!=null && t.font.HasCharacter('Ё'))+
                    " | hasShortI="+(t.font!=null && t.font.HasCharacter('Й'))+
                    " | hasDigit1="+(t.font!=null && t.font.HasCharacter('1'))+
                    " | hasSpace="+(t.font!=null && t.font.HasCharacter(' '))+
                    " | hasDiaeresis="+(t.font!=null && t.font.HasCharacter('\u0308'))+
                    " | hasBreve="+(t.font!=null && t.font.HasCharacter('\u0306')));
        foreach(var b in Resources.FindObjectsOfTypeAll<Button>())
            if(b.gameObject.activeInHierarchy && b.gameObject.scene.IsValid() && b.interactable) buttons.Add(Address(b.transform));
        foreach(var b in Resources.FindObjectsOfTypeAll<MonoBehaviour>())
            if(b!=null && b.gameObject.activeInHierarchy && b.gameObject.scene.IsValid() && b.GetType().Namespace=="TheForestOfLove")
                components.Add(b.GetType().Name+" "+Address(b.transform));
        foreach(var im in Resources.FindObjectsOfTypeAll<Image>())
            if(im.gameObject.scene.IsValid() && Address(im.transform).StartsWith("Canvas/OptionsMenu/")) {
                var corners=new Vector3[4]; im.rectTransform.GetWorldCorners(corners);
                settingsControlDiagnostics.Add(Address(im.transform)+" | activeSelf="+im.gameObject.activeSelf+" | activeInHierarchy="+im.gameObject.activeInHierarchy+" | sprite="+(im.sprite==null?"null":im.sprite.name)+
                    " | enabled="+im.enabled+" | instance="+im.GetInstanceID()+" | color="+im.color+
                    " | canvasAlpha="+im.canvasRenderer.GetAlpha()+" | culled="+im.canvasRenderer.cull+
                    " | material="+(im.materialForRendering==null?"null":im.materialForRendering.name)+
                    " | worldBottomLeft="+corners[0].ToString("R")+" | worldTopRight="+corners[2].ToString("R"));
            }
        var state=new State{scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
            frame=Time.frameCount,realtime=Time.realtimeSinceStartup,scaledTime=Time.time,timeScale=Time.timeScale,
            narrativeDbName=TheForestOfLove.Narrative.DialogueService.CurrentDialogueDbName,
            narrativeArcName=TheForestOfLove.Narrative.DialogueService.CurrentArcName,
            dataPath=Application.dataPath,persistentDataPath=Application.persistentDataPath,
            company=Application.companyName,product=Application.productName,width=Screen.width,height=Screen.height,
            texts=texts.ToArray(),buttons=buttons.ToArray(),components=components.ToArray(),
            tmpObjectCount=tmpObjects.Length,rendererDiagnostics=rendererDiagnostics.ToArray(),subtitleGlyphDiagnostics=subtitleGlyphDiagnostics.ToArray(),
            settingsGlyphDiagnostics=settingsGlyphDiagnostics.ToArray(), settingsLayoutDiagnostics=settingsLayoutDiagnostics.ToArray(),
            settingsControlDiagnostics=settingsControlDiagnostics.ToArray(), fullscreen=TheForestOfLove.UI.WindowController.IsFullscreen,
            stretch=TheForestOfLove.UI.WindowController.EnableFullscreenStretch, scaleIndex=TheForestOfLove.UI.WindowController.WindowScalingIndex,
            displayWidth=Screen.currentResolution.width, displayHeight=Screen.currentResolution.height,
            canScaleUp=TheForestOfLove.UI.WindowController.CanScaleUp(),canScaleDown=TheForestOfLove.UI.WindowController.CanScaleDown(),
            selectedControl=EventSystem.current==null || EventSystem.current.currentSelectedGameObject==null?"":Address(EventSystem.current.currentSelectedGameObject.transform),
            scaleEligibility=scaleEligibility.ToArray(),scaleControlState=scaleControlState.ToArray(),
            responseCount=responses.Count,
            responseRecords=responses.ConvertAll(row=>JsonUtility.ToJson(row)).ToArray(),
            typing=TheForestOfLove.CustomTypewriterEffectTextMeshPro.IsTyping()};
        var typewriter=FindObjectOfType<TheForestOfLove.CustomTypewriterEffectTextMeshPro>();
        state.visibleTypewriterText=typewriter==null?"":typewriter.CurrentVisibleText;
        ReadConversation(state);
        ReadTutorialCompletionRecord(state);
        ReadBuckyRecords(state);
        File.WriteAllText(Path.Combine(root,"state.json"),JsonUtility.ToJson(state,true));
    }
    [Serializable] public sealed class SaveContinuationState {
        public string scene, company, product, dataPath, persistentDataPath;
        public int frame;
        public float realtime, scaledTime, timeScale, storyClock;
        public bool diagnosticsReady, dataServicePresent, manifestPresent;
        public int dataServiceInstance;
        public string[] notReady;
        public bool hasSavedPlaySession, isChapterSelect, isCheatCode, isFinishingSoftReset;
        public bool gameplay, anyEvent, conversation;
        public string currentArea, lastArea, cameraSettingsObjectName;
        public Vector3 lastPosition, lastSpawnPosition, playerPosition;
        public bool lastPositionExact, isSwimming, isFastTraveling, playerPresent;
        public bool finishedControlTutorial, finishedDialogueTutorial, finishedGossipTutorial;
        public string playerPath;
        public int playerInstance;
        public int introStatus, tutorialIntroControllers;
        public string[] diagnostics;
    }
    // Read existing fields only. Never invoke Manifest (it dereferences _instance),
    // lifecycle callbacks, service initialization, disk IO or eligibility APIs.
    // Required nested collections are exactly the consumers used by both dumps.
    string[] ContinuationReadiness(out bool servicePresent,out bool manifestPresent,out int serviceInstance) {
        servicePresent=false;manifestPresent=false;serviceInstance=0;
        var field=typeof(TheForestOfLove.Services.Persistence.DataService).GetField("_instance",BindingFlags.Static|BindingFlags.NonPublic);
        if(field==null)throw new Exception("Unknown original DataService singleton field");
        var service=field.GetValue(null) as TheForestOfLove.Services.Persistence.DataService;
        if(service==null)return new[]{"DataService._instance"};
        servicePresent=true;serviceInstance=service.GetInstanceID();
        var manifest=ReadField(service,"_manifest") as TheForestOfLove.Narrative.DataManifest;
        if(manifest==null)return new[]{"DataService._manifest"};
        manifestPresent=true;
        var missing=new List<string>();
        if(manifest.playerRespawnData==null)missing.Add("DataManifest.playerRespawnData");
        if(manifest.generalData==null)missing.Add("DataManifest.generalData");
        if(manifest.triggersByTriggerName==null)missing.Add("DataManifest.triggersByTriggerName");
        if(manifest.activeTagsByDbName==null)missing.Add("DataManifest.activeTagsByDbName");
        if(manifest.dialoguesByDbName==null)missing.Add("DataManifest.dialoguesByDbName");
        else {
            TheForestOfLove.Narrative.Dialogue intro;
            if(!manifest.dialoguesByDbName.TryGetValue("NewGame_Intro",out intro) || intro==null)
                missing.Add("dialogue.NewGame_Intro");
        }
        if(manifest.questsByDbName==null)missing.Add("DataManifest.questsByDbName");
        else foreach(var name in new[]{"Act1_TutorialQuest","Act1_GossipQuest"}) {
            TheForestOfLove.Narrative.Quest quest;
            if(!manifest.questsByDbName.TryGetValue(name,out quest) || quest==null) {missing.Add("quest."+name);continue;}
            if(quest.dialogues==null) {missing.Add("quest."+name+".dialogues");continue;}
            foreach(var dialogue in quest.dialogues) {
                if(dialogue==null) {missing.Add("quest."+name+".dialogue");continue;}
                if(dialogue.primaryArcs==null) {missing.Add("quest."+name+".primaryArcs");continue;}
                foreach(var arc in dialogue.primaryArcs)
                    if(arc==null)missing.Add("quest."+name+".primaryArc");
            }
        }
        var eventsField=typeof(TheForestOfLove.Events.GameStateManager).GetField("isEventActive",BindingFlags.Static|BindingFlags.Public|BindingFlags.NonPublic);
        if(eventsField==null)throw new Exception("Unknown original event array field");
        var events=eventsField.GetValue(null) as bool[];
        if(events==null || events.Length<11)missing.Add("GameStateManager.isEventActive");
        return new List<string>(new HashSet<string>(missing)).ToArray();
    }
    void DumpSaveContinuation() {
        // Source-pinned getters return existing records; do not read ES3, reload,
        // evaluate availability, save, or mutate the story/scene/player state.
        var state=new SaveContinuationState {
            scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
            company=Application.companyName,product=Application.productName,
            dataPath=Application.dataPath,persistentDataPath=Application.persistentDataPath,
            frame=Time.frameCount,realtime=Time.realtimeSinceStartup,scaledTime=Time.time,timeScale=Time.timeScale,
            diagnostics=new string[0]};
        state.notReady=ContinuationReadiness(out state.dataServicePresent,out state.manifestPresent,out state.dataServiceInstance);
        state.diagnosticsReady=state.notReady.Length==0;
        if(!state.diagnosticsReady) {
            File.WriteAllText(Path.Combine(root,"save-continuation.json"),JsonUtility.ToJson(state,true));
            return;
        }
        var respawn=TheForestOfLove.Services.Persistence.DataService.GetPlayerRespawnData();
        var general=TheForestOfLove.Services.Persistence.DataService.GetGeneralData();
        var player=TheForestOfLove.Player.current;
        var intro=TheForestOfLove.Services.Persistence.DataService.GetDialogueByDbName("NewGame_Intro");
        if(intro==null)throw new Exception("Missing original intro record");
        int controllers=0;
        foreach(var controller in Resources.FindObjectsOfTypeAll<TheForestOfLove.TutorialQuestBunnyIntroduction>())
            if(controller.gameObject.scene.IsValid() && controller.gameObject.activeInHierarchy)controllers++;
        state.hasSavedPlaySession=TheForestOfLove.Services.Persistence.SaveManager.HasSavedPlaySession;
        state.isChapterSelect=Globals.isChapterSelect;
        state.isCheatCode=Globals.isCheatCode;
        state.isFinishingSoftReset=Globals.isFinishingSoftReset;
        state.gameplay=TheForestOfLove.Services.SceneManagement.SceneHelper.inGameplayScene;
        state.anyEvent=TheForestOfLove.Events.GameStateManager.isAnyEventActive;
        state.conversation=DialogueManager.IsConversationActive;
        state.currentArea=respawn.currentAreaUnitySceneName;
        state.lastArea=respawn.lastAreaUnitySceneName;
        state.lastPosition=respawn.lastPosition;
        state.lastSpawnPosition=respawn.lastSpawnPosition;
        state.lastPositionExact=respawn.lastPositionExact;
        state.isSwimming=respawn.isSwimming;
        state.isFastTraveling=respawn.isFastTraveling;
        state.cameraSettingsObjectName=respawn.cameraSettingsObjectName;
        state.storyClock=general.storyClock;
        state.finishedControlTutorial=general.finishedControlTutorial;
        state.finishedDialogueTutorial=general.finishedDialogueTutorial;
        state.finishedGossipTutorial=general.finishedGossipTutorial;
        state.playerPresent=player!=null && player.gameObject.activeInHierarchy;
        state.playerPath=player==null?null:Address(player.transform);
        state.playerInstance=player==null?0:player.GetInstanceID();
        state.playerPosition=player==null?Vector3.zero:player.transform.position;
        state.introStatus=(int)intro.status;
        state.tutorialIntroControllers=controllers;
        state.diagnostics=TutorialRouteDiagnostics();
        File.WriteAllText(Path.Combine(root,"save-continuation.json"),JsonUtility.ToJson(state,true));
    }
}
