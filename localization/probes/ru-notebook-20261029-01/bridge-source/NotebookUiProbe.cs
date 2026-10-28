// Disposable notebook staging; no item award, translated text injection or save flags.
public sealed partial class ForestProbe {
    TheForestOfLove.PagedTutorial notebookStaged;
    bool notebookLoadRequested;
    void NotebookEnsure() {
        int count=0;foreach(var owner in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.ItemGetNotification>())if(owner!=null)count++;
        if(!TheForestOfLove.Services.SceneManagement.SceneHelper.inGameplayScene && !notebookLoadRequested && UnityEngine.SceneManagement.SceneManager.GetActiveScene().name=="StartMenu") {
            TheForestOfLove.PlayMenu play=null;
            foreach(var p in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.PlayMenu>())if(p.gameObject.scene.IsValid()){if(play!=null)throw new System.Exception("Ambiguous play menu");play=p;}
            if(play==null)throw new System.Exception("No menu path to required UI resource");
            notebookLoadRequested=true;play.OnClickContinue();
        }
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"notebook-ready.txt"),count+"|"+UnityEngine.SceneManagement.SceneManager.GetActiveScene().name+"|gameplay="+TheForestOfLove.Services.SceneManagement.SceneHelper.inGameplayScene+"|loadRequested="+notebookLoadRequested);
    }
    void NotebookOpen() {
        // QA-only isolation: suspend the fixture's unrelated active dialogue canvas.
        // Do not advance dialogue, award an item or change serialized game resources.
        var background=new System.Text.StringBuilder();int hidden=0;
        foreach(var canvas in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.Canvas>()) {
            if(!canvas.gameObject.scene.IsValid() || !canvas.gameObject.activeInHierarchy || canvas.name!="OverworldDialogueCanvas")continue;
            if(MenuPath(canvas.transform)!="Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas")throw new System.Exception("Unexpected background dialogue owner");
            background.Append(MenuPath(canvas.transform)).Append('\n');
            foreach(var text in canvas.GetComponentsInChildren<TMPro.TextMeshProUGUI>(true))background.Append(MenuPath(text.transform)).Append('\t').Append(System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(text.text))).Append('\n');
            canvas.gameObject.SetActive(false);hidden++;
        }
        if(hidden!=1)throw new System.Exception("Expected exactly one fixture dialogue canvas");
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"notebook-background-staging.tsv"),background.ToString());
        var flags=System.Reflection.BindingFlags.Public|System.Reflection.BindingFlags.NonPublic|System.Reflection.BindingFlags.Instance;
        TheForestOfLove.ItemGetNotification owner=null,prefabOwner=null;
        foreach(var o in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.ItemGetNotification>()) {
            if(o.gameObject.scene.IsValid() && o.gameObject.activeInHierarchy) {if(owner!=null)throw new System.Exception("Ambiguous live popup owner");owner=o;}
            else if(!o.gameObject.scene.IsValid()) {if(prefabOwner!=null)throw new System.Exception("Ambiguous popup prefab owner");prefabOwner=o;}
        }
        if(owner==null && prefabOwner!=null)owner=UnityEngine.Object.Instantiate(prefabOwner.gameObject).GetComponent<TheForestOfLove.ItemGetNotification>();
        if(owner==null)throw new System.Exception("Notebook popup owner absent");
        var prefab=(TheForestOfLove.PagedTutorial)owner.GetType().GetField("gossipTutorialPrefab",flags).GetValue(owner);
        if(prefab==null || !prefab.gameObject.name.StartsWith("GossipTutorialRedux"))throw new System.Exception("Wrong notebook prefab");
        notebookStaged=owner.ShowPagedTutorial(prefab);
        if(notebookStaged==null)throw new System.Exception("Popup owner is already busy");
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"notebook-opened.txt"),notebookStaged.name+"|"+owner.name);
    }
    void NotebookPage(int page) {
        if(notebookStaged==null || page<0 || page>=notebookStaged.pages.Length)throw new System.Exception("Invalid notebook page");
        var flags=System.Reflection.BindingFlags.Public|System.Reflection.BindingFlags.NonPublic|System.Reflection.BindingFlags.Instance;
        notebookStaged.GetType().GetField("currentPage",flags).SetValue(notebookStaged,page);
        notebookStaged.GetType().GetMethod("UpdatePageVisibility",flags).Invoke(notebookStaged,null);
        UnityEngine.Canvas.ForceUpdateCanvases();
    }
    void NotebookGeometry() {
        if(notebookStaged==null)throw new System.Exception("Notebook not open");
        var report=new System.Text.StringBuilder("path\ttext64\talpha\tlines\toverflow\tminX\tmaxX\tminY\tmaxY\tminLineGap\n");
        var targets=new System.Text.StringBuilder();var status=new System.Text.StringBuilder("root="+notebookStaged.name+" active="+notebookStaged.gameObject.activeInHierarchy+"\n");
        UnityEngine.Camera camera=null;
        foreach(var c in UnityEngine.Camera.allCameras)if(c.name=="UI Camera" && c.enabled && c.gameObject.activeInHierarchy){if(camera!=null)throw new System.Exception("Ambiguous UI Camera");camera=c;}
        if(camera==null)throw new System.Exception("UI Camera absent");
        UnityEngine.Canvas.ForceUpdateCanvases();
        foreach(var text in notebookStaged.GetComponentsInChildren<TMPro.TextMeshProUGUI>(true)) {
            var path=MenuPath(text.transform);var relative=path.Substring(path.IndexOf("GossipTutorialRedux"));relative=relative.Replace("GossipTutorialRedux(Clone)","GossipTutorialRedux");
            targets.Append(relative).Append('\t').Append(System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(text.text))).Append('\n');
            float alpha=text.color.a;
            for(var t=text.transform;t!=null;t=t.parent)foreach(var group in t.GetComponents<UnityEngine.CanvasGroup>())alpha*=group.alpha;
            if(text.color.r>.8f && relative.Contains("/Title/") && relative.EndsWith("/Name"))status.Append(relative).Append(" active=").Append(text.gameObject.activeInHierarchy).Append(" alpha=").Append(alpha).Append(" enabled=").Append(text.enabled).Append('\n');
            if(!text.enabled || !text.gameObject.activeInHierarchy || alpha<.8f || text.color.r<.8f)continue;
            text.ForceMeshUpdate();
            float minX=float.PositiveInfinity,maxX=float.NegativeInfinity,minY=float.PositiveInfinity,maxY=float.NegativeInfinity,gap=float.PositiveInfinity;
            var bottoms=new System.Collections.Generic.Dictionary<int,float>();var tops=new System.Collections.Generic.Dictionary<int,float>();
            for(int i=0;i<text.textInfo.characterCount;i++) {
                var ch=text.textInfo.characterInfo[i];if(!ch.isVisible)continue;
                foreach(var point in new[]{ch.bottomLeft,ch.topRight}) {
                    var v=camera.WorldToViewportPoint(text.transform.TransformPoint(point));
                    minX=UnityEngine.Mathf.Min(minX,v.x);maxX=UnityEngine.Mathf.Max(maxX,v.x);minY=UnityEngine.Mathf.Min(minY,v.y);maxY=UnityEngine.Mathf.Max(maxY,v.y);
                    if(!bottoms.ContainsKey(ch.lineNumber)){bottoms[ch.lineNumber]=v.y;tops[ch.lineNumber]=v.y;}
                    bottoms[ch.lineNumber]=UnityEngine.Mathf.Min(bottoms[ch.lineNumber],v.y);tops[ch.lineNumber]=UnityEngine.Mathf.Max(tops[ch.lineNumber],v.y);
                }
            }
            for(int i=1;i<text.textInfo.lineCount;i++)if(bottoms.ContainsKey(i-1)&&tops.ContainsKey(i))gap=UnityEngine.Mathf.Min(gap,bottoms[i-1]-tops[i]);
            report.Append(relative).Append('\t').Append(System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(text.GetParsedText()))).Append('\t').Append(alpha).Append('\t').Append(text.textInfo.lineCount).Append('\t').Append(text.isTextOverflowing).Append('\t').Append(minX).Append('\t').Append(maxX).Append('\t').Append(minY).Append('\t').Append(maxY).Append('\t').Append(gap).Append('\n');
        }
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"notebook-status.txt"),status.ToString());
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"notebook-geometry.tsv"),report.ToString());
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"notebook-runtime-texts.tsv"),targets.ToString());
    }
}
