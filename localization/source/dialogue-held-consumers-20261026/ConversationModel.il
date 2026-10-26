TYPE PixelCrushers.DialogueSystem.ConversationModel
METHOD PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::GetState(PixelCrushers.DialogueSystem.DialogueEntry,System.Boolean,System.Boolean,System.Boolean)
IL_0000: ldarg.1
IL_0001: brfalse IL_0170
IL_0006: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_000b: ldstr "OnPrepareConversationLine"
IL_0010: ldarg.1
IL_0011: ldc.i4.1
IL_0012: callvirt System.Void UnityEngine.Component::SendMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_0017: ldarg.1
IL_0018: call System.Void PixelCrushers.DialogueSystem.DialogueLua::MarkDialogueEntryDisplayed(PixelCrushers.DialogueSystem.DialogueEntry)
IL_001d: ldstr "thisID = "
IL_0022: ldarg.1
IL_0023: ldflda System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0028: call System.String System.Int32::ToString()
IL_002d: call System.String System.String::Concat(System.String,System.String)
IL_0032: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::Run(System.String)
IL_0037: pop
IL_0038: ldarg.0
IL_0039: ldarg.1
IL_003a: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_003f: call System.Void PixelCrushers.DialogueSystem.ConversationModel::SetDialogTable(System.Int32)
IL_0044: ldarg.s skipExecution
IL_0046: brtrue.s IL_006a
IL_0048: ldarg.1
IL_0049: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::userScript
IL_004e: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_0053: ldarg.0
IL_0054: ldfld System.Boolean PixelCrushers.DialogueSystem.ConversationModel::m_allowLuaExceptions
IL_0059: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::Run(System.String,System.Boolean,System.Boolean)
IL_005e: pop
IL_005f: ldarg.1
IL_0060: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_0065: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_006a: ldarg.0
IL_006b: ldarg.1
IL_006c: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_0071: call PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::GetCharacterInfo(System.Int32)
IL_0076: stloc.0
IL_0077: ldarg.0
IL_0078: ldarg.1
IL_0079: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ConversantID()
IL_007e: call PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::GetCharacterInfo(System.Int32)
IL_0083: stloc.1
IL_0084: ldarg.s skipExecution
IL_0086: brtrue.s IL_00ce
IL_0088: ldarg.1
IL_0089: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_sceneEventGuid()
IL_008e: call PixelCrushers.DialogueSystem.DialogueEntrySceneEvent PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::GetDialogueEntrySceneEvent(System.String)
IL_0093: stloc.s V_6
IL_0095: ldloc.0
IL_0096: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_009b: ldnull
IL_009c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00a1: brtrue.s IL_00af
IL_00a3: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_00a8: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00ad: br.s IL_00ba
IL_00af: ldloc.0
IL_00b0: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_00b5: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00ba: stloc.s V_7
IL_00bc: ldloc.s V_6
IL_00be: brfalse.s IL_00ce
IL_00c0: ldloc.s V_6
IL_00c2: ldfld PixelCrushers.GameObjectUnityEvent PixelCrushers.DialogueSystem.DialogueEntrySceneEvent::onExecute
IL_00c7: ldloc.s V_7
IL_00c9: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.GameObject>::Invoke(!0)
IL_00ce: ldarg.1
IL_00cf: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_subtitleText()
IL_00d4: ldarg.0
IL_00d5: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_00da: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.DialogueDatabase::emphasisSettings
IL_00df: call PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.FormattedText::Parse(System.String,PixelCrushers.DialogueSystem.EmphasisSetting[])
IL_00e4: stloc.2
IL_00e5: ldarg.0
IL_00e6: ldarg.1
IL_00e7: call System.Void PixelCrushers.DialogueSystem.ConversationModel::CheckSequenceField(PixelCrushers.DialogueSystem.DialogueEntry)
IL_00ec: ldarg.0
IL_00ed: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_00f2: ldarg.1
IL_00f3: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_00f8: ldarg.1
IL_00f9: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00fe: ldarg.0
IL_00ff: ldfld PixelCrushers.DialogueSystem.EntrytagFormat PixelCrushers.DialogueSystem.ConversationModel::m_entrytagFormat
IL_0104: callvirt System.String PixelCrushers.DialogueSystem.DialogueDatabase::GetEntrytag(System.Int32,System.Int32,PixelCrushers.DialogueSystem.EntrytagFormat)
IL_0109: stloc.3
IL_010a: ldloc.0
IL_010b: ldloc.1
IL_010c: ldloc.2
IL_010d: ldarg.1
IL_010e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentSequence()
IL_0113: ldarg.1
IL_0114: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentResponseMenuSequence()
IL_0119: ldarg.1
IL_011a: ldloc.3
IL_011b: newobj System.Void PixelCrushers.DialogueSystem.Subtitle::.ctor(PixelCrushers.DialogueSystem.CharacterInfo,PixelCrushers.DialogueSystem.CharacterInfo,PixelCrushers.DialogueSystem.FormattedText,System.String,System.String,PixelCrushers.DialogueSystem.DialogueEntry,System.String)
IL_0120: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::.ctor()
IL_0125: stloc.s V_4
IL_0127: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::.ctor()
IL_012c: stloc.s V_5
IL_012e: ldarg.2
IL_012f: brfalse.s IL_0156
IL_0131: ldarg.0
IL_0132: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.ConversationModel::forceLinkEntry
IL_0137: brfalse.s IL_0145
IL_0139: ldarg.0
IL_013a: ldloc.s V_4
IL_013c: ldloc.s V_5
IL_013e: call System.Void PixelCrushers.DialogueSystem.ConversationModel::AddForcedLink(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>)
IL_0143: br.s IL_0156
IL_0145: ldarg.0
IL_0146: ldarg.1
IL_0147: ldloc.s V_4
IL_0149: ldloc.s V_5
IL_014b: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::.ctor()
IL_0150: ldarg.3
IL_0151: call System.Void PixelCrushers.DialogueSystem.ConversationModel::EvaluateLinks(PixelCrushers.DialogueSystem.DialogueEntry,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>,System.Boolean)
IL_0156: ldloc.s V_4
IL_0158: callvirt !0[] System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::ToArray()
IL_015d: ldloc.s V_5
IL_015f: callvirt !0[] System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::ToArray()
IL_0164: ldarg.1
IL_0165: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueEntry::isGroup
IL_016a: newobj System.Void PixelCrushers.DialogueSystem.ConversationState::.ctor(PixelCrushers.DialogueSystem.Subtitle,PixelCrushers.DialogueSystem.Response[],PixelCrushers.DialogueSystem.Response[],System.Boolean)
IL_016f: ret
IL_0170: ldnull
IL_0171: ret
METHOD PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::GetState(PixelCrushers.DialogueSystem.DialogueEntry)
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldc.i4.1
IL_0003: ldc.i4.0
IL_0004: ldc.i4.0
IL_0005: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::GetState(PixelCrushers.DialogueSystem.DialogueEntry,System.Boolean,System.Boolean,System.Boolean)
IL_000a: ret
METHOD System.Void PixelCrushers.DialogueSystem.ConversationModel::CheckSequenceField(PixelCrushers.DialogueSystem.DialogueEntry)
IL_0000: ldarg.1
IL_0001: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentSequence()
IL_0006: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000b: brfalse.s IL_0047
IL_000d: ldarg.1
IL_000e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_VideoFile()
IL_0013: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0018: brtrue.s IL_0047
IL_001a: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logWarnings()
IL_001f: brfalse.s IL_0047
IL_0021: ldstr "{0}: Dialogue entry '{1}' Video File field is assigned but Sequence is blank. Cutscenes now use Sequence field."
IL_0026: ldc.i4.2
IL_0027: newarr System.Object
IL_002c: dup
IL_002d: ldc.i4.0
IL_002e: ldstr "Dialogue System"
IL_0033: stelem.ref
IL_0034: dup
IL_0035: ldc.i4.1
IL_0036: ldarg.1
IL_0037: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentDialogueText()
IL_003c: stelem.ref
IL_003d: call System.String System.String::Format(System.String,System.Object[])
IL_0042: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0047: ret
METHOD System.Void PixelCrushers.DialogueSystem.ConversationModel::EvaluateLinksAtPriority(PixelCrushers.DialogueSystem.ConditionPriority,PixelCrushers.DialogueSystem.DialogueEntry,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>,System.Boolean)
IL_0000: ldarg.2
IL_0001: brfalse IL_0434
IL_0006: ldc.i4.0
IL_0007: stloc.0
IL_0008: br IL_0423
IL_000d: ldarg.2
IL_000e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0013: ldloc.0
IL_0014: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0019: stloc.1
IL_001a: ldarg.0
IL_001b: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_0020: ldloc.1
IL_0021: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.DialogueDatabase::GetDialogueEntry(PixelCrushers.DialogueSystem.Link)
IL_0026: stloc.2
IL_0027: ldloc.2
IL_0028: brfalse IL_041f
IL_002d: ldloc.1
IL_002e: ldfld PixelCrushers.DialogueSystem.ConditionPriority PixelCrushers.DialogueSystem.Link::priority
IL_0033: ldarg.1
IL_0034: bne.un IL_041f
IL_0039: ldarg.0
IL_003a: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_003f: ldloc.2
IL_0040: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_0045: callvirt PixelCrushers.DialogueSystem.CharacterType PixelCrushers.DialogueSystem.DialogueDatabase::GetCharacterType(System.Int32)
IL_004a: stloc.3
IL_004b: ldstr "thisID = "
IL_0050: ldloc.2
IL_0051: ldflda System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0056: call System.String System.Int32::ToString()
IL_005b: call System.String System.String::Concat(System.String,System.String)
IL_0060: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::Run(System.String)
IL_0065: pop
IL_0066: ldloc.2
IL_0067: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::conditionsString
IL_006c: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_0071: ldarg.0
IL_0072: ldfld System.Boolean PixelCrushers.DialogueSystem.ConversationModel::m_allowLuaExceptions
IL_0077: call System.Boolean PixelCrushers.DialogueSystem.Lua::IsTrue(System.String,System.Boolean,System.Boolean)
IL_007c: brfalse.s IL_0097
IL_007e: ldarg.0
IL_007f: call PixelCrushers.DialogueSystem.IsDialogueEntryValidDelegate PixelCrushers.DialogueSystem.ConversationModel::get_isDialogueEntryValid()
IL_0084: brfalse.s IL_0094
IL_0086: ldarg.0
IL_0087: call PixelCrushers.DialogueSystem.IsDialogueEntryValidDelegate PixelCrushers.DialogueSystem.ConversationModel::get_isDialogueEntryValid()
IL_008c: ldloc.2
IL_008d: callvirt System.Boolean PixelCrushers.DialogueSystem.IsDialogueEntryValidDelegate::Invoke(PixelCrushers.DialogueSystem.DialogueEntry)
IL_0092: br.s IL_0098
IL_0094: ldc.i4.1
IL_0095: br.s IL_0098
IL_0097: ldc.i4.0
IL_0098: stloc.s V_4
IL_009a: ldloc.s V_4
IL_009c: brtrue.s IL_00af
IL_009e: ldarg.0
IL_009f: ldfld System.Boolean PixelCrushers.DialogueSystem.ConversationModel::m_includeInvalidEntries
IL_00a4: brfalse IL_0309
IL_00a9: ldloc.3
IL_00aa: brtrue IL_0309
IL_00af: ldloc.2
IL_00b0: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueEntry::isGroup
IL_00b5: brfalse IL_0192
IL_00ba: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_00bf: brfalse.s IL_0127
IL_00c1: ldstr "{0}: Add Group ({1}): ID={2}:{3} '{4}' ({5})"
IL_00c6: ldc.i4.6
IL_00c7: newarr System.Object
IL_00cc: dup
IL_00cd: ldc.i4.0
IL_00ce: ldstr "Dialogue System"
IL_00d3: stelem.ref
IL_00d4: dup
IL_00d5: ldc.i4.1
IL_00d6: ldarg.0
IL_00d7: ldarg.0
IL_00d8: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_00dd: ldloc.2
IL_00de: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_00e3: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32)
IL_00e8: call System.String PixelCrushers.DialogueSystem.ConversationModel::GetActorName(PixelCrushers.DialogueSystem.Actor)
IL_00ed: stelem.ref
IL_00ee: dup
IL_00ef: ldc.i4.2
IL_00f0: ldloc.1
IL_00f1: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_00f6: box System.Int32
IL_00fb: stelem.ref
IL_00fc: dup
IL_00fd: ldc.i4.3
IL_00fe: ldloc.1
IL_00ff: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0104: box System.Int32
IL_0109: stelem.ref
IL_010a: dup
IL_010b: ldc.i4.4
IL_010c: ldloc.2
IL_010d: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0112: stelem.ref
IL_0113: dup
IL_0114: ldc.i4.5
IL_0115: ldloc.s V_4
IL_0117: box System.Boolean
IL_011c: stelem.ref
IL_011d: call System.String System.String::Format(System.String,System.Object[])
IL_0122: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0127: ldloc.2
IL_0128: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::userScript
IL_012d: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_0132: ldarg.0
IL_0133: ldfld System.Boolean PixelCrushers.DialogueSystem.ConversationModel::m_allowLuaExceptions
IL_0138: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::Run(System.String,System.Boolean,System.Boolean)
IL_013d: pop
IL_013e: ldloc.2
IL_013f: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_0144: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0149: ldc.i4.4
IL_014a: stloc.s V_5
IL_014c: br.s IL_0188
IL_014e: ldarg.3
IL_014f: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::get_Count()
IL_0154: ldarg.s pcResponses
IL_0156: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::get_Count()
IL_015b: add
IL_015c: stloc.s V_6
IL_015e: ldarg.0
IL_015f: ldloc.s V_5
IL_0161: ldloc.2
IL_0162: ldarg.3
IL_0163: ldarg.s pcResponses
IL_0165: ldarg.s visited
IL_0167: ldc.i4.0
IL_0168: call System.Void PixelCrushers.DialogueSystem.ConversationModel::EvaluateLinksAtPriority(PixelCrushers.DialogueSystem.ConditionPriority,PixelCrushers.DialogueSystem.DialogueEntry,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>,System.Boolean)
IL_016d: ldarg.3
IL_016e: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::get_Count()
IL_0173: ldarg.s pcResponses
IL_0175: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::get_Count()
IL_017a: add
IL_017b: ldloc.s V_6
IL_017d: bgt IL_0301
IL_0182: ldloc.s V_5
IL_0184: ldc.i4.1
IL_0185: sub
IL_0186: stloc.s V_5
IL_0188: ldloc.s V_5
IL_018a: ldc.i4.0
IL_018b: bge.s IL_014e
IL_018d: br IL_0301
IL_0192: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_0197: brfalse.s IL_0201
IL_0199: ldstr "{0}: Add Link ({1}): ID={2}:{3} '{4}' ({5})"
IL_019e: ldc.i4.6
IL_019f: newarr System.Object
IL_01a4: dup
IL_01a5: ldc.i4.0
IL_01a6: ldstr "Dialogue System"
IL_01ab: stelem.ref
IL_01ac: dup
IL_01ad: ldc.i4.1
IL_01ae: ldarg.0
IL_01af: ldarg.0
IL_01b0: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_01b5: ldloc.2
IL_01b6: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_01bb: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32)
IL_01c0: call System.String PixelCrushers.DialogueSystem.ConversationModel::GetActorName(PixelCrushers.DialogueSystem.Actor)
IL_01c5: stelem.ref
IL_01c6: dup
IL_01c7: ldc.i4.2
IL_01c8: ldloc.1
IL_01c9: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_01ce: box System.Int32
IL_01d3: stelem.ref
IL_01d4: dup
IL_01d5: ldc.i4.3
IL_01d6: ldloc.1
IL_01d7: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_01dc: box System.Int32
IL_01e1: stelem.ref
IL_01e2: dup
IL_01e3: ldc.i4.4
IL_01e4: ldarg.0
IL_01e5: ldloc.3
IL_01e6: ldloc.2
IL_01e7: call System.String PixelCrushers.DialogueSystem.ConversationModel::GetLinkText(PixelCrushers.DialogueSystem.CharacterType,PixelCrushers.DialogueSystem.DialogueEntry)
IL_01ec: stelem.ref
IL_01ed: dup
IL_01ee: ldc.i4.5
IL_01ef: ldloc.s V_4
IL_01f1: box System.Boolean
IL_01f6: stelem.ref
IL_01f7: call System.String System.String::Format(System.String,System.Object[])
IL_01fc: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0201: ldloc.3
IL_0202: ldc.i4.1
IL_0203: bne.un.s IL_022e
IL_0205: ldarg.3
IL_0206: ldloc.2
IL_0207: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_subtitleText()
IL_020c: ldarg.0
IL_020d: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_0212: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.DialogueDatabase::emphasisSettings
IL_0217: call PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.FormattedText::Parse(System.String,PixelCrushers.DialogueSystem.EmphasisSetting[])
IL_021c: ldloc.2
IL_021d: ldloc.s V_4
IL_021f: newobj System.Void PixelCrushers.DialogueSystem.Response::.ctor(PixelCrushers.DialogueSystem.FormattedText,PixelCrushers.DialogueSystem.DialogueEntry,System.Boolean)
IL_0224: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::Add(!0)
IL_0229: br IL_0301
IL_022e: ldloc.2
IL_022f: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_responseButtonText()
IL_0234: stloc.s V_7
IL_0236: ldarg.0
IL_0237: ldfld PixelCrushers.DialogueSystem.EmTag PixelCrushers.DialogueSystem.ConversationModel::m_emTagForOldResponses
IL_023c: brfalse.s IL_029d
IL_023e: ldstr "return Conversation[{0}].Dialog[{1}].SimStatus"
IL_0243: ldc.i4.2
IL_0244: newarr System.Object
IL_0249: dup
IL_024a: ldc.i4.0
IL_024b: ldloc.2
IL_024c: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0251: box System.Int32
IL_0256: stelem.ref
IL_0257: dup
IL_0258: ldc.i4.1
IL_0259: ldloc.2
IL_025a: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_025f: box System.Int32
IL_0264: stelem.ref
IL_0265: call System.String System.String::Format(System.String,System.Object[])
IL_026a: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::Run(System.String)
IL_026f: stloc.s V_9
IL_0271: ldloca.s V_9
IL_0273: call System.String PixelCrushers.DialogueSystem.Lua/Result::get_asString()
IL_0278: ldstr "WasDisplayed"
IL_027d: call System.Boolean System.String::Equals(System.String,System.String)
IL_0282: brfalse.s IL_029d
IL_0284: ldstr "[em{0}]{1}[/em{0}]"
IL_0289: ldarg.0
IL_028a: ldfld PixelCrushers.DialogueSystem.EmTag PixelCrushers.DialogueSystem.ConversationModel::m_emTagForOldResponses
IL_028f: box System.Int32
IL_0294: ldloc.s V_7
IL_0296: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_029b: stloc.s V_7
IL_029d: ldarg.0
IL_029e: ldfld PixelCrushers.DialogueSystem.EmTag PixelCrushers.DialogueSystem.ConversationModel::m_emTagForInvalidResponses
IL_02a3: brfalse.s IL_02c2
IL_02a5: ldloc.s V_4
IL_02a7: brtrue.s IL_02c2
IL_02a9: ldstr "[em{0}]{1}[/em{0}]"
IL_02ae: ldarg.0
IL_02af: ldfld PixelCrushers.DialogueSystem.EmTag PixelCrushers.DialogueSystem.ConversationModel::m_emTagForInvalidResponses
IL_02b4: box System.Int32
IL_02b9: ldloc.s V_7
IL_02bb: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_02c0: stloc.s V_7
IL_02c2: ldloc.s V_7
IL_02c4: ldarg.0
IL_02c5: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_02ca: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.DialogueDatabase::emphasisSettings
IL_02cf: call PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.FormattedText::Parse(System.String,PixelCrushers.DialogueSystem.EmphasisSetting[])
IL_02d4: stloc.s V_8
IL_02d6: ldloc.s V_4
IL_02d8: brtrue.s IL_02ea
IL_02da: ldloc.s V_8
IL_02dc: ldc.i4.0
IL_02dd: callvirt System.Void PixelCrushers.DialogueSystem.FormattedText::set_forceAuto(System.Boolean)
IL_02e2: ldloc.s V_8
IL_02e4: ldc.i4.0
IL_02e5: callvirt System.Void PixelCrushers.DialogueSystem.FormattedText::set_forceMenu(System.Boolean)
IL_02ea: ldarg.s pcResponses
IL_02ec: ldloc.s V_8
IL_02ee: ldloc.2
IL_02ef: ldloc.s V_4
IL_02f1: newobj System.Void PixelCrushers.DialogueSystem.Response::.ctor(PixelCrushers.DialogueSystem.FormattedText,PixelCrushers.DialogueSystem.DialogueEntry,System.Boolean)
IL_02f6: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::Add(!0)
IL_02fb: ldloc.2
IL_02fc: call System.Void PixelCrushers.DialogueSystem.DialogueLua::MarkDialogueEntryOffered(PixelCrushers.DialogueSystem.DialogueEntry)
IL_0301: ldarg.s stopAtFirstValid
IL_0303: brfalse IL_041f
IL_0308: ret
IL_0309: ldloc.2
IL_030a: call System.Boolean PixelCrushers.DialogueSystem.LinkUtility::IsPassthroughOnFalse(PixelCrushers.DialogueSystem.DialogueEntry)
IL_030f: brfalse IL_03b1
IL_0314: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_0319: brfalse.s IL_0382
IL_031b: ldstr "{0}: Passthrough on False Link ({1}): ID={2}:{3} '{4}' Condition='{5}'"
IL_0320: ldc.i4.6
IL_0321: newarr System.Object
IL_0326: dup
IL_0327: ldc.i4.0
IL_0328: ldstr "Dialogue System"
IL_032d: stelem.ref
IL_032e: dup
IL_032f: ldc.i4.1
IL_0330: ldarg.0
IL_0331: ldarg.0
IL_0332: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_0337: ldloc.2
IL_0338: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_033d: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32)
IL_0342: call System.String PixelCrushers.DialogueSystem.ConversationModel::GetActorName(PixelCrushers.DialogueSystem.Actor)
IL_0347: stelem.ref
IL_0348: dup
IL_0349: ldc.i4.2
IL_034a: ldloc.1
IL_034b: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_0350: box System.Int32
IL_0355: stelem.ref
IL_0356: dup
IL_0357: ldc.i4.3
IL_0358: ldloc.1
IL_0359: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_035e: box System.Int32
IL_0363: stelem.ref
IL_0364: dup
IL_0365: ldc.i4.4
IL_0366: ldarg.0
IL_0367: ldloc.3
IL_0368: ldloc.2
IL_0369: call System.String PixelCrushers.DialogueSystem.ConversationModel::GetLinkText(PixelCrushers.DialogueSystem.CharacterType,PixelCrushers.DialogueSystem.DialogueEntry)
IL_036e: stelem.ref
IL_036f: dup
IL_0370: ldc.i4.5
IL_0371: ldloc.2
IL_0372: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::conditionsString
IL_0377: stelem.ref
IL_0378: call System.String System.String::Format(System.String,System.Object[])
IL_037d: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0382: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::.ctor()
IL_0387: stloc.s V_10
IL_0389: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::.ctor()
IL_038e: stloc.s V_11
IL_0390: ldarg.0
IL_0391: ldloc.2
IL_0392: ldloc.s V_10
IL_0394: ldloc.s V_11
IL_0396: ldarg.s visited
IL_0398: ldc.i4.0
IL_0399: call System.Void PixelCrushers.DialogueSystem.ConversationModel::EvaluateLinks(PixelCrushers.DialogueSystem.DialogueEntry,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>,System.Boolean)
IL_039e: ldarg.3
IL_039f: ldloc.s V_10
IL_03a1: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_03a6: ldarg.s pcResponses
IL_03a8: ldloc.s V_11
IL_03aa: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Response>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_03af: br.s IL_041f
IL_03b1: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_03b6: brfalse.s IL_041f
IL_03b8: ldstr "{0}: Block on False Link ({1}): ID={2}:{3} '{4}' Condition='{5}'"
IL_03bd: ldc.i4.6
IL_03be: newarr System.Object
IL_03c3: dup
IL_03c4: ldc.i4.0
IL_03c5: ldstr "Dialogue System"
IL_03ca: stelem.ref
IL_03cb: dup
IL_03cc: ldc.i4.1
IL_03cd: ldarg.0
IL_03ce: ldarg.0
IL_03cf: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_03d4: ldloc.2
IL_03d5: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_03da: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32)
IL_03df: call System.String PixelCrushers.DialogueSystem.ConversationModel::GetActorName(PixelCrushers.DialogueSystem.Actor)
IL_03e4: stelem.ref
IL_03e5: dup
IL_03e6: ldc.i4.2
IL_03e7: ldloc.1
IL_03e8: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_03ed: box System.Int32
IL_03f2: stelem.ref
IL_03f3: dup
IL_03f4: ldc.i4.3
IL_03f5: ldloc.1
IL_03f6: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_03fb: box System.Int32
IL_0400: stelem.ref
IL_0401: dup
IL_0402: ldc.i4.4
IL_0403: ldarg.0
IL_0404: ldloc.3
IL_0405: ldloc.2
IL_0406: call System.String PixelCrushers.DialogueSystem.ConversationModel::GetLinkText(PixelCrushers.DialogueSystem.CharacterType,PixelCrushers.DialogueSystem.DialogueEntry)
IL_040b: stelem.ref
IL_040c: dup
IL_040d: ldc.i4.5
IL_040e: ldloc.2
IL_040f: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::conditionsString
IL_0414: stelem.ref
IL_0415: call System.String System.String::Format(System.String,System.Object[])
IL_041a: call System.Void UnityEngine.Debug::Log(System.Object)
IL_041f: ldloc.0
IL_0420: ldc.i4.1
IL_0421: add
IL_0422: stloc.0
IL_0423: ldloc.0
IL_0424: ldarg.2
IL_0425: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_042a: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Count()
IL_042f: blt IL_000d
IL_0434: ret
METHOD System.String PixelCrushers.DialogueSystem.ConversationModel::GetLinkText(PixelCrushers.DialogueSystem.CharacterType,PixelCrushers.DialogueSystem.DialogueEntry)
IL_0000: ldarg.1
IL_0001: ldc.i4.1
IL_0002: beq.s IL_000b
IL_0004: ldarg.2
IL_0005: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_responseButtonText()
IL_000a: ret
IL_000b: ldarg.2
IL_000c: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_subtitleText()
IL_0011: ret
