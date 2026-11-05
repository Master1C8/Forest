// Scale the original two counter-label groups; logical tags/wording stay intact.
using System;
using System.Collections.Generic;
using UnityEngine;
public static partial class VNRevivalImageCaptions {
    sealed class CounterPose {public RectTransform rect;public Vector2 position;}
    static Dictionary<int,CounterPose> counterPoses;
    static void ScaleGalleryCounters(Component owner,float scale) {
        if(scale==1)return;
        if(scale<.6f||scale>1)throw new InvalidOperationException("Gallery counter scale outside registered range");
        if(counterPoses==null)counterPoses=new Dictionary<int,CounterPose>();
        int matched=0;
        foreach(var rect in Resources.FindObjectsOfTypeAll<RectTransform>()) {
            if(rect.gameObject.scene!=owner.gameObject.scene)continue;
            string path=Address(rect);
            if(!path.EndsWith("/GalleryMenu/MoviesSelectionLabel/NameContainer",StringComparison.Ordinal)&&
               !path.EndsWith("/GalleryMenu/StoriesSelectionLabel/NameContainer",StringComparison.Ordinal))continue;
            var target=new Vector3(scale,scale,1);
            CounterPose pose;
            if(!counterPoses.TryGetValue(rect.GetInstanceID(),out pose)||pose.rect!=rect){
                if(rect.localScale!=Vector3.one)throw new InvalidOperationException("Unowned gallery counter scale");
                pose=new CounterPose{rect=rect,position=rect.anchoredPosition};counterPoses[rect.GetInstanceID()]=pose;
            }
            var position=pose.position+new Vector2(rect.rect.xMin*(1-scale),rect.rect.yMax*(1-scale));
            if(rect.localScale!=Vector3.one&&rect.localScale!=target)
                throw new InvalidOperationException("Unexpected original gallery counter scale");
            if(rect.anchoredPosition!=pose.position&&rect.anchoredPosition!=position)
                throw new InvalidOperationException("Unexpected gallery counter position");
            rect.localScale=target;rect.anchoredPosition=position;matched++;
        }
        if(matched!=2)throw new InvalidOperationException("Expected exactly two gallery counter groups");
    }
}
