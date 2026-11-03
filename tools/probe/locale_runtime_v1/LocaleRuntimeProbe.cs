// Extra observations and finite selection using the original quest consumer.
// This bridge is confined to a disposable QA copy and never shipped.
public sealed partial class ForestProbe {
    delegate bool LocaleWindowCallback(System.IntPtr window,System.IntPtr extra);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern bool EnumWindows(LocaleWindowCallback callback,System.IntPtr extra);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern bool IsWindowVisible(System.IntPtr window);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern bool GetClientRect(System.IntPtr handle,out ClientRect rect);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern uint GetWindowThreadProcessId(System.IntPtr handle,out uint pid);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern bool SetForegroundWindow(System.IntPtr handle);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern bool BringWindowToTop(System.IntPtr handle);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern System.IntPtr SetActiveWindow(System.IntPtr handle);
    void LocaleTaskFocus() {
        // OS window operations on our verified window only; never set Unity or
        // Rewired focus fields, input policy, event flags or gameplay state.
        System.IntPtr target=System.IntPtr.Zero;uint own=GetCurrentProcessId();int count=0;
        EnumWindows(delegate(System.IntPtr h,System.IntPtr ignored){uint pid;ClientRect r;GetWindowThreadProcessId(h,out pid);if(pid==own&&IsWindowVisible(h)&&GetClientRect(h,out r)&&r.right>r.left&&r.bottom>r.top){count++;target=h;}return true;},System.IntPtr.Zero);
        uint verified;GetWindowThreadProcessId(target,out verified);
        if(count!=1||verified!=own)throw new System.Exception("Exact own focus target unavailable");
        bool top=BringWindowToTop(target),foreground=SetForegroundWindow(target);var previous=SetActiveWindow(target);
        System.IO.File.AppendAllText(System.IO.Path.Combine(root,"task-win32-focus.tsv"),own+"\t"+target.ToInt64()+"\t"+top+"\t"+foreground+"\t"+previous.ToInt64()+"\n");
    }
    [System.Runtime.InteropServices.StructLayout(System.Runtime.InteropServices.LayoutKind.Sequential)] struct ClientRect { public int left,top,right,bottom; }
    void LocaleDiagnostics() {
        // Resolve only our own visible client, even when the owner changes focus.
        var window=System.IntPtr.Zero;uint own=GetCurrentProcessId();int found=0;
        EnumWindows(delegate(System.IntPtr h,System.IntPtr unused){uint owner;ClientRect area;GetWindowThreadProcessId(h,out owner);if(owner==own&&IsWindowVisible(h)&&GetClientRect(h,out area)&&area.right>area.left&&area.bottom>area.top){window=h;found++;}return true;},System.IntPtr.Zero);
        if(found!=1)throw new System.Exception("Ambiguous or missing task process window "+found);
        ClientRect rect;uint pid;
        bool valid=GetClientRect(window,out rect);GetWindowThreadProcessId(window,out pid);
        if(!valid||pid!=own)throw new System.Exception("Task client window identity differs");
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"locale-window.tsv"),GetCurrentProcessId()+"\t"+window.ToInt64()+"\t"+pid+"\t"+valid+"\t"+(rect.right-rect.left)+"\t"+(rect.bottom-rect.top));
        DisplayDiagnostics();MenuFontDiagnostics();MenuGlyphDiagnostics();
    }
    void LocaleFinley() {
        QuestPrepare();
        string[] expected=System.IO.File.ReadAllLines(System.IO.Path.Combine(root,"finley-expectation.tsv"));
        if(expected.Length!=1)throw new System.Exception("One pinned Finley quest required");
        var fields=expected[0].Split('\t');if(fields.Length!=3)throw new System.Exception("Finley expectation schema");
        var quest=QQuest(fields[0]);
        if(Q64(quest.title)!=fields[1]||Q64(quest.description)!=fields[2])throw new System.Exception("Pinned Finley wording not loaded");
        QStatus(quest,100);questPane.UpdateSelectedQuest(quest);
        UnityEngine.Canvas.ForceUpdateCanvases();
        if(QPaneText("title").text!=quest.title||QPaneText("description").text!=quest.description)throw new System.Exception("Original Finley consumer differs");
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"finley-shown.tsv"),expected[0]);
    }
    void LocaleSprite(string request) {
        int itemType=int.Parse(request);
        var item=TheForestOfLove.Services.Persistence.DataService.GetInventoryItemByItemType((TheForestOfLove.Inventory.InventoryItemType)itemType);
        if(item==null||item.sprite==null||item.sprite.texture==null)throw new System.Exception("Actual item sprite missing "+itemType);
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"sprite-"+itemType+".tsv"),itemType+"\t"+item.sprite.name+"\t"+item.sprite.texture.name);
    }
    void LocaleQuestDiagnostics() {
        QuestGeometry();var viewport=(UnityEngine.RectTransform)questPane.transform.Find("VNRevivalQuestViewport");
        var scroll=questPane.GetComponent<UnityEngine.UI.ScrollRect>();
        if(viewport.GetComponent<UnityEngine.UI.RectMask2D>()==null||scroll.content.parent!=viewport||!scroll.vertical||scroll.horizontal)throw new System.Exception("Quest mask/content/axis contract differs");
        var output=new System.Text.StringBuilder();var bounds=QBounds(viewport,QCamera());
        output.Append("viewport\t").Append(string.Join("\t",bounds)).Append('\t').Append(scroll.content.rect.height).Append('\t').Append(viewport.rect.height).Append('\t').Append(scroll.verticalNormalizedPosition).Append('\n');
        foreach(var text in questPane.GetComponentsInChildren<UnityEngine.UI.Text>(true)) {
            if(!text.enabled||!text.gameObject.activeInHierarchy||string.IsNullOrEmpty(text.text))continue;
            var missing=new System.Collections.Generic.HashSet<int>();foreach(char ch in text.text)if(!char.IsWhiteSpace(ch)&&!text.font.HasCharacter(ch))missing.Add((int)ch);
            output.Append("font\t").Append(MenuPath(text.transform)).Append('\t').Append(string.Join(",",missing)).Append('\n');
        }
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"locale-quest.tsv"),output.ToString());
    }
    void LocaleQuestHeadings() {
        if(System.IO.File.Exists(System.IO.Path.Combine(root,"execution","config.json")) &&
           System.IO.File.ReadAllText(System.IO.Path.Combine(root,"execution","config.json")).Contains("notebook-headings")) {
            LocaleHeadingMeasure("locale-quest-headings.json");return;
        }
        var output=new System.Text.StringBuilder();int count=0;
        foreach(var image in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.UI.Image>())if(image.gameObject.scene.IsValid()&&image.sprite!=null&&(image.sprite.name=="QuestLog_Label_Active"||image.sprite.name=="QuestLog_Label_Completed")) {
            output.Append("source-artwork\t").Append(image.sprite.name).Append('\t').Append(image.enabled).Append('\t').Append(image.gameObject.activeInHierarchy).Append('\n');count++;
        }
        if(count!=2)throw new System.Exception("Quest source status artwork inventory differs");
        foreach(var text in UnityEngine.Resources.FindObjectsOfTypeAll<TMPro.TextMeshProUGUI>()) {
            string path=MenuPath(text.transform);if(!text.gameObject.scene.IsValid()||!path.Contains("/MasterLog/")||!path.Contains("/Labels/QuestLog/")||!text.enabled||!text.gameObject.activeInHierarchy)continue;
            text.ForceMeshUpdate();output.Append("heading\t").Append(path).Append('\t').Append(Q64(text.GetParsedText())).Append('\t').Append(text.textInfo.characterCount).Append('\t').Append(text.isTextOverflowing).Append('\n');
        }
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"locale-quest-headings.tsv"),output.ToString());
    }
    // Finite current-adapter observer. Never calls Apply or writes heading text/font/style.
    TheForestOfLove.MasterLog headingMaster;
    UnityEngine.Canvas headingBackground;
    bool headingMasterEnabled,headingQuestEnabled;
    string headingPage="unopened",headingRequired="Bewohner";
    TheForestOfLove.MasterLog HeadingMaster() {
        if(headingMaster!=null)return headingMaster;
        foreach(var m in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.MasterLog>())if(m.gameObject.scene.IsValid()) {
            if(headingMaster!=null)throw new System.Exception("Ambiguous heading MasterLog");headingMaster=m;
        }
        if(headingMaster==null)throw new System.Exception("Heading MasterLog absent");
        headingMasterEnabled=headingMaster.enabled;return headingMaster;
    }
    void HeadingToggle(string page) {
        var master=HeadingMaster();var value=System.Enum.Parse(typeof(TheForestOfLove.MasterLogPage),page);
        master.GetType().GetMethod("ToggleVisible",qFlags,null,new System.Type[]{typeof(TheForestOfLove.MasterLogPage),typeof(bool)},null).Invoke(master,new object[]{value,true});
    }
    void LocaleHeadingPage(string page) {
        var master=HeadingMaster();
        if(page=="residents") {
            if(headingPage!="unopened"||questPane!=null||master.visible)throw new System.Exception("Residents must precede any quest preparation/selection");
            foreach(var c in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.Canvas>())if(c.gameObject.scene.IsValid()&&c.name=="OverworldDialogueCanvas"&&c.gameObject.activeSelf) {
                if(headingBackground!=null)throw new System.Exception("Ambiguous fixture dialogue canvas");headingBackground=c;c.gameObject.SetActive(false);
            }
            HeadingToggle("CritterLog");headingRequired="Bewohner";
        } else if(page=="quest") {
            if(headingPage!="residents")throw new System.Exception("Quest test requires first-open Residents receipt");
            if(master.visible)HeadingToggle("CritterLog");
            QuestPrepare();headingQuestEnabled=true;
            // Reversible status fixture gives original grouping both an active and completed row.
            QStatus(QQuest("MelodyFlipbookQuest"),200);
            HeadingToggle("QuestLog");HeadingToggle("QuestLog");headingRequired="Aktiv";
        } else throw new System.Exception("Unknown heading page");
        headingPage=page;UnityEngine.Canvas.ForceUpdateCanvases();
        System.IO.File.AppendAllText(System.IO.Path.Combine(root,"heading-route.tsv"),UnityEngine.Time.frameCount+"\t"+page+"\tquestPrepared="+(questPane!=null)+"\tmasterVisible="+master.visible+"\n");
    }
    void LocaleHeadingScroll(string end) {
        if(headingPage!="quest" || (end!="top"&&end!="bottom"))throw new System.Exception("Heading scroll route guard");
        var at=HeadingMaster().transform.Find("QuestLog/QuestLog UI/Content/QuestsScrollView");
        var scroll=at.GetComponent<UnityEngine.UI.ScrollRect>();if(scroll==null)throw new System.Exception("Original quest list ScrollRect absent");
        scroll.StopMovement();scroll.verticalNormalizedPosition=end=="top"?1:0;headingRequired=end=="top"?"Aktiv":"Abgeschlossen";
        UnityEngine.Canvas.ForceUpdateCanvases();
    }
    [System.Serializable] class HeadingRow {
        public string path,text,sprite,font,fontNames,material,shader,required;
        public int frame,fontSize,characters,glyphQuads,outsideRect,outsideMasks;
        public bool imageEnabled,textEnabled,active,fontMatchesDonor,maskable,raycastTarget,canvasCulled,visible;
        public float alpha,authoredAlpha,width,height,preferredWidth,preferredHeight;
        public float[] color,bounds,glyphBounds;public string[] masks;
    }
    [System.Serializable] class HeadingObservation {
        public int frame,width,height,inventoryLayers,dormantImages,pauseImages;
        public string page,required;public bool questPrepared;
        public string[] preserved;public string[] fontAssemblies;
    }
    void LocaleHeadingMeasure(string filename) {
#if FOREST_NOTEBOOK_HEADINGS
        UnityEngine.Canvas.ForceUpdateCanvases();var master=HeadingMaster();var camera=QCamera();
        var donor=master.transform.Find(VNRevivalHeadingConfig.DonorPath).GetComponent<UnityEngine.UI.Text>();
        var rows=new System.Collections.Generic.List<HeadingRow>();bool requiredPassed=false;
        for(int i=0;i<VNRevivalHeadingConfig.Paths.Length;i++) {
            var image=master.transform.Find(VNRevivalHeadingConfig.Paths[i]).GetComponent<UnityEngine.UI.Image>();
            var child=image.transform.Find("VNRevivalLocalizedHeading");var text=child==null?null:child.GetComponent<UnityEngine.UI.Text>();
            if(text==null||image.enabled||text.text!=VNRevivalHeadingConfig.Values[i]||image.sprite.name!=VNRevivalHeadingConfig.Sprites[i]||text.font!=donor.font||text.color!=donor.color*image.color||text.maskable!=image.maskable||text.raycastTarget!=image.raycastTarget)
                throw new System.Exception("Loaded heading binding/style differs "+i);
            if(image.rectTransform.rect.width!=VNRevivalHeadingConfig.Widths[i]||image.rectTransform.rect.height!=VNRevivalHeadingConfig.Heights[i])throw new System.Exception("Loaded heading source dimensions differ");
            var row=new HeadingRow{path=MenuPath(text.transform),text=text.text,sprite=image.sprite.name,font=text.font.name,fontNames=string.Join(",",text.font.fontNames),fontSize=text.fontSize,frame=UnityEngine.Time.frameCount,
                imageEnabled=image.enabled,textEnabled=text.enabled,active=text.gameObject.activeInHierarchy,fontMatchesDonor=text.font==donor.font,maskable=text.maskable,raycastTarget=text.raycastTarget,canvasCulled=text.canvasRenderer.cull,
                authoredAlpha=text.color.a,alpha=text.color.a,width=text.rectTransform.rect.width,height=text.rectTransform.rect.height,preferredWidth=text.preferredWidth,preferredHeight=text.preferredHeight,
                color=new[]{text.color.r,text.color.g,text.color.b,text.color.a},required=headingRequired,material=text.material.name,shader=text.material.shader.name};
            var masks=new System.Collections.Generic.List<UnityEngine.RectTransform>();var maskNames=new System.Collections.Generic.List<string>();
            for(var t=text.transform;t!=null;t=t.parent) {
                foreach(var cg in t.GetComponents<UnityEngine.CanvasGroup>())row.alpha*=cg.alpha;
                var rm=t.GetComponent<UnityEngine.UI.RectMask2D>();var m=t.GetComponent<UnityEngine.UI.Mask>();
                if((rm!=null&&rm.isActiveAndEnabled)||(m!=null&&m.isActiveAndEnabled)){masks.Add((UnityEngine.RectTransform)t);maskNames.Add(MenuPath(t));}
            }
            row.masks=maskNames.ToArray();var gen=text.cachedTextGenerator;row.characters=gen.characterCountVisible;
            var glyphs=new System.Collections.Generic.List<float[]>();var all=new[]{float.PositiveInfinity,float.NegativeInfinity,float.PositiveInfinity,float.NegativeInfinity};
            for(int q=0;q+3<gen.verts.Count&&q/4<text.text.Length;q+=4) {
                float x0=float.PositiveInfinity,x1=float.NegativeInfinity,y0=float.PositiveInfinity,y1=float.NegativeInfinity;
                for(int k=0;k<4;k++){var v=gen.verts[q+k];var p=text.transform.TransformPoint(v.position/text.pixelsPerUnit);var screen=camera.WorldToViewportPoint(p);
                    x0=UnityEngine.Mathf.Min(x0,screen.x);x1=UnityEngine.Mathf.Max(x1,screen.x);y0=UnityEngine.Mathf.Min(y0,screen.y);y1=UnityEngine.Mathf.Max(y1,screen.y);
                }
                if(x1-x0<.000001f||y1-y0<.000001f)continue;
                glyphs.Add(new[]{x0,x1,y0,y1});all[0]=UnityEngine.Mathf.Min(all[0],x0);all[1]=UnityEngine.Mathf.Max(all[1],x1);all[2]=UnityEngine.Mathf.Min(all[2],y0);all[3]=UnityEngine.Mathf.Max(all[3],y1);
                for(int k=0;k<4;k++){var p=text.transform.TransformPoint(gen.verts[q+k].position/text.pixelsPerUnit);var local=text.rectTransform.InverseTransformPoint(p);var rect=text.rectTransform.rect;
                    if(local.x<rect.xMin-.5f||local.x>rect.xMax+.5f||local.y<rect.yMin-.5f||local.y>rect.yMax+.5f)row.outsideRect++;
                    foreach(var mask in masks){var b=QBounds(mask,camera);var s=camera.WorldToViewportPoint(p);if(s.x<b[0]-.5f/UnityEngine.Screen.width||s.x>b[1]+.5f/UnityEngine.Screen.width||s.y<b[2]-.5f/UnityEngine.Screen.height||s.y>b[3]+.5f/UnityEngine.Screen.height)row.outsideMasks++;}
                }
            }
            var flatGlyphs=new System.Collections.Generic.List<float>();foreach(var glyph in glyphs)flatGlyphs.AddRange(glyph);
            row.glyphQuads=glyphs.Count;row.glyphBounds=flatGlyphs.ToArray();row.bounds=glyphs.Count==0?new float[0]:all;
            row.visible=row.active&&row.textEnabled&&row.alpha>=row.authoredAlpha*.99f&&row.authoredAlpha>0&&!row.canvasCulled&&row.glyphQuads==text.text.Length&&row.outsideRect==0&&row.outsideMasks==0&&all[0]>=0&&all[1]<=1&&all[2]>=0&&all[3]<=1;
            if(row.text==headingRequired){if(!row.visible)throw new System.Exception("Required heading lacks complete visible ink "+UnityEngine.JsonUtility.ToJson(row));requiredPassed=true;}
            rows.Add(row);
        }
        var kept=new System.Collections.Generic.List<string>();int inventory=0,dormant=0,pause=0;
        foreach(var line in System.IO.File.ReadAllLines(System.IO.Path.Combine(root,"inventory-heading-expectations.tsv"))) {
            var fields=line.Split('\t');var at=master.transform.Find(fields[0]);var text=at==null?null:at.GetComponent<TMPro.TextMeshProUGUI>();
            if(text==null||Q64(text.text)!=fields[1])throw new System.Exception("Exact marked-up inventory heading changed "+fields[0]);
            inventory++;kept.Add(MenuPath(text.transform)+"|"+text.text+"|enabled="+text.enabled);
        }
        foreach(var image in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.UI.Image>())if(image.gameObject.scene.IsValid()&&image.sprite!=null) {
            if(image.sprite.name=="CritterLog_Label_Inventory"){if(image.enabled)throw new System.Exception("Dormant inventory artwork enabled");dormant++;kept.Add(MenuPath(image.transform)+"|"+image.sprite.name+"|disabled");}
            if(image.sprite.name=="pause_screen_logo"){if(!image.enabled)throw new System.Exception("Pause source image disabled");pause++;kept.Add(MenuPath(image.transform)+"|pause_screen_logo|enabled");}
        }
        var assemblies=new System.Collections.Generic.List<string>();foreach(var a in System.AppDomain.CurrentDomain.GetAssemblies())if(a.GetName().Name.StartsWith("VNRevival"))assemblies.Add(a.FullName+"|"+a.Location);
        var report=new HeadingObservation{frame=UnityEngine.Time.frameCount,width=UnityEngine.Screen.width,height=UnityEngine.Screen.height,page=headingPage,required=headingRequired,questPrepared=questPane!=null,inventoryLayers=inventory,dormantImages=dormant,pauseImages=pause,preserved=kept.ToArray(),fontAssemblies=assemblies.ToArray()};
        // Unity's serializer omits private nested-class arrays. Serialize each
        // complete row explicitly; keep glyph bounds flat (four floats per quad).
        var rowJson=new System.Collections.Generic.List<string>();foreach(var row in rows)rowJson.Add(UnityEngine.JsonUtility.ToJson(row));
        var json=UnityEngine.JsonUtility.ToJson(report,true);json=json.Substring(0,json.LastIndexOf('}'))+",\"headings\":["+string.Join(",",rowJson.ToArray())+"]}";
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,filename),json);
        if(!requiredPassed||inventory!=12||dormant!=2||pause!=1)throw new System.Exception("Heading/preservation workload incomplete "+inventory+" "+dormant+" "+pause);
