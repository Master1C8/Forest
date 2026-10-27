// Disposable data/consumer regression. Never include this bridge in a release.
public sealed partial class ForestProbe
{
    [System.Serializable] public sealed class ActorDisplayRow {
        public string dbName, nameplate, fullName;
        public bool introduced;
    }
    [System.Serializable] public sealed class ActorDisplayState {
        public string scene, company, product, dataPath, labelText, font;
        public string[] fontNames;
        public int actorCount;
        public bool cyrillicGlyphsPresent, generated;
        public int visibleCharacters;
        public float textWidth, textHeight, rectWidth, rectHeight;
        public float rawTextWidth, rawTextHeight, pixelsPerUnit;
        public string boundary;
    }
    void InspectActorNames() {
        if(UnityEngine.SceneManagement.SceneManager.GetActiveScene().name!="StartMenu")
            throw new System.Exception("Actor display probe requires the original StartMenu reveal bypass");
        var rows=new System.Collections.Generic.List<ActorDisplayRow>();
        foreach(var actor in TheForestOfLove.Services.Persistence.DataService.GetActors())
            rows.Add(new ActorDisplayRow {dbName=actor.dbName,nameplate=actor.NameplateName,
                fullName=actor.FullName,introduced=actor.IsIntroduced});
        if(rows.Count!=39)throw new System.Exception("Expected all 39 initialized actors, found "+rows.Count);
        // Preserve scalars independently of Unity JsonUtility's native class-array boundary.
        System.Func<string,string> scalar=s=>s==null?"~":System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(s));
        var cells=new System.Text.StringBuilder("dbName64\tnameplate64\tfullName64\tintroduced\n");
        foreach(var row in rows)
            cells.Append(scalar(row.dbName)).Append('\t').Append(scalar(row.nameplate)).Append('\t')
                .Append(scalar(row.fullName)).Append('\t').Append(row.introduced).Append('\n');
        System.IO.File.WriteAllText(System.IO.Path.Combine(root,"actor-values.tsv"),cells.ToString());
        TheForestOfLove.DialogueNameplateController controller=null;
        foreach(var candidate in UnityEngine.Resources.FindObjectsOfTypeAll<TheForestOfLove.DialogueNameplateController>())
            if(candidate.gameObject.scene.IsValid() && candidate.gameObject.activeInHierarchy) {
                if(controller!=null)throw new System.Exception("Ambiguous live nameplate controller");
                controller=candidate;
            }
        if(controller==null)throw new System.Exception("Live nameplate controller absent");
        var flags=System.Reflection.BindingFlags.Instance|System.Reflection.BindingFlags.NonPublic|System.Reflection.BindingFlags.Public;
        var kind=controller.GetType();
        var custom=(string)kind.GetField("customNameplate",flags).GetValue(controller);
        if(!string.IsNullOrWhiteSpace(custom))throw new System.Exception("Custom name override is active; do not overwrite it");
        var rootTransform=(UnityEngine.Transform)kind.GetField("nameplateRoot",flags).GetValue(controller);
        var labels=rootTransform.GetComponentsInChildren<UnityEngine.UI.Text>();
        if(labels.Length!=1)throw new System.Exception("Expected one actual native NameLabel");
        var label=labels[0];var previous=label.text;
        var group=(UnityEngine.CanvasGroup)kind.GetField("nameplateRootCanvasGroup",flags).GetValue(controller);
        float alpha=group.alpha;
        try {
            kind.GetMethod("UpdateNameplate",flags).Invoke(controller,new object[]{"Maverick"});
            UnityEngine.Canvas.ForceUpdateCanvases();
            bool glyphs=true;
            foreach(char c in "Маверик")glyphs &= label.font.HasCharacter(c);
            var generator=new UnityEngine.TextGenerator();
            var rect=label.rectTransform.rect;
            bool generated=generator.Populate(label.text,label.GetGenerationSettings(rect.size));
            float minX=float.PositiveInfinity,maxX=float.NegativeInfinity,minY=float.PositiveInfinity,maxY=float.NegativeInfinity;
            var vertices=generator.verts;
            for(int i=0;i<vertices.Count-4;i++) {
                var p=vertices[i].position;
                minX=UnityEngine.Mathf.Min(minX,p.x);maxX=UnityEngine.Mathf.Max(maxX,p.x);
                minY=UnityEngine.Mathf.Min(minY,p.y);maxY=UnityEngine.Mathf.Max(maxY,p.y);
            }
            // The shipped Text.OnPopulateMesh multiplies generated pixel vertices
            // by 1/pixelsPerUnit before comparing them with local RectTransform units.
            float pixelsPerUnit=label.pixelsPerUnit;
            float width=(maxX-minX)/pixelsPerUnit,height=(maxY-minY)/pixelsPerUnit;
            var state=new ActorDisplayState {scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene().name,
                company=UnityEngine.Application.companyName,product=UnityEngine.Application.productName,
                dataPath=UnityEngine.Application.dataPath,actorCount=rows.Count,labelText=label.text,
                font=label.font.name,fontNames=label.font.fontNames,cyrillicGlyphsPresent=glyphs,generated=generated,
                visibleCharacters=generator.characterCountVisible,textWidth=width,textHeight=height,
                rawTextWidth=maxX-minX,rawTextHeight=maxY-minY,pixelsPerUnit=pixelsPerUnit,
                rectWidth=rect.width,rectHeight=rect.height,
                boundary="Actual loaded Actor getters and original UpdateNameplate(Maverick) on its one live native Text; StartMenu's shipped introduction bypass. Original conversation 128:174 is not replayed."};
            System.IO.File.WriteAllText(System.IO.Path.Combine(root,"actor-names.json"),UnityEngine.JsonUtility.ToJson(state,true));
            if(label.text!="Маверик" || !glyphs || !generated || generator.characterCountVisible!=7 ||
                !(pixelsPerUnit>0 && width>0 && width<=rect.width && height>0 && height<=rect.height))
                throw new System.Exception("Localized native nameplate/glyph/geometry regression");
        } finally {
            label.text=previous;group.alpha=alpha;
            UnityEngine.Canvas.ForceUpdateCanvases();
        }
    }
}
