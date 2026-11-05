using System;
using System.IO;
using System.Text.Json;
using ForestComplexText;
static class CorpusTests {
    static void Main(string[] args) {
        using var doc=JsonDocument.Parse(File.ReadAllBytes(args[0]));int checkedValues=0,failed=0,thaiValues=0;
        bool thai=doc.RootElement.GetProperty("locale").GetString()=="th";
        JsonElement layout;bool hasLayout=doc.RootElement.TryGetProperty("complexTextLayout",out layout);
        float Expected(string key,float fallback){JsonElement value;return hasLayout&&layout.TryGetProperty(key,out value)?value.GetSingle():fallback;}
        foreach(var pair in new[]{("critterHeadingLift",TextShaper.CritterHeadingLift,0f),("critterHeadingShiftX",TextShaper.CritterHeadingShiftX,0f),
            ("critterHeadingScale",TextShaper.CritterHeadingScale,1f),("questHeadingScale",TextShaper.QuestHeadingScale,1f),
            ("questHeadingShiftX",TextShaper.QuestHeadingShiftX,0f),("questHeadingLift",TextShaper.QuestHeadingLift,4f),
            ("settingsBackLift",TextShaper.SettingsBackLift,0f),("settingsDeleteLift",TextShaper.SettingsDeleteLift,0f)})
            if(pair.Item2!=Expected(pair.Item1,pair.Item3))throw new Exception("Embedded layout metadata differs: "+pair.Item1);
        foreach(var row in doc.RootElement.GetProperty("translations").EnumerateObject()) {
            string value=row.Value.GetProperty("target").GetString();
            try {
                string display=TextShaper.Shape(value);
                if(TextShaper.Shape(display)!=display)throw new Exception("Display shaping is not idempotent");
                if(thai) {
                    var logicalPlain=TextShaper.PlainForWrap(value);var displayPlain=TextShaper.PlainForWrap(display);
                    if(logicalPlain.Length!=displayPlain.Length)throw new Exception("Thai character slots changed");
                    var logicalWrap=TextShaper.WordWrapOpportunities(value);var displayWrap=TextShaper.WordWrapOpportunities(display);
                    for(int i=0;i<logicalPlain.Length;i++) {
                        char c=logicalPlain[i];bool script=(c>='\u0E01'&&c<='\u0E3A')||(c>='\u0E40'&&c<='\u0E4E');
                        if(script&&(logicalWrap[i]<0||logicalWrap[i]>2))throw new Exception("Authored Thai boundary missing at "+i);
                        if(logicalWrap[i]!=displayWrap[i])throw new Exception("Logical/pre-shaped Thai boundaries diverge at "+i);
                    }
                    thaiValues++;
                }
                checkedValues++;
            } catch(Exception e) {failed++;Console.Error.WriteLine(row.Name+": "+e.Message);}
        }
        if(thai) {
            void Require(bool condition,string why){if(!condition){failed++;Console.Error.WriteLine(why);}}
            var w=TextShaper.WordWrapOpportunities("กระจ่างในแสงไฟ");
            Require(w[6]==1&&w[8]==1&&w[13]==1,"Thai sidebar word ends");
            w=TextShaper.WordWrapOpportunities("แบบ");Require(w[0]==0&&w[1]==2&&w[2]==1,"Leading vowel remains in its cluster; first-word fallback is explicit");
            w=TextShaper.WordWrapOpportunities("<size=22>เ</size>หรอ?");
            Require(w.Length==5&&w[0]==0&&w[3]==2&&w[4]==1,"Thai tags retain visible indices and closing punctuation attaches");
            w=TextShaper.WordWrapOpportunities("ยังไงพวกเธอก็มักจะอึดกว่าด้วย");Require(w[19]==0,"Unknown-word tokenizer recovery never splits a TCC");
        }
        Console.WriteLine(JsonSerializer.Serialize(new {checkedValues,thaiValues,failed,boundary="Complete deterministic logical target corpus through the shared display shaper and Thai logical/pre-shaped index/word/TCC gates; no visual or semantic acceptance"}));
        if(failed>0)Environment.Exit(1);
    }
}
