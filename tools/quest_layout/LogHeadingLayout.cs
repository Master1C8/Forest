// Optional target layout values; original prompts and control identities stay intact.
using System;
using UnityEngine;
public static partial class VNRevivalImageCaptions {
    static float preferenceHeadingLift;
    static void ScaleCritterHeading(Component owner,float scale) {
        if(scale==1)return;
        if(scale<.6f||scale>1)throw new InvalidOperationException("Critter heading scale outside registered range");
        RectTransform selected=null;
        foreach(var rect in Resources.FindObjectsOfTypeAll<RectTransform>()) {
            if(rect.gameObject.scene!=owner.gameObject.scene||!Address(rect).EndsWith("/MasterLog/Canvas/Container/Labels/CritterLog",StringComparison.Ordinal))continue;
            if(selected!=null)throw new InvalidOperationException("Ambiguous Critter heading group");selected=rect;
        }
        if(selected==null)throw new InvalidOperationException("Original Critter heading group unavailable");
        var target=new Vector3(scale,scale,1);
        if(selected.anchorMin!=new Vector2(.5f,1)||selected.anchorMax!=selected.anchorMin||selected.pivot!=selected.anchorMin||selected.sizeDelta!=new Vector2(88,15)||(selected.localScale!=Vector3.one&&selected.localScale!=target))throw new InvalidOperationException("Unregistered Critter heading scale pose");
        selected.localScale=target;
    }
}
