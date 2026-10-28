using System;
using System.Reflection;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

// Reflow only the original active fixed-width inventory pane. No wording,
// ownership, sprites, font size or extra-items scroll geometry changes.
public static class VNRevivalInventoryLayout {
    public static string LastGlitchInput {get;private set;}
    public static string FormatGlitch(string value) {
        // Preserve the original producer's32-character fragment and exact suffix
        // as input. TMP treats a bare CR as x=0 on the same line, overprinting
        // later glyphs. At the final display boundary give CR an actual line
        // break and place the complete action label on its own following line.
        if(value==null||value.Length<32||!value.Substring(32).StartsWith(" <color=\"purple\">("))
            throw new InvalidOperationException("Unexpected glitch display input");
        LastGlitchInput=value;
        return value.Substring(0,32).Replace('\r','\n')+"\n"+value.Substring(32);
    }
    sealed class Pose {public RectTransform root;public Vector3 scale;public Vector2 position;}
    static readonly Dictionary<int,Pose> poses=new Dictionary<int,Pose>();
    static void Fit(RectTransform root,RectTransform background) {
        Pose pose;
        if(!poses.TryGetValue(root.GetInstanceID(),out pose)||pose.root!=root){pose=new Pose{root=root,scale=root.localScale,position=root.anchoredPosition};poses[root.GetInstanceID()]=pose;}
        root.localScale=pose.scale;root.anchoredPosition=pose.position;
        var canvas=root.GetComponentInParent<Canvas>();var camera=canvas==null?null:canvas.worldCamera;
        if(camera==null)foreach(var c in Camera.allCameras)if(c.name=="UI Camera"&&c.enabled){if(camera!=null)throw new InvalidOperationException("Ambiguous inventory UI camera");camera=c;}
        if(camera==null)throw new InvalidOperationException("Inventory UI camera unavailable");
        var corners=new Vector3[4];background.GetWorldCorners(corners);
        float minX=float.PositiveInfinity,maxX=float.NegativeInfinity,minY=float.PositiveInfinity,maxY=float.NegativeInfinity;
        foreach(var p in corners){var v=camera.WorldToViewportPoint(p);minX=Mathf.Min(minX,v.x);maxX=Mathf.Max(maxX,v.x);minY=Mathf.Min(minY,v.y);maxY=Mathf.Max(maxY,v.y);}
        // Keep the original header/navigation strip free at the top.
        float factor=Mathf.Min(1,Mathf.Min(.96f/(maxX-minX),.90f/(maxY-minY)));
        root.localScale=pose.scale*factor;background.GetWorldCorners(corners);
        minX=minY=float.PositiveInfinity;maxX=maxY=float.NegativeInfinity;float depth=0;
        foreach(var p in corners){var v=camera.WorldToViewportPoint(p);minX=Mathf.Min(minX,v.x);maxX=Mathf.Max(maxX,v.x);minY=Mathf.Min(minY,v.y);maxY=Mathf.Max(maxY,v.y);depth+=v.z*.25f;}
        var centre=new Vector3((minX+maxX)*.5f,(minY+maxY)*.5f,depth);
        var wanted=new Vector3(Mathf.Clamp(centre.x,.02f+(maxX-minX)*.5f,.98f-(maxX-minX)*.5f),Mathf.Clamp(centre.y,.02f+(maxY-minY)*.5f,.92f-(maxY-minY)*.5f),depth);
        root.position+=camera.ViewportToWorldPoint(wanted)-camera.ViewportToWorldPoint(centre);
    }
    public static void Apply(object value) {
        var controller=value as Component;
        if(controller==null)throw new InvalidOperationException("Inventory layout requires a component");
        if(controller.name!="ItemInfoMultilineFixedWidths")return;
        var rect=controller.transform as RectTransform;
        if(rect==null||rect.parent.name!="Inventory UI")throw new InvalidOperationException("Unexpected inventory pane binding");
        bool source=rect.sizeDelta==new Vector2(398,23)&&rect.anchoredPosition==new Vector2(16,-195);
        bool target=rect.sizeDelta==new Vector2(398,60)&&rect.anchoredPosition==new Vector2(16,-195);
        if(!source&&!target)throw new InvalidOperationException("Unknown inventory pane before state");
        var horizontal=controller.GetComponent<HorizontalLayoutGroup>();
        if(horizontal==null)throw new InvalidOperationException("Unexpected inventory layout components");
        // The original horizontal layout has a separate live divider Image.
        // It must not survive the shared vertical title/description reflow.
        var separator=rect.Find("Separator");
        if(separator==null||separator.parent!=rect||separator.childCount!=0||separator.GetComponent<Image>()==null)
            throw new InvalidOperationException("Unexpected native inventory divider binding");
        separator.gameObject.SetActive(false);
        var flags=BindingFlags.Instance|BindingFlags.Public|BindingFlags.NonPublic;
        var title=controller.GetType().GetField("itemTitleText",flags).GetValue(controller) as Text;
        var body=controller.GetType().GetField("tickerText",flags).GetValue(controller) as Text;
        foreach(var text in new[]{title,body})
            if(text==null||text.fontSize!=12||text.resizeTextForBestFit||text.transform.parent!=rect)throw new InvalidOperationException("Unexpected native inventory text role");
        horizontal.enabled=false;
        var background=rect.parent.Find("Background") as RectTransform;
        if(background==null||background.localScale!=new Vector3(.5f,.5f,1)||background.anchoredPosition!=new Vector2(0,-16)||
           (background.sizeDelta!=new Vector2(824,414)&&background.sizeDelta!=new Vector2(824,488)))throw new InvalidOperationException("Unexpected inventory background binding");
        // Keep the original information row below both complete item panels.
        // Extend only its existing background; no grid, scrolling or texture edits.
        background.sizeDelta=new Vector2(824,488);
        rect.sizeDelta=new Vector2(398,60);rect.anchoredPosition=new Vector2(16,-195);
        // The original bitmap contains the old one-row dividers. A native flat
        // backplate clears only this information area without editing pixels.
        var plateTransform=rect.parent.Find("VNRevivalInventoryTextBackdrop");
        Image plate;
        if(plateTransform==null){
            var go=new GameObject("VNRevivalInventoryTextBackdrop",typeof(RectTransform),typeof(CanvasRenderer),typeof(Image));
            go.layer=rect.gameObject.layer;go.transform.SetParent(rect.parent,false);plate=go.GetComponent<Image>();
        }else plate=plateTransform.GetComponent<Image>();
        if(plate==null)throw new InvalidOperationException("Unexpected inventory text backdrop");
        var plateRect=plate.rectTransform;plateRect.anchorMin=new Vector2(0,1);plateRect.anchorMax=new Vector2(0,1);plateRect.pivot=new Vector2(0,1);
        plateRect.anchoredPosition=new Vector2(16,-195);plateRect.sizeDelta=new Vector2(398,60);
        var sampled=new Color(193f/255,189f/255,176f/255,1);plate.color=QualitySettings.activeColorSpace==ColorSpace.Linear?sampled.linear:sampled;
        plate.raycastTarget=false;plate.sprite=null;
        var glitchObject=controller.GetType().GetField("glitchItemInfoTicker",flags).GetValue(controller) as GameObject;
        if(glitchObject==null||glitchObject.transform.parent!=rect.parent)throw new InvalidOperationException("Unexpected separate glitch binding");
        var glitchRect=glitchObject.transform as RectTransform;
        var glitchText=controller.GetType().GetField("glitchItemInfoTickerText",flags).GetValue(controller) as TMPro.TMP_Text;
        if(glitchRect==null||glitchText==null||glitchText.transform.parent!=glitchRect||glitchText.fontSize!=12||glitchText.enableAutoSizing)
            throw new InvalidOperationException("Unexpected separate glitch text role");
        var glitchLayout=glitchObject.GetComponent<HorizontalLayoutGroup>();
        if(glitchLayout==null)throw new InvalidOperationException("Unexpected separate glitch layout");
        glitchLayout.enabled=false;
        if(glitchRect.sizeDelta!=new Vector2(398,23)&&glitchRect.sizeDelta!=new Vector2(398,60))
            throw new InvalidOperationException("Unexpected separate glitch pane");
        glitchRect.sizeDelta=new Vector2(398,60);
        glitchText.rectTransform.anchorMin=new Vector2(0,1);glitchText.rectTransform.anchorMax=new Vector2(0,1);
        glitchText.rectTransform.pivot=new Vector2(0,1);glitchText.rectTransform.anchoredPosition=new Vector2(84,-2);
        glitchText.rectTransform.sizeDelta=new Vector2(308,58);
        // Removing an existing earlier sibling shifts both following indices.
        // Account for that shift so repeated selections retain the same order.
        int before=Mathf.Min(rect.GetSiblingIndex(),glitchObject.transform.GetSiblingIndex());
        if(plateRect.GetSiblingIndex()<before)before--;
        plateRect.SetSiblingIndex(before);
        foreach(var text in new[]{title,body}) {
            text.rectTransform.anchorMin=new Vector2(0,1);text.rectTransform.anchorMax=new Vector2(0,1);
            text.rectTransform.pivot=new Vector2(0,1);text.rectTransform.sizeDelta=new Vector2(394,1);
        }
        float titleHeight=Mathf.Ceil(title.preferredHeight)+1;
        float bodyHeight=Mathf.Ceil(body.preferredHeight)+1;
        if(titleHeight+bodyHeight+6>60)throw new InvalidOperationException("Inventory target exceeds the finite pane contract");
        title.rectTransform.anchoredPosition=new Vector2(2,-2);title.rectTransform.sizeDelta=new Vector2(394,titleHeight);
        body.rectTransform.anchoredPosition=new Vector2(2,-4-titleHeight);body.rectTransform.sizeDelta=new Vector2(394,bodyHeight);
        // The original glitch object is a separate sibling under Inventory UI.
        // It deliberately keeps its own original rendering/geometry.
        Fit((RectTransform)rect.parent,background);
    }
}
