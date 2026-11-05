// Native Text retains its logical value, component identity and interaction refs.
// A TMP child supplies only display geometry for the bounded Arabic experiment.
namespace ForestComplexText {
    public sealed class LegacyMirror : UnityEngine.MonoBehaviour {
        UnityEngine.UI.Text source;
        TMPro.TextMeshProUGUI display;
        static readonly System.Collections.Generic.Dictionary<UnityEngine.Font,TMPro.TMP_FontAsset> Fonts =
            new System.Collections.Generic.Dictionary<UnityEngine.Font,TMPro.TMP_FontAsset>();
        bool active;
        public static void Bind(UnityEngine.UI.Text text) {
            if (text.GetComponent<LegacyMirror>() == null) text.gameObject.AddComponent<LegacyMirror>();
        }
        void Awake() {
            source = GetComponent<UnityEngine.UI.Text>();
            var go = new UnityEngine.GameObject("ForestComplexDisplay",typeof(UnityEngine.RectTransform),typeof(TMPro.TextMeshProUGUI));
            go.layer = gameObject.layer; go.transform.SetParent(transform,false);
            // A parent Graphic originally renders before its child Graphics.
            // Appending this display would paint the parent's glow over the
            // child's foreground lettering (notably Devanagari conjuncts).
            go.transform.SetAsFirstSibling();
            var rect = (UnityEngine.RectTransform)go.transform;
            rect.anchorMin = UnityEngine.Vector2.zero; rect.anchorMax = UnityEngine.Vector2.one;
            rect.offsetMin = rect.offsetMax = UnityEngine.Vector2.zero;
            display = go.GetComponent<TMPro.TextMeshProUGUI>(); display.raycastTarget = false;
            display.textPreprocessor = new Processor(display);
            UnityEngine.Canvas.willRenderCanvases += HideOriginalMesh;
        }
        void OnDestroy() { UnityEngine.Canvas.willRenderCanvases -= HideOriginalMesh; }
        void HideOriginalMesh() { if(active && source != null && source.enabled) source.canvasRenderer.SetMesh(null); }
        void LateUpdate() { Sync(); }
#if FOREST_RESIDENT_PROFILE_FIT
        bool IsResidentProfile() {
            if(source.name!="FullName"&&source.name!="Subtitles")return false;
            var bio=source.transform.parent;
            var content=bio==null?null:bio.parent;
            if(bio==null||bio.name!="Bio"||content==null||content.name!="Content"||
               content.parent==null||content.parent.name!="CritterLog UI")return false;
            float height=source.name=="FullName"?18:39;
            var size=source.rectTransform.rect.size;
            if(!UnityEngine.Mathf.Approximately(size.x,186)||!UnityEngine.Mathf.Approximately(size.y,height))
                throw new System.InvalidOperationException("Unregistered resident profile rectangle");
            return true;
        }
#endif
        void Sync() {
            bool next = source.enabled && source.font != null && TextShaper.RequiresShaping(source.text);
            if (active && !next) source.SetVerticesDirty();
            active = next; display.enabled = active;
            if (!active) return;
            TMPro.TMP_FontAsset font;
            if (!Fonts.TryGetValue(source.font,out font)) {
                if (!source.font.HasCharacter('\uE000')) throw new System.Exception("Unprepared legacy font");
                font = TMPro.TMP_FontAsset.CreateFontAsset(source.font);
                if (font == null) throw new System.Exception("Native font could not create TMP face");
                font.name = "ForestComplex-"+source.font.name; Fonts.Add(source.font,font);
            }
            display.font = font;
#if FOREST_RESIDENT_PROFILE_FIT
            bool profile=IsResidentProfile();
            if(!profile)
#endif
                display.fontSize = source.fontSize;
            display.fontStyle = source.fontStyle == UnityEngine.FontStyle.Bold ? TMPro.FontStyles.Bold :
                source.fontStyle == UnityEngine.FontStyle.Italic ? TMPro.FontStyles.Italic :
                source.fontStyle == UnityEngine.FontStyle.BoldAndItalic ? TMPro.FontStyles.Bold|TMPro.FontStyles.Italic : TMPro.FontStyles.Normal;
            display.color = source.color; display.richText = source.supportRichText;
            var outline=source.GetComponent<UnityEngine.UI.Outline>();
            display.outlineColor=outline!=null&&outline.enabled?outline.effectColor:UnityEngine.Color.clear;
            display.outlineWidth=outline!=null&&outline.enabled?
                UnityEngine.Mathf.Clamp01(UnityEngine.Mathf.Max(UnityEngine.Mathf.Abs(outline.effectDistance.x),UnityEngine.Mathf.Abs(outline.effectDistance.y))*2/source.fontSize):0;
            display.enableWordWrapping = source.horizontalOverflow == UnityEngine.HorizontalWrapMode.Wrap;
#if FOREST_RESIDENT_PROFILE_FIT
            if(profile) {
                // Legacy point sizes can leave no room for a shaped line in
                // TMP. Fit all lines into the original box without truncation.
                display.enableAutoSizing=true;
                display.fontSizeMin=source.name=="FullName"?10:8;
                display.fontSizeMax=source.fontSize;
                display.overflowMode=TMPro.TextOverflowModes.Overflow;
            }
            else
#endif
                display.overflowMode = source.verticalOverflow == UnityEngine.VerticalWrapMode.Overflow ? TMPro.TextOverflowModes.Overflow : TMPro.TextOverflowModes.Truncate;
            int align = (int)source.alignment;
            int horizontal=align%3;
            if(TextShaper.RequiresRightToLeft(source.text)&&horizontal==0)horizontal=2;
            display.margin=TextShaper.RequiresRightToLeft(source.text)&&horizontal!=1?new UnityEngine.Vector4(1,0,3,0):UnityEngine.Vector4.zero;
            // Preserve center fields; RTL paragraphs use the matching right edge.
            display.alignment = align/3 == 0 ? (horizontal==0?TMPro.TextAlignmentOptions.TopLeft:horizontal==1?TMPro.TextAlignmentOptions.Top:TMPro.TextAlignmentOptions.TopRight) :
                align/3 == 1 ? (horizontal==0?TMPro.TextAlignmentOptions.Left:horizontal==1?TMPro.TextAlignmentOptions.Center:TMPro.TextAlignmentOptions.Right) :
                (horizontal==0?TMPro.TextAlignmentOptions.BottomLeft:horizontal==1?TMPro.TextAlignmentOptions.Bottom:TMPro.TextAlignmentOptions.BottomRight);
            display.canvasRenderer.SetAlpha(source.canvasRenderer.GetAlpha());
            if (display.text != source.text) display.text = source.text;
        }
        public static bool TryInkY(UnityEngine.UI.Text text,UnityEngine.RectTransform relative,out UnityEngine.Vector2 bounds) {
            bounds=UnityEngine.Vector2.zero;
            if(!TextShaper.RequiresShaping(text.text))return false;
            Bind(text);var mirror=text.GetComponent<LegacyMirror>();mirror.Sync();
            if(!mirror.active)return false;
            mirror.display.ForceMeshUpdate(true,true);
            float low=float.PositiveInfinity,high=float.NegativeInfinity;
            var info=mirror.display.textInfo;
            for(int i=0;i<info.characterCount;i++) {
                var c=info.characterInfo[i];if(!c.isVisible)continue;
                foreach(var p in new[]{c.bottomLeft,c.topLeft,c.topRight,c.bottomRight}) {
                    var local=relative.InverseTransformPoint(mirror.display.transform.TransformPoint(p));
                    low=UnityEngine.Mathf.Min(low,local.y);high=UnityEngine.Mathf.Max(high,local.y);
                }
            }
            if(!float.IsInfinity(low))bounds=new UnityEngine.Vector2(low,high);
            return true;
        }
    }
}
