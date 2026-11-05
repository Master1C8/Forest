// Keep rich-text markup out of bidi analysis; carry its style with each glyph.
// BidiSharp determines visual order. TMP then performs its single RTL reversal.
namespace ForestComplexText {
    public static class BidiOrder {
        sealed class Style { public string Open, Close; }
        sealed class Item { public char Value; public Style[] Styles; }
        static bool Tag(string text,int offset,out int end,out string name,out bool close) {
            end=text.IndexOf('>',offset);name=null;close=false;
            if(end<0)return false;
            string body=text.Substring(offset+1,end-offset-1);close=body.StartsWith("/");
            if(close)body=body.Substring(1);int equals=body.IndexOf('=');
            name=(equals<0?body:body.Substring(0,equals)).ToLowerInvariant();
            return name=="style"||name=="size"||name=="color"||name=="i"||name=="b"||name=="u"||name=="noparse"||name=="br";
        }
        static void Emit(System.Text.StringBuilder output,System.Collections.Generic.List<Item> line,int mode) {
            if(line.Count==0)return;
            var raw=new System.Text.StringBuilder();foreach(var item in line)raw.Append(item.Value);
            // Treat separators inside an identified numeric field as CS.
            // This keeps dates/counters internally numeric without merging a
            // neighboring URL into the same LTR run. No source glyph changes.
            var numeric=System.Text.RegularExpressions.Regex.Matches(raw.ToString(),@"\p{Nd}+(?:[-/:.]\p{Nd}+)+");
            var separators=new System.Collections.Generic.HashSet<int>();
            foreach(System.Text.RegularExpressions.Match m in numeric)
                for(int k=m.Index;k<m.Index+m.Length;k++)if(!char.IsDigit(line[k].Value))separators.Add(k);
            var chars=new System.Collections.Generic.List<char>();var types=new System.Collections.Generic.List<byte>();var original=new System.Collections.Generic.List<int>();
            for(int i=0;i<line.Count;i++) {
                char c=line[i].Value;chars.Add(c);original.Add(i);
                types.Add(separators.Contains(i) ? (byte)12 : c>='\uE000'&&c<='\uF8FF' ? (byte)(mode==1?4:3) : BidiSharp.Bidi_Types.BidiCharTypes[c]);
            }
            byte[] levels;
            int[] order=BidiSharp.Bidi.LogicalToVisualIndexes(new string(chars.ToArray()),out levels,null,types.ToArray(),1);
            Style[] current=new Style[0];
            for(int i=order.Length-1;i>=0;i--) {
                int index=original[order[i]];if(index<0)continue;
                var item=line[index];int common=0;
                while(common<current.Length&&common<item.Styles.Length&&object.ReferenceEquals(current[common],item.Styles[common]))common++;
                for(int k=current.Length-1;k>=common;k--)output.Append(current[k].Close);
                for(int k=common;k<item.Styles.Length;k++)output.Append(item.Styles[k].Open);
                output.Append(levels[order[i]]%2==1?MirrorGlyph.Get(item.Value):item.Value);current=item.Styles;
            }
            for(int k=current.Length-1;k>=0;k--)output.Append(current[k].Close);
        }
        public static string ForTmp(string logicalGlyphs,int mode) {
            var output=new System.Text.StringBuilder();var line=new System.Collections.Generic.List<Item>();
            var styles=new System.Collections.Generic.List<Style>();
            for(int i=0;i<logicalGlyphs.Length;i++) {
                char c=logicalGlyphs[i];int end;string name;bool close;
                bool noParse=styles.Exists(s=>s.Close=="</noparse>");
                if(c=='<'&&Tag(logicalGlyphs,i,out end,out name,out close)&&(!noParse||name=="noparse"&&close)) {
                    string raw=logicalGlyphs.Substring(i,end-i+1);i=end;
                    if(name=="br"){Emit(output,line,mode);line.Clear();output.Append(raw);continue;}
                    if(close) {
                        // Original Forest entries include open-ended and
                        // crossing styles. TMP closes each style independently;
                        // an unmatched closing style has no visible content.
                        for(int k=styles.Count-1;k>=0;k--)if(styles[k].Close=="</"+name+">"){styles.RemoveAt(k);break;}
                    } else styles.Add(new Style{Open=raw,Close="</"+name+">"});
                    continue;
                }
                if(c=='\n'||c=='\r'){Emit(output,line,mode);line.Clear();output.Append(c);continue;}
                if(char.IsSurrogate(c)||c=='\uFFFF')throw new System.InvalidOperationException("Unsupported bidi codepoint in bounded probe");
                line.Add(new Item{Value=c,Styles=styles.ToArray()});
            }
            Emit(output,line,mode);
            return output.ToString();
        }
    }
}
