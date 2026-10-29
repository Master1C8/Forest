// Exactly 28 wrapped chapter names and 28 original selected-role tooltips.
// No BaseSpawner, chapter selection callback, movie, award or eligibility mutation.
public sealed partial class ForestProbe {
    UnityEngine.Component ccFactory,ccCreated;
    UnityEngine.Behaviour ccPaused;
    bool ccEnabled,ccDescriptionWasLocked;
    System.Reflection.PropertyInfo ccDescriptionLock;
    UnityEngine.UI.VerticalLayoutGroup ccDescriptionLayout;float ccDescriptionSpacing;
    float ccFactoryTime;
    UnityEngine.GameObject ccSelected;
    readonly System.Collections.Generic.Dictionary<System.Reflection.FieldInfo,object> ccFields=new System.Collections.Generic.Dictionary<System.Reflection.FieldInfo,object>();
    readonly System.Collections.Generic.Dictionary<UnityEngine.CanvasGroup,float[]> ccGroups=new System.Collections.Generic.Dictionary<UnityEngine.CanvasGroup,float[]>();
    readonly System.Collections.Generic.Dictionary<UnityEngine.Animator,string> ccAnimators=new System.Collections.Generic.Dictionary<UnityEngine.Animator,string>();
    readonly System.Collections.Generic.Dictionary<UnityEngine.Animator,System.Collections.Generic.Dictionary<string,object>> ccParameters=new System.Collections.Generic.Dictionary<UnityEngine.Animator,System.Collections.Generic.Dictionary<string,object>>();
    readonly System.Collections.Generic.Dictionary<UnityEngine.GameObject,bool> ccActives=new System.Collections.Generic.Dictionary<UnityEngine.GameObject,bool>();
    readonly System.Collections.Generic.Dictionary<string,object> ccEvents=new System.Collections.Generic.Dictionary<string,object>();
    string ccBeforeValues;
    int ccDestroyedId;
    void CCRequire(bool condition,string reason){if(!condition)throw new System.Exception(reason);}
    // The original prefab is instantiated under the scene's LevelSingletons
    // wrapper. Accept that one observed envelope, never arbitrary clone/name
    // stripping or a basename match. Duplicate candidates still fail CCExact.
    static bool CCSourcePathMatches(string actual,string source){
        if(actual==source)return true;
        const string prefix="LevelSingletons/";
        return source.StartsWith(prefix,System.StringComparison.Ordinal)&&
            actual==prefix+"LevelSingletons(Clone)/"+source.Substring(prefix.Length);
    }
    UnityEngine.Component CCExact(string type,string path,bool scene){
        UnityEngine.Component found=null;
        foreach(var c in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.MonoBehaviour>())
            if(c!=null&&c.GetType().FullName=="TheForestOfLove."+type&&(!scene||c.gameObject.scene.IsValid())&&CCSourcePathMatches(CGPath(c.transform),path)){CCRequire(found==null,"ambiguous-source-bound-"+type);found=c;}
        CCRequire(found!=null,"source-route-unavailable-"+type+"-"+path);return found;
    }
    void CCEmptyEvent(string name){
        var field=typeof(TheForestOfLove.Events.GameEvents).GetField(name,cgFlags);CCRequire(field!=null,"event-field-missing");
        var value=field.GetValue(null) as UnityEngine.Events.UnityEventBase;CCRequire(value!=null&&value.GetPersistentEventCount()==0,"factory-global-persistent-subscribers-unproved-"+name);
        var calls=typeof(UnityEngine.Events.UnityEventBase).GetField("m_Calls",cgFlags).GetValue(value);
        CCRequire(calls!=null,"event-call-list-unresolved");
        foreach(var member in new[]{"m_RuntimeCalls","m_PersistentCalls"}){
            var f=calls.GetType().GetField(member,cgFlags);CCRequire(f!=null,"event-call-list-schema-unresolved");
            var list=f.GetValue(calls) as System.Collections.ICollection;CCRequire(list!=null&&list.Count==0,"factory-global-runtime-subscribers-unproved-"+name);
        }
        ccEvents[name]=value;
    }
    void CCAssertEvents(){foreach(var pair in ccEvents)CCRequire(object.ReferenceEquals(typeof(TheForestOfLove.Events.GameEvents).GetField(pair.Key,cgFlags).GetValue(null),pair.Value),"live-global-event-replaced");}
    void CCSaveFactory(UnityEngine.Component factory){
        ccFactory=factory;ccSelected=UnityEngine.EventSystems.EventSystem.current==null?null:UnityEngine.EventSystems.EventSystem.current.currentSelectedGameObject;
        // Only fields the exact factory/notification-start body writes; no maps or
        // progression callbacks are patched. Cached sound delegate is restored too.
        foreach(var name in new[]{"<visible>k__BackingField","currentOpenTime"}){var f=factory.GetType().GetField(name,cgFlags);CCRequire(f!=null,"factory-state-schema-"+name);ccFields[f]=f.GetValue(f.IsStatic?null:factory);}
        var nested=factory.GetType().GetNestedType("<>c",cgFlags);CCRequire(nested!=null,"factory-closure-schema");
        var cached=nested.GetField("<>9__82_0",cgFlags);CCRequire(cached!=null,"factory-sound-cache-schema");ccFields[cached]=cached.GetValue(null);
        foreach(var group in factory.GetComponentsInChildren<UnityEngine.CanvasGroup>(true))ccGroups[group]=new[]{group.alpha,group.interactable?1f:0f,group.blocksRaycasts?1f:0f};
        foreach(var tr in factory.GetComponentsInChildren<UnityEngine.Transform>(true))ccActives[tr.gameObject]=tr.gameObject.activeSelf;
        foreach(var animator in factory.GetComponentsInChildren<UnityEngine.Animator>(true)){
            // Trigger state cannot be restored exactly. Restrict to an idle
            // notification with no pending triggers; reject unknown parameter types.
            foreach(var p in animator.parameters)CCRequire(p.type!=UnityEngine.AnimatorControllerParameterType.Trigger||!animator.GetBool(p.name),"factory-pending-animator-trigger");
            var parameters=new System.Collections.Generic.Dictionary<string,object>();foreach(var p in animator.parameters){if(p.type==UnityEngine.AnimatorControllerParameterType.Bool)parameters[p.name]=animator.GetBool(p.name);else if(p.type==UnityEngine.AnimatorControllerParameterType.Int)parameters[p.name]=animator.GetInteger(p.name);else if(p.type==UnityEngine.AnimatorControllerParameterType.Float)parameters[p.name]=animator.GetFloat(p.name);}ccParameters[animator]=parameters;
            var parts=new System.Collections.Generic.List<string>();parts.Add(animator.enabled?"1":"0");
            for(int layer=0;layer<animator.layerCount;layer++){CCRequire(!animator.IsInTransition(layer),"factory-animator-transition-active");var state=animator.GetCurrentAnimatorStateInfo(layer);parts.Add(layer+"|"+state.fullPathHash+"|"+state.normalizedTime.ToString("R",System.Globalization.CultureInfo.InvariantCulture));}
            ccAnimators[animator]=string.Join(";",parts.ToArray());
        }
    }
    void CCFactory(){
        var factory=CCExact("ItemGetNotification","LevelSingletons/Item Get Notification",true);
        var visible=factory.GetType().GetProperty("visible",cgFlags);CCRequire(visible!=null&&!(bool)visible.GetValue(factory,null),"original-notification-busy");
        var prefab=CGField(factory,"outOfSyncContentPrefab") as UnityEngine.Component;CCRequire(prefab!=null&&CGPath(prefab.transform)=="OutOfSyncContentNotification","wrong-source-oos-prefab");
        foreach(var name in new[]{"onClickYes","onClickNo","onMadeSelection"}){
            var ev=CGField(prefab,name) as UnityEngine.Events.UnityEventBase;CCRequire(ev!=null&&ev.GetPersistentEventCount()==0,"source-oos-persistent-callbacks");
        }
        CCRequire(!(bool)CGField(factory,"showingInventoryItemNotification"),"other-inventory-notification-active");
        CCRequire(((System.Collections.ICollection)CGField(factory,"itemGetNotifications")).Count==0,"pending-item-notification-queue");
        CCEmptyEvent("onShowItemGetAchievement");CCEmptyEvent("onShowItemGetAchievementOverloadedForAdventures");
        CCSaveFactory(factory);
        var parent=CGField(factory,"messageContainer") as UnityEngine.Transform;CCRequire(parent!=null,"message-container-missing");
        var before=new System.Collections.Generic.HashSet<int>();foreach(var child in parent.GetComponentsInChildren<UnityEngine.Transform>(true))before.Add(child.GetInstanceID());
        ccFactoryTime=UnityEngine.Time.realtimeSinceStartup;
        try{factory.GetType().GetMethod("ShowOutOfSyncContentNotification",cgFlags).Invoke(factory,new object[]{string.Format("''{0}''",CGDecode(System.IO.File.ReadAllLines(System.IO.Path.Combine(root,"cg-cases.tsv"))[0].Split('\t')[5])),null,null});}
        finally{foreach(var component in parent.GetComponentsInChildren<UnityEngine.MonoBehaviour>(true))if(component.GetType().FullName=="TheForestOfLove.OutOfSyncContentNotification"&&!before.Contains(component.transform.GetInstanceID())){CCRequire(ccCreated==null,"multiple-created-oos");ccCreated=component;}}
        // The source factory has scheduled only sound500/navigation/hide closure;
        // no onMadeSelection event or yes/no progression callback is invoked.
        CCRequire(ccCreated!=null,"factory-created-no-oos");
        CCAssertEvents();
    }
    void CCReady(string surface){
        CCRequire(cgConsumer==null&&ccPaused==null,"restore-current-surface-first");
        CCRequire(surface=="oos"||surface=="description","only-two-completion-surfaces");
        CGReadback();ccBeforeValues=System.IO.File.ReadAllText(System.IO.Path.Combine(root,"cg-readback.tsv"));
        UnityEngine.Component consumer;
        if(surface=="oos"){
            CCFactory();consumer=ccCreated;
        }else{
            // This selected tooltip role is source component17041 -> GO2084.
            // ShowUi/Show emit global events; do not synthesize a visible route.
            consumer=CCExact("ChapterSelectUI","LevelSingletons/ChapterSelectUI/ChapterSelectUI",true);
            CCRequire(consumer.gameObject.activeInHierarchy,"description-original-panel-inactive-route-required");
            CCRequire((bool)consumer.GetType().GetProperty("visible",cgFlags).GetValue(null,null),"description-original-show-route-required");
        }
        var basis=CGField(consumer,surface=="oos"?"chapterNameLabelRoot":"tooltipContainer") as UnityEngine.GameObject;
        CCRequire(basis!=null&&basis.activeInHierarchy,"original-text-root-inactive");
        var labels=basis.GetComponentsInChildren<TMPro.TMP_Text>();CCRequire(labels.Length==6,"source-six-label-membership");int providers=0,faces=0;
        foreach(var label in labels){
            var suffix=CGPath(label.transform).Replace("(Clone)","");bool matches=false;
            foreach(var line in System.IO.File.ReadAllLines(System.IO.Path.Combine(root,"cc-selectors.tsv"))){var f=line.Split('\t');if(f[0]==surface&&suffix.EndsWith(f[1],System.StringComparison.Ordinal)&&label.color.a==float.Parse(f[2],System.Globalization.CultureInfo.InvariantCulture))matches=true;}
            CCRequire(matches&&label.enabled&&label.font!=null,"native-selector-alpha-or-font-differs");if(label.color.a==0)providers++;else {faces++;float alpha=label.canvasRenderer.GetAlpha();for(var tr=label.transform;tr!=null;tr=tr.parent)foreach(var group in tr.GetComponents<UnityEngine.CanvasGroup>())alpha*=group.alpha;CCRequire(alpha>=.99f,"source-visible-face-hidden-establish-original-route");}
        }
        CCRequire(providers==1&&faces==5,"one-height-provider-five-faces-required");
        ccPaused=consumer as UnityEngine.Behaviour;CCRequire(ccPaused!=null,"consumer-not-behaviour");ccEnabled=ccPaused.enabled;
        // Never disable a BaseBehavior to pause input: OnDisable unregisters
        // ChapterSelectUI and would mutate the live service map. Its existing
        // LockInteractions guard returns before input, autosave and DoChapterSelect.
        if(surface=="description"){
            ccDescriptionLock=consumer.GetType().GetProperty("LockInteractions",cgFlags);CCRequire(ccDescriptionLock!=null,"description-lock-schema");
            ccDescriptionWasLocked=(bool)ccDescriptionLock.GetValue(consumer,null);ccDescriptionLock.SetValue(consumer,true,null);
            ccDescriptionLayout=(UnityEngine.UI.VerticalLayoutGroup)CGField(consumer,"visibleContentContainerVerticalLayoutGroup");ccDescriptionSpacing=ccDescriptionLayout.spacing;
        }
        cgConsumer=consumer;cgLabels=labels;cgSurface=surface;foreach(var t in labels)cgSaved.Add(t,t.text);
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"cc-ready.txt"),surface+"|"+CGPath(basis.transform)+"|6|source-selected-role;no-progression-callbacks");
    }
    void CCRestore(){
        if(ccFactory!=null)CCRequire(UnityEngine.Time.realtimeSinceStartup-ccFactoryTime>=3.5f,"wait-original-factory-timers-before-restoration");
        if(ccDescriptionLock!=null){ccDescriptionLock.SetValue(ccPaused,ccDescriptionWasLocked,null);CCRequire((bool)ccDescriptionLock.GetValue(ccPaused,null)==ccDescriptionWasLocked,"description-lock-not-restored");ccDescriptionLock=null;ccDescriptionLayout.spacing=ccDescriptionSpacing;ccDescriptionLayout=null;}
        CGRestore();if(ccPaused!=null)CCRequire(ccPaused.enabled==ccEnabled,"consumer-enabled-state-changed");ccPaused=null;
        if(ccCreated!=null){ccDestroyedId=ccCreated.GetInstanceID();UnityEngine.Object.Destroy(ccCreated.gameObject);ccCreated=null;}
        foreach(var pair in ccActives)if(pair.Key!=null)pair.Key.SetActive(pair.Value);
        foreach(var pair in ccGroups)if(pair.Key!=null){pair.Key.alpha=pair.Value[0];pair.Key.interactable=pair.Value[1]!=0;pair.Key.blocksRaycasts=pair.Value[2]!=0;}
        foreach(var pair in ccAnimators)if(pair.Key!=null){var rows=pair.Value.Split(';');foreach(var p in pair.Key.parameters)if(p.type==UnityEngine.AnimatorControllerParameterType.Trigger)pair.Key.ResetTrigger(p.name);for(int i=1;i<rows.Length;i++){var f=rows[i].Split('|');pair.Key.Play(int.Parse(f[1]),int.Parse(f[0]),float.Parse(f[2],System.Globalization.CultureInfo.InvariantCulture));}foreach(var p in ccParameters[pair.Key]){if(p.Value is bool)pair.Key.SetBool(p.Key,(bool)p.Value);else if(p.Value is int)pair.Key.SetInteger(p.Key,(int)p.Value);else pair.Key.SetFloat(p.Key,(float)p.Value);}pair.Key.Update(0);pair.Key.enabled=rows[0]=="1";}
        foreach(var pair in ccFields)pair.Key.SetValue(pair.Key.IsStatic?null:ccFactory,pair.Value);
        foreach(var pair in ccFields)CCRequire(object.Equals(pair.Key.GetValue(pair.Key.IsStatic?null:ccFactory),pair.Value),"factory-field-restoration-failed");
        CCAssertEvents();if(ccFactory!=null&&UnityEngine.EventSystems.EventSystem.current!=null)UnityEngine.EventSystems.EventSystem.current.SetSelectedGameObject(ccSelected);
        CGReadback();CCRequire(System.IO.File.ReadAllText(System.IO.Path.Combine(root,"cg-readback.tsv"))==ccBeforeValues,"source-db-or-cache-mutated");
        ccFields.Clear();ccGroups.Clear();ccAnimators.Clear();ccParameters.Clear();ccActives.Clear();ccEvents.Clear();ccFactory=null;
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"cc-restored.txt"),"source-text;DB-cache;factory-fields;event-identities;selection;UI-state-restored;created-destruction-pending");
    }
    [System.Runtime.InteropServices.StructLayout(System.Runtime.InteropServices.LayoutKind.Sequential)] struct CCRect { public int left,top,right,bottom; }
    delegate bool CCWindowCallback(System.IntPtr handle,System.IntPtr state);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern bool EnumWindows(CCWindowCallback callback,System.IntPtr state);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern uint GetWindowThreadProcessId(System.IntPtr handle,out uint pid);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern bool IsWindowVisible(System.IntPtr handle);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern bool GetClientRect(System.IntPtr handle,out CCRect rect);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern bool GetWindowRect(System.IntPtr handle,out CCRect rect);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern int GetSystemMetrics(int metric);
    [System.Runtime.InteropServices.DllImport("user32.dll")] static extern uint GetDpiForWindow(System.IntPtr handle);
    [System.Serializable] public sealed class CCNativeDisplay {
        public int viewportWidth,viewportHeight,unityDisplayWidth,unityDisplayHeight,clientWidth,clientHeight,windowWidth,windowHeight,systemWidth,systemHeight;
        public uint processId,windowProcessId,dpi;public string windowHandle;public bool fullscreen;
    }
    void CCDisplay(){
        var pid=GetCurrentProcessId();var found=System.IntPtr.Zero;uint windowPid=0;
        CCWindowCallback callback=delegate(System.IntPtr handle,System.IntPtr state){uint owner;GetWindowThreadProcessId(handle,out owner);CCRect rect;if(owner==pid&&IsWindowVisible(handle)&&GetClientRect(handle,out rect)&&rect.right>rect.left&&rect.bottom>rect.top){CCRequire(found==System.IntPtr.Zero,"ambiguous-owned-native-client");found=handle;windowPid=owner;}return true;};
        CCRequire(EnumWindows(callback,System.IntPtr.Zero)&&found!=System.IntPtr.Zero,"owned-native-window-unavailable");
        CCRect client=new CCRect(),window=new CCRect();CCRequire(GetClientRect(found,out client)&&GetWindowRect(found,out window),"native-window-rect-unavailable");var mode=UnityEngine.Screen.currentResolution;
        var result=new CCNativeDisplay{processId=pid,windowProcessId=windowPid,windowHandle=found.ToInt64().ToString(),viewportWidth=UnityEngine.Screen.width,viewportHeight=UnityEngine.Screen.height,unityDisplayWidth=mode.width,unityDisplayHeight=mode.height,fullscreen=UnityEngine.Screen.fullScreen,clientWidth=client.right-client.left,clientHeight=client.bottom-client.top,windowWidth=window.right-window.left,windowHeight=window.bottom-window.top,systemWidth=GetSystemMetrics(0),systemHeight=GetSystemMetrics(1),dpi=GetDpiForWindow(found)};
        CCRequire(result.clientWidth>0&&result.clientHeight>0&&result.systemWidth>0&&result.systemHeight>0&&result.dpi>0,"incomplete-native-display-diagnostics");
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"cc-display.json"),UnityEngine.JsonUtility.ToJson(result));
    }
    UnityEngine.Component CCDescriptionPause(){
        CCRequire(cgConsumer==null&&ccFactory==null,"restore-current-surface-first");
        CCRequire(!PixelCrushers.DialogueSystem.DialogueManager.isConversationActive,"description-route-dialogue-active");
        var manager=CCExact("PauseScreenUIManager","LevelSingletons/PauseScreenUI",true);
        var panel=CGField(manager,"pauseScreenUi") as UnityEngine.Component;
        CCRequire(panel!=null&&panel.GetType().FullName=="TheForestOfLove.PauseScreenUiController"&&panel.gameObject.scene.IsValid(),"original-pause-panel-reference-unavailable");
        var player=TheForestOfLove.Player.current;
        if(player!=null){
            var property=player.GetType().GetProperty("waypointController",cgFlags);
            CCRequire(property!=null,"original-waypoint-property-unavailable");
            var waypoints=property.GetValue(player,null);
            if(waypoints!=null){
                var has=waypoints.GetType().GetProperty("HasWaypoints",cgFlags);
                CCRequire(has!=null&&!(bool)has.GetValue(waypoints,null),"original-description-route-waypoints-busy");
            }
        }
        return manager;
    }
    void CCDescriptionOpen(){
        var manager=CCDescriptionPause();var panel=(UnityEngine.Component)CGField(manager,"pauseScreenUi");
        var open=panel.GetType().GetProperty("isOpen",cgFlags);
        CCRequire(open!=null&&!(bool)open.GetValue(panel,null),"original-pause-panel-already-open");
        // OnPause is an event subscriber, not the original pause entry point.
        // Calling it alone leaves isPaused=false, so OnResume cannot close the
        // outer panel and its Pause heading contaminates the chapter fixture.
        CCRequire(!TheForestOfLove.PauseHelper.isPaused,"original-game-already-paused");
        TheForestOfLove.PauseHelper.Pause();
        CCRequire(TheForestOfLove.PauseHelper.isPaused,"original-pause-entry-did-not-pause");
        CCRequire((bool)open.GetValue(panel,null),"original-pause-open-did-not-open");
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"cc-description-open.txt"),CGPath(panel.transform)+"|original-PauseScreenUIManager.OnPause->UIPanelController.Open");
    }
    void CCDescriptionSelect(){
        var manager=CCDescriptionPause();var panel=(UnityEngine.Component)CGField(manager,"pauseScreenUi");
        var open=panel.GetType().GetProperty("isOpen",cgFlags);
        CCRequire(open!=null&&(bool)open.GetValue(panel,null)&&panel.gameObject.activeInHierarchy,"original-pause-panel-not-open");
        var menu=CGField(panel,"mainMenu") as UnityEngine.Component;
        CCRequire(menu!=null&&menu.GetType().FullName=="TheForestOfLove.PauseScreenMainMenu"&&menu.gameObject.activeInHierarchy,"original-pause-main-menu-unavailable");
        menu.GetType().GetMethod("OnClickChapterSelect",cgFlags).Invoke(menu,null);
        CCRequire(!TheForestOfLove.PauseHelper.isPaused&&!(bool)open.GetValue(panel,null),"original-pause-resume-did-not-close-outer-panel");
        var consumer=CCExact("ChapterSelectUI","LevelSingletons/ChapterSelectUI/ChapterSelectUI",true);
        CCRequire(consumer.gameObject.activeInHierarchy&&(bool)consumer.GetType().GetProperty("visible",cgFlags).GetValue(null,null),"original-chapter-panel-did-not-open");
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"cc-description-selected.txt"),CGPath(consumer.transform)+"|original-MainMenuChapterSelect-waypoint-guard->ShowUi->Show;no-chapter-selected");
    }
    [System.Serializable] public sealed class CCListener {
        public string declaringType,method,targetType,targetPath;public int targetInstance;public bool targetInScene;
    }
    [System.Serializable] public sealed class CCEventRoster {
        public string name;public int persistentCount,runtimeInvokables,persistentInvokables;
        public System.Collections.Generic.List<CCListener> listeners=new System.Collections.Generic.List<CCListener>();
    }
    [System.Serializable] public sealed class CCListenerRoster {
        public string scene,boundary="Read-only existing runtime call lists;no PrepareInvoke,event invocation,listener removal,replacement or notification factory";
        public System.Collections.Generic.List<CCEventRoster> events=new System.Collections.Generic.List<CCEventRoster>();
    }
    void CCListeners(){
        // JsonUtility omitted custom generic roster fields in the v5 native
        // readback. A versioned base64 TSV retains every actual scalar instead.
        // It is decoded/validated by the parent; an absent roster is never zero.
        var roster=new System.Text.StringBuilder("format\t1\nscene\t");
        roster.Append(System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(UnityEngine.SceneManagement.SceneManager.GetActiveScene().name))).Append('\n');
        foreach(var name in new[]{"onShowItemGetAchievement","onShowItemGetAchievementOverloadedForAdventures"}){
            var field=typeof(TheForestOfLove.Events.GameEvents).GetField(name,cgFlags);CCRequire(field!=null,"roster-event-field-missing");
            var value=field.GetValue(null) as UnityEngine.Events.UnityEventBase;CCRequire(value!=null,"roster-event-missing");
            var calls=typeof(UnityEngine.Events.UnityEventBase).GetField("m_Calls",cgFlags).GetValue(value);CCRequire(calls!=null,"roster-call-list-missing");
            var runtime=calls.GetType().GetField("m_RuntimeCalls",cgFlags).GetValue(calls) as System.Collections.IList;
            var persistent=calls.GetType().GetField("m_PersistentCalls",cgFlags).GetValue(calls) as System.Collections.IList;
            CCRequire(runtime!=null&&persistent!=null,"roster-call-list-schema");
            var item=new CCEventRoster{name=name,persistentCount=value.GetPersistentEventCount(),runtimeInvokables=runtime.Count,persistentInvokables=persistent.Count};
            roster.Append("event\t").Append(name).Append('\t').Append(item.persistentCount).Append('\t').Append(runtime.Count).Append('\t').Append(persistent.Count).Append('\n');
            int invokableIndex=0;
            foreach(var invokable in runtime){
                System.Delegate callback=null;int fields=0;
                for(var type=invokable.GetType();type!=null;type=type.BaseType)
                    foreach(var f in type.GetFields(cgFlags|System.Reflection.BindingFlags.DeclaredOnly))
                        if(typeof(System.Delegate).IsAssignableFrom(f.FieldType)){fields++;callback=f.GetValue(invokable) as System.Delegate;}
                CCRequire(fields==1&&callback!=null,"roster-invokable-delegate-schema");
                foreach(var action in callback.GetInvocationList()){
                    var target=action.Target;var component=target as UnityEngine.Component;
                    item.listeners.Add(new CCListener{declaringType=action.Method.DeclaringType.FullName,method=action.Method.Name,
                        targetType=target==null?"static":target.GetType().FullName,targetPath=component==null?"":CGPath(component.transform),
                        targetInstance=component==null?0:component.GetInstanceID(),targetInScene=component!=null&&component.gameObject.scene.IsValid()});
                    var listener=item.listeners[item.listeners.Count-1];
                    roster.Append("listener\t").Append(name).Append('\t').Append(invokableIndex);
                    foreach(var text in new[]{listener.declaringType,listener.method,listener.targetType,listener.targetPath})
                        roster.Append('\t').Append(System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(text)));
                    roster.Append('\t').Append(listener.targetInstance).Append('\t').Append(listener.targetInScene?"1":"0").Append('\n');
                }
                invokableIndex++;
            }
        }
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"cc-listener-roster.tsv"),roster.ToString());
    }
    void ChapterCompletionCommand(string action){
        if(action=="display")CCDisplay();
        else if(action=="listeners")CCListeners();
        else if(action=="description-open")CCDescriptionOpen();
        else if(action=="description-select")CCDescriptionSelect();
        else if(action.StartsWith("ready "))CCReady(action.Substring(6));
        else if(action.StartsWith("measure ")){if(ccFactory!=null)CCRequire(((System.Collections.ICollection)CGField(ccFactory,"itemGetNotifications")).Count==0,"notification-queue-changed");CGSelect(int.Parse(action.Substring(8)));CGGeometry();}
        else if(action=="restore")CCRestore();
        else if(action=="verify-restored"){
            CCRequire(cgConsumer==null&&ccFactory==null&&ccPaused==null,"restoration-not-complete");
            foreach(var c in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.MonoBehaviour>())if(c!=null)CCRequire(c.GetInstanceID()!=ccDestroyedId,"created-oos-still-live");
            System.IO.File.WriteAllText(System.IO.Path.Combine(root,"cc-restoration-verified.txt"),"owned-created-object-absent;restoration-complete");
        }else throw new System.Exception("Unsupported chapter-completion action");
    }
}
