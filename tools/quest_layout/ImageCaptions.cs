// Replace only registered text-bearing Images with native localized UI text.
// Original sprites, textures, transforms and controls remain intact.
using System;
using UnityEngine;
using UnityEngine.UI;
public static partial class VNRevivalImageCaptions {
    static string Address(Transform t) {return t.parent==null?t.name:Address(t.parent)+"/"+t.name;}
    static void Apply(Component owner,string spriteName,string suffix,string wording,int size,bool outlined) {
        Image selected=null;
        foreach(var image in Resources.FindObjectsOfTypeAll<Image>())
            if(image.gameObject.scene==owner.gameObject.scene&&image.sprite!=null&&image.sprite.name==spriteName&&Address(image.transform).EndsWith(suffix,StringComparison.Ordinal)) {
                if(selected!=null)throw new InvalidOperationException("Ambiguous localized image caption: "+spriteName);selected=image;
            }
        if(selected==null)throw new InvalidOperationException("Missing localized image caption: "+spriteName);
        var old=selected.transform.Find("VNRevivalImageCaption");
        if(old!=null){if(old.GetComponent<Text>().text!=wording)throw new InvalidOperationException("Conflicting caption state");return;}
        Font font=null;
        foreach(var candidate in Resources.FindObjectsOfTypeAll<Font>())if(candidate.name=="LiberationSans") {
            bool complete=true;foreach(char c in wording)if(!Char.IsWhiteSpace(c)&&!candidate.HasCharacter(c))complete=false;
            if(complete)font=candidate;
        }
        if(font==null)throw new InvalidOperationException("Registered caption font unavailable");
        var go=new GameObject("VNRevivalImageCaption",typeof(RectTransform),typeof(CanvasRenderer),typeof(Text));
        go.layer=selected.gameObject.layer;var rect=(RectTransform)go.transform;rect.SetParent(selected.transform,false);
        rect.anchorMin=Vector2.zero;rect.anchorMax=Vector2.one;rect.offsetMin=rect.offsetMax=Vector2.zero;
        var text=go.GetComponent<Text>();text.font=font;text.text=wording;text.fontSize=size;text.alignment=TextAnchor.MiddleCenter;
        text.resizeTextForBestFit=false;text.horizontalOverflow=HorizontalWrapMode.Overflow;text.verticalOverflow=VerticalWrapMode.Overflow;
        text.supportRichText=false;text.raycastTarget=false;text.color=outlined?Color.white:Color.black;
        if(outlined){var outline=go.AddComponent<Outline>();outline.effectColor=Color.black;outline.effectDistance=new Vector2(2,-2);}
        selected.enabled=false;
    }
    static float residentBodyTopLift;
    static void VersionLabel(Component owner) {
        // The original Start method instantiates the logo after our prefix.
        // Bind only the live, exact source label after that lifecycle boundary.
        if(owner.GetComponent<VersionContrast>()==null)owner.gameObject.AddComponent<VersionContrast>();
    }
    public sealed class VersionContrast:MonoBehaviour {
        void LateUpdate() {
            Graphic selected=null;
            foreach(var graphic in Resources.FindObjectsOfTypeAll<Graphic>())
                if(graphic.gameObject.scene.IsValid()&&graphic.gameObject.activeInHierarchy&&
                   Address(graphic.transform)=="Canvas/Logo/BuildVersionNumber (3)") {
                    if(selected!=null)throw new InvalidOperationException("Ambiguous source version label");selected=graphic;
                }
            if(selected==null)return;
            if(selected.GetType().FullName!="TMPro.TextMeshProUGUI")throw new InvalidOperationException("Unregistered source version component");
            if((string)selected.GetType().GetProperty("text").GetValue(selected,null)!="v0.45.1")return;
            selected.color=Color.white;enabled=false;
        }
    }
    public static void Gallery(Component owner) {VersionLabel(owner);Apply(owner,"gallery_logo","/GalleryMenu/Logo",__GALLERY__,__GALLERY_SIZE__,true);ScaleGalleryCounters(owner,__GALLERY_COUNTER_SCALE__);}
    public static void Residents(Component owner) {
        residentBodyTopLift=__RESIDENT_BODY_TOP_LIFT__;
        preferenceHeadingLift=__PREFERENCE_HEADING_LIFT__;ScaleCritterHeading(owner,__CRITTER_HEADING_SCALE__);
        Apply(owner,"CritterLog_Residents_Label","/ResidentsScrollView/Title",__RESIDENTS__,__RESIDENTS_SIZE__,false);
        if(__RESIDENT_REFLOW__)InstallResidentBody(owner);
    }
}
