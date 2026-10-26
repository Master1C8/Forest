TYPE BOC.BTagged.BTaggedSO
METHOD System.String BOC.BTagged.BTaggedSO::get_ShortName()
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brtrue.s IL_0040
IL_0009: ldarg.0
IL_000a: call System.String UnityEngine.Object::get_name()
IL_000f: ldstr "/"
IL_0014: callvirt System.Boolean System.String::Contains(System.String)
IL_0019: brtrue.s IL_0022
IL_001b: ldarg.0
IL_001c: call System.String UnityEngine.Object::get_name()
IL_0021: ret
IL_0022: ldarg.0
IL_0023: call System.String UnityEngine.Object::get_name()
IL_0028: ldarg.0
IL_0029: call System.String UnityEngine.Object::get_name()
IL_002e: ldstr "/"
IL_0033: callvirt System.Int32 System.String::LastIndexOf(System.String)
IL_0038: ldc.i4.1
IL_0039: add
IL_003a: callvirt System.String System.String::Substring(System.Int32)
IL_003f: ret
IL_0040: ldstr "null"
IL_0045: ret
