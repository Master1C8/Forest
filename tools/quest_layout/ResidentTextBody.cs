// Complete dynamically populated resident facts, with a bounded body viewport.
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public static partial class VNRevivalImageCaptions {
    static void InstallResidentBody(Component owner) {
        var fields=new Dictionary<string,Text>();RectTransform root=null;
        foreach(var text in Resources.FindObjectsOfTypeAll<Text>()) {
            if(text.gameObject.scene!=owner.gameObject.scene)continue;
            string name=text.name;
            bool selected=name=="Notes_Title"||name=="Kinks_Title";
            for(int i=1;i<=6;i++)selected|=name=="Notes"+i;
            for(int i=1;i<=9;i++)selected|=name=="Kinks"+i;
            if(!selected||!Address(text.transform).EndsWith("/CritterLog UI/Content/Bio/"+name,StringComparison.Ordinal))continue;
            if(fields.ContainsKey(name))throw new InvalidOperationException("Ambiguous resident fact: "+name);
            fields.Add(name,text);
            var parent=text.transform.parent as RectTransform;
            if(root!=null&&root!=parent)throw new InvalidOperationException("Resident fact parents changed");root=parent;
        }
        if(fields.Count!=17||root==null)throw new InvalidOperationException("Resident fact inventory changed");
        if(root.GetComponent<ResidentBody>()!=null)return;
        root.gameObject.AddComponent<ResidentBody>().Initialize(root,fields);
    }
    public sealed class ResidentBody:MonoBehaviour {
        RectTransform root,view,content;ScrollRect scroll;
        Text notesTitle,kinksTitle;Text[] notes,kinks;int[] sizes;
        float[] lefts,widths;float notesHeadingLeft,notesHeadingWidth,kinksHeadingLeft,kinksHeadingWidth,firstFactsFloor;string signature;
        static RectTransform Child(string name,Transform parent,params Type[] extra) {
            var types=new List<Type>{typeof(RectTransform)};types.AddRange(extra);
            var go=new GameObject(name,types.ToArray());go.layer=parent.gameObject.layer;
            var rect=(RectTransform)go.transform;rect.SetParent(parent,false);rect.localScale=Vector3.one;return rect;
        }
        static Vector2 Bounds(Text t,RectTransform relative,bool horizontal) {
            var corners=new Vector3[4];t.rectTransform.GetWorldCorners(corners);
            float lo=float.PositiveInfinity,hi=float.NegativeInfinity;
            foreach(var p in corners){var q=relative.InverseTransformPoint(p);float x=horizontal?q.x:q.y;lo=Mathf.Min(lo,x);hi=Mathf.Max(hi,x);}return new Vector2(lo,hi);
        }
        public void Initialize(RectTransform parent,Dictionary<string,Text> fields) {
            root=parent;notesTitle=fields["Notes_Title"];kinksTitle=fields["Kinks_Title"];
            notes=new Text[6];kinks=new Text[9];sizes=new int[15];lefts=new float[3];widths=new float[3];
            for(int i=0;i<6;i++)notes[i]=fields["Notes"+(i+1)];for(int i=0;i<9;i++)kinks[i]=fields["Kinks"+(i+1)];
            float top=Bounds(notesTitle,root,false).y,bottom=float.PositiveInfinity;
            if(residentBodyTopLift>0) {
                var portrait=root.Find("Portrait") as RectTransform;
                if(portrait==null||portrait.rect.width!=65||portrait.rect.height!=60)
                    throw new InvalidOperationException("Resident portrait geometry changed");
                var corners=new Vector3[4];portrait.GetWorldCorners(corners);float portraitBottom=float.PositiveInfinity;
                foreach(var corner in corners)portraitBottom=Mathf.Min(portraitBottom,root.InverseTransformPoint(corner).y);
                top+=residentBodyTopLift;
                // The centered heading may occupy the empty space beside the
                // portrait. The first actual fact row must clear its bottom.
                firstFactsFloor=Mathf.Max(0,top-portraitBottom+4);
            }
            for(int i=0;i<15;i++){var t=i<6?notes[i]:kinks[i-6];sizes[i]=t.fontSize;bottom=Mathf.Min(bottom,Bounds(t,root,false).x);}
            for(int i=0;i<3;i++)lefts[i]=Bounds(notes[i],root,true).x-root.rect.xMin;
            for(int i=0;i<3;i++)widths[i]=i<2?lefts[i+1]-lefts[i]-4:notes[i].rectTransform.rect.width;
            // Both labels retain their original centers. Their available band
            // spans the fact grid, rather than copying the narrow Notes rect
            // onto a longer localized preference heading.
            float band=lefts[2]+widths[2]-lefts[0];
            var nb=Bounds(notesTitle,root,true);float nc=(nb.x+nb.y)*.5f-root.rect.xMin;
            var kb=Bounds(kinksTitle,root,true);float kc=(kb.x+kb.y)*.5f-root.rect.xMin;
            notesHeadingWidth=Mathf.Min(band,2*Mathf.Min(nc-4,root.rect.width-4-nc));notesHeadingLeft=nc-notesHeadingWidth*.5f;
            kinksHeadingWidth=Mathf.Min(band,2*Mathf.Min(kc-4,root.rect.width-4-kc));kinksHeadingLeft=kc-kinksHeadingWidth*.5f;
            // The original 189-unit pane has 12 units below the last fact.
            // Reserve the registered inset from the painted frame.
            bottom=root.rect.yMin+__RESIDENT_BODY_BOTTOM_INSET__;
            if(top-bottom<40||Array.Exists(widths,w=>w<30))throw new InvalidOperationException("Resident body geometry changed");
            view=Child("VNRevivalResidentViewport",root,typeof(RectMask2D),typeof(Image),typeof(ScrollRect));
            view.anchorMin=new Vector2(0,1);view.anchorMax=Vector2.one;view.pivot=new Vector2(0,1);
            view.anchoredPosition=new Vector2(0,top-root.rect.yMax);view.sizeDelta=new Vector2(0,top-bottom);
            var image=view.GetComponent<Image>();image.color=new Color(0,0,0,0);image.raycastTarget=true;image.canvasRenderer.cullTransparentMesh=false;
            content=Child("VNRevivalResidentContent",view);content.anchorMin=new Vector2(0,1);content.anchorMax=Vector2.one;content.pivot=new Vector2(0,1);content.anchoredPosition=Vector2.zero;
            foreach(var t in fields.Values)t.rectTransform.SetParent(content,false);
            scroll=view.GetComponent<ScrollRect>();scroll.content=content;scroll.viewport=view;scroll.horizontal=false;scroll.vertical=true;scroll.movementType=ScrollRect.MovementType.Clamped;scroll.scrollSensitivity=12;
        }
        static Vector2 ResidentInkY(Text text,RectTransform content) {
            var gen=text.cachedTextGenerator;if(!gen.Populate(text.text,text.GetGenerationSettings(text.rectTransform.rect.size)))throw new InvalidOperationException("Resident text generation failed");
            float lo=float.PositiveInfinity,hi=float.NegativeInfinity;
            foreach(var vertex in gen.verts){if(vertex.color.a==0)continue;var p=content.InverseTransformPoint(text.transform.TransformPoint(vertex.position/text.pixelsPerUnit));lo=Mathf.Min(lo,p.y);hi=Mathf.Max(hi,p.y);}
            return float.IsInfinity(lo)?Vector2.zero:new Vector2(lo,hi);
        }
        float Place(Text text,float left,float top,float width) {
            var r=text.rectTransform;r.anchorMin=r.anchorMax=new Vector2(0,1);r.pivot=new Vector2(0,1);r.anchoredPosition=new Vector2(left,-top);
            text.horizontalOverflow=HorizontalWrapMode.Wrap;text.verticalOverflow=VerticalWrapMode.Overflow;text.alignment=TextAnchor.UpperCenter;
            r.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal,width);r.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical,text.preferredHeight);
            var ink=ResidentInkY(text,content);if(ink.x==ink.y)return 0;
            var pos=r.anchoredPosition;pos.y+=-top-ink.y;r.anchoredPosition=pos;return ink.y-ink.x;
        }
        float Rows(Text[] texts,int sizeOffset,int reduction,float cursor) {
            for(int row=0;row<texts.Length/3;row++) {
                float height=0;
                for(int col=0;col<3;col++){int i=row*3+col;var t=texts[i];t.fontSize=Math.Max(8,sizes[sizeOffset+i]-reduction);height=Mathf.Max(height,Place(t,lefts[col],cursor,widths[col]));}
                cursor+=Mathf.Max(6,height)+3;
            }
            return cursor;
        }
        float Layout(int reduction) {
            float cursor=Place(notesTitle,notesHeadingLeft,2,notesHeadingWidth)+5;
            cursor=Mathf.Max(cursor,firstFactsFloor);
            cursor=Rows(notes,0,reduction,cursor)+__RESIDENT_PREFERENCE_BASE_GAP__;
            cursor+=Place(kinksTitle,kinksHeadingLeft,cursor,kinksHeadingWidth)+5;
            kinksTitle.rectTransform.anchoredPosition+=new Vector2(0,preferenceHeadingLift);
            return Rows(kinks,6,reduction,cursor)+2;
        }
        void LateUpdate() {
            if(root==null||!root.gameObject.activeInHierarchy)return;
            string current=notesTitle.text+"\u0001"+kinksTitle.text;
            foreach(var t in notes)current+="\u0001"+t.text;foreach(var t in kinks)current+="\u0001"+t.text;
            if(signature==current)return;
            float old=scroll.verticalNormalizedPosition;content.anchoredPosition=Vector2.zero;
            float needed=0;for(int reduction=0;reduction<=2;reduction++){needed=Layout(reduction);if(needed<=view.rect.height)break;}
            content.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical,Mathf.Max(needed,view.rect.height));
            scroll.StopMovement();scroll.verticalNormalizedPosition=signature==null?1:old;signature=current;Canvas.ForceUpdateCanvases();
        }
    }
}
