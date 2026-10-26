METHOD ForestProbe/Bucky217Selection ForestProbe::ReadBucky217(UnityEngine.UI.Button&) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: call ForestProbe/Bucky141Subtitle ForestProbe::ReadBucky141()
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: ldfld System.Int32 ForestProbe/Bucky141Subtitle::entryId
IL_000e: ldc.i4 215
IL_0013: bne.un.s IL_001c
IL_0015: call System.Boolean TheForestOfLove.CustomTypewriterEffectTextMeshPro::IsTyping()
IL_001a: br.s IL_001d
IL_001c: ldc.i4.1
IL_001d: stloc.s V_6
IL_001f: ldloc.s V_6
IL_0021: brfalse.s IL_002e
IL_0023: ldstr "Bucky217 requires fresh non-typing215 menu"
IL_0028: newobj System.Void System.Exception::.ctor(System.String)
IL_002d: throw
IL_002e: ldarg.0
IL_002f: call System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_0034: stloc.1
IL_0035: ldloc.1
IL_0036: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_003b: ldc.i4.2
IL_003c: bne.un.s IL_005e
IL_003e: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0043: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_0048: brfalse.s IL_005e
IL_004a: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_004f: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_0054: ldlen
IL_0055: conv.i4
IL_0056: ldc.i4.2
IL_0057: ceq
IL_0059: ldc.i4.0
IL_005a: ceq
IL_005c: br.s IL_005f
IL_005e: ldc.i4.1
IL_005f: stloc.s V_7
IL_0061: ldloc.s V_7
IL_0063: brfalse.s IL_0070
IL_0065: ldstr "Bucky217 exact two choices absent"
IL_006a: newobj System.Void System.Exception::.ctor(System.String)
IL_006f: throw
IL_0070: newobj System.Void System.Collections.Generic.HashSet`1<System.Int32>::.ctor()
IL_0075: stloc.2
IL_0076: nop
IL_0077: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_007c: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_0081: stloc.s V_8
IL_0083: ldc.i4.0
IL_0084: stloc.s V_9
IL_0086: br IL_012f
IL_008b: ldloc.s V_8
IL_008d: ldloc.s V_9
IL_008f: ldelem.ref
IL_0090: stloc.s V_10
IL_0092: nop
IL_0093: ldloc.s V_10
IL_0095: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_009a: stloc.s V_11
IL_009c: ldloc.s V_11
IL_009e: brfalse.s IL_0116
IL_00a0: ldloc.s V_11
IL_00a2: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00a7: ldc.i4 216
IL_00ac: beq.s IL_00bc
IL_00ae: ldloc.s V_11
IL_00b0: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00b5: ldc.i4 217
IL_00ba: bne.un.s IL_0116
IL_00bc: ldloc.2
IL_00bd: ldloc.s V_11
IL_00bf: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00c4: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)
IL_00c9: brfalse.s IL_0116
IL_00cb: ldloc.s V_11
IL_00cd: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueManager::get_masterDatabase()
IL_00d2: ldc.i4 141
IL_00d7: ldloc.s V_11
IL_00d9: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00de: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.DialogueDatabase::GetDialogueEntry(System.Int32,System.Int32)
IL_00e3: bne.un.s IL_0116
IL_00e5: ldloc.s V_10
IL_00e7: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_00ec: brfalse.s IL_0116
IL_00ee: ldloc.s V_10
IL_00f0: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_00f5: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_00fa: ldloc.s V_11
IL_00fc: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_0101: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0106: brtrue.s IL_0116
IL_0108: ldloc.s V_10
IL_010a: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_010f: callvirt System.Boolean PixelCrushers.DialogueSystem.FormattedText::get_forceAuto()
IL_0114: br.s IL_0117
IL_0116: ldc.i4.1
IL_0117: stloc.s V_12
IL_0119: ldloc.s V_12
IL_011b: brfalse.s IL_0128
IL_011d: ldstr "Bucky217 exact PC source choices differ"
IL_0122: newobj System.Void System.Exception::.ctor(System.String)
IL_0127: throw
IL_0128: nop
IL_0129: ldloc.s V_9
IL_012b: ldc.i4.1
IL_012c: add
IL_012d: stloc.s V_9
IL_012f: ldloc.s V_9
IL_0131: ldloc.s V_8
IL_0133: ldlen
IL_0134: conv.i4
IL_0135: blt IL_008b
IL_013a: ldloc.2
IL_013b: callvirt System.Void System.Collections.Generic.HashSet`1<System.Int32>::Clear()
IL_0140: nop
IL_0141: nop
IL_0142: ldloc.1
IL_0143: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<ForestProbe/ResponseRow>::GetEnumerator()
IL_0148: stloc.s V_13
IL_014a: br IL_0210
IL_014f: ldloca.s V_13
IL_0151: call !0 System.Collections.Generic.List`1/Enumerator<ForestProbe/ResponseRow>::get_Current()
IL_0156: stloc.s V_14
IL_0158: nop
IL_0159: ldloc.s V_14
IL_015b: ldfld System.Int32 ForestProbe/ResponseRow::entryId
IL_0160: ldc.i4 216
IL_0165: beq.s IL_016e
IL_0167: ldstr "Yes"
IL_016c: br.s IL_0173
IL_016e: ldstr "No"
IL_0173: stloc.s V_15
IL_0175: ldloc.s V_14
IL_0177: ldfld System.Int32 ForestProbe/ResponseRow::entryId
IL_017c: ldc.i4 216
IL_0181: beq.s IL_0191
IL_0183: ldloc.s V_14
IL_0185: ldfld System.Int32 ForestProbe/ResponseRow::entryId
IL_018a: ldc.i4 217
IL_018f: bne.un.s IL_01fd
IL_0191: ldloc.2
IL_0192: ldloc.s V_14
IL_0194: ldfld System.Int32 ForestProbe/ResponseRow::entryId
IL_0199: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)
IL_019e: brfalse.s IL_01fd
IL_01a0: ldloc.s V_14
IL_01a2: ldfld System.Int32 ForestProbe/ResponseRow::conversationId
IL_01a7: ldc.i4 141
IL_01ac: bne.un.s IL_01fd
IL_01ae: ldloc.s V_14
IL_01b0: ldfld System.String ForestProbe/ResponseRow::text
IL_01b5: ldloc.s V_15
IL_01b7: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_01bc: brtrue.s IL_01fd
IL_01be: ldloc.s V_14
IL_01c0: ldfld System.Boolean ForestProbe/ResponseRow::visible
IL_01c5: brfalse.s IL_01fd
IL_01c7: ldloc.s V_14
IL_01c9: ldfld System.Boolean ForestProbe/ResponseRow::clickable
IL_01ce: brfalse.s IL_01fd
IL_01d0: ldloc.s V_14
IL_01d2: ldfld System.String ForestProbe/ResponseRow::targetPath
IL_01d7: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI"
IL_01dc: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_01e1: brtrue.s IL_01fd
IL_01e3: ldloc.s V_14
IL_01e5: ldfld System.String ForestProbe/ResponseRow::path
IL_01ea: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI/Dialogue Panel/Text Panel/Response Menu Panel/Viewport/Content/Response: "
IL_01ef: ldloc.s V_15
IL_01f1: call System.String System.String::Concat(System.String,System.String)
IL_01f6: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_01fb: br.s IL_01fe
IL_01fd: ldc.i4.1
IL_01fe: stloc.s V_16
IL_0200: ldloc.s V_16
IL_0202: brfalse.s IL_020f
IL_0204: ldstr "Bucky217 original response rows differ"
IL_0209: newobj System.Void System.Exception::.ctor(System.String)
IL_020e: throw
IL_020f: nop
IL_0210: ldloca.s V_13
IL_0212: call System.Boolean System.Collections.Generic.List`1/Enumerator<ForestProbe/ResponseRow>::MoveNext()
IL_0217: brtrue IL_014f
IL_021c: leave.s IL_022d
IL_021e: ldloca.s V_13
IL_0220: constrained. System.Collections.Generic.List`1/Enumerator<ForestProbe/ResponseRow>
IL_0226: callvirt System.Void System.IDisposable::Dispose()
IL_022b: nop
IL_022c: endfinally
IL_022d: ldnull
IL_022e: stloc.3
IL_022f: ldnull
IL_0230: stloc.s V_4
IL_0232: nop
IL_0233: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUIResponseButton>()
IL_0238: stloc.s V_17
IL_023a: ldc.i4.0
IL_023b: stloc.s V_18
IL_023d: br IL_058e
IL_0242: ldloc.s V_17
IL_0244: ldloc.s V_18
IL_0246: ldelem.ref
IL_0247: stloc.s V_19
IL_0249: nop
IL_024a: ldloc.s V_19
IL_024c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0251: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0256: stloc.s V_27
IL_0258: ldloca.s V_27
IL_025a: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_025f: brfalse.s IL_0289
IL_0261: ldloc.s V_19
IL_0263: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0268: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_026d: brfalse.s IL_0289
IL_026f: ldloc.s V_19
IL_0271: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0276: brfalse.s IL_0289
IL_0278: ldloc.s V_19
IL_027a: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_027f: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0284: ldnull
IL_0285: ceq
IL_0287: br.s IL_028a
IL_0289: ldc.i4.1
IL_028a: stloc.s V_26
IL_028c: ldloc.s V_26
IL_028e: brfalse.s IL_0295
IL_0290: br IL_0588
IL_0295: ldloc.s V_19
IL_0297: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_029c: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_02a1: stloc.s V_20
IL_02a3: ldloc.s V_20
IL_02a5: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_02aa: ldc.i4 216
IL_02af: beq.s IL_02b8
IL_02b1: ldstr "Yes"
IL_02b6: br.s IL_02bd
IL_02b8: ldstr "No"
IL_02bd: stloc.s V_21
IL_02bf: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI/Dialogue Panel/Text Panel/Response Menu Panel/Viewport/Content/Response: "
IL_02c4: ldloc.s V_21
IL_02c6: call System.String System.String::Concat(System.String,System.String)
IL_02cb: stloc.s V_22
IL_02cd: ldloc.s V_20
IL_02cf: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_02d4: ldc.i4 141
IL_02d9: bne.un IL_0447
IL_02de: ldloc.s V_20
IL_02e0: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_02e5: ldc.i4 216
IL_02ea: beq.s IL_02fd
IL_02ec: ldloc.s V_20
IL_02ee: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_02f3: ldc.i4 217
IL_02f8: bne.un IL_0447
IL_02fd: ldloc.s V_19
IL_02ff: callvirt System.Type System.Object::GetType()
IL_0304: ldtoken PixelCrushers.DialogueSystem.Wrappers.StandardUIResponseButton
IL_0309: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_030e: call System.Boolean System.Type::op_Inequality(System.Type,System.Type)
IL_0313: brtrue IL_0447
IL_0318: ldloc.s V_19
IL_031a: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_031f: brfalse IL_0447
IL_0324: ldloc.s V_19
IL_0326: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isVisible()
IL_032b: brfalse IL_0447
IL_0330: ldloc.s V_19
IL_0332: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isClickable()
IL_0337: brfalse IL_0447
IL_033c: ldloc.s V_19
IL_033e: callvirt System.String PixelCrushers.DialogueSystem.StandardUIResponseButton::get_text()
IL_0343: ldloc.s V_21
IL_0345: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_034a: brtrue IL_0447
IL_034f: ldloc.s V_19
IL_0351: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0356: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_035b: ldloc.s V_22
IL_035d: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0362: brtrue IL_0447
IL_0367: ldloc.s V_19
IL_0369: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_036e: ldnull
IL_036f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0374: brtrue IL_0447
IL_0379: ldloc.s V_19
IL_037b: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0380: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0385: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI"
IL_038a: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_038f: brtrue IL_0447
IL_0394: ldloc.s V_19
IL_0396: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_039b: ldnull
IL_039c: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_03a1: brtrue IL_0447
IL_03a6: ldloc.s V_19
IL_03a8: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_03ad: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_03b2: ldloc.s V_19
IL_03b4: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_03b9: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_03be: brtrue IL_0447
IL_03c3: ldloc.s V_19
IL_03c5: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_03ca: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_03cf: brfalse.s IL_0447
IL_03d1: ldloc.s V_19
IL_03d3: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_03d8: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_03dd: brfalse.s IL_0447
IL_03df: ldloc.s V_19
IL_03e1: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_03e6: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_03eb: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_03f0: brtrue.s IL_0447
IL_03f2: ldloc.s V_20
IL_03f4: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueManager::get_masterDatabase()
IL_03f9: ldc.i4 141
IL_03fe: ldloc.s V_20
IL_0400: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0405: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.DialogueDatabase::GetDialogueEntry(System.Int32,System.Int32)
IL_040a: bne.un.s IL_0447
IL_040c: ldloc.s V_19
IL_040e: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0413: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_0418: brfalse.s IL_0447
IL_041a: ldloc.s V_19
IL_041c: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0421: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_0426: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_042b: ldloc.s V_21
IL_042d: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0432: brtrue.s IL_0447
IL_0434: ldloc.s V_19
IL_0436: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_043b: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_0440: callvirt System.Boolean PixelCrushers.DialogueSystem.FormattedText::get_forceAuto()
IL_0445: br.s IL_0448
IL_0447: ldc.i4.1
IL_0448: stloc.s V_28
IL_044a: ldloc.s V_28
IL_044c: brfalse.s IL_0459
IL_044e: ldstr "Bucky217 original response control differs"
IL_0453: newobj System.Void System.Exception::.ctor(System.String)
IL_0458: throw
IL_0459: ldtoken UnityEngine.Events.UnityEventBase
IL_045e: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0463: ldstr "m_Calls"
IL_0468: ldc.i4.s 36
IL_046a: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_046f: ldloc.s V_19
IL_0471: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0476: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_047b: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0480: stloc.s V_23
IL_0482: ldloc.s V_23
IL_0484: ldstr "m_RuntimeCalls"
IL_0489: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_048e: isinst System.Collections.IList
IL_0493: stloc.s V_24
IL_0495: ldloc.s V_24
IL_0497: brfalse.s IL_04a8
IL_0499: ldloc.s V_24
IL_049b: callvirt System.Int32 System.Collections.ICollection::get_Count()
IL_04a0: ldc.i4.1
IL_04a1: ceq
IL_04a3: ldc.i4.0
IL_04a4: ceq
IL_04a6: br.s IL_04a9
IL_04a8: ldc.i4.1
IL_04a9: stloc.s V_29
IL_04ab: ldloc.s V_29
IL_04ad: brfalse.s IL_04ba
IL_04af: ldstr "Bucky217 runtime listener count differs"
IL_04b4: newobj System.Void System.Exception::.ctor(System.String)
IL_04b9: throw
IL_04ba: ldloc.s V_24
IL_04bc: ldc.i4.0
IL_04bd: callvirt System.Object System.Collections.IList::get_Item(System.Int32)
IL_04c2: ldstr "Delegate"
IL_04c7: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_04cc: isinst System.Delegate
IL_04d1: stloc.s V_25
IL_04d3: ldloc.s V_25
IL_04d5: brfalse.s IL_0523
IL_04d7: ldloc.s V_25
IL_04d9: callvirt System.Delegate[] System.Delegate::GetInvocationList()
IL_04de: ldlen
IL_04df: conv.i4
IL_04e0: ldc.i4.1
IL_04e1: bne.un.s IL_0523
IL_04e3: ldloc.s V_25
IL_04e5: callvirt System.Object System.Delegate::get_Target()
IL_04ea: ldloc.s V_19
IL_04ec: bne.un.s IL_0523
IL_04ee: ldloc.s V_25
IL_04f0: callvirt System.Reflection.MethodInfo System.Delegate::get_Method()
IL_04f5: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_04fa: ldstr "OnClick"
IL_04ff: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0504: brtrue.s IL_0523
IL_0506: ldloc.s V_25
IL_0508: callvirt System.Reflection.MethodInfo System.Delegate::get_Method()
IL_050d: callvirt System.Type System.Reflection.MemberInfo::get_DeclaringType()
IL_0512: ldtoken PixelCrushers.DialogueSystem.StandardUIResponseButton
IL_0517: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_051c: call System.Boolean System.Type::op_Inequality(System.Type,System.Type)
IL_0521: br.s IL_0524
IL_0523: ldc.i4.1
IL_0524: stloc.s V_30
IL_0526: ldloc.s V_30
IL_0528: brfalse.s IL_0535
IL_052a: ldstr "Bucky217 runtime listener target differs"
IL_052f: newobj System.Void System.Exception::.ctor(System.String)
IL_0534: throw
IL_0535: ldloc.s V_20
IL_0537: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_053c: ldc.i4 217
IL_0541: ceq
IL_0543: stloc.s V_31
IL_0545: ldloc.s V_31
IL_0547: brfalse.s IL_0568
IL_0549: nop
IL_054a: ldloc.3
IL_054b: ldnull
IL_054c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0551: stloc.s V_32
IL_0553: ldloc.s V_32
IL_0555: brfalse.s IL_0562
IL_0557: ldstr "Ambiguous Bucky217 button"
IL_055c: newobj System.Void System.Exception::.ctor(System.String)
IL_0561: throw
IL_0562: ldloc.s V_19
IL_0564: stloc.3
IL_0565: nop
IL_0566: br.s IL_0587
IL_0568: nop
IL_0569: ldloc.s V_4
IL_056b: ldnull
IL_056c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0571: stloc.s V_33
IL_0573: ldloc.s V_33
IL_0575: brfalse.s IL_0582
IL_0577: ldstr "Ambiguous Bucky216 button"
IL_057c: newobj System.Void System.Exception::.ctor(System.String)
IL_0581: throw
IL_0582: ldloc.s V_19
IL_0584: stloc.s V_4
IL_0586: nop
IL_0587: nop
IL_0588: ldloc.s V_18
IL_058a: ldc.i4.1
IL_058b: add
IL_058c: stloc.s V_18
IL_058e: ldloc.s V_18
IL_0590: ldloc.s V_17
IL_0592: ldlen
IL_0593: conv.i4
IL_0594: blt IL_0242
IL_0599: ldloc.3
IL_059a: ldnull
IL_059b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_05a0: brtrue.s IL_05ca
IL_05a2: ldloc.s V_4
IL_05a4: ldnull
IL_05a5: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_05aa: brtrue.s IL_05ca
IL_05ac: ldloc.3
IL_05ad: ldloc.s V_4
IL_05af: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_05b4: brtrue.s IL_05ca
IL_05b6: ldloc.3
IL_05b7: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_05bc: ldloc.s V_4
IL_05be: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_05c3: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_05c8: br.s IL_05cb
IL_05ca: ldc.i4.1
IL_05cb: stloc.s V_34
IL_05cd: ldloc.s V_34
IL_05cf: brfalse.s IL_05dc
IL_05d1: ldstr "Bucky217 original distinct buttons absent"
IL_05d6: newobj System.Void System.Exception::.ctor(System.String)
IL_05db: throw
IL_05dc: ldarg.1
IL_05dd: ldloc.3
IL_05de: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_05e3: stind.ref
IL_05e4: ldloc.3
IL_05e5: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_05ea: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_05ef: stloc.s V_5
IL_05f1: newobj System.Void ForestProbe/Bucky217Selection::.ctor()
IL_05f6: stloc.s V_35
IL_05f8: ldloc.s V_35
IL_05fa: ldstr "synthetic"
IL_05ff: stfld System.String ForestProbe/Bucky217Selection::choiceMode
IL_0604: ldloc.s V_35
IL_0606: call System.Int32 UnityEngine.Time::get_frameCount()
IL_060b: stfld System.Int32 ForestProbe/Bucky217Selection::frame
IL_0610: ldloc.s V_35
IL_0612: ldc.i4 141
IL_0617: stfld System.Int32 ForestProbe/Bucky217Selection::conversationId
IL_061c: ldloc.s V_35
IL_061e: ldc.i4 215
IL_0623: stfld System.Int32 ForestProbe/Bucky217Selection::sourceId
IL_0628: ldloc.s V_35
IL_062a: ldc.i4 217
IL_062f: stfld System.Int32 ForestProbe/Bucky217Selection::destinationId
IL_0634: ldloc.s V_35
IL_0636: ldc.i4 194
IL_063b: stfld System.Int32 ForestProbe/Bucky217Selection::successorId
IL_0640: ldloc.s V_35
IL_0642: ldstr "Yes"
IL_0647: stfld System.String ForestProbe/Bucky217Selection::text
IL_064c: ldloc.s V_35
IL_064e: ldloc.s V_5
IL_0650: stfld System.String ForestProbe/Bucky217Selection::path
IL_0655: ldloc.s V_35
IL_0657: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI"
IL_065c: stfld System.String ForestProbe/Bucky217Selection::targetPath
IL_0661: ldloc.s V_35
IL_0663: ldstr "OnClick"
IL_0668: stfld System.String ForestProbe/Bucky217Selection::listenerMethod
IL_066d: ldloc.s V_35
IL_066f: ldloc.s V_5
IL_0671: stfld System.String ForestProbe/Bucky217Selection::listenerTargetPath
IL_0676: ldloc.s V_35
IL_0678: ldarg.1
IL_0679: ldind.ref
IL_067a: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_067f: stfld System.Int32 ForestProbe/Bucky217Selection::buttonInstance
IL_0684: ldloc.s V_35
IL_0686: ldloc.3
IL_0687: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_068c: stfld System.Int32 ForestProbe/Bucky217Selection::controllerInstance
IL_0691: ldloc.s V_35
IL_0693: ldloc.s V_4
IL_0695: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_069a: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_069f: stfld System.Int32 ForestProbe/Bucky217Selection::declinedButtonInstance
IL_06a4: ldloc.s V_35
IL_06a6: ldloc.s V_4
IL_06a8: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_06ad: stfld System.Int32 ForestProbe/Bucky217Selection::declinedControllerInstance
IL_06b2: ldloc.s V_35
IL_06b4: ldloc.3
IL_06b5: callvirt System.Type System.Object::GetType()
IL_06ba: callvirt System.String System.Type::get_FullName()
IL_06bf: stfld System.String ForestProbe/Bucky217Selection::controllerType
IL_06c4: ldloc.s V_35
IL_06c6: ldloc.s V_4
IL_06c8: callvirt System.Type System.Object::GetType()
IL_06cd: callvirt System.String System.Type::get_FullName()
IL_06d2: stfld System.String ForestProbe/Bucky217Selection::declinedControllerType
IL_06d7: ldloc.s V_35
IL_06d9: ldtoken PixelCrushers.DialogueSystem.StandardUIResponseButton
IL_06de: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_06e3: callvirt System.String System.Type::get_FullName()
IL_06e8: stfld System.String ForestProbe/Bucky217Selection::listenerDeclaringType
IL_06ed: ldloc.s V_35
IL_06ef: ldtoken PixelCrushers.DialogueSystem.StandardUIResponseButton
IL_06f4: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_06f9: callvirt System.String System.Type::get_FullName()
IL_06fe: stfld System.String ForestProbe/Bucky217Selection::declinedListenerDeclaringType
IL_0703: ldloc.s V_35
IL_0705: ldc.i4.0
IL_0706: stfld System.Boolean ForestProbe/Bucky217Selection::typing
IL_070b: ldloc.s V_35
IL_070d: ldc.i4.1
IL_070e: stfld System.Boolean ForestProbe/Bucky217Selection::graphVerified
IL_0713: ldloc.s V_35
IL_0715: ldc.i4.1
IL_0716: stfld System.Boolean ForestProbe/Bucky217Selection::listenerVerified
IL_071b: ldloc.s V_35
IL_071d: stloc.s V_36
IL_071f: br.s IL_0721
IL_0721: ldloc.s V_36
IL_0723: ret
