// Task-owned native adapter of Forest's existing inspection bridge.
// Original UI/interaction methods and framebuffer capture only; never ship.
using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using TMPro;
using PixelCrushers.DialogueSystem;

public sealed class ForestProbe : MonoBehaviour {
    const string Root = "__TASK_ROOT__";
    const string Product = "ForestRuScreenshotsProbe20261104";
    const BindingFlags Flags = BindingFlags.Instance|BindingFlags.Public|BindingFlags.NonPublic;
    [Serializable] public class Snapshot {
        public string scene, company, product, conversationText;
        public int frame,width,height,conversationId,entryId;
        public bool conversationActive,typing,focused;
        public string[] texts,buttons,details,responses,images,scrolls,geometry;
    }
    public static void Install() {
        Debug.Log("FOREST_CAPTURE_IDENTITY "+Application.companyName+"|"+Application.productName+"|"+Application.dataPath);
        if(Application.companyName!="VNRevivalQA" || Application.productName!=Product ||
           Path.GetFullPath(Application.dataPath)!=Path.GetFullPath(Path.Combine(Root,"game.app/Contents")))
            throw new Exception("Capture bridge requires its exact isolated native game");
        Application.runInBackground=true;
        var go=new GameObject("ForestNativeCaptureBridge");DontDestroyOnLoad(go);go.AddComponent<ForestProbe>();
    }
    public static void NoteBlockedSave() {
        File.AppendAllText(Path.Combine(Root,"blocked-save-writes.log"),DateTime.UtcNow.ToString("O")+" suppressed task-owned progress save\n");
    }
    void Awake() { File.WriteAllText(Path.Combine(Root,"bridge-ready.txt"),Application.dataPath); }
    static string Address(Transform t) {return t.parent==null?t.name:Address(t.parent)+"/"+t.name;}
    static string B64(string s) {return Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(s??""));}
    static object Read(object o,string field) {return o.GetType().GetField(field,Flags).GetValue(o);}
    static object Property(object o,string name) {return o.GetType().GetProperty(name,Flags).GetValue(o,null);}
    static T One<T>() where T:Component {
        T result=null;
        foreach(var c in Resources.FindObjectsOfTypeAll<T>())if(c.gameObject.scene.IsValid()&&c.gameObject.activeInHierarchy){
            if(result!=null)throw new Exception("Ambiguous active "+typeof(T).Name);result=c;}
        if(result==null)throw new Exception("No active "+typeof(T).Name);return result;
    }
    static void Invoke(object o,string name,params object[] args) {
        MethodInfo selected=null;
        foreach(var m in o.GetType().GetMethods(Flags))if(m.Name==name&&m.GetParameters().Length==args.Length){
            if(selected!=null)throw new Exception("Ambiguous method "+name);selected=m;}
        if(selected==null)throw new Exception("Missing method "+name);selected.Invoke(o,args);
    }
    void Dump() {
        var s=new Snapshot{scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
            company=Application.companyName,product=Application.productName,frame=Time.frameCount,
            width=Screen.width,height=Screen.height,focused=Application.isFocused,conversationActive=DialogueManager.isConversationActive,
            typing=TheForestOfLove.CustomTypewriterEffectTextMeshPro.IsTyping()};
        var texts=new List<string>();var buttons=new List<string>();var details=new List<string>();var responses=new List<string>();
        foreach(var t in Resources.FindObjectsOfTypeAll<Text>())if(t.enabled&&t.gameObject.activeInHierarchy&&t.color.a>.01f)
            texts.Add(Address(t.transform)+"\t"+B64(t.text)+"\tnative\t"+t.fontSize);
        foreach(var t in Resources.FindObjectsOfTypeAll<TextMeshProUGUI>())if(t.enabled&&t.gameObject.activeInHierarchy&&t.color.a>.01f)
            texts.Add(Address(t.transform)+"\t"+B64(t.text)+"\tTMP\t"+t.fontSize);
        foreach(var b in Resources.FindObjectsOfTypeAll<Button>())if(b.gameObject.scene.IsValid()&&b.gameObject.activeInHierarchy&&b.interactable)
            buttons.Add(Address(b.transform));
        foreach(var b in Resources.FindObjectsOfTypeAll<StandardUIResponseButton>())if(b.gameObject.activeInHierarchy&&b.isVisible&&b.isClickable&&b.response!=null)
            responses.Add(b.response.destinationEntry.conversationID+"\t"+b.response.destinationEntry.id+"\t"+Address(b.transform)+"\t"+B64(b.response.formattedText.text));
        if(s.conversationActive&&DialogueManager.currentConversationState!=null){
            var sub=DialogueManager.currentConversationState.subtitle;
            if(sub!=null){s.conversationText=sub.formattedText.text;s.conversationId=sub.dialogueEntry.conversationID;s.entryId=sub.dialogueEntry.id;}
        }
        foreach(var m in Resources.FindObjectsOfTypeAll<TheForestOfLove.MasterLog>())if(m.gameObject.scene.IsValid())
            details.Add("master|"+Address(m.transform)+"|visible="+m.visible+"|page="+m.currentPage);
        foreach(var a in Resources.FindObjectsOfTypeAll<TheForestOfLove.Gameplay.SpawnableActor>())if(a.gameObject.scene.IsValid()&&a.gameObject.activeInHierarchy)
            details.Add("actor|"+a.ActorDbName+"|"+Address(a.transform)+"|"+a.transform.position);
        foreach(var i in Resources.FindObjectsOfTypeAll<TheForestOfLove.Interaction.DialogueInteractionTrigger>())if(i.gameObject.scene.IsValid()&&i.gameObject.activeInHierarchy)
            details.Add("trigger|"+Address(i.transform)+"|dialogue="+i.dialogueDbName+"|authority="+Property(i,"IsAuthority")+"|mode="+i.interactionMode+"|blocked="+i.interactionBlocked+"|canTrigger="+i.GetType().GetMethod("CanTrigger",Flags).Invoke(i,null)+"|");
        if(TheForestOfLove.Player.current!=null)details.Add("player|"+TheForestOfLove.Player.current.transform.position);
        var images=new List<string>();var scrolls=new List<string>();
        foreach(var image in Resources.FindObjectsOfTypeAll<Image>())if(image.gameObject.scene.IsValid()&&image.gameObject.activeInHierarchy&&image.sprite!=null)
            images.Add(Address(image.transform)+"\t"+image.sprite.name+"\t"+image.enabled+"\t"+image.rectTransform.rect);
        foreach(var scroll in Resources.FindObjectsOfTypeAll<ScrollRect>())if(scroll.gameObject.scene.IsValid()&&scroll.gameObject.activeInHierarchy)
            scrolls.Add(Address(scroll.transform)+"\t"+scroll.verticalNormalizedPosition+"\t"+(scroll.viewport==null?"no-viewport":scroll.viewport.rect.ToString())+"\tcontent="+(scroll.content==null?"none":scroll.content.rect.ToString()));
        var geometry=new List<string>();
        foreach(var rect in Resources.FindObjectsOfTypeAll<RectTransform>())if(rect.gameObject.scene.IsValid()) {
            string path=Address(rect);
            if(path=="Canvas/GalleryMenu/Dialogue/Dialogue"||path=="Canvas/GalleryMenu/Dialogue/On"||path=="Canvas/GalleryMenu/Dialogue/Off"||path.EndsWith("/MasterLog/Canvas/Container/Labels/QuestLog",StringComparison.Ordinal))
                geometry.Add("layout-pose|"+path+"|x="+rect.anchoredPosition.x.ToString(System.Globalization.CultureInfo.InvariantCulture)+"|y="+rect.anchoredPosition.y.ToString(System.Globalization.CultureInfo.InvariantCulture)+"|active="+rect.gameObject.activeInHierarchy);
        }
        foreach(var t in Resources.FindObjectsOfTypeAll<Text>())if(t.enabled&&t.gameObject.activeInHierarchy&&!String.IsNullOrEmpty(t.text)&&(Address(t.transform).Contains("/QuestLog/")||Address(t.transform).Contains("/Bio/VNRevivalResidentViewport/"))) {
            var gen=t.cachedTextGenerator;gen.Populate(t.text,t.GetGenerationSettings(t.rectTransform.rect.size));
            if(t.name=="VNRevivalRussianStatusLabel")details.Add("status-fit|"+Address(t.transform)+"|font="+t.fontSize+"|bestFit="+t.resizeTextForBestFit+"|min="+t.resizeTextMinSize+"|max="+t.resizeTextMaxSize+"|used="+gen.fontSizeUsedForBestFit+"|lines="+gen.lineCount+"|rect="+t.rectTransform.rect+"|preferredWidth="+t.preferredWidth+"|preferredHeight="+t.preferredHeight+"|dynamic="+t.font.dynamic+"|horizontal="+t.horizontalOverflow+"|vertical="+t.verticalOverflow);
            foreach(var mask in t.GetComponentsInParent<RectMask2D>())if(mask.enabled&&mask.gameObject.activeInHierarchy) {
                int inside=0,outside=0;float low=float.PositiveInfinity,high=float.NegativeInfinity;
                foreach(var v in gen.verts)if(v.color.a>0){var p=mask.rectTransform.InverseTransformPoint(t.transform.TransformPoint(v.position/t.pixelsPerUnit));low=Mathf.Min(low,p.y);high=Mathf.Max(high,p.y);if(mask.rectTransform.rect.Contains(p))inside++;else outside++;}
                geometry.Add(Address(t.transform)+"\tmask="+Address(mask.transform)+"\tinside="+inside+"\toutside="+outside+"\ty="+low+","+high+"\tmaskRect="+mask.rectTransform.rect);
            }
        }
        foreach(var t in Resources.FindObjectsOfTypeAll<TextMeshProUGUI>())
            if(t.gameObject.activeInHierarchy && (Address(t.transform).StartsWith("Canvas/MainMenu/") || Address(t.transform).StartsWith("Canvas/OptionsMenu/") || Address(t.transform).StartsWith("Canvas/GalleryMenu/")))
                details.Add("render-ready|"+Address(t.transform)+"|alpha="+(t.color.a*t.canvasRenderer.GetAlpha()*t.canvasRenderer.GetInheritedAlpha()).ToString(System.Globalization.CultureInfo.InvariantCulture)+"|chars="+t.textInfo.characterCount+"|cull="+t.canvasRenderer.cull);
        s.texts=texts.ToArray();s.buttons=buttons.ToArray();s.details=details.ToArray();s.responses=responses.ToArray();s.images=images.ToArray();s.scrolls=scrolls.ToArray();s.geometry=geometry.ToArray();
        File.WriteAllText(Path.Combine(Root,"state.json"),JsonUtility.ToJson(s,true));
    }
    void Click(string path) {
        Button match=null;
        foreach(var b in Resources.FindObjectsOfTypeAll<Button>())if(b.gameObject.scene.IsValid()&&b.gameObject.activeInHierarchy&&b.interactable&&Address(b.transform)==path){
            if(match!=null)throw new Exception("Ambiguous button");match=b;}
        if(match==null)throw new Exception("Button unavailable: "+path);match.onClick.Invoke();
    }
    void Page(string name) {
        if(DialogueManager.isConversationActive)throw new Exception("Close current conversation before opening log");
        var master=One<TheForestOfLove.MasterLog>();
        var page=(TheForestOfLove.MasterLogPage)Enum.Parse(typeof(TheForestOfLove.MasterLogPage),name);
        if(master.visible)Invoke(master,"JumpToPage",page);
        else typeof(TheForestOfLove.MasterLog).GetMethod("ToggleVisible",Flags,null,new[]{typeof(TheForestOfLove.MasterLogPage),typeof(bool)},null).Invoke(master,new object[]{page,true});
    }
    void CameraItem() {
        int count=0;
        foreach(var c in Resources.FindObjectsOfTypeAll<TheForestOfLove.InventoryCellUiController>())if(c.gameObject.activeInHierarchy&&c.node!=null){
            var schemas=Read(c.node,"possibleSchemas") as IEnumerable;
            if(schemas==null)continue;
            foreach(var o in schemas){var item=o as TheForestOfLove.Inventory.InventoryItem;
                if(item!=null&&item.savekey=="camera"&&item.quantity>0&&!item.isConsumed){
                    if(item.sprite==null||item.sprite.texture==null)throw new Exception("Owned camera sprite has not loaded");
                    Invoke(c,"OnSelected");count++;break;}}
        }
        if(count!=1)throw new Exception("Expected one actually owned camera cell; got "+count);
    }
    void Label(string kind,string text) {
        object owner=kind=="resident"?(object)One<TheForestOfLove.CritterLog>():One<TheForestOfLove.QuestLog>();
        var labels=(IList)Read(owner,kind=="resident"?"residentLabels":"questLabels");int found=-1;
        for(int i=0;i<labels.Count;i++)if((string)Property(labels[i],"text")==text){if(found!=-1)throw new Exception("Ambiguous label");found=i;}
        if(found<0)throw new Exception("Loaded label unavailable: "+text);
        Invoke(owner,kind=="resident"?"SelectResidentLabel":"SelectQuestLabel",found);
    }
    void Talk() {
        if(DialogueManager.isConversationActive)throw new Exception("Conversation already active");
        TheForestOfLove.Interaction.DialogueInteractionTrigger match=null;
        foreach(var t in Resources.FindObjectsOfTypeAll<TheForestOfLove.Interaction.DialogueInteractionTrigger>())
            if(t.gameObject.scene.IsValid()&&t.gameObject.activeInHierarchy&&Address(t.transform).ToLowerInvariant().Contains("maverick")&&(bool)Property(t,"IsAuthority")){
                if(match!=null)throw new Exception("Ambiguous Maverick interaction");match=t;}
        if(match==null)throw new Exception("Maverick has no current interaction authority");
        if(!(bool)match.GetType().GetMethod("CanTrigger",Flags).Invoke(match,null)||match.interactionBlocked||
           (int)match.interactionMode==2)throw new Exception("Original Maverick interaction guards reject");
        // Exact original submit branch, with OS-button delivery replaced.
        match.Fire();match.GetType().GetField("isTriggered",Flags).SetValue(match,true);
        var settings=(TheForestOfLove.DialogueSettings)Read(match,"settings");
        if(!TheForestOfLove.Narrative.StoryManager.PlayDialogue(match.interactionMode,settings))throw new Exception("Current StoryManager interaction rejected");
    }
    void LabelId(string kind,string id) {
        object owner=kind=="resident"?(object)One<TheForestOfLove.CritterLog>():One<TheForestOfLove.QuestLog>();
        var labels=(IList)Read(owner,kind=="resident"?"residentLabels":"questLabels");int found=-1;
        for(int i=0;i<labels.Count;i++) {
            string key=kind=="resident"?((TheForestOfLove.Narrative.Actor)Property(labels[i],"actor")).savekey:(string)Read(labels[i],"questDbName");
            if(key==id){if(found!=-1)throw new Exception("Ambiguous stable label identity");found=i;}
        }
        if(found<0)throw new Exception("Loaded stable label unavailable: "+id);
        Invoke(owner,kind=="resident"?"SelectResidentLabel":"SelectQuestLabel",found);
    }
    void PlaceMaverickFixture() {
        if(DialogueManager.isConversationActive)throw new Exception("Cannot place player during dialogue");
        var player=TheForestOfLove.Player.current;if(player==null)throw new Exception("No loaded player");
        var before=player.transform.position;if(Vector2.Distance(before,new Vector2(2.26f,.74f))>.2f)throw new Exception("Unexpected saved player checkpoint");
        player.transform.position=new Vector3(1.8f,1.4f,before.z);Physics2D.SyncTransforms();
        File.WriteAllText(Path.Combine(Root,"player-placement-fixture.txt"),"Transient QA position only; original loaded save and trigger authority retained. Before="+before+"; after="+player.transform.position);
    }
    void AlignQuestList(string requiredTitle) {
        ScrollRect list=null;
        foreach(var s in Resources.FindObjectsOfTypeAll<ScrollRect>())if(s.gameObject.scene.IsValid()&&s.gameObject.activeInHierarchy&&Address(s.transform).EndsWith("/QuestLog UI/Content/QuestsScrollView")) {
            if(list!=null)throw new Exception("Ambiguous quest list");list=s;
        }
        if(list==null||list.viewport==null||list.content==null)throw new Exception("Original quest list unavailable");
        list.StopMovement();float extent=Mathf.Max(0,list.content.rect.height-list.viewport.rect.height);
        int attempts=(int)Mathf.Ceil(extent);var trace=new List<string>();
        for(int step=0;step<=attempts;step++) {
            list.verticalNormalizedPosition=extent==0?1:Mathf.Clamp01(1-step/extent);Canvas.ForceUpdateCanvases();
            int partial=0,visible=0;bool required=String.IsNullOrEmpty(requiredTitle);var bounds=new List<string>();
            foreach(var t in list.content.GetComponentsInChildren<Text>())if(t.enabled&&!String.IsNullOrEmpty(t.text)) {
                var gen=t.cachedTextGenerator;gen.Populate(t.text,t.GetGenerationSettings(t.rectTransform.rect.size));
                float low=float.PositiveInfinity,high=float.NegativeInfinity;
                foreach(var v in gen.verts)if(v.color.a>0){var pt=list.viewport.InverseTransformPoint(t.transform.TransformPoint(v.position/t.pixelsPerUnit));low=Mathf.Min(low,pt.y);high=Mathf.Max(high,pt.y);}
                var rect=list.viewport.rect;bool intersects=high>rect.yMin+.1f&&low<rect.yMax-.1f;
                // The original illustrated frame covers the viewport edge.
                // A mathematical half-pixel clearance still lost the final
                // Portuguese line. Keep generated ink3 logical units inside.
                bool complete=low>=rect.yMin+3&&high<=rect.yMax-3;
                if(intersects){visible++;if(!complete)partial++;if(t.text==requiredTitle&&complete)required=true;bounds.Add(B64(t.text)+"|"+low+"|"+high+"|"+complete);}
            }
            trace.Add(step+"|"+list.verticalNormalizedPosition+"|"+partial+"|"+required);
            if(partial==0&&required&&visible>=3) {
                File.WriteAllLines(Path.Combine(Root,"quest-list-alignment.tsv"),trace);
                File.WriteAllLines(Path.Combine(Root,"quest-list-visible-bounds.tsv"),bounds);return;
            }
        }
        File.WriteAllLines(Path.Combine(Root,"quest-list-alignment.tsv"),trace);throw new Exception("No complete quest-row capture position found");
    }
    IEnumerator Capture(string name) {
        if(Path.GetFileName(name)!=name||!name.EndsWith(".png"))throw new Exception("Unsafe capture name");
        var path=Path.Combine(Root,name);if(File.Exists(path))throw new Exception("Original capture exists");
        yield return new WaitForEndOfFrame();ScreenCapture.CaptureScreenshot(path);
    }
    void Update() {
        var file=Path.Combine(Root,"command.txt");if(!File.Exists(file))return;
        var cmd=File.ReadAllText(file).Trim();File.Delete(file);
        try {
            if(cmd=="dump")Dump();
            else if(cmd=="show-menu")Invoke(One<TheForestOfLove.MainMenuController>(),"FinishShowingMenu");
            else if(cmd.StartsWith("click "))Click(cmd.Substring(6));
            else if(cmd.StartsWith("page "))Page(cmd.Substring(5));
            else if(cmd=="close-log")Invoke(One<TheForestOfLove.MasterLog>(),"ToggleVisible",false);
            else if(cmd=="camera")CameraItem();
            else if(cmd.StartsWith("resident-id "))LabelId("resident",cmd.Substring(12));
            else if(cmd.StartsWith("quest-id "))LabelId("quest",cmd.Substring(9));
            else if(cmd.StartsWith("resident "))Label("resident",cmd.Substring(9));
            else if(cmd.StartsWith("quest "))Label("quest",cmd.Substring(6));
            else if(cmd=="align-quest-list")AlignQuestList("Друг интересуется");
            else if(cmd=="align-quest-list-any")AlignQuestList(null);
            else if(cmd.StartsWith("align-quest-list-title "))AlignQuestList(cmd.Substring(23));
            else if(cmd=="place-maverick-fixture")PlaceMaverickFixture();
            else if(cmd.StartsWith("scroll ")) {
                int separator=cmd.LastIndexOf(' ');string address=cmd.Substring(7,separator-7);
                float position=float.Parse(cmd.Substring(separator+1),System.Globalization.CultureInfo.InvariantCulture);
                if(position<0||position>1)throw new Exception("Scroll position out of range");ScrollRect selected=null;
                foreach(var scroll in Resources.FindObjectsOfTypeAll<ScrollRect>())if(scroll.gameObject.scene.IsValid()&&scroll.gameObject.activeInHierarchy&&Address(scroll.transform)==address) {
                    if(selected!=null)throw new Exception("Ambiguous scroll control");selected=scroll;
                }
                if(selected==null)throw new Exception("Scroll control unavailable");selected.StopMovement();selected.verticalNormalizedPosition=position;
            }
            else if(cmd=="talk-maverick")Talk();
            else if(cmd.StartsWith("continue ")){
                var parts=cmd.Substring(9).Split(' ');var current=DialogueManager.currentConversationState;
                if(!DialogueManager.isConversationActive||current==null||current.subtitle.dialogueEntry.conversationID!=int.Parse(parts[0])||current.subtitle.dialogueEntry.id!=int.Parse(parts[1]))throw new Exception("Dialogue state changed");
                TheForestOfLove.CustomTypewriterEffectTextMeshPro.FastForwardTextOrAdvanceDialogue();
            }
            else if(cmd.StartsWith("capture "))StartCoroutine(Capture(cmd.Substring(8)));
            else if(cmd=="quit")Application.Quit();
            else throw new Exception("Unknown bounded action");
            File.AppendAllText(Path.Combine(Root,"actions.log"),DateTime.UtcNow.ToString("O")+" OK "+cmd+"\n");
        }catch(Exception e){File.AppendAllText(Path.Combine(Root,"actions.log"),DateTime.UtcNow.ToString("O")+" FAIL "+cmd+" "+e+"\n");Debug.LogException(e);}
    }
}
