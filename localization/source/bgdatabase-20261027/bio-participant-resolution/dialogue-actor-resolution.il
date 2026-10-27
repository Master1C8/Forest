TYPE PixelCrushers.DialogueSystem.DialogueActor
METHOD System.Void PixelCrushers.DialogueSystem.DialogueActor::Awake() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void PixelCrushers.DialogueSystem.DialogueActor::SetupBarkUI()
IL_0006: ldarg.0
IL_0007: callvirt System.Void PixelCrushers.DialogueSystem.DialogueActor::SetupDialoguePanels()
IL_000c: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueActor::OnEnable() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String PixelCrushers.DialogueSystem.DialogueActor::actor
IL_0006: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000b: brfalse.s IL_000e
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.String PixelCrushers.DialogueSystem.DialogueActor::actor
IL_0014: ldarg.0
IL_0015: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_001a: call System.Void PixelCrushers.DialogueSystem.CharacterInfo::RegisterActorTransform(System.String,UnityEngine.Transform)
IL_001f: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueActor::OnDisable() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String PixelCrushers.DialogueSystem.DialogueActor::actor
IL_0006: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000b: brfalse.s IL_000e
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.String PixelCrushers.DialogueSystem.DialogueActor::actor
IL_0014: ldarg.0
IL_0015: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_001a: call System.Void PixelCrushers.DialogueSystem.CharacterInfo::UnregisterActorTransform(System.String,UnityEngine.Transform)
IL_001f: ret
METHOD System.String PixelCrushers.DialogueSystem.DialogueActor::GetName() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.String PixelCrushers.DialogueSystem.DialogueActor::GetActorName()
IL_0006: ret
METHOD System.String PixelCrushers.DialogueSystem.DialogueActor::GetActorName() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String PixelCrushers.DialogueSystem.DialogueActor::actor
IL_0006: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000b: brtrue.s IL_0015
IL_000d: ldarg.0
IL_000e: ldfld System.String PixelCrushers.DialogueSystem.DialogueActor::actor
IL_0013: br.s IL_001b
IL_0015: ldarg.0
IL_0016: call System.String UnityEngine.Object::get_name()
IL_001b: stloc.0
IL_001c: ldloc.0
IL_001d: ldstr "Name"
IL_0022: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetActorField(System.String,System.String)
IL_0027: stloc.2
IL_0028: ldloca.s V_2
IL_002a: call System.String PixelCrushers.DialogueSystem.Lua/Result::get_asString()
IL_002f: call System.String PixelCrushers.DialogueSystem.CharacterInfo::GetLocalizedDisplayNameInDatabase(System.String)
IL_0034: stloc.1
IL_0035: ldloc.1
IL_0036: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_003b: brtrue.s IL_003f
IL_003d: ldloc.1
IL_003e: stloc.0
IL_003f: ldloc.0
IL_0040: ldstr "[lua"
IL_0045: callvirt System.Boolean System.String::Contains(System.String)
IL_004a: brtrue.s IL_0059
IL_004c: ldloc.0
IL_004d: ldstr "[var"
IL_0052: callvirt System.Boolean System.String::Contains(System.String)
IL_0057: brfalse.s IL_006f
IL_0059: ldloc.0
IL_005a: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueManager::get_masterDatabase()
IL_005f: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.DialogueDatabase::emphasisSettings
IL_0064: call PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.FormattedText::Parse(System.String,PixelCrushers.DialogueSystem.EmphasisSetting[])
IL_0069: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_006e: ret
IL_006f: ldloc.0
IL_0070: ret
METHOD PixelCrushers.DialogueSystem.DialogueActor PixelCrushers.DialogueSystem.DialogueActor::GetDialogueActorComponent(UnityEngine.Transform) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_000b
IL_0009: ldnull
IL_000a: ret
IL_000b: ldarg.0
IL_000c: callvirt !!0 UnityEngine.Component::GetComponent<PixelCrushers.DialogueSystem.DialogueActor>()
IL_0011: dup
IL_0012: brtrue.s IL_0025
IL_0014: pop
IL_0015: ldarg.0
IL_0016: callvirt !!0 UnityEngine.Component::GetComponentInChildren<PixelCrushers.DialogueSystem.DialogueActor>()
IL_001b: dup
IL_001c: brtrue.s IL_0025
IL_001e: pop
IL_001f: ldarg.0
IL_0020: callvirt !!0 UnityEngine.Component::GetComponentInParent<PixelCrushers.DialogueSystem.DialogueActor>()
IL_0025: ret
METHOD System.String PixelCrushers.DialogueSystem.DialogueActor::GetActorName(UnityEngine.Transform) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_000f
IL_0009: ldsfld System.String System.String::Empty
IL_000e: ret
IL_000f: ldarg.0
IL_0010: call PixelCrushers.DialogueSystem.DialogueActor PixelCrushers.DialogueSystem.DialogueActor::GetDialogueActorComponent(UnityEngine.Transform)
IL_0015: stloc.0
IL_0016: ldloc.0
IL_0017: ldnull
IL_0018: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001d: brfalse.s IL_0027
IL_001f: ldloc.0
IL_0020: callvirt System.Boolean UnityEngine.Behaviour::get_isActiveAndEnabled()
IL_0025: brtrue.s IL_0033
IL_0027: ldarg.0
IL_0028: callvirt System.String UnityEngine.Object::get_name()
IL_002d: call System.String PixelCrushers.DialogueSystem.CharacterInfo::GetLocalizedDisplayNameInDatabase(System.String)
IL_0032: ret
IL_0033: ldloc.0
IL_0034: callvirt System.String PixelCrushers.DialogueSystem.DialogueActor::GetName()
IL_0039: ret
