// Isolated readback and actual notification display calls. Never award or remove items.
public sealed partial class ForestProbe {
    TheForestOfLove.OverworldAllInOneNotificationItem itemStaged;
    void ItemsGeometry(string action) {
        if(itemStaged==null)throw new System.Exception("No staged notification");
        UnityEngine.Canvas.ForceUpdateCanvases();
        var report=new System.Text.StringBuilder();
        var flags=System.Reflection.BindingFlags.NonPublic|System.Reflection.BindingFlags.Instance;
        var animator=(UnityEngine.Animator)itemStaged.GetType().GetField("animator",flags).GetValue(itemStaged);
        var state=animator.GetCurrentAnimatorStateInfo(0);
        report.Append("animator|").Append(state.normalizedTime).Append("|transition=").Append(animator.IsInTransition(0));
        foreach(var clip in animator.GetCurrentAnimatorClipInfo(0))report.Append("|").Append(clip.clip.name).Append(":").Append(clip.clip.length);
        report.Append('\n');
        foreach(var text in itemStaged.GetComponentsInChildren<TMPro.TextMeshProUGUI>()) {
            if(text.color.r<.9f || text.color.a<.9f)continue;
            text.ForceMeshUpdate();
            foreach(var camera in UnityEngine.Camera.allCameras) {
                if(!camera.enabled || !camera.gameObject.activeInHierarchy || (camera.cullingMask & (1<<text.gameObject.layer))==0)continue;
                float minX=float.PositiveInfinity,maxX=float.NegativeInfinity,minY=float.PositiveInfinity,maxY=float.NegativeInfinity;
                for(int i=0;i<text.textInfo.characterCount;i++) {
                    var c=text.textInfo.characterInfo[i];if(!c.isVisible)continue;
                    foreach(var point in new[]{c.bottomLeft,c.topRight}) {
                        var p=camera.WorldToViewportPoint(text.transform.TransformPoint(point));
                        minX=UnityEngine.Mathf.Min(minX,p.x);maxX=UnityEngine.Mathf.Max(maxX,p.x);minY=UnityEngine.Mathf.Min(minY,p.y);maxY=UnityEngine.Mathf.Max(maxY,p.y);
                    }
                }
                report.Append("camera|").Append(camera.name).Append("|depth=").Append(camera.depth).Append("|viewport=").Append(minX).Append(',').Append(maxX).Append(',').Append(minY).Append(',').Append(maxY).Append("|alignment=").Append(text.alignment).Append("|width=").Append(text.rectTransform.rect.width).Append('\n');
            }
            for(UnityEngine.Transform t=text.transform;t!=null;t=t.parent) {
                report.Append("parent|").Append(t.name).Append("|world=").Append(t.position).Append("|local=").Append(t.localPosition);
                var rect=t as UnityEngine.RectTransform;if(rect!=null)report.Append("|rect=").Append(rect.rect).Append("|pivot=").Append(rect.pivot).Append("|anchored=").Append(rect.anchoredPosition);
                report.Append('\n');
            }
        }
        System.IO.File.AppendAllText(System.IO.Path.Combine(root,"geometry-"+action+".txt"),report.ToString()+"END\n");
    }

    void ItemsReady() {
        var flags=System.Reflection.BindingFlags.NonPublic|System.Reflection.BindingFlags.Instance|System.Reflection.BindingFlags.Static;
        var type=typeof(TheForestOfLove.Services.Persistence.DataService);
        var instance=type.GetField("_instance",flags).GetValue(null);
        var manifest=instance==null?null:type.GetField("_manifest",flags).GetValue(instance);
        var count=manifest==null?0:((System.Collections.ICollection)manifest.GetType().GetField("inventoryItems").GetValue(manifest)).Count;
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"items-ready.txt"),count.ToString());
    }
    void ItemsReadback() {
        var lines=System.IO.File.ReadAllLines(System.IO.Path.Combine(root,"item-expectations.tsv"));
        if(lines.Length!=48)throw new System.Exception("Incomplete item workload");
        var output=new System.Text.StringBuilder();
        foreach(var line in lines) {
            var fields=line.Split('\t');if(fields.Length!=3)throw new System.Exception("Malformed item expectation");
            int itemType=int.Parse(fields[0]);
            var item=TheForestOfLove.Services.Persistence.DataService.GetInventoryItemByItemType((TheForestOfLove.Inventory.InventoryItemType)itemType);
            if(item==null)throw new System.Exception("Runtime item missing: "+itemType);
            string title=System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(item.title));
            string phrase=System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(item.notificationPhrase));
            if(title!=fields[1] || phrase!=fields[2])throw new System.Exception("Runtime item mismatch: "+itemType);
            output.Append(itemType).Append('\t').Append(title).Append('\t').Append(phrase).Append('\n');
        }
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"item-readback.tsv"),output.ToString());
    }
    void ItemsDisplay(string action) {
        var flags=System.Reflection.BindingFlags.Public|System.Reflection.BindingFlags.NonPublic|System.Reflection.BindingFlags.Instance;
        TheForestOfLove.OverworldAllInOneNotification controller=null;
        foreach(var c in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.OverworldAllInOneNotification>())
            if(c.gameObject.scene.IsValid()) {if(controller!=null)throw new System.Exception("Ambiguous notification controller");controller=c;}
        if(controller==null)throw new System.Exception("Notification controller absent");
        var prefab=(TheForestOfLove.OverworldAllInOneNotificationItem)controller.GetType().GetField(action=="glitch"?"glitchNotificationItemPrefab":"notificationItemPrefab",flags).GetValue(controller);
        var container=(UnityEngine.Transform)controller.GetType().GetField("messageContainer",flags).GetValue(controller);
        foreach(UnityEngine.Transform child in container)UnityEngine.Object.Destroy(child.gameObject);
        var notification=UnityEngine.Object.Instantiate(prefab,container);itemStaged=notification;
        int itemType=action=="received"?190:30;
        var item=TheForestOfLove.Services.Persistence.DataService.GetInventoryItemByItemType((TheForestOfLove.Inventory.InventoryItemType)itemType);
        if(action=="glitch") { /* Original branch1 displays the serialized prefab text directly. */ }
        else if(action=="received")notification.ConfigureItemGetNotification(item.sprite,item.title);
        else if(action=="found")notification.ConfigureItemFoundNotification(item.sprite,item.title);
        else if(action=="delivered")notification.ConfigureItemLostNotification(item.sprite,item.title);
        else throw new System.Exception("Unsupported notification action");
        notification.FadeIn();
        UnityEngine.Canvas.ForceUpdateCanvases();
        var report=new System.Text.StringBuilder();int visible=0;
        foreach(var text in notification.GetComponentsInChildren<TMPro.TextMeshProUGUI>()) {
            text.ForceMeshUpdate();
            if(text.enabled && text.gameObject.activeInHierarchy && text.color.a>0)visible++;
            report.Append(text.text).Append(" | font=").Append(text.font.name).Append(" | overflow=").Append(text.isTextOverflowing).Append(" | lines=").Append(text.textInfo.lineCount).Append(" | width=").Append(text.rectTransform.rect.width).Append('\n');
            if(text.text.Contains("Item ") || text.text.Contains("Bottle of Lube") || text.text.Contains("Get Well Card"))throw new System.Exception("Source item wording remains");
        }
        if(visible==0)throw new System.Exception("Notification has no active text");
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"notification-"+action+".txt"),report.ToString());
    }
}
