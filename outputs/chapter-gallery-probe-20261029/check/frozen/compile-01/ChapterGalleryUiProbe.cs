// Disposable display-argument fixtures. No unlocks, gameplay or scene callbacks.
public sealed partial class ForestProbe {
    readonly System.Reflection.BindingFlags cgFlags=System.Reflection.BindingFlags.Public|System.Reflection.BindingFlags.NonPublic|System.Reflection.BindingFlags.Instance|System.Reflection.BindingFlags.Static;
    readonly System.Collections.Generic.Dictionary<TMPro.TMP_Text,string> cgSaved=new System.Collections.Generic.Dictionary<TMPro.TMP_Text,string>();
    UnityEngine.Component cgConsumer;TMPro.TMP_Text[] cgLabels;string cgSurface;
    object CGField(object owner,string name){var f=owner.GetType().GetField(name,cgFlags);if(f==null)throw new System.Exception("Missing field "+name);return f.GetValue(owner);}
    object CGManifest(){var t=typeof(TheForestOfLove.Services.Persistence.DataService);var instance=t.GetField("_instance",cgFlags).GetValue(null);if(instance==null)throw new System.Exception("DataService not ready");var manifest=CGField(instance,"_manifest");if(manifest==null)throw new System.Exception("Manifest not ready");return manifest;}
    object CGRecord(string sheet,int index){var list=(System.Collections.IEnumerable)CGField(CGManifest(),sheet=="Movie"?"movies":"chapters");object found=null;foreach(var record in list){var entity=CGField(record,sheet=="Movie"?"dbMovie":"dbChapter");if((int)entity.GetType().GetProperty("Index").GetValue(entity,null)!=index)continue;if(found!=null)throw new System.Exception("Ambiguous BG row");found=record;}if(found==null)throw new System.Exception("Missing BG row "+sheet+index);return found;}
    string CG64(string value){return value==null?"~":System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(value));}
    string CGDecode(string value){return value=="~"?null:System.Text.Encoding.UTF8.GetString(System.Convert.FromBase64String(value));}
    string CGWord(string key){foreach(var line in System.IO.File.ReadAllLines(System.IO.Path.Combine(root,"cg-words.tsv"))){var f=line.Split('\t');if(f[0]==key)return CGDecode(f[1]);}throw new System.Exception("Missing word "+key);}
    string CGPath(UnityEngine.Transform t){return t.parent==null?t.name:CGPath(t.parent)+"/"+t.name;}
    void CGReadback(){var output=new System.Text.StringBuilder();int strings=0,absences=0;foreach(var line in System.IO.File.ReadAllLines(System.IO.Path.Combine(root,"cg-values.tsv"))){var f=line.Split('\t');if(f.Length!=5)throw new System.Exception("Bad value expectation");var record=CGRecord(f[1],int.Parse(f[2]));string field=f[3]=="hint_phrase"?"hintPhrase":f[3];var actual=(string)CGField(record,field);if(CG64(actual)!=f[4])throw new System.Exception("Loaded value differs "+f[0]);var entity=CGField(record,f[1]=="Movie"?"dbMovie":"dbChapter");var stored=(string)entity.GetType().GetProperty(f[3]).GetValue(entity,null);if(CG64(stored)!=f[4])throw new System.Exception("DB/cache mismatch "+f[0]);if(f[4]=="~")absences++;else strings++;output.Append(line).Append('\n');}if(strings!=113||absences!=16)throw new System.Exception("Incomplete corpus");System.IO.File.WriteAllText(System.IO.Path.Combine(root,"cg-readback.tsv"),output.ToString());}
    void CGReady(string surface){
        if(cgConsumer!=null)throw new System.Exception("Restore current surface first");
        string type=surface=="gallery"?"GalleryHintTutorial":surface=="oos"?"OutOfSyncContentNotification":surface=="description"?"ChapterSelectUI":null;
        if(type==null)throw new System.Exception("Unsupported surface");
        UnityEngine.Component consumer=null;
        foreach(var c in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.MonoBehaviour>())if(c!=null&&c.GetType().FullName=="TheForestOfLove."+type&&c.gameObject.scene.IsValid()&&c.gameObject.activeInHierarchy){if(consumer!=null)throw new System.Exception("Ambiguous native surface");consumer=c;}
        if(consumer==null)throw new System.Exception("Native surface not ready; parent must establish original UI route. No synthetic active root is permitted.");
        object value=CGField(consumer,surface=="gallery"?"labelRoot":surface=="oos"?"chapterNameLabelRoot":"tooltipContainer");var go=value as UnityEngine.GameObject;var component=value as UnityEngine.Component;var basis=go!=null?go:component==null?null:component.gameObject;
        if(basis==null||!basis.activeInHierarchy)throw new System.Exception("Native text root inactive");
        var labels=basis.GetComponentsInChildren<TMPro.TMP_Text>();if(labels.Length!=(surface=="description"?labels.Length:6)||labels.Length==0)throw new System.Exception("Native text root membership differs");
        foreach(var t in labels)if(!t.enabled||!t.gameObject.activeInHierarchy||t.font==null)throw new System.Exception("Native text not ready");
        cgConsumer=consumer;cgLabels=labels;cgSurface=surface;foreach(var t in labels)cgSaved.Add(t,t.text);
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"cg-ready.txt"),surface+"|"+CGPath(basis.transform)+"|"+labels.Length);
    }
    void CGSelect(int index){
        if(cgConsumer==null)throw new System.Exception("Surface not ready");var lines=System.IO.File.ReadAllLines(System.IO.Path.Combine(root,"cg-cases.tsv"));if(index<0||index>=lines.Length)throw new System.Exception("Case out of range");var f=lines[index].Split('\t');if(f.Length!=7||f[0]!=cgSurface)throw new System.Exception("Wrong surface case");string expected=CGDecode(f[6]);
        if(cgSurface=="gallery"){
            TheForestOfLove.StartScreenGalleryMenu gallery=null;foreach(var g in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.StartScreenGalleryMenu>())if(g.gameObject.scene.IsValid()){if(gallery!=null)throw new System.Exception("Ambiguous gallery");gallery=g;}
            if(gallery==null)throw new System.Exception("Original gallery controller missing");
            bool isMovie=f[3]=="movie";int ordinal=int.Parse(f[4]);var helper=gallery.GetType().GetMethod("BuildLastAttemptedMovieIdentifierPhrase",cgFlags,null,new[]{typeof(bool),typeof(int),typeof(int)},null);
            string identifier=(string)helper.Invoke(gallery,new object[]{isMovie,ordinal,ordinal});if(identifier!=string.Format(CGWord(isMovie?"movie":"story"),ordinal+1))throw new System.Exception("Original numbering differs");
            var record=CGRecord("Movie",int.Parse(f[2]));var key=CGField(record,"movie");var map=(System.Collections.IDictionary)CGField(CGManifest(),"moviesByMovie");if(!map.Contains(key)||!object.ReferenceEquals(map[key],record))throw new System.Exception("Movie cache identity differs");
            var kind=typeof(TheForestOfLove.StartScreenGalleryMenu);var movieField=kind.GetField("lastAttemptedMovie",cgFlags);var phraseField=kind.GetField("lastAttemptedMovieIdentifierPhrase",cgFlags);var oldMovie=movieField.GetValue(null);var oldPhrase=phraseField.GetValue(null);var oldRecord=map[key];
            try{
                if(f[1]=="missing")map.Remove(key);else{var clone=typeof(object).GetMethod("MemberwiseClone",cgFlags).Invoke(record,null);clone.GetType().GetField("hintPhrase",cgFlags).SetValue(clone,CGDecode(f[5]));map[key]=clone;}
                movieField.SetValue(null,key);phraseField.SetValue(null,identifier);
                cgConsumer.GetType().GetMethod("Start",cgFlags).Invoke(cgConsumer,null);
            }finally{map[key]=oldRecord;movieField.SetValue(null,oldMovie);phraseField.SetValue(null,oldPhrase);}
            if(!object.ReferenceEquals(map[key],oldRecord)||!object.Equals(movieField.GetValue(null),oldMovie)||!object.Equals(phraseField.GetValue(null),oldPhrase))throw new System.Exception("Gallery fixture restoration failed");
        }else{
            string value=CGDecode(f[5]);if(cgSurface=="oos"){
                // Use the pinned original wrapper as a pure argument fixture.
                // Calling BaseSpawner itself would schedule gameplay callbacks.
                value=string.Format(CGWord("wrapper"),value);
                cgConsumer.GetType().GetMethod("SetChapterNameLabel",cgFlags).Invoke(cgConsumer,new object[]{value});
            }else cgConsumer.GetType().GetMethod("UpdateTooltipText",cgFlags).Invoke(cgConsumer,new object[]{value});
        }
        foreach(var t in cgLabels)if(t.text!=expected)throw new System.Exception("Original consumer output differs "+index);
        UnityEngine.Canvas.ForceUpdateCanvases();System.IO.File.WriteAllText(System.IO.Path.Combine(root,"cg-selected.txt"),index+"\n"+CG64(expected)+"\nfixture-restored=true\n");
    }
    [System.Serializable] public sealed class CGMetric {
        public string path,text,font,family,overflowMode;public string[] glyphs,cameras;
        public float fontSize,fontSizeMin,fontSizeMax,width,height,preferredWidth,preferredHeight,authoredAlpha,effectiveAlpha;
        public int characters,visibleCharacters,missingGlyphs,outsideRect,outsideMasks,outsideViewport;
        public bool active,enabled,autoSize,overflow;public int viewportWidth,viewportHeight;
    }
    void CGGeometry(){
        if(cgLabels==null)throw new System.Exception("No native surface");UnityEngine.Canvas.ForceUpdateCanvases();var rows=new System.Text.StringBuilder();
        foreach(var t in cgLabels){t.ForceMeshUpdate(false,true);var rect=t.rectTransform.rect;float alpha=t.enabled&&t.gameObject.activeInHierarchy?t.color.a*t.canvasRenderer.GetAlpha():0;for(var a=t.transform;a!=null;a=a.parent)foreach(var group in a.GetComponents<UnityEngine.CanvasGroup>())alpha*=group.alpha;
            var m=new CGMetric{path=CGPath(t.transform),text=t.text,font=t.font.name,family=t.font.faceInfo.familyName,fontSize=t.fontSize,fontSizeMin=t.fontSizeMin,fontSizeMax=t.fontSizeMax,autoSize=t.enableAutoSizing,width=rect.width,height=rect.height,preferredWidth=t.preferredWidth,preferredHeight=t.preferredHeight,authoredAlpha=t.color.a,effectiveAlpha=alpha,active=t.gameObject.activeInHierarchy,enabled=t.enabled,characters=t.textInfo.characterCount,overflow=t.isTextOverflowing,overflowMode=t.overflowMode.ToString(),viewportWidth=UnityEngine.Screen.width,viewportHeight=UnityEngine.Screen.height};
            var glyphs=new System.Collections.Generic.List<string>();var cameras=new System.Collections.Generic.List<string>();var canvas=t.canvas;UnityEngine.Camera camera=canvas==null?null:canvas.rootCanvas.worldCamera;
            if(canvas!=null&&canvas.rootCanvas.renderMode!=UnityEngine.RenderMode.ScreenSpaceOverlay&&camera==null){foreach(var c in UnityEngine.Camera.allCameras)if(c.enabled&&c.gameObject.activeInHierarchy&&(c.cullingMask&(1<<t.gameObject.layer))!=0){if(camera!=null)throw new System.Exception("Ambiguous rendering camera; resolve native binding");camera=c;}if(camera==null)throw new System.Exception("Native UI camera unresolved");}
            cameras.Add(camera==null?"overlay":CGPath(camera.transform));
            for(int i=0;i<t.textInfo.characterCount;i++){var ch=t.textInfo.characterInfo[i];glyphs.Add(((int)ch.character)+"|"+(ch.fontAsset==null?"<null>":ch.fontAsset.name)+"|"+(ch.textElement==null?0:ch.textElement.glyphIndex)+"|"+ch.isVisible+"|"+(ch.xAdvance-ch.origin));if(!char.IsWhiteSpace(ch.character)&&(ch.textElement==null||ch.textElement.glyphIndex==0||ch.character=='\u25a1'||ch.character=='\ufffd'))m.missingGlyphs++;if(!ch.isVisible)continue;m.visibleCharacters++;
                foreach(var point in new[]{ch.bottomLeft,ch.topLeft,ch.topRight,ch.bottomRight}){
                    if(point.x<rect.xMin-.25f||point.x>rect.xMax+.25f||point.y<rect.yMin-.25f||point.y>rect.yMax+.25f)m.outsideRect++;
                    var world=t.transform.TransformPoint(point);var screen=UnityEngine.RectTransformUtility.WorldToScreenPoint(camera,world);if(screen.x<0||screen.x>UnityEngine.Screen.width||screen.y<0||screen.y>UnityEngine.Screen.height||(camera!=null&&camera.WorldToViewportPoint(world).z<=0))m.outsideViewport++;
                    for(var a=t.transform.parent;a!=null;a=a.parent){var mask=a.GetComponent<UnityEngine.UI.Mask>();var mask2=a.GetComponent<UnityEngine.UI.RectMask2D>();if((mask!=null&&mask.IsActive())||(mask2!=null&&mask2.IsActive())){var r=(UnityEngine.RectTransform)a;var local=r.InverseTransformPoint(world);if(!r.rect.Contains(local))m.outsideMasks++;}}
                }
            }m.glyphs=glyphs.ToArray();m.cameras=cameras.ToArray();rows.Append(UnityEngine.JsonUtility.ToJson(m)).Append('\n');
        }System.IO.File.WriteAllText(System.IO.Path.Combine(root,"cg-geometry.jsonl"),rows.ToString());
    }
    void CGRestore(){foreach(var pair in cgSaved)if(pair.Key!=null)pair.Key.text=pair.Value;foreach(var pair in cgSaved)if(pair.Key==null||pair.Key.text!=pair.Value)throw new System.Exception("Native text restoration failed");cgSaved.Clear();cgConsumer=null;cgLabels=null;cgSurface=null;System.IO.File.WriteAllText(System.IO.Path.Combine(root,"cg-restored.txt"),"native-text-byte-equal;no-eligibility-or-layout-changes");}
    void ChapterGalleryCommand(string action){if(action=="readback")CGReadback();else if(action.StartsWith("ready "))CGReady(action.Substring(6));else if(action.StartsWith("select "))CGSelect(int.Parse(action.Substring(7)));else if(action=="geometry")CGGeometry();else if(action=="restore")CGRestore();else throw new System.Exception("Unsupported chapter/gallery action");}
}
