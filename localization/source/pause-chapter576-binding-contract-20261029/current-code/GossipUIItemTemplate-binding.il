TYPE TheForestOfLove.GossipUIItemTemplate
METHOD System.Void TheForestOfLove.GossipUIItemTemplate::SetText(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call !!0[] UnityEngine.Component::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_0006: stloc.0
IL_0007: ldc.i4.0
IL_0008: stloc.1
IL_0009: br.s IL_0048
IL_000b: ldloc.0
IL_000c: ldloc.1
IL_000d: ldelem.ref
IL_000e: stloc.2
IL_000f: ldloc.2
IL_0010: ldarg.1
IL_0011: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0016: ldarg.0
IL_0017: ldloc.2
IL_0018: ldarg.0
IL_0019: ldfld System.Boolean TheForestOfLove.GossipUIItemTemplate::lockIconVisible
IL_001e: ldstr "<sprite=2>"
IL_0023: ldstr "<sprite=3>"
IL_0028: call System.Void TheForestOfLove.GossipUIItemTemplate::TryPrependGlyphCode(TMPro.TextMeshProUGUI,System.Boolean,System.String,System.String)
IL_002d: ldarg.0
IL_002e: ldloc.2
IL_002f: ldarg.0
IL_0030: ldfld System.Boolean TheForestOfLove.GossipUIItemTemplate::newLabelVisible
IL_0035: ldstr "<sprite=0>"
IL_003a: ldstr "<sprite=1>"
IL_003f: call System.Void TheForestOfLove.GossipUIItemTemplate::TryPrependGlyphCode(TMPro.TextMeshProUGUI,System.Boolean,System.String,System.String)
IL_0044: ldloc.1
IL_0045: ldc.i4.1
IL_0046: add
IL_0047: stloc.1
IL_0048: ldloc.1
IL_0049: ldloc.0
IL_004a: ldlen
IL_004b: conv.i4
IL_004c: blt.s IL_000b
IL_004e: ret
METHOD System.Void TheForestOfLove.GossipUIItemTemplate::TryPrependGlyphCode(TMPro.TextMeshProUGUI,System.Boolean,System.String,System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: brfalse.s IL_003b
IL_0003: ldarg.1
IL_0004: callvirt System.String UnityEngine.Object::get_name()
IL_0009: ldstr "Name"
IL_000e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0013: brfalse.s IL_0028
IL_0015: ldarg.1
IL_0016: ldarg.3
IL_0017: ldarg.1
IL_0018: callvirt System.String TMPro.TMP_Text::get_text()
IL_001d: call System.String System.String::Concat(System.String,System.String)
IL_0022: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0027: ret
IL_0028: ldarg.1
IL_0029: ldarg.s glyphCodeInvisible
IL_002b: ldarg.1
IL_002c: callvirt System.String TMPro.TMP_Text::get_text()
IL_0031: call System.String System.String::Concat(System.String,System.String)
IL_0036: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_003b: ret
