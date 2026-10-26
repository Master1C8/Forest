METHOD System.Void ForestProbe::ObserveBucky212End(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.Boolean ForestProbe::bucky217Selected
IL_0007: brfalse.s IL_001f
IL_0009: ldarg.3
IL_000a: ldc.i4 141
IL_000f: bne.un.s IL_001f
IL_0011: ldarg.s entryId
IL_0013: ldc.i4 212
IL_0018: ceq
IL_001a: ldc.i4.0
IL_001b: ceq
IL_001d: br.s IL_0020
IL_001f: ldc.i4.1
IL_0020: stloc.0
IL_0021: ldloc.0
IL_0022: brfalse.s IL_0026
IL_0024: br.s IL_00a0
IL_0026: ldarg.0
IL_0027: newobj System.Void ForestProbe/Bucky212End::.ctor()
IL_002c: dup
IL_002d: ldarg.1
IL_002e: brfalse.s IL_0038
IL_0030: ldarg.1
IL_0031: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0036: br.s IL_003d
IL_0038: ldstr ""
IL_003d: stfld System.String ForestProbe/Bucky212End::dbName
IL_0042: dup
IL_0043: ldarg.2
IL_0044: brfalse.s IL_004e
IL_0046: ldarg.2
IL_0047: ldfld System.String TheForestOfLove.Narrative.Arc::pluginDbSuffix
IL_004c: br.s IL_0053
IL_004e: ldstr ""
IL_0053: stfld System.String ForestProbe/Bucky212End::arc
IL_0058: dup
IL_0059: ldarg.3
IL_005a: stfld System.Int32 ForestProbe/Bucky212End::conversationId
IL_005f: dup
IL_0060: ldarg.s entryId
IL_0062: stfld System.Int32 ForestProbe/Bucky212End::entryId
IL_0067: dup
IL_0068: call System.Int32 UnityEngine.Time::get_frameCount()
IL_006d: stfld System.Int32 ForestProbe/Bucky212End::frame
IL_0072: dup
IL_0073: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0078: stfld System.Single ForestProbe/Bucky212End::realtime
IL_007d: dup
IL_007e: ldarg.0
IL_007f: ldfld ForestProbe/Bucky212End ForestProbe::bucky212End
IL_0084: brfalse.s IL_0095
IL_0086: ldarg.0
IL_0087: ldfld ForestProbe/Bucky212End ForestProbe::bucky212End
IL_008c: ldfld System.Int32 ForestProbe/Bucky212End::count
IL_0091: ldc.i4.1
IL_0092: add
IL_0093: br.s IL_0096
IL_0095: ldc.i4.1
IL_0096: stfld System.Int32 ForestProbe/Bucky212End::count
IL_009b: stfld ForestProbe/Bucky212End ForestProbe::bucky212End
IL_00a0: ret
