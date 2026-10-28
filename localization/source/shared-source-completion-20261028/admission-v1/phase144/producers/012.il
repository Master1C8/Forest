TYPE TheForestOfLove.Audio.SoundManager
METHOD System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4 1300
IL_0006: bgt IL_00bc
IL_000b: ldarg.0
IL_000c: ldc.i4 600
IL_0011: bgt.s IL_005c
IL_0013: ldarg.0
IL_0014: ldc.i4 300
IL_0019: bgt.s IL_003a
IL_001b: ldarg.0
IL_001c: ldc.i4.s 100
IL_001e: beq IL_0170
IL_0023: ldarg.0
IL_0024: ldc.i4 200
IL_0029: beq IL_019e
IL_002e: ldarg.0
IL_002f: ldc.i4 300
IL_0034: beq IL_01cc
IL_0039: ret
IL_003a: ldarg.0
IL_003b: ldc.i4 400
IL_0040: beq IL_01fa
IL_0045: ldarg.0
IL_0046: ldc.i4 500
IL_004b: beq IL_0256
IL_0050: ldarg.0
IL_0051: ldc.i4 600
IL_0056: beq IL_02e0
IL_005b: ret
IL_005c: ldarg.0
IL_005d: ldc.i4 900
IL_0062: bgt.s IL_0086
IL_0064: ldarg.0
IL_0065: ldc.i4 700
IL_006a: beq IL_030e
IL_006f: ldarg.0
IL_0070: ldc.i4 800
IL_0075: beq IL_033c
IL_007a: ldarg.0
IL_007b: ldc.i4 900
IL_0080: beq IL_036a
IL_0085: ret
IL_0086: ldarg.0
IL_0087: ldc.i4 1100
IL_008c: bgt.s IL_00a5
IL_008e: ldarg.0
IL_008f: ldc.i4 1000
IL_0094: beq IL_0398
IL_0099: ldarg.0
IL_009a: ldc.i4 1100
IL_009f: beq IL_03c6
IL_00a4: ret
IL_00a5: ldarg.0
IL_00a6: ldc.i4 1200
IL_00ab: beq IL_03f4
IL_00b0: ldarg.0
IL_00b1: ldc.i4 1300
IL_00b6: beq IL_0422
IL_00bb: ret
IL_00bc: ldarg.0
IL_00bd: ldc.i4 1630
IL_00c2: bgt.s IL_0110
IL_00c4: ldarg.0
IL_00c5: ldc.i4 1600
IL_00ca: bgt.s IL_00ee
IL_00cc: ldarg.0
IL_00cd: ldc.i4 1400
IL_00d2: beq IL_0450
IL_00d7: ldarg.0
IL_00d8: ldc.i4 1500
IL_00dd: beq IL_047e
IL_00e2: ldarg.0
IL_00e3: ldc.i4 1600
IL_00e8: beq IL_04ac
IL_00ed: ret
IL_00ee: ldarg.0
IL_00ef: ldc.i4 1610
IL_00f4: beq IL_04da
IL_00f9: ldarg.0
IL_00fa: ldc.i4 1620
IL_00ff: beq IL_0508
IL_0104: ldarg.0
IL_0105: ldc.i4 1630
IL_010a: beq IL_0536
IL_010f: ret
IL_0110: ldarg.0
IL_0111: ldc.i4 1660
IL_0116: bgt.s IL_013a
IL_0118: ldarg.0
IL_0119: ldc.i4 1640
IL_011e: beq IL_0564
IL_0123: ldarg.0
IL_0124: ldc.i4 1650
IL_0129: beq IL_0592
IL_012e: ldarg.0
IL_012f: ldc.i4 1660
IL_0134: beq IL_0228
IL_0139: ret
IL_013a: ldarg.0
IL_013b: ldc.i4 1680
IL_0140: bgt.s IL_0159
IL_0142: ldarg.0
IL_0143: ldc.i4 1670
IL_0148: beq IL_05c0
IL_014d: ldarg.0
IL_014e: ldc.i4 1680
IL_0153: beq IL_05ee
IL_0158: ret
IL_0159: ldarg.0
IL_015a: ldc.i4 1690
IL_015f: beq IL_0284
IL_0164: ldarg.0
IL_0165: ldc.i4 1700
IL_016a: beq IL_02b2
IL_016f: ret
IL_0170: ldstr "MenuSFXGroup"
IL_0175: ldc.r4 1
IL_017a: ldloca.s V_3
IL_017c: initobj System.Nullable`1<System.Single>
IL_0182: ldloc.3
IL_0183: ldc.r4 0
IL_0188: ldstr "MenuSFX_ChangeSelection"
IL_018d: ldloca.s V_4
IL_018f: initobj System.Nullable`1<System.Double>
IL_0195: ldloc.s V_4
IL_0197: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_019c: pop
IL_019d: ret
IL_019e: ldstr "MenuSFXGroup"
IL_01a3: ldc.r4 1
IL_01a8: ldloca.s V_3
IL_01aa: initobj System.Nullable`1<System.Single>
IL_01b0: ldloc.3
IL_01b1: ldc.r4 0
IL_01b6: ldstr "MenuSFX_Select"
IL_01bb: ldloca.s V_4
IL_01bd: initobj System.Nullable`1<System.Double>
IL_01c3: ldloc.s V_4
IL_01c5: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_01ca: pop
IL_01cb: ret
IL_01cc: ldstr "MenuSFXGroup"
IL_01d1: ldc.r4 1
IL_01d6: ldloca.s V_3
IL_01d8: initobj System.Nullable`1<System.Single>
IL_01de: ldloc.3
IL_01df: ldc.r4 0
IL_01e4: ldstr "MenuSFX_Back"
IL_01e9: ldloca.s V_4
IL_01eb: initobj System.Nullable`1<System.Double>
IL_01f1: ldloc.s V_4
IL_01f3: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_01f8: pop
IL_01f9: ret
IL_01fa: ldstr "MenuSFXGroupMusicTest"
IL_01ff: ldc.r4 1
IL_0204: ldloca.s V_3
IL_0206: initobj System.Nullable`1<System.Single>
IL_020c: ldloc.3
IL_020d: ldc.r4 0
IL_0212: ldstr "MenuSFX_ChangeSelection"
IL_0217: ldloca.s V_4
IL_0219: initobj System.Nullable`1<System.Double>
IL_021f: ldloc.s V_4
IL_0221: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0226: pop
IL_0227: ret
IL_0228: ldstr "MenuSFXGroup"
IL_022d: ldc.r4 1
IL_0232: ldloca.s V_3
IL_0234: initobj System.Nullable`1<System.Single>
IL_023a: ldloc.3
IL_023b: ldc.r4 0
IL_0240: ldstr "MenuSFX_CameraSnapshot"
IL_0245: ldloca.s V_4
IL_0247: initobj System.Nullable`1<System.Double>
IL_024d: ldloc.s V_4
IL_024f: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0254: pop
IL_0255: ret
IL_0256: ldstr "ItemGetSFXGroup"
IL_025b: ldc.r4 1
IL_0260: ldloca.s V_3
IL_0262: initobj System.Nullable`1<System.Single>
IL_0268: ldloc.3
IL_0269: ldc.r4 0
IL_026e: ldstr "ItemGetSFX_ItemGetRedux"
IL_0273: ldloca.s V_4
IL_0275: initobj System.Nullable`1<System.Double>
IL_027b: ldloc.s V_4
IL_027d: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0282: pop
IL_0283: ret
IL_0284: ldstr "GeneralSFXGroup"
IL_0289: ldc.r4 1
IL_028e: ldloca.s V_3
IL_0290: initobj System.Nullable`1<System.Single>
IL_0296: ldloc.3
IL_0297: ldc.r4 0
IL_029c: ldstr "GeneralSFX_LockPad"
IL_02a1: ldloca.s V_4
IL_02a3: initobj System.Nullable`1<System.Double>
IL_02a9: ldloc.s V_4
IL_02ab: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_02b0: pop
IL_02b1: ret
IL_02b2: ldstr "GeneralSFXGroup"
IL_02b7: ldc.r4 1.5
IL_02bc: ldloca.s V_3
IL_02be: initobj System.Nullable`1<System.Single>
IL_02c4: ldloc.3
IL_02c5: ldc.r4 0
IL_02ca: ldstr "GeneralSFX_ShortPurchase"
IL_02cf: ldloca.s V_4
IL_02d1: initobj System.Nullable`1<System.Double>
IL_02d7: ldloc.s V_4
IL_02d9: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_02de: pop
IL_02df: ret
IL_02e0: ldstr "FastTravelBellsSFXGroup"
IL_02e5: ldc.r4 1
IL_02ea: ldloca.s V_3
IL_02ec: initobj System.Nullable`1<System.Single>
IL_02f2: ldloc.3
IL_02f3: ldc.r4 0
IL_02f8: ldstr "FastTravelBellsSFX_CentralForest"
IL_02fd: ldloca.s V_4
IL_02ff: initobj System.Nullable`1<System.Double>
IL_0305: ldloc.s V_4
IL_0307: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_030c: pop
IL_030d: ret
IL_030e: ldstr "MenuSFXGroup"
IL_0313: ldc.r4 1
IL_0318: ldloca.s V_3
IL_031a: initobj System.Nullable`1<System.Single>
IL_0320: ldloc.3
IL_0321: ldc.r4 0
IL_0326: ldstr "MenuSFX_GameOver"
IL_032b: ldloca.s V_4
IL_032d: initobj System.Nullable`1<System.Double>
IL_0333: ldloc.s V_4
IL_0335: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_033a: pop
IL_033b: ret
IL_033c: ldstr "MenuSFXGroup"
IL_0341: ldc.r4 1
IL_0346: ldloca.s V_3
IL_0348: initobj System.Nullable`1<System.Single>
IL_034e: ldloc.3
IL_034f: ldc.r4 0
IL_0354: ldstr "MenuSFX_ArcadePositive"
IL_0359: ldloca.s V_4
IL_035b: initobj System.Nullable`1<System.Double>
IL_0361: ldloc.s V_4
IL_0363: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0368: pop
IL_0369: ret
IL_036a: ldstr "MenuSFXGroup"
IL_036f: ldc.r4 1
IL_0374: ldloca.s V_3
IL_0376: initobj System.Nullable`1<System.Single>
IL_037c: ldloc.3
IL_037d: ldc.r4 0
IL_0382: ldstr "MenuSFX_SwordSound"
IL_0387: ldloca.s V_4
IL_0389: initobj System.Nullable`1<System.Double>
IL_038f: ldloc.s V_4
IL_0391: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0396: pop
IL_0397: ret
IL_0398: ldstr "GeneralSFXGroup"
IL_039d: ldc.r4 1
IL_03a2: ldloca.s V_3
IL_03a4: initobj System.Nullable`1<System.Single>
IL_03aa: ldloc.3
IL_03ab: ldc.r4 0
IL_03b0: ldstr "GeneralSFX_Dashroll"
IL_03b5: ldloca.s V_4
IL_03b7: initobj System.Nullable`1<System.Double>
IL_03bd: ldloc.s V_4
IL_03bf: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_03c4: pop
IL_03c5: ret
IL_03c6: ldstr "GeneralSFXGroup"
IL_03cb: ldc.r4 1
IL_03d0: ldloca.s V_3
IL_03d2: initobj System.Nullable`1<System.Single>
IL_03d8: ldloc.3
IL_03d9: ldc.r4 0
IL_03de: ldstr "GeneralSFX_DiveSplash"
IL_03e3: ldloca.s V_4
IL_03e5: initobj System.Nullable`1<System.Double>
IL_03eb: ldloc.s V_4
IL_03ed: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_03f2: pop
IL_03f3: ret
IL_03f4: ldstr "GeneralSFXGroup"
IL_03f9: ldc.r4 1
IL_03fe: ldloca.s V_3
IL_0400: initobj System.Nullable`1<System.Single>
IL_0406: ldloc.3
IL_0407: ldc.r4 0
IL_040c: ldstr "GeneralSFX_SplashOut"
IL_0411: ldloca.s V_4
IL_0413: initobj System.Nullable`1<System.Double>
IL_0419: ldloc.s V_4
IL_041b: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0420: pop
IL_0421: ret
IL_0422: ldstr "GeneralSFXGroup"
IL_0427: ldc.r4 1
IL_042c: ldloca.s V_3
IL_042e: initobj System.Nullable`1<System.Single>
IL_0434: ldloc.3
IL_0435: ldc.r4 0
IL_043a: ldstr "GeneralSFX_BunnyEnter"
IL_043f: ldloca.s V_4
IL_0441: initobj System.Nullable`1<System.Double>
IL_0447: ldloc.s V_4
IL_0449: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_044e: pop
IL_044f: ret
IL_0450: ldstr "GeneralSFXGroup"
IL_0455: ldc.r4 1
IL_045a: ldloca.s V_3
IL_045c: initobj System.Nullable`1<System.Single>
IL_0462: ldloc.3
IL_0463: ldc.r4 0
IL_0468: ldstr "GeneralSFX_BunnyCloser"
IL_046d: ldloca.s V_4
IL_046f: initobj System.Nullable`1<System.Double>
IL_0475: ldloc.s V_4
IL_0477: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_047c: pop
IL_047d: ret
IL_047e: ldstr "GeneralSFXGroup"
IL_0483: ldc.r4 1
IL_0488: ldloca.s V_3
IL_048a: initobj System.Nullable`1<System.Single>
IL_0490: ldloc.3
IL_0491: ldc.r4 0
IL_0496: ldstr "GeneralSFX_BunnyLeaving"
IL_049b: ldloca.s V_4
IL_049d: initobj System.Nullable`1<System.Double>
IL_04a3: ldloc.s V_4
IL_04a5: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_04aa: pop
IL_04ab: ret
IL_04ac: ldstr "GeneralSFXGroup"
IL_04b1: ldc.r4 1
IL_04b6: ldloca.s V_3
IL_04b8: initobj System.Nullable`1<System.Single>
IL_04be: ldloc.3
IL_04bf: ldc.r4 0
IL_04c4: ldstr "GeneralSFX_PennyCaw"
IL_04c9: ldloca.s V_4
IL_04cb: initobj System.Nullable`1<System.Double>
IL_04d1: ldloc.s V_4
IL_04d3: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_04d8: pop
IL_04d9: ret
IL_04da: ldstr "GeneralSFXGroup"
IL_04df: ldc.r4 1
IL_04e4: ldloca.s V_3
IL_04e6: initobj System.Nullable`1<System.Single>
IL_04ec: ldloc.3
IL_04ed: ldc.r4 0
IL_04f2: ldstr "GeneralSFX_Snip1"
IL_04f7: ldloca.s V_4
IL_04f9: initobj System.Nullable`1<System.Double>
IL_04ff: ldloc.s V_4
IL_0501: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0506: pop
IL_0507: ret
IL_0508: ldstr "GeneralSFXGroup"
IL_050d: ldc.r4 1
IL_0512: ldloca.s V_3
IL_0514: initobj System.Nullable`1<System.Single>
IL_051a: ldloc.3
IL_051b: ldc.r4 0
IL_0520: ldstr "GeneralSFX_Snip2"
IL_0525: ldloca.s V_4
IL_0527: initobj System.Nullable`1<System.Double>
IL_052d: ldloc.s V_4
IL_052f: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0534: pop
IL_0535: ret
IL_0536: ldstr "GeneralSFXGroup"
IL_053b: ldc.r4 1
IL_0540: ldloca.s V_3
IL_0542: initobj System.Nullable`1<System.Single>
IL_0548: ldloc.3
IL_0549: ldc.r4 0
IL_054e: ldstr "GeneralSFX_Snip3"
IL_0553: ldloca.s V_4
IL_0555: initobj System.Nullable`1<System.Double>
IL_055b: ldloc.s V_4
IL_055d: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0562: pop
IL_0563: ret
IL_0564: ldstr "GeneralSFXGroup"
IL_0569: ldc.r4 1
IL_056e: ldloca.s V_3
IL_0570: initobj System.Nullable`1<System.Single>
IL_0576: ldloc.3
IL_0577: ldc.r4 0
IL_057c: ldstr "GeneralSFX_Snip4"
IL_0581: ldloca.s V_4
IL_0583: initobj System.Nullable`1<System.Double>
IL_0589: ldloc.s V_4
IL_058b: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0590: pop
IL_0591: ret
IL_0592: ldstr "GeneralSFXGroup"
IL_0597: ldc.r4 1
IL_059c: ldloca.s V_3
IL_059e: initobj System.Nullable`1<System.Single>
IL_05a4: ldloc.3
IL_05a5: ldc.r4 0
IL_05aa: ldstr "GeneralSFX_OliverRun"
IL_05af: ldloca.s V_4
IL_05b1: initobj System.Nullable`1<System.Double>
IL_05b7: ldloc.s V_4
IL_05b9: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_05be: pop
IL_05bf: ret
IL_05c0: ldstr "StormSFXGroup_Thunder"
IL_05c5: ldc.r4 1
IL_05ca: ldloca.s V_3
IL_05cc: initobj System.Nullable`1<System.Single>
IL_05d2: ldloc.3
IL_05d3: ldc.r4 0
IL_05d8: ldstr "StormSFX_Thunder_7"
IL_05dd: ldloca.s V_4
IL_05df: initobj System.Nullable`1<System.Double>
IL_05e5: ldloc.s V_4
IL_05e7: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_05ec: pop
IL_05ed: ret
IL_05ee: ldstr "StormSFXGroup_Thunder"
IL_05f3: ldstr "StormSFX_Thunder_"
IL_05f8: stloc.0
IL_05f9: ldc.i4.s 9
IL_05fb: stloc.1
IL_05fc: ldc.i4.1
IL_05fd: ldloc.1
IL_05fe: ldc.i4.1
IL_05ff: add
IL_0600: call System.Int32 UnityEngine.Random::Range(System.Int32,System.Int32)
IL_0605: stloc.2
IL_0606: ldc.r4 1
IL_060b: ldloca.s V_3
IL_060d: initobj System.Nullable`1<System.Single>
IL_0613: ldloc.3
IL_0614: ldc.r4 0
IL_0619: ldloc.0
IL_061a: ldloca.s V_2
IL_061c: call System.String System.Int32::ToString()
IL_0621: call System.String System.String::Concat(System.String,System.String)
IL_0626: ldloca.s V_4
IL_0628: initobj System.Nullable`1<System.Double>
IL_062e: ldloc.s V_4
IL_0630: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0635: pop
IL_0636: ret
METHOD System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.DustinMinigameSoundEffect) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: switch IL_001f,IL_004c,IL_0079,IL_00a6,IL_00d3,IL_0100
IL_001e: ret
IL_001f: ldstr "DustinMinigameSFXGroup"
IL_0024: ldc.r4 1
IL_0029: ldloca.s V_0
IL_002b: initobj System.Nullable`1<System.Single>
IL_0031: ldloc.0
IL_0032: ldc.r4 0
IL_0037: ldstr "DustinMinigameSFX_Throw"
IL_003c: ldloca.s V_1
IL_003e: initobj System.Nullable`1<System.Double>
IL_0044: ldloc.1
IL_0045: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_004a: pop
IL_004b: ret
IL_004c: ldstr "DustinMinigameSFXGroup"
IL_0051: ldc.r4 1
IL_0056: ldloca.s V_0
IL_0058: initobj System.Nullable`1<System.Single>
IL_005e: ldloc.0
IL_005f: ldc.r4 0
IL_0064: ldstr "DustinMinigameSFX_Impact"
IL_0069: ldloca.s V_1
IL_006b: initobj System.Nullable`1<System.Double>
IL_0071: ldloc.1
IL_0072: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0077: pop
IL_0078: ret
IL_0079: ldstr "DustinMinigameSFXGroup"
IL_007e: ldc.r4 1
IL_0083: ldloca.s V_0
IL_0085: initobj System.Nullable`1<System.Single>
IL_008b: ldloc.0
IL_008c: ldc.r4 0
IL_0091: ldstr "DustinMinigameSFX_Thwack"
IL_0096: ldloca.s V_1
IL_0098: initobj System.Nullable`1<System.Double>
IL_009e: ldloc.1
IL_009f: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_00a4: pop
IL_00a5: ret
IL_00a6: ldstr "DustinMinigameSFXGroup"
IL_00ab: ldc.r4 1
IL_00b0: ldloca.s V_0
IL_00b2: initobj System.Nullable`1<System.Single>
IL_00b8: ldloc.0
IL_00b9: ldc.r4 0
IL_00be: ldstr "DustinMinigameSFX_ElectricSlam"
IL_00c3: ldloca.s V_1
IL_00c5: initobj System.Nullable`1<System.Double>
IL_00cb: ldloc.1
IL_00cc: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_00d1: pop
IL_00d2: ret
IL_00d3: ldstr "DustinMinigameSFXGroup"
IL_00d8: ldc.r4 1
IL_00dd: ldloca.s V_0
IL_00df: initobj System.Nullable`1<System.Single>
IL_00e5: ldloc.0
IL_00e6: ldc.r4 0
IL_00eb: ldstr "DustinMinigameSFX_GroundShatter"
IL_00f0: ldloca.s V_1
IL_00f2: initobj System.Nullable`1<System.Double>
IL_00f8: ldloc.1
IL_00f9: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_00fe: pop
IL_00ff: ret
IL_0100: ldstr "DustinMinigameSFXGroup"
IL_0105: ldc.r4 1
IL_010a: ldloca.s V_0
IL_010c: initobj System.Nullable`1<System.Single>
IL_0112: ldloc.0
IL_0113: ldc.r4 0
IL_0118: ldstr "DustinMinigameSFX_GameOver"
IL_011d: ldloca.s V_1
IL_011f: initobj System.Nullable`1<System.Double>
IL_0125: ldloc.1
IL_0126: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_012b: pop
IL_012c: ret
METHOD System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect,System.Single,System.Single) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "MenuSFXGroup"
IL_0005: ldarg.1
IL_0006: ldarg.2
IL_0007: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_000c: ldc.r4 0
IL_0011: ldstr "MenuSFX_ChangeSelection"
IL_0016: ldloca.s V_0
IL_0018: initobj System.Nullable`1<System.Double>
IL_001e: ldloc.0
IL_001f: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0024: pop
IL_0025: ret
METHOD System.Void TheForestOfLove.Audio.SoundManager::PlayTypewriterSound(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Single TheForestOfLove.Audio.SoundManager::typewriterSoundTimeLastPlayed
IL_0005: ldc.r4 0.075
IL_000a: add
IL_000b: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0010: blt.un.s IL_0013
IL_0012: ret
IL_0013: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0018: stsfld System.Single TheForestOfLove.Audio.SoundManager::typewriterSoundTimeLastPlayed
IL_001d: ldarg.0
IL_001e: brfalse IL_09c1
IL_0023: ldarg.0
IL_0024: call System.UInt32 <PrivateImplementationDetails>::ComputeStringHash(System.String)
IL_0029: stloc.0
IL_002a: ldloc.0
IL_002b: ldc.i4 1913745654
IL_0030: bgt.un IL_012d
IL_0035: ldloc.0
IL_0036: ldc.i4 814229697
IL_003b: bgt.un.s IL_00a9
IL_003d: ldloc.0
IL_003e: ldc.i4 625056010
IL_0043: bgt.un.s IL_006b
IL_0045: ldloc.0
IL_0046: ldc.i4 109679597
IL_004b: beq IL_026a
IL_0050: ldloc.0
IL_0051: ldc.i4 587846041
IL_0056: beq IL_027f
IL_005b: ldloc.0
IL_005c: ldc.i4 625056010
IL_0061: beq IL_04a1
IL_0066: br IL_09c1
IL_006b: ldloc.0
IL_006c: ldc.i4 730681806
IL_0071: bgt.un.s IL_008e
IL_0073: ldloc.0
IL_0074: ldc.i4 685672553
IL_0079: beq IL_03cf
IL_007e: ldloc.0
IL_007f: ldc.i4 730681806
IL_0084: beq IL_040e
IL_0089: br IL_09c1
IL_008e: ldloc.0
IL_008f: ldc.i4 802805123
IL_0094: beq IL_03a5
IL_0099: ldloc.0
IL_009a: ldc.i4 814229697
IL_009f: beq IL_0351
IL_00a4: br IL_09c1
IL_00a9: ldloc.0
IL_00aa: ldc.i4 1577794413
IL_00af: bgt.un.s IL_00ef
IL_00b1: ldloc.0
IL_00b2: ldc.i4 1341893544
IL_00b7: bgt.un.s IL_00d4
IL_00b9: ldloc.0
IL_00ba: ldc.i4 944588958
IL_00bf: beq IL_0327
IL_00c4: ldloc.0
IL_00c5: ldc.i4 1341893544
IL_00ca: beq IL_02a9
IL_00cf: br IL_09c1
IL_00d4: ldloc.0
IL_00d5: ldc.i4 1491079565
IL_00da: beq IL_02e8
IL_00df: ldloc.0
IL_00e0: ldc.i4 1577794413
IL_00e5: beq IL_0477
IL_00ea: br IL_09c1
IL_00ef: ldloc.0
IL_00f0: ldc.i4 1711307487
IL_00f5: bgt.un.s IL_0112
IL_00f7: ldloc.0
IL_00f8: ldc.i4 1702629511
IL_00fd: beq IL_02be
IL_0102: ldloc.0
IL_0103: ldc.i4 1711307487
IL_0108: beq IL_0294
IL_010d: br IL_09c1
IL_0112: ldloc.0
IL_0113: ldc.i4 1803517931
IL_0118: beq IL_0255
IL_011d: ldloc.0
IL_011e: ldc.i4 1913745654
IL_0123: beq IL_0312
IL_0128: br IL_09c1
IL_012d: ldloc.0
IL_012e: ldc.i4 -1107826754
IL_0133: bgt.un IL_01bc
IL_0138: ldloc.0
IL_0139: ldc.i4 -1938283991
IL_013e: bgt.un.s IL_017e
IL_0140: ldloc.0
IL_0141: ldc.i4 -2081974963
IL_0146: bgt.un.s IL_0163
IL_0148: ldloc.0
IL_0149: ldc.i4 -2122957536
IL_014e: beq IL_02d3
IL_0153: ldloc.0
IL_0154: ldc.i4 -2081974963
IL_0159: beq IL_0240
IL_015e: br IL_09c1
IL_0163: ldloc.0
IL_0164: ldc.i4 -1946370202
IL_0169: beq IL_03f9
IL_016e: ldloc.0
IL_016f: ldc.i4 -1938283991
IL_0174: beq IL_0390
IL_0179: br IL_09c1
IL_017e: ldloc.0
IL_017f: ldc.i4 -1765352941
IL_0184: bgt.un.s IL_01a1
IL_0186: ldloc.0
IL_0187: ldc.i4 -1772049342
IL_018c: beq IL_02fd
IL_0191: ldloc.0
IL_0192: ldc.i4 -1765352941
IL_0197: beq IL_0423
IL_019c: br IL_09c1
IL_01a1: ldloc.0
IL_01a2: ldc.i4 -1634711369
IL_01a7: beq IL_03ba
IL_01ac: ldloc.0
IL_01ad: ldc.i4 -1107826754
IL_01b2: beq IL_0462
IL_01b7: br IL_09c1
IL_01bc: ldloc.0
IL_01bd: ldc.i4 -285654030
IL_01c2: bgt.un.s IL_0202
IL_01c4: ldloc.0
IL_01c5: ldc.i4 -446121187
IL_01ca: bgt.un.s IL_01e7
IL_01cc: ldloc.0
IL_01cd: ldc.i4 -583733738
IL_01d2: beq IL_044d
IL_01d7: ldloc.0
IL_01d8: ldc.i4 -446121187
IL_01dd: beq IL_048c
IL_01e2: br IL_09c1
IL_01e7: ldloc.0
IL_01e8: ldc.i4 -389189639
IL_01ed: beq IL_03e4
IL_01f2: ldloc.0
IL_01f3: ldc.i4 -285654030
IL_01f8: beq IL_04b6
IL_01fd: br IL_09c1
IL_0202: ldloc.0
IL_0203: ldc.i4 -243028812
IL_0208: bgt.un.s IL_0225
IL_020a: ldloc.0
IL_020b: ldc.i4 -264511726
IL_0210: beq IL_0366
IL_0215: ldloc.0
IL_0216: ldc.i4 -243028812
IL_021b: beq IL_033c
IL_0220: br IL_09c1
IL_0225: ldloc.0
IL_0226: ldc.i4 -34715590
IL_022b: beq IL_037b
IL_0230: ldloc.0
IL_0231: ldc.i4 -19880352
IL_0236: beq IL_0438
IL_023b: br IL_09c1
IL_0240: ldarg.0
IL_0241: ldstr "Charlotte In Bed"
IL_0246: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_024b: brtrue IL_04cb
IL_0250: br IL_09c1
IL_0255: ldarg.0
IL_0256: ldstr "Charlotte"
IL_025b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0260: brtrue IL_04cb
IL_0265: br IL_09c1
IL_026a: ldarg.0
IL_026b: ldstr "Bucky"
IL_0270: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0275: brtrue IL_04f8
IL_027a: br IL_09c1
IL_027f: ldarg.0
IL_0280: ldstr "Penny"
IL_0285: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_028a: brtrue IL_0525
IL_028f: br IL_09c1
IL_0294: ldarg.0
IL_0295: ldstr "Scarlett"
IL_029a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_029f: brtrue IL_0552
IL_02a4: br IL_09c1
IL_02a9: ldarg.0
IL_02aa: ldstr "Augustus"
IL_02af: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02b4: brtrue IL_057f
IL_02b9: br IL_09c1
IL_02be: ldarg.0
IL_02bf: ldstr "Bridge Builders Group"
IL_02c4: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02c9: brtrue IL_05ac
IL_02ce: br IL_09c1
IL_02d3: ldarg.0
IL_02d4: ldstr "Narrator"
IL_02d9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02de: brtrue IL_05ac
IL_02e3: br IL_09c1
IL_02e8: ldarg.0
IL_02e9: ldstr "Maverick"
IL_02ee: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02f3: brtrue IL_05d9
IL_02f8: br IL_09c1
IL_02fd: ldarg.0
IL_02fe: ldstr "Mabel"
IL_0303: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0308: brtrue IL_0606
IL_030d: br IL_09c1
IL_0312: ldarg.0
IL_0313: ldstr "MabelsMom"
IL_0318: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_031d: brtrue IL_0633
IL_0322: br IL_09c1
IL_0327: ldarg.0
IL_0328: ldstr "Dustin"
IL_032d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0332: brtrue IL_0661
IL_0337: br IL_09c1
IL_033c: ldarg.0
IL_033d: ldstr "Finley"
IL_0342: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0347: brtrue IL_068e
IL_034c: br IL_09c1
IL_0351: ldarg.0
IL_0352: ldstr "Claire"
IL_0357: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_035c: brtrue IL_06bb
IL_0361: br IL_09c1
IL_0366: ldarg.0
IL_0367: ldstr "Violet"
IL_036c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0371: brtrue IL_06e9
IL_0376: br IL_09c1
IL_037b: ldarg.0
IL_037c: ldstr "Oliver"
IL_0381: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0386: brtrue IL_0717
IL_038b: br IL_09c1
IL_0390: ldarg.0
IL_0391: ldstr "Peter"
IL_0396: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_039b: brtrue IL_0745
IL_03a0: br IL_09c1
IL_03a5: ldarg.0
IL_03a6: ldstr "Fish"
IL_03ab: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03b0: brtrue IL_0772
IL_03b5: br IL_09c1
IL_03ba: ldarg.0
IL_03bb: ldstr "Rascal"
IL_03c0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03c5: brtrue IL_079f
IL_03ca: br IL_09c1
IL_03cf: ldarg.0
IL_03d0: ldstr "Bug Report Rascal"
IL_03d5: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03da: brtrue IL_079f
IL_03df: br IL_09c1
IL_03e4: ldarg.0
IL_03e5: ldstr "Melody"
IL_03ea: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03ef: brtrue IL_07cc
IL_03f4: br IL_09c1
IL_03f9: ldarg.0
IL_03fa: ldstr "Glitch Rascal"
IL_03ff: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0404: brtrue IL_07fa
IL_0409: br IL_09c1
IL_040e: ldarg.0
IL_040f: ldstr "Fen"
IL_0414: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0419: brtrue IL_0823
IL_041e: br IL_09c1
IL_0423: ldarg.0
IL_0424: ldstr "ForestMouse_Hospitable"
IL_0429: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_042e: brtrue IL_0851
IL_0433: br IL_09c1
IL_0438: ldarg.0
IL_0439: ldstr "ForestMouse_Amorous"
IL_043e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0443: brtrue IL_087f
IL_0448: br IL_09c1
IL_044d: ldarg.0
IL_044e: ldstr "ForestMouse_Curious"
IL_0453: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0458: brtrue IL_08ad
IL_045d: br IL_09c1
IL_0462: ldarg.0
IL_0463: ldstr "ForestMouse_Cordial"
IL_0468: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_046d: brtrue IL_08db
IL_0472: br IL_09c1
IL_0477: ldarg.0
IL_0478: ldstr "ForestMouse_Cautious"
IL_047d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0482: brtrue IL_0909
IL_0487: br IL_09c1
IL_048c: ldarg.0
IL_048d: ldstr "ForestMouse_Polite"
IL_0492: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0497: brtrue IL_0937
IL_049c: br IL_09c1
IL_04a1: ldarg.0
IL_04a2: ldstr "ForestMouse_Astonished"
IL_04a7: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04ac: brtrue IL_0965
IL_04b1: br IL_09c1
IL_04b6: ldarg.0
IL_04b7: ldstr "ForestMouse_Excited"
IL_04bc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04c1: brtrue IL_0993
IL_04c6: br IL_09c1
IL_04cb: ldstr "DialogueChirpsSFXGroup"
IL_04d0: ldc.r4 1
IL_04d5: ldloca.s V_1
IL_04d7: initobj System.Nullable`1<System.Single>
IL_04dd: ldloc.1
IL_04de: ldc.r4 0
IL_04e3: ldstr "DialogueChirpsSFX_Bear"
IL_04e8: ldloca.s V_2
IL_04ea: initobj System.Nullable`1<System.Double>
IL_04f0: ldloc.2
IL_04f1: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_04f6: pop
IL_04f7: ret
IL_04f8: ldstr "DialogueChirpsSFXGroup"
IL_04fd: ldc.r4 1
IL_0502: ldloca.s V_1
IL_0504: initobj System.Nullable`1<System.Single>
IL_050a: ldloc.1
IL_050b: ldc.r4 0
IL_0510: ldstr "DialogueChirpsSFX_Beaver"
IL_0515: ldloca.s V_2
IL_0517: initobj System.Nullable`1<System.Double>
IL_051d: ldloc.2
IL_051e: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0523: pop
IL_0524: ret
IL_0525: ldstr "DialogueChirpsSFXGroup"
IL_052a: ldc.r4 1
IL_052f: ldloca.s V_1
IL_0531: initobj System.Nullable`1<System.Single>
IL_0537: ldloc.1
IL_0538: ldc.r4 0
IL_053d: ldstr "DialogueChirpsSFX_Bird"
IL_0542: ldloca.s V_2
IL_0544: initobj System.Nullable`1<System.Double>
IL_054a: ldloc.2
IL_054b: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0550: pop
IL_0551: ret
IL_0552: ldstr "DialogueChirpsSFXGroup"
IL_0557: ldc.r4 1
IL_055c: ldloca.s V_1
IL_055e: initobj System.Nullable`1<System.Single>
IL_0564: ldloc.1
IL_0565: ldc.r4 0
IL_056a: ldstr "DialogueChirpsSFX_BunnyMom"
IL_056f: ldloca.s V_2
IL_0571: initobj System.Nullable`1<System.Double>
IL_0577: ldloc.2
IL_0578: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_057d: pop
IL_057e: ret
IL_057f: ldstr "DialogueChirpsSFXGroup"
IL_0584: ldc.r4 1
IL_0589: ldloca.s V_1
IL_058b: initobj System.Nullable`1<System.Single>
IL_0591: ldloc.1
IL_0592: ldc.r4 0
IL_0597: ldstr "DialogueChirpsSFX_Gator"
IL_059c: ldloca.s V_2
IL_059e: initobj System.Nullable`1<System.Double>
IL_05a4: ldloc.2
IL_05a5: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_05aa: pop
IL_05ab: ret
IL_05ac: ldstr "DialogueChirpsSFXGroup"
IL_05b1: ldc.r4 1
IL_05b6: ldloca.s V_1
IL_05b8: initobj System.Nullable`1<System.Single>
IL_05be: ldloc.1
IL_05bf: ldc.r4 0
IL_05c4: ldstr "DialogueChirpsSFX_Narrator"
IL_05c9: ldloca.s V_2
IL_05cb: initobj System.Nullable`1<System.Double>
IL_05d1: ldloc.2
IL_05d2: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_05d7: pop
IL_05d8: ret
IL_05d9: ldstr "DialogueChirpsSFXGroup"
IL_05de: ldc.r4 1
IL_05e3: ldloca.s V_1
IL_05e5: initobj System.Nullable`1<System.Single>
IL_05eb: ldloc.1
IL_05ec: ldc.r4 0
IL_05f1: ldstr "DialogueChirpsSFX_Otter"
IL_05f6: ldloca.s V_2
IL_05f8: initobj System.Nullable`1<System.Double>
IL_05fe: ldloc.2
IL_05ff: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0604: pop
IL_0605: ret
IL_0606: ldstr "DialogueChirpsSFXGroup"
IL_060b: ldc.r4 1
IL_0610: ldloca.s V_1
IL_0612: initobj System.Nullable`1<System.Single>
IL_0618: ldloc.1
IL_0619: ldc.r4 0
IL_061e: ldstr "DialogueChirpsSFX_Mouse"
IL_0623: ldloca.s V_2
IL_0625: initobj System.Nullable`1<System.Double>
IL_062b: ldloc.2
IL_062c: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0631: pop
IL_0632: ret
IL_0633: ldstr "DialogueChirpsSFXGroup"
IL_0638: ldc.r4 1
IL_063d: ldc.r4 0.8
IL_0642: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_0647: ldc.r4 0
IL_064c: ldstr "DialogueChirpsSFX_Mouse"
IL_0651: ldloca.s V_2
IL_0653: initobj System.Nullable`1<System.Double>
IL_0659: ldloc.2
IL_065a: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_065f: pop
IL_0660: ret
IL_0661: ldstr "DialogueChirpsSFXGroup"
IL_0666: ldc.r4 1
IL_066b: ldloca.s V_1
IL_066d: initobj System.Nullable`1<System.Single>
IL_0673: ldloc.1
IL_0674: ldc.r4 0
IL_0679: ldstr "DialogueChirpsSFX_Squirrel"
IL_067e: ldloca.s V_2
IL_0680: initobj System.Nullable`1<System.Double>
IL_0686: ldloc.2
IL_0687: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_068c: pop
IL_068d: ret
IL_068e: ldstr "DialogueChirpsSFXGroup"
IL_0693: ldc.r4 1
IL_0698: ldloca.s V_1
IL_069a: initobj System.Nullable`1<System.Single>
IL_06a0: ldloc.1
IL_06a1: ldc.r4 0
IL_06a6: ldstr "DialogueChirpsSFX_Ram"
IL_06ab: ldloca.s V_2
IL_06ad: initobj System.Nullable`1<System.Double>
IL_06b3: ldloc.2
IL_06b4: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_06b9: pop
IL_06ba: ret
IL_06bb: ldstr "DialogueChirpsSFXGroup"
IL_06c0: ldc.r4 1
IL_06c5: ldc.r4 0.85
IL_06ca: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_06cf: ldc.r4 0
IL_06d4: ldstr "DialogueChirpsSFX_BunnyMom"
IL_06d9: ldloca.s V_2
IL_06db: initobj System.Nullable`1<System.Double>
IL_06e1: ldloc.2
IL_06e2: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_06e7: pop
IL_06e8: ret
IL_06e9: ldstr "DialogueChirpsSFXGroup"
IL_06ee: ldc.r4 1
IL_06f3: ldc.r4 0.78
IL_06f8: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_06fd: ldc.r4 0
IL_0702: ldstr "DialogueChirpsSFX_BunnyMom"
IL_0707: ldloca.s V_2
IL_0709: initobj System.Nullable`1<System.Double>
IL_070f: ldloc.2
IL_0710: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0715: pop
IL_0716: ret
IL_0717: ldstr "DialogueChirpsSFXGroup"
IL_071c: ldc.r4 1
IL_0721: ldc.r4 0.8
IL_0726: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_072b: ldc.r4 0
IL_0730: ldstr "DialogueChirpsSFX_Otter"
IL_0735: ldloca.s V_2
IL_0737: initobj System.Nullable`1<System.Double>
IL_073d: ldloc.2
IL_073e: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0743: pop
IL_0744: ret
IL_0745: ldstr "DialogueChirpsSFXGroup"
IL_074a: ldc.r4 1
IL_074f: ldloca.s V_1
IL_0751: initobj System.Nullable`1<System.Single>
IL_0757: ldloc.1
IL_0758: ldc.r4 0
IL_075d: ldstr "DialogueChirpsSFX_Peter"
IL_0762: ldloca.s V_2
IL_0764: initobj System.Nullable`1<System.Double>
IL_076a: ldloc.2
IL_076b: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0770: pop
IL_0771: ret
IL_0772: ldstr "DialogueChirpsSFXGroup"
IL_0777: ldc.r4 1
IL_077c: ldloca.s V_1
IL_077e: initobj System.Nullable`1<System.Single>
IL_0784: ldloc.1
IL_0785: ldc.r4 0
IL_078a: ldstr "DialogueChirpsSFX_Fish"
IL_078f: ldloca.s V_2
IL_0791: initobj System.Nullable`1<System.Double>
IL_0797: ldloc.2
IL_0798: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_079d: pop
IL_079e: ret
IL_079f: ldstr "DialogueChirpsSFXGroup"
IL_07a4: ldc.r4 1
IL_07a9: ldloca.s V_1
IL_07ab: initobj System.Nullable`1<System.Single>
IL_07b1: ldloc.1
IL_07b2: ldc.r4 0
IL_07b7: ldstr "DialogueChirpsSFX_Rascal"
IL_07bc: ldloca.s V_2
IL_07be: initobj System.Nullable`1<System.Double>
IL_07c4: ldloc.2
IL_07c5: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_07ca: pop
IL_07cb: ret
IL_07cc: ldstr "DialogueChirpsSFXGroup"
IL_07d1: ldc.r4 1
IL_07d6: ldc.r4 1.15
IL_07db: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_07e0: ldc.r4 0
IL_07e5: ldstr "DialogueChirpsSFX_Bear"
IL_07ea: ldloca.s V_2
IL_07ec: initobj System.Nullable`1<System.Double>
IL_07f2: ldloc.2
IL_07f3: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_07f8: pop
IL_07f9: ret
IL_07fa: ldstr "DialogueChirpsSFXGroup_GlitchRascal"
IL_07ff: ldc.r4 1
IL_0804: ldloca.s V_1
IL_0806: initobj System.Nullable`1<System.Single>
IL_080c: ldloc.1
IL_080d: ldc.r4 0
IL_0812: ldnull
IL_0813: ldloca.s V_2
IL_0815: initobj System.Nullable`1<System.Double>
IL_081b: ldloc.2
IL_081c: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0821: pop
IL_0822: ret
IL_0823: ldstr "DialogueChirpsSFXGroup"
IL_0828: ldc.r4 1
IL_082d: ldc.r4 0.6
IL_0832: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_0837: ldc.r4 0
IL_083c: ldstr "DialogueChirpsSFX_Beaver"
IL_0841: ldloca.s V_2
IL_0843: initobj System.Nullable`1<System.Double>
IL_0849: ldloc.2
IL_084a: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_084f: pop
IL_0850: ret
IL_0851: ldstr "DialogueChirpsSFXGroup"
IL_0856: ldc.r4 1
IL_085b: ldc.r4 0.85
IL_0860: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_0865: ldc.r4 0
IL_086a: ldstr "DialogueChirpsSFX_ForestMouse"
IL_086f: ldloca.s V_2
IL_0871: initobj System.Nullable`1<System.Double>
IL_0877: ldloc.2
IL_0878: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_087d: pop
IL_087e: ret
IL_087f: ldstr "DialogueChirpsSFXGroup"
IL_0884: ldc.r4 1
IL_0889: ldc.r4 0.9
IL_088e: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_0893: ldc.r4 0
IL_0898: ldstr "DialogueChirpsSFX_ForestMouse"
IL_089d: ldloca.s V_2
IL_089f: initobj System.Nullable`1<System.Double>
IL_08a5: ldloc.2
IL_08a6: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_08ab: pop
IL_08ac: ret
IL_08ad: ldstr "DialogueChirpsSFXGroup"
IL_08b2: ldc.r4 1
IL_08b7: ldc.r4 0.95
IL_08bc: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_08c1: ldc.r4 0
IL_08c6: ldstr "DialogueChirpsSFX_ForestMouse"
IL_08cb: ldloca.s V_2
IL_08cd: initobj System.Nullable`1<System.Double>
IL_08d3: ldloc.2
IL_08d4: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_08d9: pop
IL_08da: ret
IL_08db: ldstr "DialogueChirpsSFXGroup"
IL_08e0: ldc.r4 1
IL_08e5: ldc.r4 1
IL_08ea: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_08ef: ldc.r4 0
IL_08f4: ldstr "DialogueChirpsSFX_ForestMouse"
IL_08f9: ldloca.s V_2
IL_08fb: initobj System.Nullable`1<System.Double>
IL_0901: ldloc.2
IL_0902: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0907: pop
IL_0908: ret
IL_0909: ldstr "DialogueChirpsSFXGroup"
IL_090e: ldc.r4 1
IL_0913: ldc.r4 1.05
IL_0918: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_091d: ldc.r4 0
IL_0922: ldstr "DialogueChirpsSFX_ForestMouse"
IL_0927: ldloca.s V_2
IL_0929: initobj System.Nullable`1<System.Double>
IL_092f: ldloc.2
IL_0930: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0935: pop
IL_0936: ret
IL_0937: ldstr "DialogueChirpsSFXGroup"
IL_093c: ldc.r4 1
IL_0941: ldc.r4 0.9
IL_0946: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_094b: ldc.r4 0
IL_0950: ldstr "DialogueChirpsSFX_ForestMouse"
IL_0955: ldloca.s V_2
IL_0957: initobj System.Nullable`1<System.Double>
IL_095d: ldloc.2
IL_095e: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0963: pop
IL_0964: ret
IL_0965: ldstr "DialogueChirpsSFXGroup"
IL_096a: ldc.r4 1
IL_096f: ldc.r4 1.15
IL_0974: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_0979: ldc.r4 0
IL_097e: ldstr "DialogueChirpsSFX_ForestMouse"
IL_0983: ldloca.s V_2
IL_0985: initobj System.Nullable`1<System.Double>
IL_098b: ldloc.2
IL_098c: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0991: pop
IL_0992: ret
IL_0993: ldstr "DialogueChirpsSFXGroup"
IL_0998: ldc.r4 1
IL_099d: ldc.r4 1.2
IL_09a2: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_09a7: ldc.r4 0
IL_09ac: ldstr "DialogueChirpsSFX_ForestMouse"
IL_09b1: ldloca.s V_2
IL_09b3: initobj System.Nullable`1<System.Double>
IL_09b9: ldloc.2
IL_09ba: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_09bf: pop
IL_09c0: ret
IL_09c1: ldsfld System.Boolean TheForestOfLove.Audio.SoundManager::defaultTypewriterAlternateVoice
IL_09c6: brfalse.s IL_09f9
IL_09c8: ldstr "DialogueChirpsSFXGroup"
IL_09cd: ldloca.s V_1
IL_09cf: ldsfld System.Single TheForestOfLove.Audio.SoundManager::defaultTypewriterPitch
IL_09d4: call System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_09d9: ldsfld System.Single TheForestOfLove.Audio.SoundManager::defaultTypewriterVolume
IL_09de: ldloc.1
IL_09df: ldc.r4 0
IL_09e4: ldstr "DialogueChirpsSFX_Beaver"
IL_09e9: ldloca.s V_2
IL_09eb: initobj System.Nullable`1<System.Double>
IL_09f1: ldloc.2
IL_09f2: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_09f7: pop
IL_09f8: ret
IL_09f9: ldstr "DialogueChirpsSFXGroup"
IL_09fe: ldloca.s V_1
IL_0a00: ldsfld System.Single TheForestOfLove.Audio.SoundManager::defaultTypewriterPitch
IL_0a05: call System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_0a0a: ldsfld System.Single TheForestOfLove.Audio.SoundManager::defaultTypewriterVolume
IL_0a0f: ldloc.1
IL_0a10: ldc.r4 0
IL_0a15: ldstr "DialogueChirpsSFX_Default"
IL_0a1a: ldloca.s V_2
IL_0a1c: initobj System.Nullable`1<System.Double>
IL_0a22: ldloc.2
IL_0a23: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0a28: pop
IL_0a29: ret
METHOD System.Void TheForestOfLove.Audio.SoundManager::PlayTypingSound_Keys() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "TypingSFXGroup_Keys"
IL_0005: ldstr "TypingSFX_Key_"
IL_000a: stloc.0
IL_000b: ldc.i4.4
IL_000c: stloc.1
IL_000d: ldc.i4.1
IL_000e: ldloc.1
IL_000f: ldc.i4.1
IL_0010: add
IL_0011: call System.Int32 UnityEngine.Random::Range(System.Int32,System.Int32)
IL_0016: stloc.2
IL_0017: ldc.r4 1
IL_001c: ldloca.s V_3
IL_001e: initobj System.Nullable`1<System.Single>
IL_0024: ldloc.3
IL_0025: ldc.r4 0
IL_002a: ldloc.0
IL_002b: ldloca.s V_2
IL_002d: call System.String System.Int32::ToString()
IL_0032: call System.String System.String::Concat(System.String,System.String)
IL_0037: ldloca.s V_4
IL_0039: initobj System.Nullable`1<System.Double>
IL_003f: ldloc.s V_4
IL_0041: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_0046: pop
IL_0047: ret
METHOD System.Void TheForestOfLove.Audio.SoundManager::PlayFootstepSound(TheForestOfLove.TerrainType) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean TheForestOfLove.Audio.SoundManager::disableFootstepSounds
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldnull
IL_0009: stloc.0
IL_000a: ldnull
IL_000b: stloc.1
IL_000c: ldc.i4.m1
IL_000d: stloc.2
IL_000e: ldarg.0
IL_000f: switch IL_0032,IL_0052,IL_0042,IL_0063,IL_0073,IL_0083,IL_0093
IL_0030: br.s IL_00a1
IL_0032: ldstr "FootstepsSFXGroup_Grass"
IL_0037: stloc.0
IL_0038: ldstr "FootstepsSFX_Grass_"
IL_003d: stloc.1
IL_003e: ldc.i4.6
IL_003f: stloc.2
IL_0040: br.s IL_00a1
IL_0042: ldstr "FootstepsSFXGroup_Wood"
IL_0047: stloc.0
IL_0048: ldstr "FootstepsSFX_Wood_"
IL_004d: stloc.1
IL_004e: ldc.i4.6
IL_004f: stloc.2
IL_0050: br.s IL_00a1
IL_0052: ldstr "FootstepsSFXGroup_Road"
IL_0057: stloc.0
IL_0058: ldstr "FootstepsSFX_Road_"
IL_005d: stloc.1
IL_005e: ldc.i4.s 9
IL_0060: stloc.2
IL_0061: br.s IL_00a1
IL_0063: ldstr "FootstepsSFXGroup_Snow"
IL_0068: stloc.0
IL_0069: ldstr "FootstepsSFX_Snow_"
IL_006e: stloc.1
IL_006f: ldc.i4.8
IL_0070: stloc.2
IL_0071: br.s IL_00a1
IL_0073: ldstr "FootstepsSFXGroup_Swim"
IL_0078: stloc.0
IL_0079: ldstr "FootstepsSFX_Swim_"
IL_007e: stloc.1
IL_007f: ldc.i4.2
IL_0080: stloc.2
IL_0081: br.s IL_00a1
IL_0083: ldstr "FootstepsSFXGroup_CarpetAndMetal"
IL_0088: stloc.0
IL_0089: ldstr "FootstepsSFX_CarpetAndMetal_"
IL_008e: stloc.1
IL_008f: ldc.i4.6
IL_0090: stloc.2
IL_0091: br.s IL_00a1
IL_0093: ldstr "FootstepsSFXGroup_GlitchRoom"
IL_0098: stloc.0
IL_0099: ldstr "FootstepsSFX_GlitchRoom_"
IL_009e: stloc.1
IL_009f: ldc.i4.8
IL_00a0: stloc.2
IL_00a1: ldc.i4.1
IL_00a2: ldloc.2
IL_00a3: ldc.i4.1
IL_00a4: add
IL_00a5: call System.Int32 UnityEngine.Random::Range(System.Int32,System.Int32)
IL_00aa: stloc.3
IL_00ab: ldloc.0
IL_00ac: ldc.r4 1
IL_00b1: ldloca.s V_4
IL_00b3: initobj System.Nullable`1<System.Single>
IL_00b9: ldloc.s V_4
IL_00bb: ldc.r4 0
IL_00c0: ldloc.1
IL_00c1: ldloca.s V_3
IL_00c3: call System.String System.Int32::ToString()
IL_00c8: call System.String System.String::Concat(System.String,System.String)
IL_00cd: ldloca.s V_5
IL_00cf: initobj System.Nullable`1<System.Double>
IL_00d5: ldloc.s V_5
IL_00d7: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>)
IL_00dc: pop
IL_00dd: ret