#else
        throw new System.InvalidOperationException("Notebook heading measurement requires its explicit resource/configuration contract");
#endif
    }
    void LocaleHeadingCapture(string name) {
        if(System.IO.Path.GetFileName(name)!=name||!name.EndsWith(".png")||System.IO.File.Exists(System.IO.Path.Combine(root,name)))throw new System.Exception("Invalid heading capture name");
        StartCoroutine(LocaleHeadingCaptureFrame(name));
    }
    System.Collections.IEnumerator LocaleHeadingCaptureFrame(string name) {
        yield return new UnityEngine.WaitForEndOfFrame();
        LocaleHeadingMeasure(name+".heading.json");
        UnityEngine.ScreenCapture.CaptureScreenshot(System.IO.Path.Combine(root,name));
    }
    void LocaleHeadingRestore() {
        if(headingMaster==null)return;
        if(headingMaster.visible)HeadingToggle(headingPage=="residents"?"CritterLog":"QuestLog");
        QuestRestore();headingMaster.enabled=headingMasterEnabled;
        if(headingQuestEnabled&&questLog!=null)questLog.enabled=true;
        if(headingBackground!=null)headingBackground.gameObject.SetActive(true);
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"heading-restored.txt"),"Original log visibility, managed fixture status records, component enablement and background canvas restored; no saves or heading resource writes.");
    }
}
