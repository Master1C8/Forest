TYPE Rewired.ReInput
METHOD System.Void Rewired.ReInput::nKQbCtkHPOPnqlOqEQhEesshditg(Rewired.InputManager_Base,System.Func`2<Rewired.Data.ConfigVars,System.Object>,Rewired.Data.ConfigVars,Rewired.Data.ControllerDataFiles,Rewired.Data.UserData) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Int32 Rewired.ReInput::udFCAbnzHWbsOecnXuffHfHmmoh
IL_0005: stsfld System.Int32 Rewired.ReInput::_id
IL_000a: ldsfld System.Int32 Rewired.ReInput::udFCAbnzHWbsOecnXuffHfHmmoh
IL_000f: ldc.i4.1
IL_0010: add
IL_0011: stsfld System.Int32 Rewired.ReInput::udFCAbnzHWbsOecnXuffHfHmmoh
IL_0016: ldc.i4 -1184401375
IL_001b: ldc.i4 -1184401376
IL_0020: xor
IL_0021: switch IL_02be,IL_0254,IL_03e9,IL_0108,IL_02de,IL_027a,IL_00ad,IL_02cd,IL_026a,IL_019f,IL_0161,IL_0093,IL_03af,IL_033f,IL_0016,IL_00cd,IL_03c0,IL_01dc,IL_017b,IL_021b,IL_01af,IL_02a3,IL_01f0,IL_0136,IL_00eb,IL_0236
IL_008e: br IL_03e9
IL_0093: ldarg.2
IL_0094: stsfld Rewired.Data.ConfigVars Rewired.ReInput::OJxXokxjIIFupQczlCnOgNGVMwNT
IL_0099: call Rewired.Platforms.Platform Rewired.Utils.UnityTools::get_platform()
IL_009e: stsfld Rewired.Platforms.Platform Rewired.ReInput::eWhZzsSgwWjRIKLlVSaybvDfHuf
IL_00a3: ldc.i4 -1184401361
IL_00a8: br IL_001b
IL_00ad: call Rewired.Utils.Interfaces.IExternalTools Rewired.Utils.UnityTools::get_externalTools()
IL_00b2: ldnull
IL_00b3: ldftn System.Void Rewired.ReInput::esyGTdijJGjaJEUlApXivBSuPVG(System.Boolean)
IL_00b9: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_00be: callvirt System.Void Rewired.Utils.Interfaces.IExternalTools::add_EditorPausedStateChangedEvent(System.Action`1<System.Boolean>)
IL_00c3: ldc.i4 -1184401368
IL_00c8: br IL_001b
IL_00cd: call Rewired.Platforms.WebplayerPlatform Rewired.Utils.UnityTools::get_webplayerPlatform()
IL_00d2: stsfld Rewired.Platforms.WebplayerPlatform Rewired.ReInput::IGPMXAYNVLCwoLQnyhpjGNBMIbR
IL_00d7: call Rewired.Platforms.EditorPlatform Rewired.Utils.UnityTools::get_editorPlatform()
IL_00dc: stsfld Rewired.Platforms.EditorPlatform Rewired.ReInput::oPUAJMywrLEmBbqmOIkACwccdcP
IL_00e1: ldc.i4 -1184401355
IL_00e6: br IL_001b
IL_00eb: ldc.r8 1
IL_00f4: newobj System.Void Rewired.Utils.Classes.Utility.TimerAbs::.ctor(System.Double)
IL_00f9: stsfld Rewired.Utils.Classes.Utility.TimerAbs Rewired.ReInput::JOBvZCwcejLmepHDIGBbiGtkzuC
IL_00fe: ldc.i4 -1184401353
IL_0103: br IL_001b
IL_0108: call System.Void Rewired.ThreadSafeUnityInput::Initialize()
IL_010d: newobj System.Void Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::.ctor()
IL_0112: stsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0117: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_011c: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QBAmVSgbZBPmppTHWYNgMiDCmXg
IL_0121: ldsfld System.Boolean Rewired.ReInput::cbmmwJPDGUhXqzzdtJQPbNHADIB
IL_0126: callvirt System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::Set(T)
IL_012b: pop
IL_012c: ldc.i4 -1184401372
IL_0131: br IL_001b
IL_0136: newobj System.Void Rewired.ReInput/boJgboDXhtOpkFRaIkAocTQCligw::.ctor()
IL_013b: stsfld Rewired.ReInput/boJgboDXhtOpkFRaIkAocTQCligw Rewired.ReInput::WCBgQMGSpRhxzDiVYlIVPBjukCy
IL_0140: ldarg.1
IL_0141: call System.Void Rewired.ReInput::AmwdgMKuSHccvLAvSffEwbeJQAxa(System.Func`2<Rewired.Data.ConfigVars,System.Object>)
IL_0146: ldarg.s 
IL_0148: callvirt System.Collections.Generic.List`1<Rewired.InputAction> Rewired.Data.UserData::GetActions_Copy()
IL_014d: newobj System.Void tmYKYJtivFZNMMdFSwUqjsavhHY::.ctor(System.Collections.Generic.List`1<Rewired.InputAction>)
IL_0152: stsfld tmYKYJtivFZNMMdFSwUqjsavhHY Rewired.ReInput::UmkZRVIxxOokFtVtbGnILukIJar
IL_0157: ldc.i4 -1184401366
IL_015c: br IL_001b
IL_0161: ldarg.2
IL_0162: ldsfld Rewired.PlatformInputManager Rewired.ReInput::EipmgiMCREFLYqaOyKWtcpJhWRc
IL_0167: newobj System.Void zMtJShWdNqreuDVsbowqVZNzwts::.ctor(Rewired.Data.ConfigVars,Rewired.PlatformInputManager)
IL_016c: stsfld zMtJShWdNqreuDVsbowqVZNzwts Rewired.ReInput::BoiYVdWmWlQykdYqdqdvncsPfPC
IL_0171: ldc.i4 -1184401354
IL_0176: br IL_001b
IL_017b: ldsfld Rewired.Data.UserDataStore Rewired.ReInput::HTlYcaiYYYNfWUhBffPIAlOFlDB
IL_0180: ldnull
IL_0181: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0186: brfalse IL_03c0
IL_018b: ldsfld Rewired.Data.UserDataStore Rewired.ReInput::HTlYcaiYYYNfWUhBffPIAlOFlDB
IL_0190: callvirt System.Void Rewired.Data.UserDataStore::Initialize()
IL_0195: ldc.i4 -1184401360
IL_019a: br IL_001b
IL_019f: ldarg.0
IL_01a0: stsfld Rewired.InputManager_Base Rewired.ReInput::XetmRAGybyGoHEAxhcHUKeAQrjaF
IL_01a5: ldc.i4 -1184401365
IL_01aa: br IL_001b
IL_01af: call System.Boolean Rewired.Utils.UnityTools::get_isEditor()
IL_01b4: brfalse.s IL_01c0
IL_01b6: call System.Boolean UnityEngine.Application::get_isPlaying()
IL_01bb: ldc.i4.0
IL_01bc: ceq
IL_01be: br.s IL_01c1
IL_01c0: ldc.i4.0
IL_01c1: stsfld System.Boolean Rewired.ReInput::URciBBfYPOJNzFhzOemZncBVJYB
IL_01c6: call System.Boolean Rewired.Utils.UnityTools::get_isEditor()
IL_01cb: brfalse.s IL_019f
IL_01cd: call System.Void Rewired.ReInput::CheckRewiredVersionCompatibility()
IL_01d2: ldc.i4 -1184401367
IL_01d7: br IL_001b
IL_01dc: ldsfld Rewired.Utils.SafeAction Rewired.ReInput::hpMlLXyCgFYRRkoQMvzwOVHEIJs
IL_01e1: callvirt System.Void Rewired.Utils.SafeAction::Invoke()
IL_01e6: ldc.i4 -1184401374
IL_01eb: br IL_001b
IL_01f0: ldarg.2
IL_01f1: newobj System.Void TkcjGAMrGlZBptIAfinKwqiqWse::.ctor(Rewired.Data.ConfigVars)
IL_01f6: stsfld TkcjGAMrGlZBptIAfinKwqiqWse Rewired.ReInput::rMKNQgWzfWednDCMGpAIuspSVKN
IL_01fb: ldsfld Rewired.PlatformInputManager Rewired.ReInput::EipmgiMCREFLYqaOyKWtcpJhWRc
IL_0200: ldnull
IL_0201: ldftn System.Void Rewired.ReInput::yRqWoEWYDcpXxYzerZhCLBeBhUt(Rewired.BridgedController)
IL_0207: newobj System.Void System.Action`1<Rewired.BridgedController>::.ctor(System.Object,System.IntPtr)
IL_020c: callvirt System.Void Rewired.PlatformInputManager::add_DeviceConnectedEvent(System.Action`1<Rewired.BridgedController>)
IL_0211: ldc.i4 -1184401363
IL_0216: br IL_001b
IL_021b: ldsfld Rewired.Utils.SafeAction Rewired.ReInput::hpMlLXyCgFYRRkoQMvzwOVHEIJs
IL_0220: brtrue.s IL_022a
IL_0222: ldc.i4 -1184401374
IL_0227: dup
IL_0228: br.s IL_0230
IL_022a: ldc.i4 -1184401359
IL_022f: dup
IL_0230: pop
IL_0231: br IL_001b
IL_0236: call System.Void Rewired.ThreadSafeUnityInput::PostInitialize2()
IL_023b: ldsfld Rewired.InputManager_Base Rewired.ReInput::XetmRAGybyGoHEAxhcHUKeAQrjaF
IL_0240: call T Rewired.Utils.UnityTools::GetComponent<Rewired.Data.UserDataStore>(UnityEngine.Component)
IL_0245: stsfld Rewired.Data.UserDataStore Rewired.ReInput::HTlYcaiYYYNfWUhBffPIAlOFlDB
IL_024a: ldc.i4 -1184401358
IL_024f: br IL_001b
IL_0254: ldc.i4.1
IL_0255: stsfld System.Boolean Rewired.ReInput::aLzbAjHdyinuPAkYilYZkIGyBOc
IL_025a: ldc.i4.1
IL_025b: stsfld System.Boolean Rewired.ReInput::fymRdAgNSEHytFkEZfRonqvRubb
IL_0260: ldc.i4 -1184401356
IL_0265: br IL_001b
IL_026a: ldarg.3
IL_026b: stsfld Rewired.Data.ControllerDataFiles Rewired.ReInput::zRlWjsiurHfMmGqfsMcLRjaJiumc
IL_0270: ldc.i4 -1184401369
IL_0275: br IL_001b
IL_027a: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_027f: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QBAmVSgbZBPmppTHWYNgMiDCmXg
IL_0284: call System.Boolean Rewired.ReInput::get_isUnityEditorFocused()
IL_0289: brfalse.s IL_0292
IL_028b: call System.Boolean Rewired.ReInput::get_isAllowedEditorWindowFocused()
IL_0290: br.s IL_0293
IL_0292: ldc.i4.0
IL_0293: callvirt System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::Set(T)
IL_0298: pop
IL_0299: ldc.i4 -1184401376
IL_029e: br IL_001b
IL_02a3: ldarg.2
IL_02a4: ldfld System.Boolean Rewired.Data.ConfigVars::logToScreen
IL_02a9: brfalse IL_00ad
IL_02ae: ldc.i4.1
IL_02af: call System.Void Rewired.Logger::set_logToScreen(System.Boolean)
IL_02b4: ldc.i4 -1184401370
IL_02b9: br IL_001b
IL_02be: call System.Void Rewired.ReInput::NavijpmlHmAjhDisfzPPUTADGLlI()
IL_02c3: ldc.i4 -1184401352
IL_02c8: br IL_001b
IL_02cd: ldarg.s 
IL_02cf: stsfld Rewired.Data.UserData Rewired.ReInput::wWsgFeuqSUsgwwBPjdjpjPGupZZ
IL_02d4: ldc.i4 -1184401364
IL_02d9: br IL_001b
IL_02de: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_02e3: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QBAmVSgbZBPmppTHWYNgMiDCmXg
IL_02e8: callvirt System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher::Use()
IL_02ed: pop
IL_02ee: ldsfld Rewired.Platforms.EditorPlatform Rewired.ReInput::oPUAJMywrLEmBbqmOIkACwccdcP
IL_02f3: brfalse.s IL_02be
IL_02f5: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_02fa: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QBAmVSgbZBPmppTHWYNgMiDCmXg
IL_02ff: ldsfld System.Func`1<System.Boolean> Rewired.ReInput::DNTaZFaqqCENnFHcfxuAnYSQMSti
IL_0304: brtrue.s IL_0317
IL_0306: ldnull
IL_0307: ldftn System.Boolean Rewired.ReInput::ZKumZMMwjLdcKigSxyxILFzYDuE()
IL_030d: newobj System.Void System.Func`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0312: stsfld System.Func`1<System.Boolean> Rewired.ReInput::DNTaZFaqqCENnFHcfxuAnYSQMSti
IL_0317: ldsfld System.Func`1<System.Boolean> Rewired.ReInput::DNTaZFaqqCENnFHcfxuAnYSQMSti
IL_031c: callvirt System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::set_getValueDelegate(System.Func`1<T>)
IL_0321: ldsfld System.Boolean Rewired.ReInput::URciBBfYPOJNzFhzOemZncBVJYB
IL_0326: brfalse IL_027a
IL_032b: call System.Boolean Rewired.ReInput::get_isEditorGameViewFocused()
IL_0330: stsfld System.Boolean Rewired.ReInput::cbmmwJPDGUhXqzzdtJQPbNHADIB
IL_0335: ldc.i4 -1184401371
IL_033a: br IL_001b
IL_033f: ldsfld Rewired.PlatformInputManager Rewired.ReInput::EipmgiMCREFLYqaOyKWtcpJhWRc
IL_0344: ldnull
IL_0345: ldftn System.Void Rewired.ReInput::JLvYhhRlmmgDDcSftnVLjLLuIom(Rewired.ControllerDisconnectedEventArgs)
IL_034b: newobj System.Void System.Action`1<Rewired.ControllerDisconnectedEventArgs>::.ctor(System.Object,System.IntPtr)
IL_0350: callvirt System.Void Rewired.PlatformInputManager::add_DeviceDisconnectedEvent(System.Action`1<Rewired.ControllerDisconnectedEventArgs>)
IL_0355: ldsfld Rewired.PlatformInputManager Rewired.ReInput::EipmgiMCREFLYqaOyKWtcpJhWRc
IL_035a: ldnull
IL_035b: ldftn System.Void Rewired.ReInput::BoayLLNfznvSeqSnUDhlCKKPInZL(Rewired.UpdateControllerInfoEventArgs)
IL_0361: newobj System.Void System.Action`1<Rewired.UpdateControllerInfoEventArgs>::.ctor(System.Object,System.IntPtr)
IL_0366: callvirt System.Void Rewired.PlatformInputManager::add_UpdateControllerInfoEvent(System.Action`1<Rewired.UpdateControllerInfoEventArgs>)
IL_036b: ldsfld zMtJShWdNqreuDVsbowqVZNzwts Rewired.ReInput::BoiYVdWmWlQykdYqdqdvncsPfPC
IL_0370: ldnull
IL_0371: ldftn System.Void Rewired.ReInput::wwmSMybonrCmAmLEmSKxoRWPbnm(Rewired.ControllerStatusChangedEventArgs)
IL_0377: newobj System.Void System.Action`1<Rewired.ControllerStatusChangedEventArgs>::.ctor(System.Object,System.IntPtr)
IL_037c: callvirt System.Void zMtJShWdNqreuDVsbowqVZNzwts::add_ControllerDisconnectStartedEvent(System.Action`1<Rewired.ControllerStatusChangedEventArgs>)
IL_0381: ldsfld zMtJShWdNqreuDVsbowqVZNzwts Rewired.ReInput::BoiYVdWmWlQykdYqdqdvncsPfPC
IL_0386: ldsfld TkcjGAMrGlZBptIAfinKwqiqWse Rewired.ReInput::rMKNQgWzfWednDCMGpAIuspSVKN
IL_038b: ldftn System.Void TkcjGAMrGlZBptIAfinKwqiqWse::yzJosMxezqfelckXTrxviFnNKahg(Rewired.ControllerType,System.Int32)
IL_0391: newobj System.Void System.Action`2<Rewired.ControllerType,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0396: callvirt System.Void zMtJShWdNqreuDVsbowqVZNzwts::add_JustBeforeControllerFullyDisconnectedEvent(System.Action`2<Rewired.ControllerType,System.Int32>)
IL_039b: call System.Void Rewired.ThreadSafeUnityInput::PostInitialize()
IL_03a0: call System.Void Rewired.ReInput::hKEAcWfxjIJBxUCeQMQfTsBXJEuC()
IL_03a5: ldc.i4 -1184401351
IL_03aa: br IL_001b
IL_03af: ldarg.s 
IL_03b1: callvirt System.Void Rewired.Data.UserData::nKQbCtkHPOPnqlOqEQhEesshditg()
IL_03b6: ldc.i4 -1184401373
IL_03bb: br IL_001b
IL_03c0: call System.Void Rewired.ReInput::sXSmojTfsGWqzEIEtxKcdoWFQcy()
IL_03c5: ldc.i4.0
IL_03c6: stsfld System.Boolean Rewired.ReInput::fymRdAgNSEHytFkEZfRonqvRubb
IL_03cb: ldsfld System.Boolean Rewired.ReInput::URciBBfYPOJNzFhzOemZncBVJYB
IL_03d0: brfalse IL_021b
IL_03d5: ldstr "Rewired is running in Edit mode."
IL_03da: call System.Void Rewired.Logger::Log(System.Object)
IL_03df: ldc.i4 -1184401357
IL_03e4: br IL_001b
IL_03e9: leave.s IL_03fa
IL_03eb: stloc.0
IL_03ec: ldc.i4.0
IL_03ed: stsfld System.Boolean Rewired.ReInput::aLzbAjHdyinuPAkYilYZkIGyBOc
IL_03f2: ldc.i4.0
IL_03f3: stsfld System.Boolean Rewired.ReInput::fymRdAgNSEHytFkEZfRonqvRubb
IL_03f8: ldloc.0
IL_03f9: throw
IL_03fa: ret
