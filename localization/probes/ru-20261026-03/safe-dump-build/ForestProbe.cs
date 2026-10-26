// Disposable runtime inspection bridge. Never include it in a player release.
using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using PixelCrushers.DialogueSystem;

public sealed class ForestProbe : MonoBehaviour
{
    [Serializable] public sealed class TextRow {
        public string path, text, font; public float size; public bool overflow;
    }
    [Serializable] public sealed class State {
        public string scene, dataPath, persistentDataPath, company, product, conversationState;
        public bool conversationActive;
        public int conversationId, entryId;
        public int width, height; public TextRow[] texts; public string[] buttons, components;
    }
    private string root;
    private float next;
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
            else if(text=="quit") Application.Quit();
            else if(text=="show-menu") {
                var controller=FindObjectOfType<TheForestOfLove.MainMenuController>();
                if(controller==null)throw new Exception("Main menu controller not active");
                controller.GetType().GetMethod("FinishShowingMenu",BindingFlags.Instance|BindingFlags.NonPublic).Invoke(controller,null);
            } else if(text=="continue") {
                if(!DialogueManager.isConversationActive)throw new Exception("No active conversation");
                var ui=DialogueManager.dialogueUI;
                var method=ui.GetType().GetMethod("OnContinue",Type.EmptyTypes);
                if(method==null)throw new Exception("Active dialogue UI has no normal continue action");
                method.Invoke(ui,null);
            }
            else if(text.StartsWith("capture ")) {
                var name=text.Substring(8);
                if(Path.GetFileName(name)!=name || !name.EndsWith(".png")) throw new Exception("Invalid capture name");
                var path=Path.Combine(root,name);if(File.Exists(path)) throw new Exception("Capture already exists");
                StartCoroutine(Capture(path));
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
    IEnumerator Capture(string path) {
        yield return new WaitForEndOfFrame();
        ScreenCapture.CaptureScreenshot(path);
        Debug.Log("FOREST_PROBE_CAPTURE " + path);
    }
    void Dump() {
        var texts=new List<TextRow>();var buttons=new List<string>();var components=new List<string>();
        foreach(var t in Resources.FindObjectsOfTypeAll<TMP_Text>())
            if(t.gameObject.activeInHierarchy && t.gameObject.scene.IsValid())
                texts.Add(new TextRow{path=Address(t.transform),text=t.text,font=t.font==null?"":t.font.name,size=t.fontSize,overflow=t.isTextOverflowing});
        foreach(var b in Resources.FindObjectsOfTypeAll<Button>())
            if(b.gameObject.activeInHierarchy && b.gameObject.scene.IsValid() && b.interactable) buttons.Add(Address(b.transform));
        foreach(var b in Resources.FindObjectsOfTypeAll<MonoBehaviour>())
            if(b!=null && b.gameObject.activeInHierarchy && b.gameObject.scene.IsValid() && b.GetType().Namespace=="TheForestOfLove")
                components.Add(b.GetType().Name+" "+Address(b.transform));
        var state=new State{scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
            dataPath=Application.dataPath,persistentDataPath=Application.persistentDataPath,
            company=Application.companyName,product=Application.productName,width=Screen.width,height=Screen.height,
            texts=texts.ToArray(),buttons=buttons.ToArray(),components=components.ToArray()};
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
