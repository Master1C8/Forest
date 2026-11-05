// Bounded native feasibility only. Not a production bootstrap.
namespace ForestComplexText {
    public sealed class ProbeAdapter : UnityEngine.MonoBehaviour {
        static string root;
        public static void Install(string directory) {
            root = directory;
            Runtime.Install();
            var go = new UnityEngine.GameObject("ForestComplexScriptFeasibility");
            UnityEngine.Object.DontDestroyOnLoad(go);
            go.AddComponent<ProbeAdapter>().Bind();
        }
        void Bind() {
            if (__LEGACY_ENABLED__)
                foreach (var text in UnityEngine.Resources.FindObjectsOfTypeAll<UnityEngine.UI.Text>())
                    if (text.gameObject.scene.IsValid()) LegacyMirror.Bind(text);
            foreach (var text in UnityEngine.Resources.FindObjectsOfTypeAll<TMPro.TMP_Text>()) {
                if (!text.gameObject.scene.IsValid() || text.textPreprocessor is Processor) continue;
                if (text.textPreprocessor != null)
                    throw new System.InvalidOperationException("Existing preprocessor must be composed explicitly");
                string before = text.text;
                text.textPreprocessor = new Processor(text);
                text.havePropertiesChanged = true;
                text.SetVerticesDirty();
                if (text.text != before) throw new System.Exception("Logical text changed during binding");
            }
        }
        void LateUpdate() { Bind(); }
        public static void Samples() {
            TMPro.TMP_FontAsset font = null;
            foreach (var t in UnityEngine.Resources.FindObjectsOfTypeAll<TMPro.TMP_Text>())
                if (t.gameObject.activeInHierarchy && t.font != null) { font = t.font; break; }
            if (font == null) throw new System.Exception("No live font for bounded samples");
            var go = new UnityEngine.GameObject("ComplexScriptSamples", typeof(UnityEngine.Canvas),
                typeof(UnityEngine.UI.CanvasScaler));
            var canvas = go.GetComponent<UnityEngine.Canvas>();
            canvas.renderMode = UnityEngine.RenderMode.ScreenSpaceOverlay; canvas.sortingOrder = 30000;
            var scale = go.GetComponent<UnityEngine.UI.CanvasScaler>();
            scale.uiScaleMode = UnityEngine.UI.CanvasScaler.ScaleMode.ScaleWithScreenSize;
            scale.referenceResolution = new UnityEngine.Vector2(1280,800);
            var panel = new UnityEngine.GameObject("Background", typeof(UnityEngine.RectTransform), typeof(UnityEngine.UI.Image));
            panel.transform.SetParent(go.transform, false);
            var rect = panel.GetComponent<UnityEngine.RectTransform>();
            rect.anchorMin = UnityEngine.Vector2.zero; rect.anchorMax = UnityEngine.Vector2.one;
            rect.offsetMin = UnityEngine.Vector2.zero; rect.offsetMax = UnityEngine.Vector2.zero;
            panel.GetComponent<UnityEngine.UI.Image>().color = new UnityEngine.Color(.08f,.08f,.08f,1);
            string[] logical = System.IO.File.ReadAllLines(System.IO.Path.Combine(root,"samples.txt"));
            var report = new System.Text.StringBuilder();
            for (int i=0;i<logical.Length;i++) {
                if(i==7) {
                    // Exercise a real serialized prepared value through a fresh
                    // component, with the same no-double-shaping path.
                    string prepared = TextShaper.Shape(logical[i]);
                    string path = System.IO.Path.Combine(root,"serialized-prepared-sample.txt");
                    System.IO.File.WriteAllText(path,prepared);
                    logical[i] = System.IO.File.ReadAllText(path);
                    if(TextShaper.Shape(logical[i])!=prepared) throw new System.Exception("Double shaping");
                }
                var row = new UnityEngine.GameObject("Sample"+i, typeof(UnityEngine.RectTransform), typeof(TMPro.TextMeshProUGUI));
                row.transform.SetParent(panel.transform, false);
                var t = row.GetComponent<TMPro.TextMeshProUGUI>();
                t.font = font; t.fontSize = 30; t.color = UnityEngine.Color.white;
                t.alignment = TMPro.TextAlignmentOptions.Center;
                t.enableWordWrapping = true; t.overflowMode = TMPro.TextOverflowModes.Overflow;
                var r = t.rectTransform; r.anchorMin = r.anchorMax = new UnityEngine.Vector2(.5f,1);
                r.pivot = new UnityEngine.Vector2(.5f,1); r.sizeDelta = new UnityEngine.Vector2(1180,75);
                r.anchoredPosition = new UnityEngine.Vector2(0,-30-i*90);
                t.text = logical[i]; t.ForceMeshUpdate();
                var info=t.GetTextInfo(logical[i]);
                int expected=System.Text.RegularExpressions.Regex.Replace(logical[i],"<[^>]*>","").Length;
                if(info.characterCount!=expected)throw new System.Exception("Animated character index drift: "+i+" "+info.characterCount+" != "+expected);
                if(!(t.textPreprocessor is Processor))throw new System.Exception("Global input hook did not bind processor");
                if (t.text != logical[i]) throw new System.Exception("Logical sample changed");
                report.AppendLine(i+"\tlogical="+System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(t.text))+
                    "\trtl="+t.isRightToLeftText+"\tcharacters="+t.textInfo.characterCount);
            }
            System.IO.File.WriteAllText(System.IO.Path.Combine(root,"logical-sample-readback.tsv"),report.ToString());
        }
    }
}
