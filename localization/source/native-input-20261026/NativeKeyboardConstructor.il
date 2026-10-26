TYPE aUzJnDdLagLcYhSjJnsRTHTqyRC
METHOD System.Void aUzJnDdLagLcYhSjJnsRTHTqyRC::.ctor(Rewired.Config.UpdateLoopSetting)
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Object::.ctor()
IL_0006: stfld System.Object aUzJnDdLagLcYhSjJnsRTHTqyRC::TJULmSpaEzfBDdILYlpveRitPere
IL_000b: ldarg.0
IL_000c: ldc.i4 256
IL_0011: newarr System.Boolean
IL_0016: stfld System.Boolean[] aUzJnDdLagLcYhSjJnsRTHTqyRC::RtGjEhFKwsGJjuBsTiWEHBNCMbZ
IL_001b: ldarg.0
IL_001c: newobj System.Void gLUHitzcFKTCpNKHDImJANvTau::.ctor()
IL_0021: stfld gLUHitzcFKTCpNKHDImJANvTau aUzJnDdLagLcYhSjJnsRTHTqyRC::PYfhXWJoMKrJuaIjASqokBupVQl
IL_0026: ldarg.0
IL_0027: call System.Void System.Object::.ctor()
IL_002c: ldarg.0
IL_002d: call System.Int32 aUzJnDdLagLcYhSjJnsRTHTqyRC::ZWLCbxwnNMtPkZRcOwNGcfgiVLb()
IL_0032: pop
IL_0033: ldarg.0
IL_0034: ldarg.1
IL_0035: newobj System.Void Rewired.UpdateLoopDataSet`1<aUzJnDdLagLcYhSjJnsRTHTqyRC/AgZXduwKhJeBLroGTcaqPcWBqcb>::.ctor(Rewired.Config.UpdateLoopSetting)
IL_003a: stfld Rewired.UpdateLoopDataSet`1<aUzJnDdLagLcYhSjJnsRTHTqyRC/AgZXduwKhJeBLroGTcaqPcWBqcb> aUzJnDdLagLcYhSjJnsRTHTqyRC::bAqTiTWZvzFWtDClFRiZvCZRWTy
IL_003f: ldc.i4.3
IL_0040: call Rewired.Utils.TempListPool/TList`1<!!0> Rewired.Utils.TempListPool::GetTList<Rewired.UpdateLoopType>(System.Int32)
IL_0045: stloc.0
IL_0046: ldloc.0
IL_0047: callvirt System.Collections.Generic.List`1<!0> Rewired.Utils.TempListPool/TList`1<Rewired.UpdateLoopType>::get_list()
IL_004c: stloc.1
IL_004d: ldarg.1
IL_004e: ldloc.1
IL_004f: call System.Int32 Rewired.EnumConverter::ToUpdateLoopTypes(Rewired.Config.UpdateLoopSetting,System.Collections.Generic.List`1<Rewired.UpdateLoopType>)
IL_0054: pop
IL_0055: ldc.i4.0
IL_0056: stloc.2
IL_0057: br.s IL_0075
IL_0059: ldarg.0
IL_005a: ldfld Rewired.UpdateLoopDataSet`1<aUzJnDdLagLcYhSjJnsRTHTqyRC/AgZXduwKhJeBLroGTcaqPcWBqcb> aUzJnDdLagLcYhSjJnsRTHTqyRC::bAqTiTWZvzFWtDClFRiZvCZRWTy
IL_005f: ldloc.2
IL_0060: ldloc.1
IL_0061: ldloc.2
IL_0062: callvirt !0 System.Collections.Generic.List`1<Rewired.UpdateLoopType>::get_Item(System.Int32)
IL_0067: newobj System.Void aUzJnDdLagLcYhSjJnsRTHTqyRC/AgZXduwKhJeBLroGTcaqPcWBqcb::.ctor(Rewired.UpdateLoopType)
IL_006c: callvirt System.Void Rewired.UpdateLoopDataSet`1<aUzJnDdLagLcYhSjJnsRTHTqyRC/AgZXduwKhJeBLroGTcaqPcWBqcb>::set_Item(System.Int32,!0)
IL_0071: ldloc.2
IL_0072: ldc.i4.1
IL_0073: add
IL_0074: stloc.2
IL_0075: ldloc.2
IL_0076: ldloc.1
IL_0077: callvirt System.Int32 System.Collections.Generic.List`1<Rewired.UpdateLoopType>::get_Count()
IL_007c: blt.s IL_0059
IL_007e: leave.s IL_008a
IL_0080: ldloc.0
IL_0081: brfalse.s IL_0089
IL_0083: ldloc.0
IL_0084: callvirt System.Void System.IDisposable::Dispose()
IL_0089: endfinally
IL_008a: ldarg.0
IL_008b: ldc.i4.0
IL_008c: call System.Boolean Rewired.ReInput::IsInputAllowed(Rewired.ControllerType)
IL_0091: stfld System.Boolean aUzJnDdLagLcYhSjJnsRTHTqyRC::MvIqhjWcqJKGilVhFwYrpLvNlhF
IL_0096: ldarg.0
IL_0097: ldftn System.Void aUzJnDdLagLcYhSjJnsRTHTqyRC::LZNsKbwPVvFAFBxJJeiWdfNIrzhN(System.Boolean)
IL_009d: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_00a2: call System.Void Rewired.ReInput::add_ApplicationFocusChangedEvent(System.Action`1<System.Boolean>)
IL_00a7: ldarg.0
IL_00a8: ldftn System.Void aUzJnDdLagLcYhSjJnsRTHTqyRC::QkzeJZWvGHLRYCEiDSlZOeCXSQy(System.Boolean)
IL_00ae: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_00b3: call System.Void Rewired.ReInput::add_EditorPauseChangedEvent(System.Action`1<System.Boolean>)
IL_00b8: ldarg.0
IL_00b9: ldftn System.Void aUzJnDdLagLcYhSjJnsRTHTqyRC::vPPOnUQLTRWeWzUXSqMEBOQOkgF(Rewired.UpdateLoopType)
IL_00bf: newobj System.Void System.Action`1<Rewired.UpdateLoopType>::.ctor(System.Object,System.IntPtr)
IL_00c4: call System.Void Rewired.ReInput::add_UpdateEndedEvent(System.Action`1<Rewired.UpdateLoopType>)
IL_00c9: ldarg.0
IL_00ca: ldftn System.Void aUzJnDdLagLcYhSjJnsRTHTqyRC::mrvVtJKrfRVHdtknvAbDkiHchja(System.Boolean)
IL_00d0: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_00d5: call System.Void Rewired.ReInput::add_TimeScalePauseChangedEvent(System.Action`1<System.Boolean>)
IL_00da: ret
METHOD Rewired.InputSource aUzJnDdLagLcYhSjJnsRTHTqyRC::get_inputSource()
IL_0000: ldc.i4.5
IL_0001: ret
