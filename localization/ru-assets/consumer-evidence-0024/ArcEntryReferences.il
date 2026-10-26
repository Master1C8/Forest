METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::PopulateDialogueArcs(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Dialogue,System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>)
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
METHOD System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_0000: ldarg.2
IL_0001: ldarg.1
IL_0002: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0007: bne.un.s IL_000b
IL_0009: ldarg.3
IL_000a: ret
IL_000b: ldnull
IL_000c: stloc.0
IL_000d: ldarg.1
IL_000e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_0013: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::GetEnumerator()
IL_0018: stloc.1
IL_0019: br.s IL_007f
IL_001b: ldloca.s V_1
IL_001d: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>::get_Current()
IL_0022: stloc.2
IL_0023: ldloc.2
IL_0024: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0029: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::GetEnumerator()
IL_002e: stloc.3
IL_002f: br.s IL_0061
IL_0031: ldloca.s V_3
IL_0033: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::get_Current()
IL_0038: stloc.s V_4
IL_003a: ldloc.s V_4
IL_003c: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_0041: ldarg.1
IL_0042: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0047: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_004c: bne.un.s IL_0061
IL_004e: ldloc.s V_4
IL_0050: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0055: ldarg.2
IL_0056: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_005b: bne.un.s IL_0061
IL_005d: ldloc.2
IL_005e: stloc.0
IL_005f: leave.s IL_007a
IL_0061: ldloca.s V_3
IL_0063: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::MoveNext()
IL_0068: brtrue.s IL_0031
IL_006a: leave.s IL_007a
IL_006c: ldloca.s V_3
IL_006e: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>
IL_0074: callvirt System.Void System.IDisposable::Dispose()
IL_0079: endfinally
IL_007a: ldloc.0
IL_007b: brfalse.s IL_007f
IL_007d: leave.s IL_0098
IL_007f: ldloca.s V_1
IL_0081: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>::MoveNext()
IL_0086: brtrue.s IL_001b
IL_0088: leave.s IL_0098
IL_008a: ldloca.s V_1
IL_008c: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>
IL_0092: callvirt System.Void System.IDisposable::Dispose()
IL_0097: endfinally
IL_0098: ldloc.0
IL_0099: brfalse.s IL_00a7
IL_009b: ldarg.0
IL_009c: ldarg.1
IL_009d: ldloc.0
IL_009e: ldarg.3
IL_009f: ldc.i4.1
IL_00a0: add
IL_00a1: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_00a6: ret
IL_00a7: ldstr "error finding parent dialogue entry in "
IL_00ac: ldarg.1
IL_00ad: ldfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.Arc::dialogue
IL_00b2: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00b7: ldstr "."
IL_00bc: ldarg.1
IL_00bd: ldfld System.String TheForestOfLove.Narrative.Arc::generatedName
IL_00c2: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_00c7: newobj System.Void System.Exception::.ctor(System.String)
IL_00cc: throw
METHOD System.Void TheForestOfLove.Narrative.DialogueService::BuildDynamicConversation(System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Arc>,System.Boolean,System.String,System.Boolean)
IL_0000: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.DialogueSystem.DialogueSystemController>()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: callvirt System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::get_IsConversationActive()
IL_000c: brtrue.s IL_000f
IL_000e: ret
IL_000f: ldloc.0
IL_0010: callvirt System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.ActiveConversationRecord> PixelCrushers.DialogueSystem.DialogueSystemController::get_activeConversations()
IL_0015: ldc.i4.0
IL_0016: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.ActiveConversationRecord>::get_Item(System.Int32)
IL_001b: stloc.1
IL_001c: ldloc.0
IL_001d: callvirt PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::get_databaseManager()
IL_0022: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_0027: stloc.2
IL_0028: ldloc.2
IL_0029: ldstr "system/dynamicConversation"
IL_002e: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)
IL_0033: stloc.3
IL_0034: ldloc.3
IL_0035: ldstr "PASSTHROUGH"
IL_003a: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_003f: stloc.s V_4
IL_0041: ldloc.3
IL_0042: ldstr "DYNAMICROOT"
IL_0047: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_004c: stloc.s V_5
IL_004e: ldloc.3
IL_004f: ldstr "DYNAMICQUESTIONS"
IL_0054: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_0059: stloc.s V_6
IL_005b: ldloc.3
IL_005c: ldstr "GENERICFAREWELL"
IL_0061: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_0066: stloc.s V_7
IL_0068: ldloc.s V_6
IL_006a: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_006f: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Clear()
IL_0074: ldloc.s V_5
IL_0076: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_007b: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Clear()
IL_0080: ldarg.2
IL_0081: brfalse IL_016c
IL_0086: ldarg.3
IL_0087: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_008c: stloc.s V_8
IL_008e: ldloc.2
IL_008f: ldstr "system/dynamicQuestions/{0}"
IL_0094: ldloc.s V_8
IL_0096: ldfld System.String TheForestOfLove.Narrative.Actor::pluginDbName
IL_009b: call System.String System.String::Format(System.String,System.Object)
IL_00a0: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)
IL_00a5: stloc.s V_9
IL_00a7: ldloc.s V_9
IL_00a9: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetFirstDialogueEntry()
IL_00ae: stloc.s V_10
IL_00b0: ldloc.s V_5
IL_00b2: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_00b7: ldloc.3
IL_00b8: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00bd: ldloc.s V_5
IL_00bf: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00c4: ldloc.s V_9
IL_00c6: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00cb: ldloc.s V_10
IL_00cd: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00d2: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_00d7: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_00dc: ldarg.1
IL_00dd: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_00e2: stloc.s V_11
IL_00e4: br.s IL_0125
IL_00e6: ldloc.s V_11
IL_00e8: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Arc>::get_Current()
IL_00ed: stloc.s V_12
IL_00ef: ldloc.s V_6
IL_00f1: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_00f6: ldloc.3
IL_00f7: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00fc: ldloc.s V_6
IL_00fe: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0103: ldloc.s V_12
IL_0105: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_010a: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_010f: ldloc.s V_12
IL_0111: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0116: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_011b: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_0120: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_0125: ldloc.s V_11
IL_0127: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_012c: brtrue.s IL_00e6
IL_012e: leave.s IL_013c
IL_0130: ldloc.s V_11
IL_0132: brfalse.s IL_013b
IL_0134: ldloc.s V_11
IL_0136: callvirt System.Void System.IDisposable::Dispose()
IL_013b: endfinally
IL_013c: ldloc.s V_6
IL_013e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0143: ldloc.3
IL_0144: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0149: ldloc.s V_6
IL_014b: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0150: ldloc.3
IL_0151: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0156: ldloc.s V_7
IL_0158: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_015d: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_0162: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_0167: br IL_0290
IL_016c: ldarg.1
IL_016d: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0172: stloc.s V_11
IL_0174: br IL_0276
IL_0179: ldloc.s V_11
IL_017b: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0180: stloc.s V_13
IL_0182: ldloc.s V_13
IL_0184: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0189: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_018e: stloc.s V_14
IL_0190: ldarg.s skipPlayerQuestion
IL_0192: brfalse IL_024a
IL_0197: ldloc.2
IL_0198: ldloc.s V_13
IL_019a: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_019f: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_01a4: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.Int32)
IL_01a9: stloc.s V_15
IL_01ab: ldloc.s V_15
IL_01ad: ldloc.s V_13
IL_01af: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_01b4: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_01b9: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_01be: stloc.s V_16
IL_01c0: ldloc.s V_13
IL_01c2: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstPlayerQuestionDialogueEntry
IL_01c7: brfalse.s IL_01d2
IL_01c9: ldloc.s V_13
IL_01cb: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstPlayerQuestionDialogueEntry
IL_01d0: stloc.s V_16
IL_01d2: ldloc.s V_13
IL_01d4: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_01d9: ldloc.s V_13
IL_01db: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstPlayerQuestionDialogueEntry
IL_01e0: beq.s IL_020c
IL_01e2: ldarg.0
IL_01e3: ldloc.s V_13
IL_01e5: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_01ea: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_01ef: ldloc.s V_13
IL_01f1: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_01f6: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_01fb: ldloc.s V_13
IL_01fd: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0202: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_subtitleText()
IL_0207: call System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineEnd(System.Int32,System.Int32,System.String)
IL_020c: ldloc.2
IL_020d: ldloc.s V_16
IL_020f: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_0214: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32)
IL_0219: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_021e: ldstr "player"
IL_0223: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0228: brfalse.s IL_024a
IL_022a: ldloc.s V_15
IL_022c: ldloc.s V_16
IL_022e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0233: ldc.i4.0
IL_0234: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0239: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_023e: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_0243: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0248: stloc.s V_14
IL_024a: ldloc.s V_5
IL_024c: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0251: ldloc.3
IL_0252: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0257: ldloc.s V_5
IL_0259: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_025e: ldloc.s V_13
IL_0260: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0265: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_026a: ldloc.s V_14
IL_026c: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_0271: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_0276: ldloc.s V_11
IL_0278: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_027d: brtrue IL_0179
IL_0282: leave.s IL_0290
IL_0284: ldloc.s V_11
IL_0286: brfalse.s IL_028f
IL_0288: ldloc.s V_11
IL_028a: callvirt System.Void System.IDisposable::Dispose()
IL_028f: endfinally
IL_0290: ldloc.1
IL_0291: callvirt PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ActiveConversationRecord::get_conversationModel()
IL_0296: ldloc.s V_4
IL_0298: callvirt System.Void PixelCrushers.DialogueSystem.ConversationModel::ForceNextStateToLinkToEntry(PixelCrushers.DialogueSystem.DialogueEntry)
IL_029d: ret
