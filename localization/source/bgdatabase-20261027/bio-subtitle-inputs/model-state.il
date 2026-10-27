TYPE PixelCrushers.DialogueSystem.ConversationModel
METHOD System.Void PixelCrushers.DialogueSystem.ConversationModel::FixFirstStateSequence() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_0006: brfalse.s IL_005d
IL_0008: ldarg.0
IL_0009: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_000e: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0013: brfalse.s IL_005d
IL_0015: ldarg.0
IL_0016: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_001b: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0020: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0025: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_002a: brfalse.s IL_005d
IL_002c: ldarg.0
IL_002d: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_0032: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0037: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_003c: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0041: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0046: brfalse.s IL_005d
IL_0048: ldarg.0
IL_0049: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_004e: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0053: ldstr "None()"
IL_0058: stfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_005d: ret
METHOD PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::GetState(PixelCrushers.DialogueSystem.DialogueEntry,System.Boolean,System.Boolean,System.Boolean) | attributes=Public, HideBySig | impl=IL
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
METHOD PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::GetState(PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldc.i4.1
IL_0003: ldc.i4.0
IL_0004: ldc.i4.0
IL_0005: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::GetState(PixelCrushers.DialogueSystem.DialogueEntry,System.Boolean,System.Boolean,System.Boolean)
IL_000a: ret
