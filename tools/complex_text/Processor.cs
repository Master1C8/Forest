namespace ForestComplexText {
    sealed class Processor : TMPro.ITextPreprocessor {
        readonly TMPro.TMP_Text target;
        string wrapValue;
        int[] wrapOpportunities;
        public Processor(TMPro.TMP_Text value) { target = value; }
        public string PreprocessText(string value) {
            bool rtl = TextShaper.RequiresRightToLeft(value);
            if (target.isRightToLeftText != rtl) target.isRightToLeftText = rtl;
            string display=TextShaper.Shape(value);
            if(TextShaper.UsesThaiWrapping && wrapValue!=value) {
                wrapValue=value;wrapOpportunities=TextShaper.WordWrapOpportunities(value);
            }
            return display;
        }
        public int WrapOpportunity(int index) {
            return wrapOpportunities!=null && index>=0 && index<wrapOpportunities.Length ? wrapOpportunities[index] : -1;
        }
    }
}
