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
        public bool typing;
        public string visibleTypewriterText;
        public int conversationId, entryId, tmpObjectCount;
        public string[] rendererDiagnostics;
        public string[] subtitleGlyphDiagnostics;
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
                TheForestOfLove.CustomTypewriterEffectTextMeshPro.FastForwardTextOrAdvanceDialogue();
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
        var tmpObjects=Resources.FindObjectsOfTypeAll<TMP_Text>();
        var rendererDiagnostics=new List<string>();
        var subtitleGlyphDiagnostics=new List<string>();
        foreach(var t in tmpObjects)
            if(t.gameObject.activeInHierarchy)
            {
                if(t.name=="Subtitle Text") {
                    // Measurement only: never mutate fonts, strings, meshes or typewriter state.
                    var info=t.textInfo;
                    for(int i=0;i<info.characterCount;i++) {
                        var ch=info.characterInfo[i]; if(ch.textElement==null)continue;
                        var g=ch.textElement.glyph; var metrics=g.metrics;
                        subtitleGlyphDiagnostics.Add(String.Format(System.Globalization.CultureInfo.InvariantCulture,
                            "{0} | U+{1:X4} | glyph={2} | font={3} | face={4} | origin={5:R} | advance={6:R} | baseline={7:R} | scale={8:R} | bearing=({9:R},{10:R}) | size=({11:R},{12:R}) | glyphAdvance={13:R} | topLeft=({14:R},{15:R}) | bottomRight=({16:R},{17:R})",
                            i,(int)ch.character,g.index,ch.fontAsset==null?"":ch.fontAsset.name,
                            ch.fontAsset==null?"":ch.fontAsset.faceInfo.familyName,
                            ch.origin,ch.xAdvance,ch.baseLine,ch.scale,metrics.horizontalBearingX,metrics.horizontalBearingY,
                            metrics.width,metrics.height,metrics.horizontalAdvance,ch.topLeft.x,ch.topLeft.y,ch.bottomRight.x,ch.bottomRight.y));
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
        var state=new State{scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
            dataPath=Application.dataPath,persistentDataPath=Application.persistentDataPath,
            company=Application.companyName,product=Application.productName,width=Screen.width,height=Screen.height,
            texts=texts.ToArray(),buttons=buttons.ToArray(),components=components.ToArray(),
            tmpObjectCount=tmpObjects.Length,rendererDiagnostics=rendererDiagnostics.ToArray(),subtitleGlyphDiagnostics=subtitleGlyphDiagnostics.ToArray(),
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
