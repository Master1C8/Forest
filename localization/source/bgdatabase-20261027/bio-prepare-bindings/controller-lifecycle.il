TYPE PixelCrushers.DialogueSystem.DialogueSystemController
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::InitStaticVariables() | attributes=Private, Static, HideBySig | impl=IL
ATTRIBUTE UnityEngine.RuntimeInitializeOnLoadMethodAttribute
IL_0000: ldc.i4.0
IL_0001: stsfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::applicationIsQuitting
IL_0006: ldnull
IL_0007: stsfld System.String PixelCrushers.DialogueSystem.DialogueSystemController::lastInitialDatabaseName
IL_000c: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::OnDestroy() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::dontDestroyOnLoad
IL_0006: brfalse.s IL_0016
IL_0008: ldarg.0
IL_0009: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::allowOnlyOneInstance
IL_000e: brfalse.s IL_0016
IL_0010: ldc.i4.1
IL_0011: stsfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::applicationIsQuitting
IL_0016: ldarg.0
IL_0017: ldftn System.Void PixelCrushers.DialogueSystem.DialogueSystemController::OnSceneLoaded(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode)
IL_001d: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode>::.ctor(System.Object,System.IntPtr)
IL_0022: call System.Void UnityEngine.SceneManagement.SceneManager::remove_sceneLoaded(UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode>)
IL_0027: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::Awake() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::allowOnlyOneInstance
IL_0006: brfalse.s IL_001e
IL_0008: call !!0[] UnityEngine.Object::FindObjectsOfType<PixelCrushers.DialogueSystem.DialogueSystemController>()
IL_000d: ldlen
IL_000e: conv.i4
IL_000f: ldc.i4.1
IL_0010: ble.s IL_001e
IL_0012: ldarg.0
IL_0013: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0018: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_001d: ret
IL_001e: ldarg.0
IL_001f: ldarg.0
IL_0020: ldftn System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::StandardGetInputButtonDown(System.String)
IL_0026: newobj System.Void PixelCrushers.DialogueSystem.GetInputButtonDownDelegate::.ctor(System.Object,System.IntPtr)
IL_002b: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_getInputButtonDown(PixelCrushers.DialogueSystem.GetInputButtonDownDelegate)
IL_0030: ldarg.0
IL_0031: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::instantiateDatabase
IL_0036: brtrue.s IL_0041
IL_0038: ldarg.0
IL_0039: ldfld PixelCrushers.DialogueSystem.DialogueSystemController/WarmUpMode PixelCrushers.DialogueSystem.DialogueSystemController::warmUpConversationController
IL_003e: ldc.i4.2
IL_003f: beq.s IL_0073
IL_0041: ldarg.0
IL_0042: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueSystemController::initialDatabase
IL_0047: ldnull
IL_0048: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_004d: brfalse.s IL_0073
IL_004f: ldarg.0
IL_0050: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueSystemController::initialDatabase
IL_0055: call !!0 UnityEngine.Object::Instantiate<PixelCrushers.DialogueSystem.DialogueDatabase>(!!0)
IL_005a: stloc.1
IL_005b: ldloc.1
IL_005c: ldarg.0
IL_005d: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueSystemController::initialDatabase
IL_0062: callvirt System.String UnityEngine.Object::get_name()
IL_0067: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_006c: ldarg.0
IL_006d: ldloc.1
IL_006e: stfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueSystemController::initialDatabase
IL_0073: ldarg.0
IL_0074: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0079: brfalse.s IL_009d
IL_007b: ldarg.0
IL_007c: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0081: ldfld PixelCrushers.DialogueSystem.DisplaySettings/InputSettings PixelCrushers.DialogueSystem.DisplaySettings::inputSettings
IL_0086: brfalse.s IL_009d
IL_0088: ldarg.0
IL_0089: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_008e: ldfld PixelCrushers.DialogueSystem.DisplaySettings/InputSettings PixelCrushers.DialogueSystem.DisplaySettings::inputSettings
IL_0093: ldfld PixelCrushers.DialogueSystem.EmTag PixelCrushers.DialogueSystem.DisplaySettings/InputSettings::emTagForOldResponses
IL_0098: ldc.i4.0
IL_0099: cgt.un
IL_009b: br.s IL_009e
IL_009d: ldc.i4.0
IL_009e: stloc.0
IL_009f: ldarg.0
IL_00a0: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::includeSimStatus
IL_00a5: ldloc.0
IL_00a6: or
IL_00a7: stsfld System.Boolean PixelCrushers.DialogueSystem.DialogueLua::includeSimStatus
IL_00ac: ldsfld System.Boolean PixelCrushers.DialogueSystem.DialogueLua::includeSimStatus
IL_00b1: stsfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataManager::includeSimStatus
IL_00b6: ldarg.0
IL_00b7: ldfld PixelCrushers.DialogueSystem.PersistentDataSettings PixelCrushers.DialogueSystem.DialogueSystemController::persistentDataSettings
IL_00bc: ldfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataSettings::includeActorData
IL_00c1: stsfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataManager::includeActorData
IL_00c6: ldarg.0
IL_00c7: ldfld PixelCrushers.DialogueSystem.PersistentDataSettings PixelCrushers.DialogueSystem.DialogueSystemController::persistentDataSettings
IL_00cc: ldfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataSettings::includeAllItemData
IL_00d1: stsfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataManager::includeAllItemData
IL_00d6: ldarg.0
IL_00d7: ldfld PixelCrushers.DialogueSystem.PersistentDataSettings PixelCrushers.DialogueSystem.DialogueSystemController::persistentDataSettings
IL_00dc: ldfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataSettings::includeLocationData
IL_00e1: stsfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataManager::includeLocationData
IL_00e6: ldarg.0
IL_00e7: ldfld PixelCrushers.DialogueSystem.PersistentDataSettings PixelCrushers.DialogueSystem.DialogueSystemController::persistentDataSettings
IL_00ec: ldfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataSettings::includeStatusAndRelationshipData
IL_00f1: stsfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataManager::includeRelationshipAndStatusData
IL_00f6: ldarg.0
IL_00f7: ldfld PixelCrushers.DialogueSystem.PersistentDataSettings PixelCrushers.DialogueSystem.DialogueSystemController::persistentDataSettings
IL_00fc: ldfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataSettings::includeAllConversationFields
IL_0101: stsfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataManager::includeAllConversationFields
IL_0106: ldarg.0
IL_0107: ldfld PixelCrushers.DialogueSystem.PersistentDataSettings PixelCrushers.DialogueSystem.DialogueSystemController::persistentDataSettings
IL_010c: ldfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataSettings::initializeNewVariables
IL_0111: stsfld System.Boolean PixelCrushers.DialogueSystem.PersistentDataManager::initializeNewVariables
IL_0116: ldarg.0
IL_0117: ldfld PixelCrushers.DialogueSystem.PersistentDataSettings PixelCrushers.DialogueSystem.DialogueSystemController::persistentDataSettings
IL_011c: ldfld System.String PixelCrushers.DialogueSystem.PersistentDataSettings::saveConversationSimStatusWithField
IL_0121: stsfld System.String PixelCrushers.DialogueSystem.PersistentDataManager::saveConversationSimStatusWithField
IL_0126: ldarg.0
IL_0127: ldfld PixelCrushers.DialogueSystem.PersistentDataSettings PixelCrushers.DialogueSystem.DialogueSystemController::persistentDataSettings
IL_012c: ldfld System.String PixelCrushers.DialogueSystem.PersistentDataSettings::saveDialogueEntrySimStatusWithField
IL_0131: stsfld System.String PixelCrushers.DialogueSystem.PersistentDataManager::saveDialogueEntrySimStatusWithField
IL_0136: ldarg.0
IL_0137: ldfld PixelCrushers.DialogueSystem.PersistentDataSettings PixelCrushers.DialogueSystem.DialogueSystemController::persistentDataSettings
IL_013c: ldfld PixelCrushers.DialogueSystem.PersistentDataManager/RecordPersistentDataOn PixelCrushers.DialogueSystem.PersistentDataSettings::recordPersistentDataOn
IL_0141: stsfld PixelCrushers.DialogueSystem.PersistentDataManager/RecordPersistentDataOn PixelCrushers.DialogueSystem.PersistentDataManager::recordPersistentDataOn
IL_0146: ldarg.0
IL_0147: ldfld PixelCrushers.DialogueSystem.PersistentDataSettings PixelCrushers.DialogueSystem.DialogueSystemController::persistentDataSettings
IL_014c: ldfld System.Int32 PixelCrushers.DialogueSystem.PersistentDataSettings::asyncGameObjectBatchSize
IL_0151: stsfld System.Int32 PixelCrushers.DialogueSystem.PersistentDataManager::asyncGameObjectBatchSize
IL_0156: ldarg.0
IL_0157: ldfld PixelCrushers.DialogueSystem.PersistentDataSettings PixelCrushers.DialogueSystem.DialogueSystemController::persistentDataSettings
IL_015c: ldfld System.Int32 PixelCrushers.DialogueSystem.PersistentDataSettings::asyncDialogueEntryBatchSize
IL_0161: stsfld System.Int32 PixelCrushers.DialogueSystem.PersistentDataManager::asyncDialogueEntryBatchSize
IL_0166: ldarg.0
IL_0167: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::dontDestroyOnLoad
IL_016c: brfalse.s IL_019b
IL_016e: ldarg.0
IL_016f: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0174: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_0179: ldnull
IL_017a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_017f: brfalse.s IL_018e
IL_0181: ldarg.0
IL_0182: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0187: ldnull
IL_0188: ldc.i4.0
IL_0189: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform,System.Boolean)
IL_018e: ldarg.0
IL_018f: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0194: call System.Void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)
IL_0199: br.s IL_01e7
IL_019b: ldarg.0
IL_019c: call !!0 UnityEngine.Component::GetComponent<PixelCrushers.SaveSystem>()
IL_01a1: ldarg.0
IL_01a2: call !!0 UnityEngine.Component::GetComponent<PixelCrushers.InputDeviceManager>()
IL_01a7: stloc.2
IL_01a8: ldnull
IL_01a9: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_01ae: brfalse.s IL_01c4
IL_01b0: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logWarnings()
IL_01b5: brfalse.s IL_01e7
IL_01b7: ldstr "Dialogue System: The Dialogue Manager's Don't Destroy On Load checkbox is UNticked, but the GameObject has a Save System which will mark it Don't Destroy On Load anyway. You may want to tick Don't Destroy On Load or move the Save System to another GameObject."
IL_01bc: ldarg.0
IL_01bd: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_01c2: br.s IL_01e7
IL_01c4: ldloc.2
IL_01c5: ldnull
IL_01c6: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_01cb: brfalse.s IL_01e7
IL_01cd: ldloc.2
IL_01ce: ldfld System.Boolean PixelCrushers.InputDeviceManager::singleton
IL_01d3: brfalse.s IL_01e7
IL_01d5: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logWarnings()
IL_01da: brfalse.s IL_01e7
IL_01dc: ldstr "Dialogue System: The Dialogue Manager's Don't Destroy On Load checkbox is UNticked, but the GameObject has an Input Device Manager whose Singleton checkbox is ticked, which will mark it Don't Destroy On Load anyway. You may want to tick Don't Destroy On Load or untick the Input Device Manager's Singleton checkbox."
IL_01e1: ldarg.0
IL_01e2: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_01e7: ldarg.0
IL_01e8: ldc.i4.0
IL_01e9: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_allowLuaExceptions(System.Boolean)
IL_01ee: ldarg.0
IL_01ef: ldc.i4.0
IL_01f0: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_warnIfActorAndConversantSame(System.Boolean)
IL_01f5: ldarg.0
IL_01f6: ldfld PixelCrushers.DialogueSystem.DialogueTime/TimeMode PixelCrushers.DialogueSystem.DialogueSystemController::dialogueTimeMode
IL_01fb: call System.Void PixelCrushers.DialogueSystem.DialogueTime::set_mode(PixelCrushers.DialogueSystem.DialogueTime/TimeMode)
IL_0200: ldarg.0
IL_0201: ldfld PixelCrushers.DialogueSystem.DialogueDebug/DebugLevel PixelCrushers.DialogueSystem.DialogueSystemController::debugLevel
IL_0206: call System.Void PixelCrushers.DialogueSystem.DialogueDebug::set_level(PixelCrushers.DialogueSystem.DialogueDebug/DebugLevel)
IL_020b: ldarg.0
IL_020c: ldarg.0
IL_020d: ldfld PixelCrushers.DialogueSystem.DialogueDebug/DebugLevel PixelCrushers.DialogueSystem.DialogueSystemController::debugLevel
IL_0212: stfld PixelCrushers.DialogueSystem.DialogueDebug/DebugLevel PixelCrushers.DialogueSystem.DialogueSystemController::m_lastDebugLevelSet
IL_0217: ldarg.0
IL_0218: ldsfld System.String System.String::Empty
IL_021d: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_lastConversationStarted(System.String)
IL_0222: ldarg.0
IL_0223: ldc.i4.m1
IL_0224: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_lastConversationID(System.Int32)
IL_0229: ldarg.0
IL_022a: ldnull
IL_022b: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_currentActor(UnityEngine.Transform)
IL_0230: ldarg.0
IL_0231: ldnull
IL_0232: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_currentConversant(UnityEngine.Transform)
IL_0237: ldarg.0
IL_0238: ldnull
IL_0239: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_currentConversationState(PixelCrushers.DialogueSystem.ConversationState)
IL_023e: ldarg.0
IL_023f: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::InitializeDatabase()
IL_0244: ldarg.0
IL_0245: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::InitializeDisplaySettings()
IL_024a: ldarg.0
IL_024b: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::InitializeLocalization()
IL_0250: ldarg.0
IL_0251: ldftn System.Void PixelCrushers.DialogueSystem.DialogueSystemController::OnSceneLoaded(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode)
IL_0257: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode>::.ctor(System.Object,System.IntPtr)
IL_025c: call System.Void UnityEngine.SceneManagement.SceneManager::add_sceneLoaded(UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode>)
IL_0261: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ret
