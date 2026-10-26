TYPE aUzJnDdLagLcYhSjJnsRTHTqyRC
METHOD System.Void aUzJnDdLagLcYhSjJnsRTHTqyRC::ZXuGbUVrsKcbexFubWFQFBrecCK(Rewired.UpdateLoopType)
IL_0000: ldarg.0
IL_0001: ldfld Rewired.UpdateLoopDataSet`1<aUzJnDdLagLcYhSjJnsRTHTqyRC/AgZXduwKhJeBLroGTcaqPcWBqcb> aUzJnDdLagLcYhSjJnsRTHTqyRC::bAqTiTWZvzFWtDClFRiZvCZRWTy
IL_0006: ldarg.1
IL_0007: callvirt System.Void Rewired.UpdateLoopDataSet`1<aUzJnDdLagLcYhSjJnsRTHTqyRC/AgZXduwKhJeBLroGTcaqPcWBqcb>::SetUpdateLoop(Rewired.UpdateLoopType)
IL_000c: ldc.i4 1728750410
IL_0011: ldc.i4 1728750411
IL_0016: xor
IL_0017: switch IL_003d,IL_002a,IL_000c
IL_0028: br.s IL_003d
IL_002a: ldarg.0
IL_002b: ldc.i4.0
IL_002c: call System.Boolean Rewired.ReInput::IsInputAllowed(Rewired.ControllerType)
IL_0031: stfld System.Boolean aUzJnDdLagLcYhSjJnsRTHTqyRC::MvIqhjWcqJKGilVhFwYrpLvNlhF
IL_0036: ldc.i4 1728750411
IL_003b: br.s IL_0011
IL_003d: ldarg.0
IL_003e: ldfld System.Object aUzJnDdLagLcYhSjJnsRTHTqyRC::TJULmSpaEzfBDdILYlpveRitPere
IL_0043: dup
IL_0044: stloc.3
IL_0045: call System.Void System.Threading.Monitor::Enter(System.Object)
IL_004a: ldc.i4 256
IL_004f: conv.u
IL_0050: localloc
IL_0052: stloc.0
IL_0053: ldc.i4 1728750426
IL_0058: ldc.i4 1728750411
IL_005d: xor
IL_005e: switch IL_0053,IL_01e6,IL_0114,IL_0130,IL_02d6,IL_014d,IL_00b8,IL_0175,IL_023f,IL_0281,IL_0106,IL_01fc,IL_0219,IL_0255,IL_02b3,IL_02c0,IL_026b,IL_0223,IL_01b4,IL_0320
IL_00b3: br IL_0320
IL_00b8: ldarg.0
IL_00b9: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_00be: ldsfld System.IntPtr System.IntPtr::Zero
IL_00c3: stfld System.IntPtr gLUHitzcFKTCpNKHDImJANvTau::DsVJttEHzqCaeJzcUnmXMWAZZzSM
IL_00c8: ldarg.0
IL_00c9: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_00ce: ldloc.1
IL_00cf: stfld Rewired.Libraries.SharpDX.Windows.Forms.Keys gLUHitzcFKTCpNKHDImJANvTau::OOowaFfQjlPRwebHWMjfxUgbaZS
IL_00d4: ldarg.0
IL_00d5: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_00da: ldc.i4.0
IL_00db: stfld System.Int32 gLUHitzcFKTCpNKHDImJANvTau::uKDCDQeydSEYDZcSXFKSFWQQBpNP
IL_00e0: ldarg.0
IL_00e1: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_00e6: ldc.i4.0
IL_00e7: stfld Rewired.Libraries.SharpDX.RawInput.ScanCodeFlags gLUHitzcFKTCpNKHDImJANvTau::tiIiQkoKsHzjNQewpgKlaVgBMrLH
IL_00ec: ldarg.0
IL_00ed: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_00f2: ldc.i4 256
IL_00f7: stfld Rewired.Libraries.SharpDX.RawInput.KeyState gLUHitzcFKTCpNKHDImJANvTau::eLYuuCkzYzSptBvtDOENJLCVmpO
IL_00fc: ldc.i4 1728750427
IL_0101: br IL_0058
IL_0106: ldloc.1
IL_0107: ldc.i4.1
IL_0108: add
IL_0109: stloc.1
IL_010a: ldc.i4 1728750409
IL_010f: br IL_0058
IL_0114: ldloc.1
IL_0115: ldc.i4 256
IL_011a: blt.s IL_0124
IL_011c: ldc.i4 1728750424
IL_0121: dup
IL_0122: br.s IL_012a
IL_0124: ldc.i4 1728750405
IL_0129: dup
IL_012a: pop
IL_012b: br IL_0058
IL_0130: ldloc.s V_4
IL_0132: ldc.i4 131072
IL_0137: bne.un.s IL_0141
IL_0139: ldc.i4 1728750401
IL_013e: dup
IL_013f: br.s IL_0147
IL_0141: ldc.i4 1728750414
IL_0146: dup
IL_0147: pop
IL_0148: br IL_0058
IL_014d: ldloc.0
IL_014e: ldloc.1
IL_014f: add
IL_0150: ldind.u1
IL_0151: ldc.i4 128
IL_0156: and
IL_0157: ldc.i4.0
IL_0158: ceq
IL_015a: ldc.i4.0
IL_015b: ceq
IL_015d: stloc.2
IL_015e: ldloc.2
IL_015f: brtrue.s IL_0169
IL_0161: ldc.i4 1728750412
IL_0166: dup
IL_0167: br.s IL_016f
IL_0169: ldc.i4 1728750425
IL_016e: dup
IL_016f: pop
IL_0170: br IL_0058
IL_0175: ldarg.0
IL_0176: ldfld System.Boolean[] aUzJnDdLagLcYhSjJnsRTHTqyRC::RtGjEhFKwsGJjuBsTiWEHBNCMbZ
IL_017b: ldloc.1
IL_017c: ldelem.i1
IL_017d: brfalse.s IL_0106
IL_017f: ldarg.0
IL_0180: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_0185: callvirt System.Void mrsBGabDvezJXfYZZpPcCwiICVLm::bUCatAZteyOEEqLInHTSFRQUGkE()
IL_018a: ldarg.0
IL_018b: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_0190: call System.Double Rewired.ReInput::get_realTime()
IL_0195: stfld System.Double mrsBGabDvezJXfYZZpPcCwiICVLm::llSwtOPcDDZtoAuJENOJAKUGCLIH
IL_019a: ldarg.0
IL_019b: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_01a0: ldsfld System.IntPtr System.IntPtr::Zero
IL_01a5: stfld System.IntPtr gLUHitzcFKTCpNKHDImJANvTau::DsVJttEHzqCaeJzcUnmXMWAZZzSM
IL_01aa: ldc.i4 1728750406
IL_01af: br IL_0058
IL_01b4: ldarg.0
IL_01b5: ldfld System.Boolean[] aUzJnDdLagLcYhSjJnsRTHTqyRC::RtGjEhFKwsGJjuBsTiWEHBNCMbZ
IL_01ba: ldloc.1
IL_01bb: ldelem.i1
IL_01bc: brtrue IL_0106
IL_01c1: ldarg.0
IL_01c2: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_01c7: callvirt System.Void mrsBGabDvezJXfYZZpPcCwiICVLm::bUCatAZteyOEEqLInHTSFRQUGkE()
IL_01cc: ldarg.0
IL_01cd: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_01d2: call System.Double Rewired.ReInput::get_realTime()
IL_01d7: stfld System.Double mrsBGabDvezJXfYZZpPcCwiICVLm::llSwtOPcDDZtoAuJENOJAKUGCLIH
IL_01dc: ldc.i4 1728750413
IL_01e1: br IL_0058
IL_01e6: ldarg.0
IL_01e7: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_01ec: ldc.i4.1
IL_01ed: stfld Rewired.Libraries.SharpDX.RawInput.ScanCodeFlags gLUHitzcFKTCpNKHDImJANvTau::tiIiQkoKsHzjNQewpgKlaVgBMrLH
IL_01f2: ldc.i4 1728750402
IL_01f7: br IL_0058
IL_01fc: ldloc.s V_4
IL_01fe: ldc.i4 65536
IL_0203: beq.s IL_020d
IL_0205: ldc.i4 1728750408
IL_020a: dup
IL_020b: br.s IL_0213
IL_020d: ldc.i4 1728750401
IL_0212: dup
IL_0213: pop
IL_0214: br IL_0058
IL_0219: ldc.i4 1728750409
IL_021e: br IL_0058
IL_0223: ldloc.0
IL_0224: call System.IntPtr System.IntPtr::op_Explicit(System.Void*)
IL_0229: call System.Boolean SCQmdccoZFRYqcuLYerfHqFUhZX::nvsKlePfQGVLtRnOuRECVBpvcrdB(System.IntPtr)
IL_022e: brfalse IL_0320
IL_0233: ldc.i4.0
IL_0234: stloc.1
IL_0235: ldc.i4 1728750407
IL_023a: br IL_0058
IL_023f: ldarg.0
IL_0240: ldarg.0
IL_0241: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_0246: call System.Void aUzJnDdLagLcYhSjJnsRTHTqyRC::pmEkkkanGSbOAFLCwZTkNgBKQei(gLUHitzcFKTCpNKHDImJANvTau)
IL_024b: ldc.i4 1728750401
IL_0250: br IL_0058
IL_0255: ldarg.0
IL_0256: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_025b: ldloc.1
IL_025c: stfld Rewired.Libraries.SharpDX.Windows.Forms.Keys gLUHitzcFKTCpNKHDImJANvTau::OOowaFfQjlPRwebHWMjfxUgbaZS
IL_0261: ldc.i4 1728750404
IL_0266: br IL_0058
IL_026b: ldarg.0
IL_026c: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_0271: ldc.i4.0
IL_0272: stfld System.Int32 gLUHitzcFKTCpNKHDImJANvTau::gHSrtPAJQZLFRKqPmAclChCCcvO
IL_0277: ldc.i4 1728750403
IL_027c: br IL_0058
IL_0281: ldarg.0
IL_0282: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_0287: ldc.i4 257
IL_028c: stfld Rewired.Libraries.SharpDX.RawInput.KeyState gLUHitzcFKTCpNKHDImJANvTau::eLYuuCkzYzSptBvtDOENJLCVmpO
IL_0291: ldarg.0
IL_0292: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_0297: ldc.i4.0
IL_0298: stfld System.Int32 gLUHitzcFKTCpNKHDImJANvTau::gHSrtPAJQZLFRKqPmAclChCCcvO
IL_029d: ldarg.0
IL_029e: ldarg.0
IL_029f: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_02a4: call System.Void aUzJnDdLagLcYhSjJnsRTHTqyRC::pmEkkkanGSbOAFLCwZTkNgBKQei(gLUHitzcFKTCpNKHDImJANvTau)
IL_02a9: ldc.i4 1728750401
IL_02ae: br IL_0058
IL_02b3: ldloc.1
IL_02b4: stloc.s V_4
IL_02b6: ldc.i4 1728750415
IL_02bb: br IL_0058
IL_02c0: ldarg.0
IL_02c1: ldfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_02c6: ldc.i4.0
IL_02c7: stfld System.Int32 gLUHitzcFKTCpNKHDImJANvTau::uKDCDQeydSEYDZcSXFKSFWQQBpNP
IL_02cc: ldc.i4 1728750410
IL_02d1: br IL_0058
IL_02d6: ldloc.s V_4
IL_02d8: ldc.i4.s 18
IL_02da: bgt IL_01fc
IL_02df: ldloc.s V_4
IL_02e1: ldc.i4.1
IL_02e2: sub
IL_02e3: switch IL_0106,IL_0106,IL_014d,IL_0106,IL_0106,IL_0106
IL_0300: ldloc.s V_4
IL_0302: ldc.i4.s 16
IL_0304: sub
IL_0305: switch IL_0106,IL_0106,IL_0106
IL_0316: ldc.i4 1728750414
IL_031b: br IL_0058
IL_0320: leave.s IL_0325
IL_0322: pop
IL_0323: leave.s IL_0325
IL_0325: leave.s IL_032e
IL_0327: ldloc.3
IL_0328: call System.Void System.Threading.Monitor::Exit(System.Object)
IL_032d: endfinally
IL_032e: ret
