TYPE TMPro.TMP_Text
METHOD System.Int32 TMPro.TMP_Text::GetStyleHashCode(TMPro.TMP_Text/TextBackingContainer&,System.Int32,System.Int32&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldarg.3
IL_0003: ldc.i4.0
IL_0004: stind.i4
IL_0005: ldarg.2
IL_0006: stloc.1
IL_0007: br.s IL_003c
IL_0009: ldarg.1
IL_000a: ldloc.1
IL_000b: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_0010: ldc.i4.s 34
IL_0012: beq.s IL_0038
IL_0014: ldarg.1
IL_0015: ldloc.1
IL_0016: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_001b: ldc.i4.s 62
IL_001d: bne.un.s IL_0024
IL_001f: ldarg.3
IL_0020: ldloc.1
IL_0021: stind.i4
IL_0022: br.s IL_0045
IL_0024: ldloc.0
IL_0025: ldc.i4.5
IL_0026: shl
IL_0027: ldloc.0
IL_0028: add
IL_0029: ldarg.1
IL_002a: ldloc.1
IL_002b: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_0030: conv.u2
IL_0031: call System.Char TMPro.TMP_TextParsingUtilities::ToUpperASCIIFast(System.Char)
IL_0036: xor
IL_0037: stloc.0
IL_0038: ldloc.1
IL_0039: ldc.i4.1
IL_003a: add
IL_003b: stloc.1
IL_003c: ldloc.1
IL_003d: ldarg.1
IL_003e: call System.Int32 TMPro.TMP_Text/TextBackingContainer::get_Capacity()
IL_0043: blt.s IL_0009
IL_0045: ldloc.0
IL_0046: ret
