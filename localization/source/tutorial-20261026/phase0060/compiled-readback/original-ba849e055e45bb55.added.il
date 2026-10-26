METHOD System.Void ForestProbe::ReadBuckyRecords(ForestProbe/State) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.1
IL_0002: ldarg.0
IL_0003: ldfld ForestProbe/Bucky212End ForestProbe::bucky212End
IL_0008: brfalse.s IL_0017
IL_000a: ldarg.0
IL_000b: ldfld ForestProbe/Bucky212End ForestProbe::bucky212End
IL_0010: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_0015: br.s IL_001c
IL_0017: ldstr ""
IL_001c: stfld System.String ForestProbe/State::bucky212EndRecord
IL_0021: ldarg.1
IL_0022: ldfld System.Boolean ForestProbe/State::conversationActive
IL_0027: brfalse.s IL_003b
IL_0029: ldarg.1
IL_002a: ldfld System.Int32 ForestProbe/State::conversationId
IL_002f: ldc.i4 141
IL_0034: ceq
IL_0036: ldc.i4.0
IL_0037: ceq
IL_0039: br.s IL_003c
IL_003b: ldc.i4.1
IL_003c: stloc.0
IL_003d: ldloc.0
IL_003e: brfalse.s IL_0042
IL_0040: br.s IL_00b8
IL_0042: nop
IL_0043: nop
IL_0044: ldarg.1
IL_0045: ldarg.0
IL_0046: call ForestProbe/Bucky141Subtitle ForestProbe::ReadBucky141()
IL_004b: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_0050: stfld System.String ForestProbe/State::bucky141Record
IL_0055: ldarg.1
IL_0056: ldfld System.Int32 ForestProbe/State::entryId
IL_005b: ldc.i4 215
IL_0060: bne.un.s IL_007a
IL_0062: ldarg.1
IL_0063: ldfld System.Boolean ForestProbe/State::typing
IL_0068: brtrue.s IL_007a
IL_006a: ldarg.0
IL_006b: call System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_0070: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_0075: ldc.i4.0
IL_0076: cgt.un
IL_0078: br.s IL_007b
IL_007a: ldc.i4.0
IL_007b: stloc.1
IL_007c: ldloc.1
IL_007d: brfalse.s IL_0094
IL_007f: nop
IL_0080: ldarg.1
IL_0081: ldarg.0
IL_0082: ldloca.s V_2
IL_0084: call ForestProbe/Bucky217Selection ForestProbe::ReadBucky217(UnityEngine.UI.Button&)
IL_0089: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_008e: stfld System.String ForestProbe/State::bucky217Record
IL_0093: nop
IL_0094: nop
IL_0095: leave.s IL_00b8
IL_0097: stloc.3
IL_0098: nop
IL_0099: ldarg.1
IL_009a: newobj System.Void ForestProbe/Tutorial181Rejection::.ctor()
IL_009f: dup
IL_00a0: ldloc.3
IL_00a1: callvirt System.String System.Exception::get_Message()
IL_00a6: stfld System.String ForestProbe/Tutorial181Rejection::error
IL_00ab: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_00b0: stfld System.String ForestProbe/State::bucky141Record
IL_00b5: nop
IL_00b6: leave.s IL_00b8
IL_00b8: ret
