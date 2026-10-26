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
    }
    [Serializable] public sealed class NotebookRouteState {
        public string scene, company, product, dataPath, persistentDataPath;
        public string[] diagnostics;
    }
    [Serializable] public sealed class ContinueReceipt {
        public string result;
        public bool active;
        public int expectedConversationId, expectedEntryId, actualConversationId, actualEntryId;
    }
    private string root;
    private float next;
    private bool? originalIgnoreUnfocused;
    private bool samplingKeyboard;
    private readonly List<string> keyboardSamples=new List<string>();
    [DllImport("user32.dll")] static extern bool GetKeyboardState([Out] byte[] keys);
    [DllImport("user32.dll")] static extern short GetAsyncKeyState(int key);
    [DllImport("kernel32.dll")] static extern uint GetCurrentProcessId();
    public static void Install() {
        if (Application.companyName != "VNRevivalQA" || Application.productName != "ForestRuRendererProbe")
            throw new InvalidOperationException("QA bridge requires the isolated player identity.");
        var go = new GameObject("ForestRendererProbeBridge");
        DontDestroyOnLoad(go); go.AddComponent<ForestProbe>();
    }
    void Awake() {
        root = Path.GetFullPath(Path.Combine(Application.dataPath,"../.."));
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
        var text=File.ReadAllText(command).Trim();File.Delete(command);
        try {
            if(text=="dump") Dump();
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
            } else if(text.StartsWith("continue-bound ")) {
                var parts=text.Substring(15).Split(' ');
                if(parts.Length!=2)throw new Exception("Expected conversation and source entry");
                int conversationId=Int32.Parse(parts[0]), entryId=Int32.Parse(parts[1]);
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
                if(parts.Length!=2 || !(parts[0]=="StartScreenMainMenu" || parts[0]=="PlayMenu" || parts[0]=="OptionsMenu") ||
                   !(parts[1]=="OnClickStart" || parts[1]=="OnClickOptions" || parts[1]=="OnClickBack"))
                    throw new Exception("Unsupported menu command");
                MonoBehaviour match=null;
                foreach(var b in Resources.FindObjectsOfTypeAll<MonoBehaviour>())
                    if(b!=null && b.gameObject.activeInHierarchy && b.GetType().Name==parts[0]){
                        if(match!=null)throw new Exception("Duplicate active menu");match=b;}
                if(match==null)throw new Exception("Menu not active");
                match.GetType().GetMethod(parts[1]).Invoke(match,null);
            } else throw new Exception("Unsupported command");
            File.AppendAllText(Path.Combine(root,"actions.log"),DateTime.UtcNow.ToString("O")+" OK "+text+"\n");
        } catch(Exception ex) {
            File.AppendAllText(Path.Combine(root,"actions.log"),DateTime.UtcNow.ToString("O")+" FAIL "+text+" "+ex+"\n");
            Debug.LogException(ex);
        }
    }
    void RestoreInputPolicy() {
        if(!originalIgnoreUnfocused.HasValue)return;
        var expected=originalIgnoreUnfocused.Value;
        Rewired.ReInput.configuration.ignoreInputWhenAppNotInFocus=expected;
        if(Rewired.ReInput.configuration.ignoreInputWhenAppNotInFocus!=expected)
            throw new Exception("Original input focus policy not restored");
        originalIgnoreUnfocused=null;
    }
    void OnDestroy() { RestoreInputPolicy(); }
    void LateUpdate() {
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
        // Observe the real producer and public getters. Never feed these values back.
        keyboardSamples.Add("keyboard | time="+Time.realtimeSinceStartup+
            " | winPid="+GetCurrentProcessId()+" | focused="+Application.isFocused+
            " | ignoreUnfocused="+Rewired.ReInput.configuration.ignoreInputWhenAppNotInFocus+
            " | nativeValid="+valid+" | nativeLeft="+((keys[0x25]&128)!=0)+
            " | asyncLeft="+((GetAsyncKeyState(0x25)&0x8000)!=0)+
            " | rewiredLeft="+keyboard.GetKey(KeyCode.LeftArrow)+
            " | keyboardEnabled="+keyboard.enabled+" | unityLeft="+Input.GetKey(KeyCode.LeftArrow)+
            " | player="+(player==null?"null":player.id+":"+player.name)+
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
            " | scene="+UnityEngine.SceneManagement.SceneManager.GetActiveScene().name+
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
            " | nativeKeyboard="+Rewired.ReInput.configuration.nativeKeyboardSupport+
            " | unityInput="+Rewired.ReInput.configuration.alwaysUseUnityInput);
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
    string[] TutorialRouteDiagnostics() {
        var rows=new List<string>();
        int introControllers=0,bedControllers=0,activeBedControllers=0;
        foreach(var cutscene in Resources.FindObjectsOfTypeAll<TheForestOfLove.IntroBunnyHouseCutscene>())
            if(cutscene.gameObject.scene.IsValid()) {
                introControllers++;
                rows.Add("introCutscene | path="+Address(cutscene.transform)+" | active="+cutscene.gameObject.activeInHierarchy+
                    " | stage="+ReadField(cutscene,"currentStage")+" | timerSet="+ReadField(cutscene,"timerSet")+
                    " | timerSeconds="+ReadField(cutscene,"timerSecondsRemaining"));
            }
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
        foreach(var name in new[]{"Cutscene_IntroForest","Cutscene_IntroBunnyHouse","intro_from_beaver","intro_from_mouse","intro_from_otter","give_sugar_to_bunny"}) {
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
                if(Address(controller.transform)=="SpawnedContent/Elements/Bed/Content/Bed(Clone)/Interaction/InteractionIconInspect") {
                    bedControllers++;
                    if(controller.gameObject.activeInHierarchy && controller.enabled)activeBedControllers++;
                }
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
        rows.Add("introCleanup | remainingControllers="+introControllers+" | bedControllers="+bedControllers+
            " | activeBedControllers="+activeBedControllers);
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
    void Dump() {
        var texts=new List<TextRow>();var buttons=new List<string>();var components=new List<string>();
        var responses=new List<ResponseRow>();
        foreach(var b in Resources.FindObjectsOfTypeAll<StandardUIResponseButton>())
            if(b.gameObject.scene.IsValid() && b.gameObject.activeInHierarchy && b.response!=null && b.response.destinationEntry!=null)
                responses.Add(new ResponseRow{path=Address(b.transform),text=b.text,
                    targetPath=b.target==null?"":Address(b.target),visible=b.isVisible,clickable=b.isClickable,
                    conversationId=b.response.destinationEntry.conversationID,entryId=b.response.destinationEntry.id});
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
                    " | hasCyrillicAndDigits="+(t.font!=null && t.font.HasCharacter('Ё') && t.font.HasCharacter('Й') && t.font.HasCharacter('1')));
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
        state.conversationActive=DialogueManager.isConversationActive;
        // Subtitle contains actor/Unity objects and a conversation graph. Never
        // hand that graph to JsonUtility: inspect only bounded scalar values.
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
        File.WriteAllText(Path.Combine(root,"state.json"),JsonUtility.ToJson(state,true));
    }
}
