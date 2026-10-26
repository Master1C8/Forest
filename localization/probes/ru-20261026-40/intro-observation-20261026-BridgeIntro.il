TYPE ForestProbe
METHOD System.String[] ForestProbe::IntroCleanupDiagnostics()
IL_0000: nop
IL_0001: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0006: stloc.0
IL_0007: ldc.i4.0
IL_0008: stloc.1
IL_0009: ldc.i4.0
IL_000a: stloc.2
IL_000b: ldc.i4.0
IL_000c: stloc.3
IL_000d: nop
IL_000e: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.IntroBunnyHouseCutscene>()
IL_0013: stloc.s V_5
IL_0015: ldc.i4.0
IL_0016: stloc.s V_6
IL_0018: br IL_0102
IL_001d: ldloc.s V_5
IL_001f: ldloc.s V_6
IL_0021: ldelem.ref
IL_0022: stloc.s V_7
IL_0024: ldloc.s V_7
IL_0026: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_002b: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0030: stloc.s V_9
IL_0032: ldloca.s V_9
IL_0034: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0039: stloc.s V_8
IL_003b: ldloc.s V_8
IL_003d: brfalse IL_00fc
IL_0042: nop
IL_0043: ldloc.1
IL_0044: ldc.i4.1
IL_0045: add
IL_0046: stloc.1
IL_0047: ldloc.0
IL_0048: ldc.i4.s 10
IL_004a: newarr System.String
IL_004f: dup
IL_0050: ldc.i4.0
IL_0051: ldstr "introCutscene | path="
IL_0056: stelem.ref
IL_0057: dup
IL_0058: ldc.i4.1
IL_0059: ldloc.s V_7
IL_005b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0060: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0065: stelem.ref
IL_0066: dup
IL_0067: ldc.i4.2
IL_0068: ldstr " | active="
IL_006d: stelem.ref
IL_006e: dup
IL_006f: ldc.i4.3
IL_0070: ldloc.s V_7
IL_0072: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0077: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_007c: stloc.s V_10
IL_007e: ldloca.s V_10
IL_0080: call System.String System.Boolean::ToString()
IL_0085: stelem.ref
IL_0086: dup
IL_0087: ldc.i4.4
IL_0088: ldstr " | stage="
IL_008d: stelem.ref
IL_008e: dup
IL_008f: ldc.i4.5
IL_0090: ldloc.s V_7
IL_0092: ldstr "currentStage"
IL_0097: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_009c: dup
IL_009d: brtrue.s IL_00a3
IL_009f: pop
IL_00a0: ldnull
IL_00a1: br.s IL_00a8
IL_00a3: callvirt System.String System.Object::ToString()
IL_00a8: stelem.ref
IL_00a9: dup
IL_00aa: ldc.i4.6
IL_00ab: ldstr " | timerSet="
IL_00b0: stelem.ref
IL_00b1: dup
IL_00b2: ldc.i4.7
IL_00b3: ldloc.s V_7
IL_00b5: ldstr "timerSet"
IL_00ba: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_00bf: dup
IL_00c0: brtrue.s IL_00c6
IL_00c2: pop
IL_00c3: ldnull
IL_00c4: br.s IL_00cb
IL_00c6: callvirt System.String System.Object::ToString()
IL_00cb: stelem.ref
IL_00cc: dup
IL_00cd: ldc.i4.8
IL_00ce: ldstr " | timerSeconds="
IL_00d3: stelem.ref
IL_00d4: dup
IL_00d5: ldc.i4.s 9
IL_00d7: ldloc.s V_7
IL_00d9: ldstr "timerSecondsRemaining"
IL_00de: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_00e3: dup
IL_00e4: brtrue.s IL_00ea
IL_00e6: pop
IL_00e7: ldnull
IL_00e8: br.s IL_00ef
IL_00ea: callvirt System.String System.Object::ToString()
IL_00ef: stelem.ref
IL_00f0: call System.String System.String::Concat(System.String[])
IL_00f5: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00fa: nop
IL_00fb: nop
IL_00fc: ldloc.s V_6
IL_00fe: ldc.i4.1
IL_00ff: add
IL_0100: stloc.s V_6
IL_0102: ldloc.s V_6
IL_0104: ldloc.s V_5
IL_0106: ldlen
IL_0107: conv.i4
IL_0108: blt IL_001d
IL_010d: ldstr "Cutscene_IntroBunnyHouse"
IL_0112: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0117: stloc.s V_4
IL_0119: ldloc.0
IL_011a: ldstr "trigger | name=Cutscene_IntroBunnyHouse | count="
IL_011f: ldloc.s V_4
IL_0121: brfalse.s IL_0136
IL_0123: ldloc.s V_4
IL_0125: ldstr "<CountActivated>k__BackingField"
IL_012a: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_012f: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_0134: br.s IL_013b
IL_0136: ldstr "absent"
IL_013b: call System.String System.String::Concat(System.String,System.String)
IL_0140: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0145: nop
IL_0146: nop
IL_0147: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.InteractionUiController>()
IL_014c: stloc.s V_11
IL_014e: ldc.i4.0
IL_014f: stloc.s V_12
IL_0151: br.s IL_01be
IL_0153: ldloc.s V_11
IL_0155: ldloc.s V_12
IL_0157: ldelem.ref
IL_0158: stloc.s V_13
IL_015a: ldloc.s V_13
IL_015c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0161: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0166: stloc.s V_9
IL_0168: ldloca.s V_9
IL_016a: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_016f: brfalse.s IL_0189
IL_0171: ldloc.s V_13
IL_0173: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0178: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_017d: ldstr "SpawnedContent/Elements/Bed/Content/Bed(Clone)/Interaction/InteractionIconInspect"
IL_0182: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0187: br.s IL_018a
IL_0189: ldc.i4.0
IL_018a: stloc.s V_14
IL_018c: ldloc.s V_14
IL_018e: brfalse.s IL_01b8
IL_0190: nop
IL_0191: ldloc.2
IL_0192: ldc.i4.1
IL_0193: add
IL_0194: stloc.2
IL_0195: ldloc.s V_13
IL_0197: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_019c: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_01a1: brfalse.s IL_01ac
IL_01a3: ldloc.s V_13
IL_01a5: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_01aa: br.s IL_01ad
IL_01ac: ldc.i4.0
IL_01ad: stloc.s V_15
IL_01af: ldloc.s V_15
IL_01b1: brfalse.s IL_01b7
IL_01b3: ldloc.3
IL_01b4: ldc.i4.1
IL_01b5: add
IL_01b6: stloc.3
IL_01b7: nop
IL_01b8: ldloc.s V_12
IL_01ba: ldc.i4.1
IL_01bb: add
IL_01bc: stloc.s V_12
IL_01be: ldloc.s V_12
IL_01c0: ldloc.s V_11
IL_01c2: ldlen
IL_01c3: conv.i4
IL_01c4: blt.s IL_0153
IL_01c6: ldloc.0
IL_01c7: ldc.i4.6
IL_01c8: newarr System.String
IL_01cd: dup
IL_01ce: ldc.i4.0
IL_01cf: ldstr "introCleanup | remainingControllers="
IL_01d4: stelem.ref
IL_01d5: dup
IL_01d6: ldc.i4.1
IL_01d7: ldloca.s V_1
IL_01d9: call System.String System.Int32::ToString()
IL_01de: stelem.ref
IL_01df: dup
IL_01e0: ldc.i4.2
IL_01e1: ldstr " | bedControllers="
IL_01e6: stelem.ref
IL_01e7: dup
IL_01e8: ldc.i4.3
IL_01e9: ldloca.s V_2
IL_01eb: call System.String System.Int32::ToString()
IL_01f0: stelem.ref
IL_01f1: dup
IL_01f2: ldc.i4.4
IL_01f3: ldstr " | activeBedControllers="
IL_01f8: stelem.ref
IL_01f9: dup
IL_01fa: ldc.i4.5
IL_01fb: ldloca.s V_3
IL_01fd: call System.String System.Int32::ToString()
IL_0202: stelem.ref
IL_0203: call System.String System.String::Concat(System.String[])
IL_0208: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_020d: nop
IL_020e: ldloc.0
IL_020f: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0214: stloc.s V_16
IL_0216: br.s IL_0218
IL_0218: ldloc.s V_16
IL_021a: ret
METHOD System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_0000: nop
IL_0001: newobj System.Void System.Collections.Generic.List`1<ForestProbe/ResponseRow>::.ctor()
IL_0006: stloc.0
IL_0007: nop
IL_0008: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUIResponseButton>()
IL_000d: stloc.1
IL_000e: ldc.i4.0
IL_000f: stloc.2
IL_0010: br IL_00f5
IL_0015: ldloc.1
IL_0016: ldloc.2
IL_0017: ldelem.ref
IL_0018: stloc.3
IL_0019: ldloc.3
IL_001a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001f: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0024: stloc.s V_5
IL_0026: ldloca.s V_5
IL_0028: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_002d: brfalse.s IL_0054
IL_002f: ldloc.3
IL_0030: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0035: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_003a: brfalse.s IL_0054
IL_003c: ldloc.3
IL_003d: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0042: brfalse.s IL_0054
IL_0044: ldloc.3
IL_0045: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_004a: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_004f: ldnull
IL_0050: cgt.un
IL_0052: br.s IL_0055
IL_0054: ldc.i4.0
IL_0055: stloc.s V_4
IL_0057: ldloc.s V_4
IL_0059: brfalse IL_00f1
IL_005e: ldloc.0
IL_005f: newobj System.Void ForestProbe/ResponseRow::.ctor()
IL_0064: dup
IL_0065: ldloc.3
IL_0066: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_006b: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0070: stfld System.String ForestProbe/ResponseRow::path
IL_0075: dup
IL_0076: ldloc.3
IL_0077: callvirt System.String PixelCrushers.DialogueSystem.StandardUIResponseButton::get_text()
IL_007c: stfld System.String ForestProbe/ResponseRow::text
IL_0081: dup
IL_0082: ldloc.3
IL_0083: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0088: ldnull
IL_0089: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_008e: brtrue.s IL_009d
IL_0090: ldloc.3
IL_0091: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0096: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_009b: br.s IL_00a2
IL_009d: ldstr ""
IL_00a2: stfld System.String ForestProbe/ResponseRow::targetPath
IL_00a7: dup
IL_00a8: ldloc.3
IL_00a9: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isVisible()
IL_00ae: stfld System.Boolean ForestProbe/ResponseRow::visible
IL_00b3: dup
IL_00b4: ldloc.3
IL_00b5: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isClickable()
IL_00ba: stfld System.Boolean ForestProbe/ResponseRow::clickable
IL_00bf: dup
IL_00c0: ldloc.3
IL_00c1: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_00c6: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_00cb: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_00d0: stfld System.Int32 ForestProbe/ResponseRow::conversationId
IL_00d5: dup
IL_00d6: ldloc.3
IL_00d7: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_00dc: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_00e1: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00e6: stfld System.Int32 ForestProbe/ResponseRow::entryId
IL_00eb: callvirt System.Void System.Collections.Generic.List`1<ForestProbe/ResponseRow>::Add(!0)
IL_00f0: nop
IL_00f1: ldloc.2
IL_00f2: ldc.i4.1
IL_00f3: add
IL_00f4: stloc.2
IL_00f5: ldloc.2
IL_00f6: ldloc.1
IL_00f7: ldlen
IL_00f8: conv.i4
IL_00f9: blt IL_0015
IL_00fe: ldloc.0
IL_00ff: stloc.s V_6
IL_0101: br.s IL_0103
IL_0103: ldloc.s V_6
IL_0105: ret
METHOD System.Void ForestProbe::ReadConversation(ForestProbe/State)
IL_0000: nop
IL_0001: ldarg.1
IL_0002: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0007: stfld System.Boolean ForestProbe/State::conversationActive
IL_000c: ldarg.1
IL_000d: ldfld System.Boolean ForestProbe/State::conversationActive
IL_0012: brfalse.s IL_001e
IL_0014: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0019: ldnull
IL_001a: cgt.un
IL_001c: br.s IL_001f
IL_001e: ldc.i4.0
IL_001f: stloc.0
IL_0020: ldloc.0
IL_0021: brfalse.s IL_008b
IL_0023: nop
IL_0024: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0029: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_002e: stloc.1
IL_002f: ldloc.1
IL_0030: ldnull
IL_0031: cgt.un
IL_0033: stloc.2
IL_0034: ldloc.2
IL_0035: brfalse.s IL_008a
IL_0037: nop
IL_0038: ldarg.1
IL_0039: ldloc.1
IL_003a: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_003f: brfalse.s IL_004e
IL_0041: ldloc.1
IL_0042: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0047: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_004c: br.s IL_0053
IL_004e: ldstr ""
IL_0053: stfld System.String ForestProbe/State::conversationState
IL_0058: ldloc.1
IL_0059: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_005e: ldnull
IL_005f: cgt.un
IL_0061: stloc.3
IL_0062: ldloc.3
IL_0063: brfalse.s IL_0089
IL_0065: nop
IL_0066: ldarg.1
IL_0067: ldloc.1
IL_0068: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_006d: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0072: stfld System.Int32 ForestProbe/State::conversationId
IL_0077: ldarg.1
IL_0078: ldloc.1
IL_0079: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_007e: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0083: stfld System.Int32 ForestProbe/State::entryId
IL_0088: nop
IL_0089: nop
IL_008a: nop
IL_008b: ret
METHOD System.Void ForestProbe::DumpIntro()
IL_0000: nop
IL_0001: ldarg.0
IL_0002: call System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_0007: stloc.0
IL_0008: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_000d: stloc.1
IL_000e: ldloc.1
IL_000f: ldc.i4.8
IL_0010: newarr System.String
IL_0015: dup
IL_0016: ldc.i4.0
IL_0017: ldstr "guards | gameplay="
IL_001c: stelem.ref
IL_001d: dup
IL_001e: ldc.i4.1
IL_001f: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_0024: stloc.3
IL_0025: ldloca.s V_3
IL_0027: call System.String System.Boolean::ToString()
IL_002c: stelem.ref
IL_002d: dup
IL_002e: ldc.i4.2
IL_002f: ldstr " | dustin="
IL_0034: stelem.ref
IL_0035: dup
IL_0036: ldc.i4.3
IL_0037: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_003c: stloc.3
IL_003d: ldloca.s V_3
IL_003f: call System.String System.Boolean::ToString()
IL_0044: stelem.ref
IL_0045: dup
IL_0046: ldc.i4.4
IL_0047: ldstr " | glitch="
IL_004c: stelem.ref
IL_004d: dup
IL_004e: ldc.i4.5
IL_004f: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGlitchRoom()
IL_0054: stloc.3
IL_0055: ldloca.s V_3
IL_0057: call System.String System.Boolean::ToString()
IL_005c: stelem.ref
IL_005d: dup
IL_005e: ldc.i4.6
IL_005f: ldstr " | anyEvent="
IL_0064: stelem.ref
IL_0065: dup
IL_0066: ldc.i4.7
IL_0067: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_006c: stloc.3
IL_006d: ldloca.s V_3
IL_006f: call System.String System.Boolean::ToString()
IL_0074: stelem.ref
IL_0075: call System.String System.String::Concat(System.String[])
IL_007a: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_007f: nop
IL_0080: ldloc.1
IL_0081: ldarg.0
IL_0082: call System.String[] ForestProbe::IntroCleanupDiagnostics()
IL_0087: callvirt System.Void System.Collections.Generic.List`1<System.String>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_008c: nop
IL_008d: newobj System.Void ForestProbe/State::.ctor()
IL_0092: dup
IL_0093: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0098: stloc.s V_4
IL_009a: ldloca.s V_4
IL_009c: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_00a1: stfld System.String ForestProbe/State::scene
IL_00a6: dup
IL_00a7: call System.String UnityEngine.Application::get_dataPath()
IL_00ac: stfld System.String ForestProbe/State::dataPath
IL_00b1: dup
IL_00b2: call System.String UnityEngine.Application::get_persistentDataPath()
IL_00b7: stfld System.String ForestProbe/State::persistentDataPath
IL_00bc: dup
IL_00bd: call System.String UnityEngine.Application::get_companyName()
IL_00c2: stfld System.String ForestProbe/State::company
IL_00c7: dup
IL_00c8: call System.String UnityEngine.Application::get_productName()
IL_00cd: stfld System.String ForestProbe/State::product
IL_00d2: dup
IL_00d3: call System.Int32 UnityEngine.Time::get_frameCount()
IL_00d8: stfld System.Int32 ForestProbe/State::frame
IL_00dd: dup
IL_00de: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_00e3: stfld System.Single ForestProbe/State::realtime
IL_00e8: dup
IL_00e9: call System.Single UnityEngine.Time::get_time()
IL_00ee: stfld System.Single ForestProbe/State::scaledTime
IL_00f3: dup
IL_00f4: call System.Single UnityEngine.Time::get_timeScale()
IL_00f9: stfld System.Single ForestProbe/State::timeScale
IL_00fe: dup
IL_00ff: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0104: stfld System.String ForestProbe/State::narrativeDbName
IL_0109: dup
IL_010a: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_010f: stfld System.String ForestProbe/State::narrativeArcName
IL_0114: dup
IL_0115: ldloc.0
IL_0116: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_011b: stfld System.Int32 ForestProbe/State::responseCount
IL_0120: dup
IL_0121: ldloc.0
IL_0122: ldsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__37_0
IL_0127: dup
IL_0128: brtrue.s IL_0141
IL_012a: pop
IL_012b: ldsfld ForestProbe/<>c ForestProbe/<>c::<>9
IL_0130: ldftn System.String ForestProbe/<>c::<DumpIntro>b__37_0(ForestProbe/ResponseRow)
IL_0136: newobj System.Void System.Converter`2<ForestProbe/ResponseRow,System.String>::.ctor(System.Object,System.IntPtr)
IL_013b: dup
IL_013c: stsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__37_0
IL_0141: callvirt System.Collections.Generic.List`1<!!0> System.Collections.Generic.List`1<ForestProbe/ResponseRow>::ConvertAll<System.String>(System.Converter`2<!0,!!0>)
IL_0146: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_014b: stfld System.String[] ForestProbe/State::responseRecords
IL_0150: dup
IL_0151: call System.Boolean TheForestOfLove.CustomTypewriterEffectTextMeshPro::IsTyping()
IL_0156: stfld System.Boolean ForestProbe/State::typing
IL_015b: dup
IL_015c: ldloc.1
IL_015d: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0162: stfld System.String[] ForestProbe/State::introDiagnostics
IL_0167: stloc.2
IL_0168: ldarg.0
IL_0169: ldloc.2
IL_016a: call System.Void ForestProbe::ReadConversation(ForestProbe/State)
IL_016f: nop
IL_0170: ldarg.0
IL_0171: ldfld System.String ForestProbe::root
IL_0176: ldstr "intro-state.json"
IL_017b: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0180: ldloc.2
IL_0181: ldc.i4.1
IL_0182: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0187: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_018c: nop
IL_018d: ret
