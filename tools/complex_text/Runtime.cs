// Optional locale-owned renderer. No game-data or persistence writes.
namespace ForestComplexText {
    public sealed class Runtime : UnityEngine.MonoBehaviour {
        static Runtime current;
        static System.Reflection.FieldInfo inputHook;
        static System.Action<TMPro.TMP_Text> ownedHook;
        static System.Reflection.FieldInfo wrapHook;
        static System.Func<TMPro.TMP_Text,int,int> ownedWrap;
        public static void Install() {
            if(current!=null)return;
            var hook=typeof(TMPro.TMP_Text).GetField("ForestPrepareText",System.Reflection.BindingFlags.Public|System.Reflection.BindingFlags.Static);
            if(hook==null||hook.FieldType!=typeof(System.Action<TMPro.TMP_Text>))throw new System.InvalidOperationException("Patched shared TMP input route unavailable");
            if(hook.GetValue(null)!=null)throw new System.InvalidOperationException("Unowned TMP rendering hook");
            inputHook=hook;ownedHook=new System.Action<TMPro.TMP_Text>(Prepare);hook.SetValue(null,ownedHook);
            if(TextShaper.UsesThaiWrapping) {
                wrapHook=typeof(TMPro.TMP_Text).GetField("ForestWordWrap",System.Reflection.BindingFlags.Public|System.Reflection.BindingFlags.Static);
                if(wrapHook==null||wrapHook.FieldType!=typeof(System.Func<TMPro.TMP_Text,int,int>)||wrapHook.GetValue(null)!=null)throw new System.InvalidOperationException("Thai word-wrap hook unavailable or unowned");
                ownedWrap=new System.Func<TMPro.TMP_Text,int,int>(WrapOpportunity);wrapHook.SetValue(null,ownedWrap);
            }
            var go=new UnityEngine.GameObject("ForestComplexTextRenderer");
            UnityEngine.Object.DontDestroyOnLoad(go);current=go.AddComponent<Runtime>();current.Bind();
        }
        static void Prepare(TMPro.TMP_Text text) {
            if(text.textPreprocessor is Processor)return;
            if(text.textPreprocessor!=null)throw new System.InvalidOperationException("Unregistered text preprocessor conflict");
            text.textPreprocessor=new Processor(text);
        }
        static int WrapOpportunity(TMPro.TMP_Text text,int index) {
            var processor=text.textPreprocessor as Processor;
            return processor==null?-1:processor.WrapOpportunity(index);
        }
        // These are separate original controls, so bidi within each string cannot
        // order their label/value group. Move the original display groups;
        // retain their components, parent button, callbacks and logical strings.
        static void GalleryDirection(TMPro.TMP_Text text) {
            if(text.name!="NameContainer (1)"||!TextShaper.RequiresRightToLeft(text.text))return;
            var label=text.transform.parent as UnityEngine.RectTransform;
            if(label==null||label.name!="Dialogue")return;
            var group=label.parent;
            if(group==null||group.name!="Dialogue"||group.parent==null||group.parent.name!="GalleryMenu"||group.parent.parent==null||group.parent.parent.name!="Canvas")return;
            var on=group.Find("On") as UnityEngine.RectTransform;
            var off=group.Find("Off") as UnityEngine.RectTransform;
            var controls=new[]{label,on,off};
            // Validate the entire group before writing any position. The second
            // valid state is the exact already-applied state, not a substring test.
            for(int i=0;i<controls.Length;i++) {
                var rect=controls[i];float original=i==0?-20:44;float target=i==0?44:-20;
                if(rect==null||rect.anchorMin!=new UnityEngine.Vector2(.5f,.5f)||rect.anchorMax!=rect.anchorMin||rect.pivot!=rect.anchorMin||rect.sizeDelta!=new UnityEngine.Vector2(120,16)||rect.localScale!=UnityEngine.Vector3.one||rect.anchoredPosition.y!=0||(rect.anchoredPosition.x!=original&&rect.anchoredPosition.x!=target))throw new System.InvalidOperationException("Unregistered gallery dialogue control pose");
            }
            label.anchoredPosition=new UnityEngine.Vector2(44,0);
            on.anchoredPosition=off.anchoredPosition=new UnityEngine.Vector2(-20,0);
        }
        static void QuestHeadingClearance(TMPro.TMP_Text text) {
            if(text.name!="NameContainer (1)"||!TextShaper.RequiresRightToLeft(text.text))return;
            var heading=text.transform.parent as UnityEngine.RectTransform;
            if(heading==null||heading.name!="QuestLog"||heading.parent==null||heading.parent.name!="Labels"||heading.parent.parent==null||heading.parent.parent.name!="Container"||heading.parent.parent.parent==null||heading.parent.parent.parent.name!="Canvas")return;
            // Original foreground artwork occludes Arabic descenders at y=0.
            // Move the complete heading (including outline children) above it.
            if(heading.anchorMin!=new UnityEngine.Vector2(.5f,1)||heading.anchorMax!=heading.anchorMin||heading.pivot!=heading.anchorMin||heading.sizeDelta!=new UnityEngine.Vector2(88,15)||heading.localScale!=UnityEngine.Vector3.one||heading.anchoredPosition.x!=0||(heading.anchoredPosition.y!=0&&heading.anchoredPosition.y!=4))throw new System.InvalidOperationException("Unregistered quest heading pose");
            heading.anchoredPosition=new UnityEngine.Vector2(0,4);
        }
        static void CritterHeadingClearance(TMPro.TMP_Text text) {
            float lift=TextShaper.CritterHeadingLift,shift=TextShaper.CritterHeadingShiftX;
            if((lift==0&&shift==0)||text.name!="NameContainer (1)")return;
            var heading=text.transform.parent as UnityEngine.RectTransform;
            if(heading==null||heading.name!="CritterLog"||heading.parent==null||heading.parent.name!="Labels"||heading.parent.parent==null||heading.parent.parent.name!="Container"||heading.parent.parent.parent==null||heading.parent.parent.parent.name!="Canvas")return;
            var target=new UnityEngine.Vector2(shift,lift);
            bool knownPose=heading.anchoredPosition==UnityEngine.Vector2.zero||heading.anchoredPosition==new UnityEngine.Vector2(0,lift)||heading.anchoredPosition==target;
            if(heading.anchorMin!=new UnityEngine.Vector2(.5f,1)||heading.anchorMax!=heading.anchorMin||heading.pivot!=heading.anchorMin||heading.sizeDelta!=new UnityEngine.Vector2(88,15)||heading.localScale!=UnityEngine.Vector3.one||!knownPose)throw new System.InvalidOperationException("Unregistered CritterLog heading pose");
            heading.anchoredPosition=target;
        }
        void Bind() {
            foreach(var text in UnityEngine.Resources.FindObjectsOfTypeAll<TMPro.TMP_Text>()) {
                if(!text.gameObject.scene.IsValid())continue;
                GalleryDirection(text);
                QuestHeadingClearance(text);
                CritterHeadingClearance(text);
                if(text.textPreprocessor is Processor)continue;
                if(text.textPreprocessor!=null)throw new System.InvalidOperationException("Unregistered text preprocessor conflict");
                string logical=text.text;Prepare(text);text.havePropertiesChanged=true;text.SetVerticesDirty();
                if(text.text!=logical)throw new System.Exception("Renderer changed logical TMP text");
            }
            foreach(var text in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.UI.Text>())
                if(text.gameObject.scene.IsValid())LegacyMirror.Bind(text);
        }
        void LateUpdate(){Bind();}
        void OnDestroy(){if(current==this){if(inputHook!=null&&object.Equals(inputHook.GetValue(null),ownedHook))inputHook.SetValue(null,null);if(wrapHook!=null&&object.Equals(wrapHook.GetValue(null),ownedWrap))wrapHook.SetValue(null,null);current=null;}}
    }
}
