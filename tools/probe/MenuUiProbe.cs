// Disposable staging and geometry inspection. No replacement text or save flags.
public sealed partial class ForestProbe {
    [System.Serializable] public sealed class MenuProbeState {
        public string scene,company,product,geometrySpace;public int width,height;
        public bool fullscreen,stretch,hasSavedSession;
    }
    static string MenuPath(UnityEngine.Transform t) {
        return t.parent==null?t.name:MenuPath(t.parent)+"/"+t.name;
    }
    void MenuPanel(string panel) {
        var flags=System.Reflection.BindingFlags.Public|System.Reflection.BindingFlags.NonPublic|System.Reflection.BindingFlags.Instance;
        TheForestOfLove.MainMenuController controller=null;
        foreach(var c in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.MainMenuController>())
            if(c.gameObject.scene.IsValid()) {if(controller!=null)throw new System.Exception("Ambiguous menu controller");controller=c;}
        if(controller==null)throw new System.Exception("Menu controller absent");
        var type=controller.GetType();
        var fields=new[]{"mainMenu","galleryMenu","optionsMenu","playMenu","deleteSavegameConfirmation","newgameConfirmation","quitConfirmation"};
        foreach(var name in fields) {
            var component=(UnityEngine.Component)type.GetField(name,flags).GetValue(controller);
            component.GetType().GetMethod("Close",System.Type.EmptyTypes).Invoke(component,null);
        }
        string selected=panel=="play"?"playMenu":panel=="gallery"?"galleryMenu":panel=="options"?"optionsMenu":
            panel=="delete"?"deleteSavegameConfirmation":panel=="new"?"newgameConfirmation":panel=="quit"?"quitConfirmation":null;
        if(selected==null)throw new System.Exception("Unknown inspection panel");
        var target=(UnityEngine.Component)type.GetField(selected,flags).GetValue(controller);
        target.GetType().GetMethod("Open",System.Type.EmptyTypes).Invoke(target,null);
        // Match the original controller's gallery presentation, without marking
        // the first-time gallery tutorial played or invoking a cheat/unlock action.
        foreach(var name in new[]{"StartLogo","MainMenuBackground"})
            ((UnityEngine.GameObject)type.GetField(name,flags).GetValue(controller)).SetActive(panel!="gallery");
        if(panel=="gallery") {
            target.GetType().GetMethod("UpdateStorySelectionText",flags,null,new[]{typeof(int)},null).Invoke(target,new object[]{0});
            target.GetType().GetMethod("UpdateMovieSelectionText",flags,null,new[]{typeof(int)},null).Invoke(target,new object[]{0});
            var images=new System.Text.StringBuilder("path\tsprite\ttexture\n");
            foreach(var image in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.UI.Image>())
                if(image.gameObject.scene.IsValid() && image.gameObject.activeInHierarchy && image.enabled && image.sprite!=null && MenuPath(image.transform).StartsWith("Canvas/GalleryMenu"))
                    images.Append(MenuPath(image.transform)).Append('\t').Append(image.sprite.name).Append('\t').Append(image.sprite.texture.name).Append('\n');
            System.IO.File.WriteAllText(System.IO.Path.Combine(root,"gallery-active-images.tsv"),images.ToString());
        }
        UnityEngine.Canvas.ForceUpdateCanvases();
    }
    void MenuShowActOne() {
        // Separate command: first opening the inactive panel schedules its Start,
        // which hides these controls after the earlier Open call has returned.
        var flags=System.Reflection.BindingFlags.Public|System.Reflection.BindingFlags.NonPublic|System.Reflection.BindingFlags.Instance;
        foreach(var play in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.PlayMenu>()) {
            if(!play.gameObject.scene.IsValid() || !play.gameObject.activeInHierarchy)continue;
            var kind=play.GetType();
            ((UnityEngine.GameObject)kind.GetField("fastForwardControls",flags).GetValue(play)).SetActive(true);
            var destinations=(UnityEngine.GameObject[])kind.GetField("fastForwardDestinations",flags).GetValue(play);
            var report=new System.Text.StringBuilder();
            foreach(var destination in destinations)if(destination!=null) {
                destination.SetActive(destination.name=="Act 1");
                report.Append(MenuPath(destination.transform)).Append('\t').Append(destination.activeInHierarchy).Append('\n');
            }
            System.IO.File.WriteAllText(System.IO.Path.Combine(root,"play-staged-destinations.tsv"),report.ToString());
        }
        UnityEngine.Canvas.ForceUpdateCanvases();
    }
    void MenuGeometry() {
        UnityEngine.Canvas.ForceUpdateCanvases();
        var output=new System.Text.StringBuilder("path\ttext64\tvisible\tink\tminX\tmaxX\tminY\tmaxY\n");
        foreach(var text in UnityEngine.Resources.FindObjectsOfTypeAll<TMPro.TextMeshProUGUI>()) {
            if(!text.gameObject.scene.IsValid() || !text.gameObject.activeInHierarchy || !text.enabled)continue;
            string path=MenuPath(text.transform);
            if(!path.StartsWith("Canvas/"))continue;
            text.ForceMeshUpdate();
            float minX=float.PositiveInfinity,maxX=float.NegativeInfinity,minY=float.PositiveInfinity,maxY=float.NegativeInfinity;
            bool ink=false;var canvas=text.canvas;
            for(int i=0;i<text.textInfo.characterCount;i++) {
                var c=text.textInfo.characterInfo[i];if(!c.isVisible)continue;ink=true;
                foreach(var point in new[]{c.bottomLeft,c.topRight}) {
                    // This game renders a world-space Canvas with no worldCamera.
                    // Compare both siblings in their common root-Canvas units;
                    // a null-camera WorldToScreenPoint returns world coordinates.
                    var p=canvas.rootCanvas.transform.InverseTransformPoint(text.transform.TransformPoint(point));
                    minX=UnityEngine.Mathf.Min(minX,p.x);maxX=UnityEngine.Mathf.Max(maxX,p.x);
                    minY=UnityEngine.Mathf.Min(minY,p.y);maxY=UnityEngine.Mathf.Max(maxY,p.y);
                }
            }
            bool visible=text.color.a>0 && text.canvasRenderer.GetAlpha()>0;
            var culture=System.Globalization.CultureInfo.InvariantCulture;
            output.Append(path).Append('\t').Append(System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(text.text)))
                .Append('\t').Append(visible).Append('\t').Append(ink).Append('\t')
                .Append(minX.ToString(culture)).Append('\t').Append(maxX.ToString(culture)).Append('\t')
                .Append(minY.ToString(culture)).Append('\t').Append(maxY.ToString(culture)).Append('\n');
        }
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"menu-geometry.tsv"),output.ToString());
        var state=new MenuProbeState {scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
            company=UnityEngine.Application.companyName,product=UnityEngine.Application.productName,
            width=UnityEngine.Screen.width,height=UnityEngine.Screen.height,geometrySpace="root-canvas-local",
            fullscreen=TheForestOfLove.UI.WindowController.IsFullscreen,stretch=TheForestOfLove.UI.WindowController.EnableFullscreenStretch};
        var flags=System.Reflection.BindingFlags.Instance|System.Reflection.BindingFlags.Public|System.Reflection.BindingFlags.NonPublic;
        foreach(var p in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.PlayMenu>())
            if(p.gameObject.scene.IsValid())state.hasSavedSession=(bool)p.GetType().GetProperty("showContinueButton",flags).GetValue(p,null);
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"menu-state.json"),UnityEngine.JsonUtility.ToJson(state,true));
    }
    void MenuOriginalLayout() {
        var rects=new System.Collections.Generic.List<UnityEngine.RectTransform>();
        var pivots=new System.Collections.Generic.List<UnityEngine.Vector2>();
        var positions=new System.Collections.Generic.List<UnityEngine.Vector2>();
        var sizes=new System.Collections.Generic.List<UnityEngine.Vector2>();
        var fitters=new System.Collections.Generic.List<UnityEngine.UI.ContentSizeFitter>();
        var modes=new System.Collections.Generic.List<UnityEngine.UI.ContentSizeFitter.FitMode>();
        string[] paths={"Canvas/OptionsMenu/Controls/Fullscreen/Fullscreen/NameContainer (1)","Canvas/OptionsMenu/Controls/FullscreenStretch/FullscreenStretch/NameContainer"};
        foreach(string path in paths) {
            UnityEngine.RectTransform found=null;
            foreach(var r in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.RectTransform>())
                if(r.gameObject.scene.IsValid() && MenuPath(r)==path)found=r;
            if(found==null || !found.gameObject.activeInHierarchy)throw new System.Exception("Caption counterfactual requires visible Options labels");
            var f=found.GetComponent<UnityEngine.UI.ContentSizeFitter>();
            rects.Add(found);pivots.Add(found.pivot);positions.Add(found.anchoredPosition);sizes.Add(found.sizeDelta);fitters.Add(f);modes.Add(f.horizontalFit);
        }
        try {
            for(int i=0;i<rects.Count;i++) {
                fitters[i].horizontalFit=UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained;
                rects[i].pivot=new UnityEngine.Vector2(.5f,rects[i].pivot.y);
                rects[i].anchoredPosition=new UnityEngine.Vector2(i==0?68:79,rects[i].anchoredPosition.y);
                rects[i].sizeDelta=new UnityEngine.Vector2(72,rects[i].sizeDelta.y);
            }
            UnityEngine.Canvas.ForceUpdateCanvases();MenuGeometry();
        } finally {
            for(int i=0;i<rects.Count;i++) {
                rects[i].pivot=pivots[i];rects[i].anchoredPosition=positions[i];rects[i].sizeDelta=sizes[i];fitters[i].horizontalFit=modes[i];
            }
            UnityEngine.Canvas.ForceUpdateCanvases();
        }
    }
}
