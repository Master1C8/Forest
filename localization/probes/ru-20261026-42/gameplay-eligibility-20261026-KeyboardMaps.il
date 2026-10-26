TYPE Rewired.Player/ControllerHelper/MapHelper
METHOD System.Collections.Generic.IEnumerable`1<Rewired.ControllerMap> Rewired.Player/ControllerHelper/MapHelper::GetAllMaps()
IL_0000: ldc.i4.s -2
IL_0002: newobj System.Void Rewired.Player/ControllerHelper/MapHelper/gODtbUQNyxERNdFoRRowLgBSBXS::.ctor(System.Int32)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: ldarg.0
IL_000a: stfld Rewired.Player/ControllerHelper/MapHelper Rewired.Player/ControllerHelper/MapHelper/gODtbUQNyxERNdFoRRowLgBSBXS::TiaUIShtPVkFOKyDFxywSfPUjyv
IL_000f: ldloc.0
IL_0010: ret
METHOD System.Int32 Rewired.Player/ControllerHelper/MapHelper::GetAllMaps(System.Collections.Generic.List`1<Rewired.ControllerMap>)
IL_0000: ldsfld System.Int32 Rewired.ReInput::_id
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 Rewired.Player/ControllerHelper/MapHelper::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_000b: beq.s IL_001b
IL_000d: ldarg.0
IL_000e: ldfld System.Int32 Rewired.Player/ControllerHelper/MapHelper::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_0013: call System.Boolean Rewired.ReInput::CheckInitialized(System.Int32)
IL_0018: pop
IL_0019: ldc.i4.0
IL_001a: ret
IL_001b: ldarg.1
IL_001c: brtrue.s IL_0053
IL_001e: ldstr "results"
IL_0023: newobj System.Void System.ArgumentNullException::.ctor(System.String)
IL_0028: throw
IL_0029: ldc.i4 -1376758001
IL_002e: ldc.i4 -1376758005
IL_0033: xor
IL_0034: switch IL_0095,IL_00bb,IL_0029,IL_0073,IL_0053,IL_00ce
IL_0051: br.s IL_00ce
IL_0053: ldarg.1
IL_0054: callvirt System.Void System.Collections.Generic.List`1<Rewired.ControllerMap>::Clear()
IL_0059: ldarg.0
IL_005a: ldfld Rewired.Player/ControllerHelper Rewired.Player/ControllerHelper/MapHelper::nJZnacDXVTOsqnobcffKkqOOwqe
IL_005f: ldfld Rewired.Player/ControllerHelper/PoqTwqALEubeEdjyHFcjjusivmU Rewired.Player/ControllerHelper::LHQNIDATKjxsDbGgpujVToVWSF
IL_0064: ldfld System.Int32 Rewired.Player/ControllerHelper/PoqTwqALEubeEdjyHFcjjusivmU::tqHsLGmqtOxduYyQHOvGjaXlSkF
IL_0069: stloc.0
IL_006a: ldc.i4.0
IL_006b: stloc.1
IL_006c: ldc.i4 -1376758002
IL_0071: br.s IL_002e
IL_0073: ldloc.2
IL_0074: ldloc.s V_4
IL_0076: callvirt Rewired.Player/ControllerHelper/MoZkoZkKhznTmuGorbHzCQGmFGzG Rewired.Player/ControllerHelper/HufIdBLDKJNxiYLrNEspsgeFclu::get_Item(System.Int32)
IL_007b: callvirt TwStiFJMlKlmQTGKcAnOGuzJsTzT Rewired.Player/ControllerHelper/MoZkoZkKhznTmuGorbHzCQGmFGzG::get_mapSet()
IL_0080: ldarg.1
IL_0081: ldc.i4.1
IL_0082: callvirt System.Int32 TwStiFJMlKlmQTGKcAnOGuzJsTzT::vBOEJWVtkUXalfiHrsfnflwQPxq(System.Collections.Generic.List`1<Rewired.ControllerMap>,System.Boolean)
IL_0087: pop
IL_0088: ldloc.s V_4
IL_008a: ldc.i4.1
IL_008b: add
IL_008c: stloc.s V_4
IL_008e: ldc.i4 -1376758006
IL_0093: br.s IL_002e
IL_0095: ldarg.0
IL_0096: ldfld Rewired.Player/ControllerHelper Rewired.Player/ControllerHelper/MapHelper::nJZnacDXVTOsqnobcffKkqOOwqe
IL_009b: ldfld Rewired.Player/ControllerHelper/PoqTwqALEubeEdjyHFcjjusivmU Rewired.Player/ControllerHelper::LHQNIDATKjxsDbGgpujVToVWSF
IL_00a0: ldloc.1
IL_00a1: callvirt Rewired.Player/ControllerHelper/HufIdBLDKJNxiYLrNEspsgeFclu Rewired.Player/ControllerHelper/PoqTwqALEubeEdjyHFcjjusivmU::abwryKHsFVCHxCCyKTotDhHpBEZ(System.Int32)
IL_00a6: stloc.2
IL_00a7: ldloc.2
IL_00a8: callvirt System.Int32 Rewired.Player/ControllerHelper/HufIdBLDKJNxiYLrNEspsgeFclu::get_Count()
IL_00ad: stloc.3
IL_00ae: ldc.i4.0
IL_00af: stloc.s V_4
IL_00b1: ldc.i4 -1376758006
IL_00b6: br IL_002e
IL_00bb: ldloc.s V_4
IL_00bd: ldloc.3
IL_00be: blt.s IL_0073
IL_00c0: ldloc.1
IL_00c1: ldc.i4.1
IL_00c2: add
IL_00c3: stloc.1
IL_00c4: ldc.i4 -1376758002
IL_00c9: br IL_002e
IL_00ce: ldloc.1
IL_00cf: ldloc.0
IL_00d0: blt.s IL_0095
IL_00d2: ldarg.1
IL_00d3: callvirt System.Int32 System.Collections.Generic.List`1<Rewired.ControllerMap>::get_Count()
IL_00d8: ret
METHOD System.Collections.Generic.IEnumerable`1<T> Rewired.Player/ControllerHelper/MapHelper::GetAllMaps()
IL_0000: ldc.i4.s -2
IL_0002: newobj System.Void Rewired.Player/ControllerHelper/MapHelper/RwpxwiWXwopgrDaNVEdVrcIHDSP<T>::.ctor(System.Int32)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: ldarg.0
IL_000a: stfld Rewired.Player/ControllerHelper/MapHelper Rewired.Player/ControllerHelper/MapHelper/RwpxwiWXwopgrDaNVEdVrcIHDSP<T>::TiaUIShtPVkFOKyDFxywSfPUjyv
IL_000f: ldloc.0
IL_0010: ret
METHOD System.Int32 Rewired.Player/ControllerHelper/MapHelper::GetAllMaps(System.Collections.Generic.List`1<T>)
IL_0000: ldsfld System.Int32 Rewired.ReInput::_id
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 Rewired.Player/ControllerHelper/MapHelper::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_000b: beq IL_0109
IL_0010: ldc.i4 1319663799
IL_0015: ldc.i4 1319663797
IL_001a: xor
IL_001b: switch IL_0010,IL_009e,IL_0189,IL_0120,IL_0107,IL_0153,IL_00f9,IL_019f,IL_01c6,IL_0077,IL_0163,IL_0090,IL_00df,IL_006d,IL_01d0,IL_01ea,IL_0135,IL_00ab
IL_0068: br IL_01ea
IL_006d: ldc.i4.0
IL_006e: stloc.s V_8
IL_0070: ldc.i4 1319663801
IL_0075: br.s IL_0015
IL_0077: ldarg.0
IL_0078: ldfld Rewired.Player/ControllerHelper Rewired.Player/ControllerHelper/MapHelper::nJZnacDXVTOsqnobcffKkqOOwqe
IL_007d: ldfld Rewired.Player/ControllerHelper/PoqTwqALEubeEdjyHFcjjusivmU Rewired.Player/ControllerHelper::LHQNIDATKjxsDbGgpujVToVWSF
IL_0082: ldfld System.Int32 Rewired.Player/ControllerHelper/PoqTwqALEubeEdjyHFcjjusivmU::tqHsLGmqtOxduYyQHOvGjaXlSkF
IL_0087: stloc.s V_4
IL_0089: ldc.i4 1319663796
IL_008e: br.s IL_0015
IL_0090: ldloc.3
IL_0091: ldc.i4.1
IL_0092: add
IL_0093: stloc.3
IL_0094: ldc.i4 1319663795
IL_0099: br IL_0015
IL_009e: ldc.i4.0
IL_009f: stloc.s V_5
IL_00a1: ldc.i4 1319663803
IL_00a6: br IL_0015
IL_00ab: ldarg.1
IL_00ac: callvirt System.Void System.Collections.Generic.List`1<T>::Clear()
IL_00b1: ldloca.s V_0
IL_00b3: call System.Boolean OazowIVyVJjdLfSKtwolkfEQvoW::rHHQtwSqCqyPjKVJvhsPHlzHEhn<T>(Rewired.ControllerType&)
IL_00b8: brfalse.s IL_0077
IL_00ba: ldarg.0
IL_00bb: ldfld Rewired.Player/ControllerHelper Rewired.Player/ControllerHelper/MapHelper::nJZnacDXVTOsqnobcffKkqOOwqe
IL_00c0: ldfld Rewired.Player/ControllerHelper/PoqTwqALEubeEdjyHFcjjusivmU Rewired.Player/ControllerHelper::LHQNIDATKjxsDbGgpujVToVWSF
IL_00c5: ldloc.0
IL_00c6: callvirt Rewired.Player/ControllerHelper/HufIdBLDKJNxiYLrNEspsgeFclu Rewired.Player/ControllerHelper/PoqTwqALEubeEdjyHFcjjusivmU::ekQcglwEnwkUZhNGPjDNHFwrfTvK(Rewired.ControllerType)
IL_00cb: stloc.1
IL_00cc: ldloc.1
IL_00cd: callvirt System.Int32 Rewired.Player/ControllerHelper/HufIdBLDKJNxiYLrNEspsgeFclu::get_Count()
IL_00d2: stloc.2
IL_00d3: ldc.i4.0
IL_00d4: stloc.3
IL_00d5: ldc.i4 1319663805
IL_00da: br IL_0015
IL_00df: ldloc.s V_8
IL_00e1: ldloc.s V_7
IL_00e3: blt.s IL_00ed
IL_00e5: ldc.i4 1319663792
IL_00ea: dup
IL_00eb: br.s IL_00f3
IL_00ed: ldc.i4 1319663807
IL_00f2: dup
IL_00f3: pop
IL_00f4: br IL_0015
IL_00f9: ldloc.3
IL_00fa: ldloc.2
IL_00fb: blt.s IL_0135
IL_00fd: ldc.i4 1319663802
IL_0102: br IL_0015
IL_0107: ldc.i4.0
IL_0108: ret
IL_0109: ldarg.1
IL_010a: brfalse.s IL_0114
IL_010c: ldc.i4 1319663780
IL_0111: dup
IL_0112: br.s IL_011a
IL_0114: ldc.i4 1319663798
IL_0119: dup
IL_011a: pop
IL_011b: br IL_0015
IL_0120: ldstr "results"
IL_0125: newobj System.Void System.ArgumentNullException::.ctor(System.String)
IL_012a: throw
IL_012b: ldc.i4 1319663780
IL_0130: br IL_0015
IL_0135: ldloc.1
IL_0136: ldloc.3
IL_0137: callvirt Rewired.Player/ControllerHelper/MoZkoZkKhznTmuGorbHzCQGmFGzG Rewired.Player/ControllerHelper/HufIdBLDKJNxiYLrNEspsgeFclu::get_Item(System.Int32)
IL_013c: callvirt TwStiFJMlKlmQTGKcAnOGuzJsTzT Rewired.Player/ControllerHelper/MoZkoZkKhznTmuGorbHzCQGmFGzG::get_mapSet()
IL_0141: ldarg.1
IL_0142: ldc.i4.1
IL_0143: callvirt System.Int32 TwStiFJMlKlmQTGKcAnOGuzJsTzT::vBOEJWVtkUXalfiHrsfnflwQPxq<T>(System.Collections.Generic.List`1<T>,System.Boolean)
IL_0148: pop
IL_0149: ldc.i4 1319663806
IL_014e: br IL_0015
IL_0153: ldloc.s V_5
IL_0155: ldc.i4.1
IL_0156: add
IL_0157: stloc.s V_5
IL_0159: ldc.i4 1319663803
IL_015e: br IL_0015
IL_0163: ldloc.s V_6
IL_0165: ldloc.s V_8
IL_0167: callvirt Rewired.Player/ControllerHelper/MoZkoZkKhznTmuGorbHzCQGmFGzG Rewired.Player/ControllerHelper/HufIdBLDKJNxiYLrNEspsgeFclu::get_Item(System.Int32)
IL_016c: callvirt TwStiFJMlKlmQTGKcAnOGuzJsTzT Rewired.Player/ControllerHelper/MoZkoZkKhznTmuGorbHzCQGmFGzG::get_mapSet()
IL_0171: ldarg.1
IL_0172: ldc.i4.1
IL_0173: callvirt System.Int32 TwStiFJMlKlmQTGKcAnOGuzJsTzT::vBOEJWVtkUXalfiHrsfnflwQPxq<T>(System.Collections.Generic.List`1<T>,System.Boolean)
IL_0178: pop
IL_0179: ldloc.s V_8
IL_017b: ldc.i4.1
IL_017c: add
IL_017d: stloc.s V_8
IL_017f: ldc.i4 1319663801
IL_0184: br IL_0015
IL_0189: ldarg.0
IL_018a: ldfld System.Int32 Rewired.Player/ControllerHelper/MapHelper::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_018f: call System.Boolean Rewired.ReInput::CheckInitialized(System.Int32)
IL_0194: pop
IL_0195: ldc.i4 1319663793
IL_019a: br IL_0015
IL_019f: ldarg.0
IL_01a0: ldfld Rewired.Player/ControllerHelper Rewired.Player/ControllerHelper/MapHelper::nJZnacDXVTOsqnobcffKkqOOwqe
IL_01a5: ldfld Rewired.Player/ControllerHelper/PoqTwqALEubeEdjyHFcjjusivmU Rewired.Player/ControllerHelper::LHQNIDATKjxsDbGgpujVToVWSF
IL_01aa: ldloc.s V_5
IL_01ac: callvirt Rewired.Player/ControllerHelper/HufIdBLDKJNxiYLrNEspsgeFclu Rewired.Player/ControllerHelper/PoqTwqALEubeEdjyHFcjjusivmU::abwryKHsFVCHxCCyKTotDhHpBEZ(System.Int32)
IL_01b1: stloc.s V_6
IL_01b3: ldloc.s V_6
IL_01b5: callvirt System.Int32 Rewired.Player/ControllerHelper/HufIdBLDKJNxiYLrNEspsgeFclu::get_Count()
IL_01ba: stloc.s V_7
IL_01bc: ldc.i4 1319663800
IL_01c1: br IL_0015
IL_01c6: ldc.i4 1319663795
IL_01cb: br IL_0015
IL_01d0: ldloc.s V_5
IL_01d2: ldloc.s V_4
IL_01d4: blt.s IL_01de
IL_01d6: ldc.i4 1319663802
IL_01db: dup
IL_01dc: br.s IL_01e4
IL_01de: ldc.i4 1319663794
IL_01e3: dup
IL_01e4: pop
IL_01e5: br IL_0015
IL_01ea: ldarg.1
IL_01eb: callvirt System.Int32 System.Collections.Generic.List`1<T>::get_Count()
IL_01f0: ret
METHOD System.Collections.Generic.IEnumerable`1<Rewired.ControllerMap> Rewired.Player/ControllerHelper/MapHelper::GetAllMaps(Rewired.ControllerType)
IL_0000: ldc.i4.s -2
IL_0002: newobj System.Void Rewired.Player/ControllerHelper/MapHelper/yvtMLgqhSABcamdBxBRhiFddGugS::.ctor(System.Int32)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: ldarg.0
IL_000a: stfld Rewired.Player/ControllerHelper/MapHelper Rewired.Player/ControllerHelper/MapHelper/yvtMLgqhSABcamdBxBRhiFddGugS::TiaUIShtPVkFOKyDFxywSfPUjyv
IL_000f: ldloc.0
IL_0010: ldarg.1
IL_0011: stfld Rewired.ControllerType Rewired.Player/ControllerHelper/MapHelper/yvtMLgqhSABcamdBxBRhiFddGugS::gPwETarVLHKJFjqekOPeZTcuPXI
IL_0016: ldloc.0
IL_0017: ret
METHOD System.Int32 Rewired.Player/ControllerHelper/MapHelper::GetAllMaps(Rewired.ControllerType,System.Collections.Generic.List`1<Rewired.ControllerMap>)
IL_0000: ldsfld System.Int32 Rewired.ReInput::_id
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 Rewired.Player/ControllerHelper/MapHelper::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_000b: beq.s IL_001b
IL_000d: ldarg.0
IL_000e: ldfld System.Int32 Rewired.Player/ControllerHelper/MapHelper::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_0013: call System.Boolean Rewired.ReInput::CheckInitialized(System.Int32)
IL_0018: pop
IL_0019: ldc.i4.0
IL_001a: ret
IL_001b: ldarg.2
IL_001c: brtrue.s IL_0058
IL_001e: ldc.i4 -474384108
IL_0023: ldc.i4 -474384107
IL_0028: xor
IL_0029: switch IL_0048,IL_0077,IL_001e,IL_0089,IL_00ab,IL_0058
IL_0046: br.s IL_00ab
IL_0048: ldloc.0
IL_0049: callvirt System.Int32 Rewired.Player/ControllerHelper/HufIdBLDKJNxiYLrNEspsgeFclu::get_Count()
IL_004e: stloc.1
IL_004f: ldc.i4.0
IL_0050: stloc.2
IL_0051: ldc.i4 -474384111
IL_0056: br.s IL_0023
IL_0058: ldarg.2
IL_0059: callvirt System.Void System.Collections.Generic.List`1<Rewired.ControllerMap>::Clear()
IL_005e: ldarg.0
IL_005f: ldfld Rewired.Player/ControllerHelper Rewired.Player/ControllerHelper/MapHelper::nJZnacDXVTOsqnobcffKkqOOwqe
IL_0064: ldfld Rewired.Player/ControllerHelper/PoqTwqALEubeEdjyHFcjjusivmU Rewired.Player/ControllerHelper::LHQNIDATKjxsDbGgpujVToVWSF
IL_0069: ldarg.1
IL_006a: callvirt Rewired.Player/ControllerHelper/HufIdBLDKJNxiYLrNEspsgeFclu Rewired.Player/ControllerHelper/PoqTwqALEubeEdjyHFcjjusivmU::ekQcglwEnwkUZhNGPjDNHFwrfTvK(Rewired.ControllerType)
IL_006f: stloc.0
IL_0070: ldc.i4 -474384107
IL_0075: br.s IL_0023
IL_0077: ldstr "results"
IL_007c: newobj System.Void System.ArgumentNullException::.ctor(System.String)
IL_0081: throw
IL_0082: ldc.i4 -474384112
IL_0087: br.s IL_0023
IL_0089: ldloc.0
IL_008a: ldloc.2
IL_008b: callvirt Rewired.Player/ControllerHelper/MoZkoZkKhznTmuGorbHzCQGmFGzG Rewired.Player/ControllerHelper/HufIdBLDKJNxiYLrNEspsgeFclu::get_Item(System.Int32)
IL_0090: callvirt TwStiFJMlKlmQTGKcAnOGuzJsTzT Rewired.Player/ControllerHelper/MoZkoZkKhznTmuGorbHzCQGmFGzG::get_mapSet()
IL_0095: ldarg.2
IL_0096: ldc.i4.1
IL_0097: callvirt System.Int32 TwStiFJMlKlmQTGKcAnOGuzJsTzT::vBOEJWVtkUXalfiHrsfnflwQPxq(System.Collections.Generic.List`1<Rewired.ControllerMap>,System.Boolean)
IL_009c: pop
IL_009d: ldloc.2
IL_009e: ldc.i4.1
IL_009f: add
IL_00a0: stloc.2
IL_00a1: ldc.i4 -474384111
IL_00a6: br IL_0023
IL_00ab: ldloc.2
IL_00ac: ldloc.1
IL_00ad: blt.s IL_0089
IL_00af: ldarg.2
IL_00b0: callvirt System.Int32 System.Collections.Generic.List`1<Rewired.ControllerMap>::get_Count()
IL_00b5: ret
