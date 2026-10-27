// Complete localized quest text keeps its source font/size and uses the existing detail ScrollRect.
using System;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;
using UnityEngine.UI;
public static class VNRevivalQuestLayout {
    sealed class State {
        public RectTransform root,viewport,content;
        public ScrollRect scroll;
        public Text title,description;
        public Image portrait;
        public Text[] history;
        public float descX,portraitX,portraitDeltaY,titleY;
        public string signature;
    }
    static readonly Dictionary<int,State> states=new Dictionary<int,State>();
    const BindingFlags flags=BindingFlags.Public|BindingFlags.NonPublic|BindingFlags.Instance;
    static T Field<T>(Component pane,string name) where T:UnityEngine.Object {
        var f=pane.GetType().GetField(name,flags);if(f==null)throw new InvalidOperationException("Quest layout field absent: "+name);
        var value=f.GetValue(pane) as T;if(value==null)throw new InvalidOperationException("Quest layout reference absent: "+name);return value;
    }
    static RectTransform Child(string name,Transform parent,params Type[] components) {
        var types=new List<Type>{typeof(RectTransform)};types.AddRange(components);
        var go=new GameObject(name,types.ToArray());go.layer=parent.gameObject.layer;
        var rect=(RectTransform)go.transform;rect.SetParent(parent,false);rect.localScale=Vector3.one;return rect;
    }
    static State Initialize(Component pane) {
        if(pane.GetType().FullName!="TheForestOfLove.QuestLogDetailsPane")throw new InvalidOperationException("Wrong Quest layout owner");
        var s=new State();s.root=(RectTransform)pane.transform;s.title=Field<Text>(pane,"title");s.description=Field<Text>(pane,"description");s.portrait=Field<Image>(pane,"portrait");s.scroll=pane.GetComponent<ScrollRect>();
        if(s.scroll==null||s.scroll.content!=null||s.scroll.viewport!=null)throw new InvalidOperationException("Unexpected source Quest ScrollRect state");
        s.history=new[]{Field<Text>(pane,"stepHistory4Back"),Field<Text>(pane,"stepHistory3Back"),Field<Text>(pane,"stepHistory2Back"),Field<Text>(pane,"stepHistory1Back"),Field<Text>(pane,"stepHistoryCurrent")};
        s.descX=s.description.rectTransform.anchoredPosition.x;s.portraitX=s.portrait.rectTransform.anchoredPosition.x;s.portraitDeltaY=s.portrait.rectTransform.anchoredPosition.y-s.description.rectTransform.anchoredPosition.y;s.titleY=s.title.rectTransform.anchoredPosition.y;
        s.viewport=Child("VNRevivalQuestViewport",s.root,typeof(RectMask2D),typeof(Image));
        var raycaster=s.viewport.GetComponent<Image>();raycaster.color=new Color(0,0,0,0);raycaster.raycastTarget=true;raycaster.canvasRenderer.cullTransparentMesh=false;
        s.viewport.anchorMin=Vector2.zero;s.viewport.anchorMax=Vector2.one;s.viewport.pivot=new Vector2(0,1);
        s.content=Child("VNRevivalQuestContent",s.viewport);s.content.anchorMin=new Vector2(0,1);s.content.anchorMax=new Vector2(1,1);s.content.pivot=new Vector2(0,1);s.content.anchoredPosition=Vector2.zero;
        s.description.rectTransform.SetParent(s.content,false); // Portrait stays in its original fixed artwork frame.
        foreach(var text in s.history)text.rectTransform.parent.SetParent(s.content,false);
        // content must precede viewport: ScrollRect.IsActive rejects null content,
        // so the source viewport setter otherwise returns before clearing m_ViewRect.
        s.scroll.content=s.content;s.scroll.viewport=s.viewport;s.scroll.horizontal=false;s.scroll.vertical=true;s.scroll.movementType=ScrollRect.MovementType.Clamped;s.scroll.scrollSensitivity=12;s.scroll.inertia=true;
        return s;
    }
    static float Wrap(Text text,float width) {
        if(width<=0||text.rectTransform.localScale.x<=0||text.rectTransform.localScale.y<=0)throw new InvalidOperationException("Invalid Quest layout scale");
        text.horizontalOverflow=HorizontalWrapMode.Wrap;text.verticalOverflow=VerticalWrapMode.Overflow;
        var r=text.rectTransform;r.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal,width/r.localScale.x);
        float height=String.IsNullOrEmpty(text.text)?0:text.preferredHeight;
        r.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical,height);
        return height*r.localScale.y;
    }
    // Native bitmap glyph bearings can exceed preferredHeight. Place actual generated ink,
    // so a correct TextGenerator count cannot conceal portrait/history overlap.
    static Vector2 InkY(Text text,RectTransform relative) {
        if(String.IsNullOrEmpty(text.text))return Vector2.zero;
        var gen=text.cachedTextGenerator;
        if(!gen.Populate(text.text,text.GetGenerationSettings(text.rectTransform.rect.size)))throw new InvalidOperationException("Quest text generation failed");
        float low=float.PositiveInfinity,high=float.NegativeInfinity;
        foreach(var vertex in gen.verts){if(vertex.color.a==0)continue;var p=relative.InverseTransformPoint(text.transform.TransformPoint(vertex.position/text.pixelsPerUnit));low=Mathf.Min(low,p.y);high=Mathf.Max(high,p.y);}
        if(float.IsInfinity(low))return Vector2.zero;return new Vector2(low,high);
    }
    static float Place(Text text,RectTransform relative,float top) {
        var ink=InkY(text,relative);var p=text.rectTransform.anchoredPosition;p.y+=top-ink.y;text.rectTransform.anchoredPosition=p;return ink.y-ink.x;
    }
    public static void Apply(Component pane) {
        if(pane==null)return;State s;int id=pane.GetInstanceID();
        if(!states.TryGetValue(id,out s)){s=Initialize(pane);states[id]=s;}
        string signature=s.title.text+"\u0001"+s.description.text;foreach(var t in s.history)signature+="\u0001"+t.text;
        bool changed=s.signature!=signature;float oldScroll=s.scroll.verticalNormalizedPosition;
        float width=s.root.rect.width;if(width<100)throw new InvalidOperationException("Quest detail width unavailable");
        var tr=s.title.rectTransform;tr.anchorMin=tr.anchorMax=new Vector2(.5f,1);tr.pivot=new Vector2(.5f,1);tr.anchoredPosition=new Vector2(-5,s.titleY);
        Wrap(s.title,width-16);float titleHeight=Place(s.title,s.root,s.root.rect.yMax+s.titleY);float header=Mathf.Abs(s.titleY)+titleHeight+8;
        s.viewport.offsetMin=new Vector2(0,4);s.viewport.offsetMax=new Vector2(0,-header);
        float cursor=4;
        var dr=s.description.rectTransform;dr.anchorMin=dr.anchorMax=new Vector2(0,1);dr.pivot=new Vector2(0,1);dr.anchoredPosition=new Vector2(s.descX,-cursor);
        Wrap(s.description,Mathf.Min(148,width-s.descX-12));float descHeight=Place(s.description,s.content,-cursor);
        var pr=s.portrait.rectTransform; // Preserve its original parent,anchors,pivot and position.
        float portraitHeight=s.portrait.enabled&&s.portrait.gameObject.activeInHierarchy?pr.rect.height*pr.localScale.y-s.portraitDeltaY:0;
        cursor+=Mathf.Max(descHeight,portraitHeight)+10;
        foreach(var text in s.history) {
            var r=text.rectTransform;var row=(RectTransform)r.parent;
            bool present=!String.IsNullOrWhiteSpace(text.text);row.gameObject.SetActive(present);if(!present)continue;
            row.anchorMin=row.anchorMax=new Vector2(0,1);row.pivot=new Vector2(0,1);row.anchoredPosition=new Vector2(10,-cursor);row.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal,width-22);
            r.anchorMin=r.anchorMax=new Vector2(0,1);r.pivot=new Vector2(0,1);r.anchoredPosition=new Vector2(r.anchoredPosition.x,0);
            // Reserve the whole portrait/backing column even while text is scrolled upward.
            float leftColumnWidth=s.descX+148-10-r.anchoredPosition.x;
            Wrap(text,Mathf.Min(leftColumnWidth,width-26-r.anchoredPosition.x));float h=Place(text,s.content,-cursor);row.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical,h);cursor+=h+5;
        }
        s.content.sizeDelta=new Vector2(0,Mathf.Max(cursor+4,s.viewport.rect.height));
        Canvas.ForceUpdateCanvases();if(changed)s.scroll.StopMovement();s.scroll.verticalNormalizedPosition=oldScroll;s.signature=signature;Canvas.ForceUpdateCanvases();
    }
    sealed class HudLabel {public Text text;public Vector2 leftTop;}
    static readonly Dictionary<int,List<HudLabel>> hudStates=new Dictionary<int,List<HudLabel>>();
    public static void ApplyHud(Component hud) {
        if(hud==null||hud.GetType().FullName!="TheForestOfLove.QuestUpdatedUI")throw new InvalidOperationException("Wrong Quest HUD owner");
        List<HudLabel> labels;int id=hud.GetInstanceID();
        if(!hudStates.TryGetValue(id,out labels)){
            labels=new List<HudLabel>();
            foreach(string group in new[]{"oldStepLabels","newStepLabels"}){
                var field=hud.GetType().GetField(group,flags);var list=field==null?null:field.GetValue(hud) as List<Text>;
                if(list==null||list.Count!=8)throw new InvalidOperationException("Unexpected Quest HUD text layers");
                foreach(var text in list){var r=text.rectTransform;labels.Add(new HudLabel{text=text,leftTop=r.anchoredPosition+new Vector2(-r.pivot.x*r.rect.width,(1-r.pivot.y)*r.rect.height)});}
            }
            hudStates[id]=labels;
        }
        // The original animator translates hidden/visible copies horizontally. A320-unit
        // common column stays within the native HUD's available screen area at both states.
        // All face/outline layers keep exactly the same wrapping and source offsets.
        foreach(var item in labels){var text=item.text;var r=text.rectTransform;r.pivot=new Vector2(0,1);r.anchoredPosition=item.leftTop;text.alignment=TextAnchor.UpperLeft;Wrap(text,320);Place(text,(RectTransform)r.parent,r.localPosition.y);}
        Canvas.ForceUpdateCanvases();
    }

}
