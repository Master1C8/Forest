// Original loaded inventory consumers with disposable argument fixtures only.
// No item awards/removals, actual quantity mutation, dialogue or progression.
public sealed partial class ForestProbe {
    System.Reflection.BindingFlags invFlags=System.Reflection.BindingFlags.Public|System.Reflection.BindingFlags.NonPublic|System.Reflection.BindingFlags.Instance;
    TheForestOfLove.InventoryInfoTicker invTicker;
    TheForestOfLove.InventoryUi invUi;
    TheForestOfLove.MasterLog invMaster;
    float invGlitchHiddenAt;
    System.Collections.Generic.List<UnityEngine.GameObject> invHiddenDialogue=new System.Collections.Generic.List<UnityEngine.GameObject>();
    System.Collections.Generic.List<UnityEngine.Renderer> invHiddenRenderers=new System.Collections.Generic.List<UnityEngine.Renderer>();
    System.Collections.Generic.List<UnityEngine.UI.Graphic> invHiddenGraphics=new System.Collections.Generic.List<UnityEngine.UI.Graphic>();
    string Inv64(string s){return System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(s));}
    UnityEngine.UI.Text InvText(string field){return (UnityEngine.UI.Text)invTicker.GetType().GetField(field,invFlags).GetValue(invTicker);}
    void InventoryReadback(){
        var output=new System.Text.StringBuilder();var lines=System.IO.File.ReadAllLines(System.IO.Path.Combine(root,"inventory-expectations.tsv"));
        if(lines.Length!=48)throw new System.Exception("Incomplete inventory description workload");
        foreach(var line in lines){var f=line.Split('\t');if(f.Length!=3)throw new System.Exception("Invalid inventory expectation");
            var item=TheForestOfLove.Services.Persistence.DataService.GetInventoryItemByItemType((TheForestOfLove.Inventory.InventoryItemType)int.Parse(f[0]));
            if(item==null||Inv64(item.title)!=f[1]||Inv64(item.description)!=f[2])throw new System.Exception("Loaded inventory mismatch "+f[0]);output.Append(line).Append('\n');}
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"inventory-readback.tsv"),output.ToString());
    }
    void InventoryOpen(){
        if(invTicker!=null)throw new System.Exception("Inventory already prepared");
        foreach(var m in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.MasterLog>())if(m.gameObject.scene.IsValid()){if(invMaster!=null)throw new System.Exception("Ambiguous inventory MasterLog");invMaster=m;}
        foreach(var ui in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.InventoryUi>())if(ui.gameObject.scene.IsValid()){if(invUi!=null)throw new System.Exception("Ambiguous InventoryUi");invUi=ui;}
        if(invMaster==null||invUi==null||invMaster.visible)throw new System.Exception("Unexpected inventory route state");
        invMaster.ToggleVisible_Inventory(true);
        // Renderer fixture only. Hide the existing dialogue canvas without
        // advancing its conversation, selecting an answer or changing progress.
        foreach(var canvas in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.Canvas>())
            if(canvas.gameObject.scene.IsValid()&&canvas.name=="OverworldDialogueCanvas"&&canvas.gameObject.activeSelf){invHiddenDialogue.Add(canvas.gameObject);canvas.gameObject.SetActive(false);}
        var isolated=new System.Text.StringBuilder();
        foreach(var behaviour in UnityEngine.Resources.FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.DialogueSystemController>())
            if(behaviour.gameObject.scene.IsValid()){
                foreach(var renderer in behaviour.GetComponentsInChildren<UnityEngine.Renderer>(true))if(renderer.enabled&&renderer.gameObject.activeInHierarchy&&!renderer.transform.IsChildOf(invUi.transform)){invHiddenRenderers.Add(renderer);renderer.enabled=false;isolated.Append("renderer|").Append(MenuPath(renderer.transform)).Append('\n');}
                foreach(var graphic in behaviour.GetComponentsInChildren<UnityEngine.UI.Graphic>(true))if(graphic.enabled&&graphic.gameObject.activeInHierarchy&&!graphic.transform.IsChildOf(invUi.transform)){invHiddenGraphics.Add(graphic);graphic.enabled=false;isolated.Append("graphic|").Append(MenuPath(graphic.transform)).Append('\n');}
            }
        // This is a UI renderer fixture, not normal gameplay/input acceptance.
        // Suppress unrelated scene meshes/sprites while keeping every original
        // inventory CanvasRenderer/Graphic and its artwork. Restore on close.
        foreach(var renderer in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.Renderer>())
            if(renderer.gameObject.scene.IsValid()&&renderer.gameObject.activeInHierarchy&&renderer.enabled&&!renderer.transform.IsChildOf(invMaster.transform)){
                invHiddenRenderers.Add(renderer);renderer.enabled=false;isolated.Append("scene-renderer|").Append(MenuPath(renderer.transform)).Append('|').Append(renderer.GetType().FullName).Append('|').Append(renderer.sortingLayerName).Append('|').Append(renderer.sortingOrder).Append('\n');
            }
        foreach(var graphic in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.UI.Graphic>())
            if(graphic.gameObject.scene.IsValid()&&graphic.gameObject.activeInHierarchy&&graphic.enabled&&!graphic.transform.IsChildOf(invMaster.transform)){
                invHiddenGraphics.Add(graphic);graphic.enabled=false;isolated.Append("scene-graphic|").Append(MenuPath(graphic.transform)).Append('|').Append(graphic.GetType().FullName).Append('\n');
            }
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"inventory-isolation.txt"),isolated.ToString());
        foreach(var ticker in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.InventoryInfoTicker>())if(ticker.gameObject.scene.IsValid()&&ticker.gameObject.activeInHierarchy){if(invTicker!=null)throw new System.Exception("Ambiguous active ticker");invTicker=ticker;}
        if(invTicker==null)throw new System.Exception("No active inventory ticker");
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"inventory-open.txt"),MenuPath(invTicker.transform)+"|"+invUi.visible+"|"+invMaster.visible);
        var neighbours=new System.Text.StringBuilder("path\txMin\txMax\tyMin\tyMax\n");var basis=(UnityEngine.RectTransform)invUi.transform;
        foreach(var item in invUi.GetComponentsInChildren<UnityEngine.RectTransform>(true))if(item.gameObject.activeInHierarchy){
            var corners=new UnityEngine.Vector3[4];item.GetWorldCorners(corners);float minX=float.PositiveInfinity,maxX=float.NegativeInfinity,minY=float.PositiveInfinity,maxY=float.NegativeInfinity;
            foreach(var c in corners){var p=basis.InverseTransformPoint(c);float x=p.x-basis.rect.xMin,y=basis.rect.yMax-p.y;minX=UnityEngine.Mathf.Min(minX,x);maxX=UnityEngine.Mathf.Max(maxX,x);minY=UnityEngine.Mathf.Min(minY,y);maxY=UnityEngine.Mathf.Max(maxY,y);}
            neighbours.Append(MenuPath(item)).Append('\t').Append(minX).Append('\t').Append(maxX).Append('\t').Append(minY).Append('\t').Append(maxY).Append('\n');
        }System.IO.File.WriteAllText(System.IO.Path.Combine(root,"inventory-neighbours.tsv"),neighbours.ToString());
    }
    void InventorySelect(string request){
        if(invTicker==null)throw new System.Exception("Inventory not open");
        var parts=request.Split(' ');string mode=parts[0];int id=parts.Length==2?int.Parse(parts[1]):0;
        TheForestOfLove.InventoryCellUiController cell=null;
        foreach(var c in invUi.GetComponentsInChildren<TheForestOfLove.InventoryCellUiController>(true))if(c.gameObject.activeInHierarchy){cell=c;break;}
        if(cell==null)throw new System.Exception("Original inventory cell unavailable");
        var previous=cell.node;var node=new TheForestOfLove.InventoryGridNode();
        node.gridLocation=new UnityEngine.Vector2(mode=="empty-special"?4:0,mode=="empty-special"?3:0);
        TheForestOfLove.Inventory.InventoryItem fixture=null;
        if(mode=="owned"||mode=="consumed"||mode=="zero"){
            var original=TheForestOfLove.Services.Persistence.DataService.GetInventoryItemByItemType((TheForestOfLove.Inventory.InventoryItemType)id);
            if(original==null)throw new System.Exception("Unknown item fixture");
            fixture=(TheForestOfLove.Inventory.InventoryItem)typeof(object).GetMethod("MemberwiseClone",invFlags).Invoke(original,null);
            fixture.quantity=mode=="owned"?1:0;fixture.isConsumed=mode=="consumed";fixture.isInactive=false;
            ((System.Collections.Generic.List<TheForestOfLove.Inventory.InventoryItem>)node.GetType().GetField("possibleSchemas",invFlags).GetValue(node)).Add(fixture);
        }else if(mode!="empty-special"&&mode!="empty")throw new System.Exception("Unsupported inventory fixture mode");
        cell.node=node;
        try{invTicker.GetType().GetMethod("OnCellSelected",invFlags).Invoke(invTicker,new object[]{cell});}
        finally{cell.node=previous;}
        string expectedTitle,expectedDescription;
        if(mode=="owned"||mode=="consumed"){
            expectedTitle=id==400?"":fixture.title;expectedDescription=id==400?"":fixture.description;
        }else{
            var expected=System.IO.File.ReadAllLines(System.IO.Path.Combine(root,"inventory-empty-expectations.tsv"));
            var map=new System.Collections.Generic.Dictionary<string,string>();foreach(var l in expected){var f=l.Split('\t');map.Add(f[0],System.Text.Encoding.UTF8.GetString(System.Convert.FromBase64String(f[1])));}
            expectedTitle=map[mode=="empty-special"?"010c":"011d"];expectedDescription=map[mode=="empty-special"?"0111":"0122"];
        }
        if(InvText("itemTitleText").text!=expectedTitle||InvText("tickerText").text!=expectedDescription)throw new System.Exception("Original consumer branch mismatch "+request);
        UnityEngine.Canvas.ForceUpdateCanvases();
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"inventory-selected.txt"),request+"\n"+Inv64(expectedTitle)+"\n"+Inv64(expectedDescription)+"\n");
    }
    void InventoryGeometry(){
        UnityEngine.Canvas.ForceUpdateCanvases();var output=new System.Text.StringBuilder();
        foreach(var key in new[]{"itemTitleText","tickerText"}){
            var t=InvText(key);var rect=t.rectTransform;float alpha=t.enabled&&t.gameObject.activeInHierarchy?t.color.a:0;
            for(var p=t.transform;p!=null;p=p.parent)foreach(var group in p.GetComponents<UnityEngine.CanvasGroup>())alpha*=group.alpha;
            t.font.RequestCharactersInTexture(t.text,t.fontSize,t.fontStyle);var missing=new System.Text.StringBuilder();
            foreach(char ch in t.text)if(!char.IsWhiteSpace(ch)&&!t.font.HasCharacter(ch))missing.Append(((int)ch).ToString("x4")).Append(',');
            int outsideMasks=0;
            var vertices=t.cachedTextGenerator.verts;UnityEngine.Vector2 rounding=UnityEngine.Vector2.zero;
            if(vertices.Count>0){var first=(UnityEngine.Vector2)vertices[0].position/t.pixelsPerUnit;rounding=t.PixelAdjustPoint(first)-first;}
            foreach(var vertex in t.cachedTextGenerator.verts)if(vertex.color.a>0){
                var pointInText=vertex.position/t.pixelsPerUnit;pointInText.x+=rounding.x;pointInText.y+=rounding.y;
                var world=t.transform.TransformPoint(pointInText);
                for(var p=t.transform.parent;p!=null;p=p.parent){
                    var mask=p.GetComponent<UnityEngine.UI.Mask>();var rectMask=p.GetComponent<UnityEngine.UI.RectMask2D>();
                    if((mask!=null&&mask.IsActive())||(rectMask!=null&&rectMask.IsActive())){
                        var bounds=(UnityEngine.RectTransform)p;var point=bounds.InverseTransformPoint(world);var r=bounds.rect;
                        if(point.x<r.xMin-.25f||point.x>r.xMax+.25f||point.y<r.yMin-.25f||point.y>r.yMax+.25f)outsideMasks++;
                    }
                }
            }
            output.Append(key).Append('\t').Append(Inv64(t.text)).Append('\t').Append(t.font.name).Append('\t').Append(t.fontSize).Append('\t').Append(alpha).Append('\t').Append(rect.rect.width).Append('\t').Append(rect.rect.height).Append('\t').Append(t.preferredWidth).Append('\t').Append(t.preferredHeight).Append('\t').Append(t.cachedTextGenerator.characterCountVisible).Append('\t').Append(missing).Append('\t').Append(t.color.a).Append('\t').Append(outsideMasks).Append('\n');
        }
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"inventory-geometry.tsv"),output.ToString());
    }
    void InventoryGlitch(){
        var lines=System.IO.File.ReadAllLines(System.IO.Path.Combine(root,"inventory-glitch-expectations.tsv"));
        if(lines.Length!=2)throw new System.Exception("Missing exact glitch producer contract");
        string trace=System.Text.Encoding.UTF8.GetString(System.Convert.FromBase64String(lines[0]));
        string suffix=System.Text.Encoding.UTF8.GetString(System.Convert.FromBase64String(lines[1]));
        var go=(UnityEngine.GameObject)invTicker.GetType().GetField("glitchItemInfoTicker",invFlags).GetValue(invTicker);
        var text=(TMPro.TMP_Text)invTicker.GetType().GetField("glitchItemInfoTickerText",invFlags).GetValue(invTicker);
        int count=(int)invTicker.GetType().GetField("glitchInfoTickerSubstringLength",invFlags).GetValue(invTicker);
        float interval=(float)invTicker.GetType().GetField("glitchInfoTickerRandomizeInterval",invFlags).GetValue(invTicker);
        if(!go.activeInHierarchy||text.transform.parent!=go.transform||count!=32||interval!=.5f)throw new System.Exception("Unexpected glitch source binding");
        string value=text.text;string plainTrace=trace.Replace('\n',' ');
        var layout=System.Reflection.Assembly.Load("VNRevivalInventoryLayout").GetType("VNRevivalInventoryLayout");
        bool adapted=layout.GetMethod("FormatGlitch")!=null;
        string logical=adapted?(string)layout.GetProperty("LastGlitchInput").GetValue(null,null):value;
        if(!logical.EndsWith(suffix)||logical.Length!=count+suffix.Length)throw new System.Exception("Localized glitch suffix or fragment length mismatch");
        if(value!=(adapted?logical.Substring(0,count).Replace('\r','\n')+"\n"+suffix:logical))throw new System.Exception("Unexpected final glitch display transformation");
        string fragment=logical.Substring(0,count);int sourceIndex=plainTrace.IndexOf(fragment,System.StringComparison.Ordinal);
        if(sourceIndex<0||sourceIndex>=trace.Length-count-1)throw new System.Exception("Not an original 32-character code fragment");
        TMPro.TMP_Text title=null;foreach(var t in go.GetComponentsInChildren<TMPro.TMP_Text>(true))if(t!=text){if(title!=null)throw new System.Exception("Ambiguous glitch title");title=t;}
        if(title==null||title.text!="??????")throw new System.Exception("Unknown-item title changed");
        // Preferred size probes do not change the visible original random text.
        int starts=trace.Length-count-1;float maxHeight=0;int maxStart=-1;
        var sizes=new System.Text.StringBuilder("start\tpreferredHeight\n");
        for(int i=0;i<starts;i++){
            string candidate=plainTrace.Substring(i,count);
            string rendered=adapted?candidate.Replace('\r','\n')+"\n"+suffix:candidate+suffix;
            float height=text.GetPreferredValues(rendered,text.rectTransform.rect.width,float.PositiveInfinity).y;
            sizes.Append(i).Append('\t').Append(height).Append('\n');
            if(height>maxHeight){maxHeight=height;maxStart=i;}
        }
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"inventory-glitch-finite-sizes.tsv"),sizes.ToString());
        text.ForceMeshUpdate(false,true);int outside=0;var rect=text.rectTransform.rect;
        for(int i=0;i<text.textInfo.characterCount;i++){
            var c=text.textInfo.characterInfo[i];if(!c.isVisible)continue;
            foreach(var p in new[]{c.bottomLeft,c.topRight})if(p.x<rect.xMin-.25f||p.x>rect.xMax+.25f||p.y<rect.yMin-.25f||p.y>rect.yMax+.25f)outside++;
        }
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"inventory-glitch-readback.tsv"),Inv64(title.text)+"\t"+Inv64(value)+"\t"+sourceIndex+"\t"+starts+"\t"+maxStart+"\t"+maxHeight+"\t"+text.rectTransform.rect.width+"\t"+text.rectTransform.rect.height+"\t"+outside+"\t"+text.fontSize+"\t"+Inv64(logical)+"\n");
        // Let the existing scheduled callback see the inactive object and end.
        // The capture runner reactivates the same text without invoking selection.
        go.SetActive(false);
        invGlitchHiddenAt=UnityEngine.Time.time;
    }
    void InventoryGlitchMode(string mode){
        if(mode!="cr"&&mode!="no-cr")throw new System.Exception("Unknown glitch fixture");
        var layout=System.Reflection.Assembly.Load("VNRevivalInventoryLayout").GetType("VNRevivalInventoryLayout");
        var method=invTicker.GetType().GetMethod("RandomizeGlitchItemInfoTickerText",invFlags);
        var previous=UnityEngine.Random.state;
        try{
            for(int seed=0;seed<4096;seed++){
                UnityEngine.Random.InitState(seed);method.Invoke(invTicker,null);
                string input=(string)layout.GetProperty("LastGlitchInput").GetValue(null,null);
                if(input.Substring(0,32).Contains("\r")== (mode=="cr")){
                    System.IO.File.WriteAllText(System.IO.Path.Combine(root,"inventory-glitch-mode.txt"),mode+"|seed="+seed+"|original-producer-called;prior-PRNG-state-restored");
                    // Capture source/readback and deactivate in this SAME Update;
                    // an intervening0.5s callback could otherwise replace the case.
                    InventoryGlitch();return;
                }
            }throw new System.Exception("No matching original glitch fragment found within finite fixture bound");
        }finally{UnityEngine.Random.state=previous;}
    }
    void InventoryGlitchShow(){
        if(UnityEngine.Time.time-invGlitchHiddenAt<.6f)throw new System.Exception("Original glitch callbacks have not had an inactive timer interval");
        var go=(UnityEngine.GameObject)invTicker.GetType().GetField("glitchItemInfoTicker",invFlags).GetValue(invTicker);
        go.SetActive(true);UnityEngine.Canvas.ForceUpdateCanvases();
        var text=(TMPro.TMP_Text)invTicker.GetType().GetField("glitchItemInfoTickerText",invFlags).GetValue(invTicker);
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"inventory-glitch-shown.txt"),Inv64(text.text));
    }
    void InventoryClose(){
        if(invMaster!=null&&invMaster.visible)invMaster.ToggleVisible_Inventory(true);
        foreach(var canvas in invHiddenDialogue)if(canvas!=null)canvas.SetActive(true);invHiddenDialogue.Clear();
        foreach(var renderer in invHiddenRenderers)if(renderer!=null)renderer.enabled=true;invHiddenRenderers.Clear();
        foreach(var graphic in invHiddenGraphics)if(graphic!=null)graphic.enabled=true;invHiddenGraphics.Clear();
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"inventory-closed.txt"),"true");
    }
}
