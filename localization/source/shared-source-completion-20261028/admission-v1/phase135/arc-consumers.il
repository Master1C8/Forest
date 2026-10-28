TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::PopulateDialogueArcs(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Dialogue,System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.3
IL_0001: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0006: ldarg.s rootNodeTitle
IL_0008: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_000d: stloc.0
IL_000e: ldloc.0
IL_000f: brfalse IL_054c
IL_0014: ldloc.0
IL_0015: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_001a: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Count()
IL_001f: brtrue.s IL_0037
IL_0021: ldstr "orphaned dialogue arc root node! "
IL_0026: ldarg.3
IL_0027: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_002c: call System.String System.String::Concat(System.String,System.String)
IL_0031: newobj System.Void System.Exception::.ctor(System.String)
IL_0036: throw
IL_0037: ldc.i4.0
IL_0038: stloc.1
IL_0039: br IL_053b
IL_003e: newobj System.Void TheForestOfLove.Narrative.Arc::.ctor()
IL_0043: stloc.2
IL_0044: ldarg.s rootNodeTitle
IL_0046: ldstr "NAMED"
IL_004b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0050: brfalse.s IL_009d
IL_0052: ldarg.3
IL_0053: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0058: ldloc.0
IL_0059: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_005e: ldloc.1
IL_005f: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0064: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0069: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_006e: stloc.s V_8
IL_0070: ldloc.2
IL_0071: ldloc.s V_8
IL_0073: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0078: stfld System.String TheForestOfLove.Narrative.Arc::customName
IL_007d: ldarg.3
IL_007e: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0083: ldloc.s V_8
IL_0085: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_008a: ldc.i4.0
IL_008b: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0090: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0095: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_009a: stloc.3
IL_009b: br.s IL_00ba
IL_009d: ldarg.3
IL_009e: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_00a3: ldloc.0
IL_00a4: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_00a9: ldloc.1
IL_00aa: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_00af: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_00b4: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_00b9: stloc.3
IL_00ba: ldarg.s rootNodeTitle
IL_00bc: ldstr "PRIMARY"
IL_00c1: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00c6: brfalse IL_01ce
IL_00cb: ldarg.3
IL_00cc: ldfld System.Boolean TheForestOfLove.Narrative.Dialogue::hasPlayerInitiatedQuestion
IL_00d1: brfalse IL_01ce
IL_00d6: ldarg.3
IL_00d7: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_00dc: ldc.i4 200
IL_00e1: beq.s IL_00fa
IL_00e3: ldarg.3
IL_00e4: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_00e9: ldc.i4 400
IL_00ee: beq.s IL_00fa
IL_00f0: ldstr "an unexpected dialogue type has a player question, is this intended? plz fix the db data or remove this check..."
IL_00f5: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_00fa: ldloc.3
IL_00fb: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_0100: ldarg.1
IL_0101: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_0106: ldstr "player"
IL_010b: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_0110: ldfld PixelCrushers.DialogueSystem.Actor TheForestOfLove.Narrative.Actor::pluginDbActor
IL_0115: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_011a: bne.un.s IL_0134
IL_011c: ldarg.3
IL_011d: ldloc.2
IL_011e: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::playerInitiatedQuestion
IL_0123: ldarg.3
IL_0124: ldfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::playerInitiatedQuestion
IL_0129: ldloc.3
IL_012a: stfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstPlayerQuestionDialogueEntry
IL_012f: br IL_01ce
IL_0134: ldloc.3
IL_0135: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Sequence()
IL_013a: callvirt System.String System.String::ToLower()
IL_013f: ldstr "none"
IL_0144: callvirt System.Boolean System.String::Contains(System.String)
IL_0149: brfalse.s IL_01b8
IL_014b: ldarg.3
IL_014c: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0151: ldloc.3
IL_0152: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0157: ldc.i4.0
IL_0158: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_015d: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0162: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_0167: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_016c: ldarg.1
IL_016d: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_0172: ldstr "player"
IL_0177: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_017c: ldfld PixelCrushers.DialogueSystem.Actor TheForestOfLove.Narrative.Actor::pluginDbActor
IL_0181: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0186: bne.un.s IL_01b8
IL_0188: ldarg.3
IL_0189: ldloc.2
IL_018a: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::playerInitiatedQuestion
IL_018f: ldarg.3
IL_0190: ldfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::playerInitiatedQuestion
IL_0195: ldarg.3
IL_0196: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_019b: ldloc.3
IL_019c: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_01a1: ldc.i4.0
IL_01a2: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_01a7: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_01ac: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_01b1: stfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstPlayerQuestionDialogueEntry
IL_01b6: br.s IL_01ce
IL_01b8: ldstr "expecting a player question at the first primary node! "
IL_01bd: ldarg.3
IL_01be: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_01c3: call System.String System.String::Concat(System.String,System.String)
IL_01c8: newobj System.Void System.Exception::.ctor(System.String)
IL_01cd: throw
IL_01ce: ldloc.3
IL_01cf: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.DialogueEntry::fields
IL_01d4: ldstr "TfolUniqueDataKeySuffix"
IL_01d9: call PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.Field::AssignedField(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_01de: stloc.s V_4
IL_01e0: ldloc.s V_4
IL_01e2: brfalse.s IL_01f2
IL_01e4: ldloc.s V_4
IL_01e6: ldfld System.String PixelCrushers.DialogueSystem.Field::value
IL_01eb: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_01f0: brfalse.s IL_0213
IL_01f2: ldstr "all dialogue arcs must have a manually defined unique data key "
IL_01f7: ldloc.3
IL_01f8: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_01fd: ldstr " "
IL_0202: ldarg.3
IL_0203: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0208: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_020d: newobj System.Void System.Exception::.ctor(System.String)
IL_0212: throw
IL_0213: ldloc.s V_4
IL_0215: ldfld System.String PixelCrushers.DialogueSystem.Field::value
IL_021a: stloc.s V_5
IL_021c: ldarg.3
IL_021d: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0222: ldstr "_"
IL_0227: ldloc.s V_5
IL_0229: call System.String System.String::Concat(System.String,System.String,System.String)
IL_022e: stloc.s V_6
IL_0230: ldarg.3
IL_0231: ldfld System.String TheForestOfLove.Narrative.Dialogue::savekey
IL_0236: ldstr "_"
IL_023b: ldloc.s V_5
IL_023d: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0242: stloc.s V_7
IL_0244: ldarg.s arcSublist
IL_0246: ldarg.3
IL_0247: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_024c: bne.un IL_02de
IL_0251: ldloc.s V_5
IL_0253: ldstr "^[p][0-9]*"
IL_0258: call System.Boolean System.Text.RegularExpressions.Regex::IsMatch(System.String,System.String)
IL_025d: brtrue.s IL_0280
IL_025f: ldstr "primary arc unique data key doesn't match conventions "
IL_0264: ldloc.3
IL_0265: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_026a: ldstr " "
IL_026f: ldarg.3
IL_0270: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0275: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_027a: newobj System.Void System.Exception::.ctor(System.String)
IL_027f: throw
IL_0280: ldarg.3
IL_0281: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_0286: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_028b: stloc.s V_9
IL_028d: br.s IL_02c5
IL_028f: ldloca.s V_9
IL_0291: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0296: ldfld System.String TheForestOfLove.Narrative.Arc::generatedName
IL_029b: ldloc.s V_6
IL_029d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02a2: brfalse.s IL_02c5
IL_02a4: ldstr "primary arc unique data key is not unique "
IL_02a9: ldloc.3
IL_02aa: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_02af: ldstr " "
IL_02b4: ldarg.3
IL_02b5: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_02ba: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_02bf: newobj System.Void System.Exception::.ctor(System.String)
IL_02c4: throw
IL_02c5: ldloca.s V_9
IL_02c7: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_02cc: brtrue.s IL_028f
IL_02ce: leave.s IL_02de
IL_02d0: ldloca.s V_9
IL_02d2: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_02d8: callvirt System.Void System.IDisposable::Dispose()
IL_02dd: endfinally
IL_02de: ldarg.s arcSublist
IL_02e0: ldarg.3
IL_02e1: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::secondaryArcs
IL_02e6: bne.un IL_0378
IL_02eb: ldloc.s V_5
IL_02ed: ldstr "^[s][0-9]*"
IL_02f2: call System.Boolean System.Text.RegularExpressions.Regex::IsMatch(System.String,System.String)
IL_02f7: brtrue.s IL_031a
IL_02f9: ldstr "secondary arc unique data key doesn't match conventions "
IL_02fe: ldloc.3
IL_02ff: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_0304: ldstr " "
IL_0309: ldarg.3
IL_030a: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_030f: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0314: newobj System.Void System.Exception::.ctor(System.String)
IL_0319: throw
IL_031a: ldarg.3
IL_031b: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::secondaryArcs
IL_0320: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0325: stloc.s V_9
IL_0327: br.s IL_035f
IL_0329: ldloca.s V_9
IL_032b: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0330: ldfld System.String TheForestOfLove.Narrative.Arc::generatedName
IL_0335: ldloc.s V_6
IL_0337: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_033c: brfalse.s IL_035f
IL_033e: ldstr "secondary arc unique data key is not unique "
IL_0343: ldloc.3
IL_0344: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_0349: ldstr " "
IL_034e: ldarg.3
IL_034f: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0354: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0359: newobj System.Void System.Exception::.ctor(System.String)
IL_035e: throw
IL_035f: ldloca.s V_9
IL_0361: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_0366: brtrue.s IL_0329
IL_0368: leave.s IL_0378
IL_036a: ldloca.s V_9
IL_036c: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_0372: callvirt System.Void System.IDisposable::Dispose()
IL_0377: endfinally
IL_0378: ldarg.s arcSublist
IL_037a: ldarg.3
IL_037b: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::idleArcs
IL_0380: bne.un IL_0412
IL_0385: ldloc.s V_5
IL_0387: ldstr "^[i][0-9]*"
IL_038c: call System.Boolean System.Text.RegularExpressions.Regex::IsMatch(System.String,System.String)
IL_0391: brtrue.s IL_03b4
IL_0393: ldstr "idle arc unique data key doesn't match conventions "
IL_0398: ldloc.3
IL_0399: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_039e: ldstr " "
IL_03a3: ldarg.3
IL_03a4: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_03a9: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_03ae: newobj System.Void System.Exception::.ctor(System.String)
IL_03b3: throw
IL_03b4: ldarg.3
IL_03b5: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::idleArcs
IL_03ba: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_03bf: stloc.s V_9
IL_03c1: br.s IL_03f9
IL_03c3: ldloca.s V_9
IL_03c5: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_03ca: ldfld System.String TheForestOfLove.Narrative.Arc::generatedName
IL_03cf: ldloc.s V_6
IL_03d1: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03d6: brfalse.s IL_03f9
IL_03d8: ldstr "idle arc unique data key is not unique "
IL_03dd: ldloc.3
IL_03de: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_03e3: ldstr " "
IL_03e8: ldarg.3
IL_03e9: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_03ee: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_03f3: newobj System.Void System.Exception::.ctor(System.String)
IL_03f8: throw
IL_03f9: ldloca.s V_9
IL_03fb: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_0400: brtrue.s IL_03c3
IL_0402: leave.s IL_0412
IL_0404: ldloca.s V_9
IL_0406: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_040c: callvirt System.Void System.IDisposable::Dispose()
IL_0411: endfinally
IL_0412: ldarg.s arcSublist
IL_0414: ldarg.3
IL_0415: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::namedArcs
IL_041a: bne.un IL_04ac
IL_041f: ldloc.s V_5
IL_0421: ldstr "^[n][0-9]*"
IL_0426: call System.Boolean System.Text.RegularExpressions.Regex::IsMatch(System.String,System.String)
IL_042b: brtrue.s IL_044e
IL_042d: ldstr "named arc unique data key doesn't match conventions "
IL_0432: ldloc.3
IL_0433: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_0438: ldstr " "
IL_043d: ldarg.3
IL_043e: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0443: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0448: newobj System.Void System.Exception::.ctor(System.String)
IL_044d: throw
IL_044e: ldarg.3
IL_044f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::namedArcs
IL_0454: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0459: stloc.s V_9
IL_045b: br.s IL_0493
IL_045d: ldloca.s V_9
IL_045f: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0464: ldfld System.String TheForestOfLove.Narrative.Arc::generatedName
IL_0469: ldloc.s V_6
IL_046b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0470: brfalse.s IL_0493
IL_0472: ldstr "named arc unique data key is not unique "
IL_0477: ldloc.3
IL_0478: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_047d: ldstr " "
IL_0482: ldarg.3
IL_0483: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0488: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_048d: newobj System.Void System.Exception::.ctor(System.String)
IL_0492: throw
IL_0493: ldloca.s V_9
IL_0495: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_049a: brtrue.s IL_045d
IL_049c: leave.s IL_04ac
IL_049e: ldloca.s V_9
IL_04a0: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_04a6: callvirt System.Void System.IDisposable::Dispose()
IL_04ab: endfinally
IL_04ac: ldloc.2
IL_04ad: ldloc.s V_6
IL_04af: stfld System.String TheForestOfLove.Narrative.Arc::generatedName
IL_04b4: ldloc.2
IL_04b5: ldloc.s V_5
IL_04b7: stfld System.String TheForestOfLove.Narrative.Arc::pluginDbSuffix
IL_04bc: ldloc.2
IL_04bd: ldloc.s V_7
IL_04bf: stfld System.String TheForestOfLove.Narrative.Arc::generatedSavekey
IL_04c4: ldloc.2
IL_04c5: ldarg.3
IL_04c6: stfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.Arc::dialogue
IL_04cb: ldloc.2
IL_04cc: ldarg.3
IL_04cd: ldfld System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Narrative.Dialogue::arcSuffixesDisallowSkip
IL_04d2: ldloc.s V_5
IL_04d4: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Contains(!0)
IL_04d9: stfld System.Boolean TheForestOfLove.Narrative.Arc::isSkipDisallowed
IL_04de: ldloc.2
IL_04df: ldloc.3
IL_04e0: stfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_04e5: ldarg.0
IL_04e6: ldarg.2
IL_04e7: ldloc.2
IL_04e8: ldloc.2
IL_04e9: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_04ee: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::RecursivelyPopulateDialogueEntries(PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry)
IL_04f3: ldarg.3
IL_04f4: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_04f9: ldloc.2
IL_04fa: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::Add(!0)
IL_04ff: ldarg.3
IL_0500: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcsByDbArcSuffix
IL_0505: ldloc.2
IL_0506: ldfld System.String TheForestOfLove.Narrative.Arc::pluginDbSuffix
IL_050b: ldloc.2
IL_050c: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Arc>::Add(!0,!1)
IL_0511: ldarg.3
IL_0512: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcsBySavekey
IL_0517: ldloc.2
IL_0518: ldfld System.String TheForestOfLove.Narrative.Arc::generatedSavekey
IL_051d: ldloc.2
IL_051e: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Arc>::Add(!0,!1)
IL_0523: ldarg.1
IL_0524: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.DataManifest::arcs
IL_0529: ldloc.2
IL_052a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::Add(!0)
IL_052f: ldarg.s arcSublist
IL_0531: ldloc.2
IL_0532: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::Add(!0)
IL_0537: ldloc.1
IL_0538: ldc.i4.1
IL_0539: add
IL_053a: stloc.1
IL_053b: ldloc.1
IL_053c: ldloc.0
IL_053d: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0542: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Count()
IL_0547: blt IL_003e
IL_054c: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::RecursivelyPopulateDialogueEntries(PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_0006: ldarg.3
IL_0007: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_000c: brfalse.s IL_000f
IL_000e: ret
IL_000f: ldarg.2
IL_0010: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_0015: ldarg.3
IL_0016: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Add(!0)
IL_001b: ldarg.3
IL_001c: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0021: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::GetEnumerator()
IL_0026: stloc.0
IL_0027: br.s IL_0050
IL_0029: ldloca.s V_0
IL_002b: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::get_Current()
IL_0030: stloc.1
IL_0031: ldloc.1
IL_0032: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_0037: ldarg.3
IL_0038: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_003d: bne.un.s IL_0050
IL_003f: ldarg.1
IL_0040: ldloc.1
IL_0041: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.DialogueDatabase::GetDialogueEntry(PixelCrushers.DialogueSystem.Link)
IL_0046: stloc.2
IL_0047: ldarg.0
IL_0048: ldarg.1
IL_0049: ldarg.2
IL_004a: ldloc.2
IL_004b: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::RecursivelyPopulateDialogueEntries(PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry)
IL_0050: ldloca.s V_0
IL_0052: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::MoveNext()
IL_0057: brtrue.s IL_0029
IL_0059: leave.s IL_0069
IL_005b: ldloca.s V_0
IL_005d: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>
IL_0063: callvirt System.Void System.IDisposable::Dispose()
IL_0068: endfinally
IL_0069: ret
