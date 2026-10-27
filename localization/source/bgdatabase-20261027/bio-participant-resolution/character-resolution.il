TYPE PixelCrushers.DialogueSystem.CharacterInfo
METHOD System.String PixelCrushers.DialogueSystem.CharacterInfo::get_Name() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.String PixelCrushers.DialogueSystem.CharacterInfo::<Name>k__BackingField
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.CharacterInfo::set_Name(System.String) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.String PixelCrushers.DialogueSystem.CharacterInfo::<Name>k__BackingField
IL_0007: ret
METHOD System.Void PixelCrushers.DialogueSystem.CharacterInfo::.ctor(System.Int32,System.String,UnityEngine.Transform,PixelCrushers.DialogueSystem.CharacterType,UnityEngine.Sprite) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: ldarg.0
IL_0007: ldarg.1
IL_0008: stfld System.Int32 PixelCrushers.DialogueSystem.CharacterInfo::id
IL_000d: ldarg.0
IL_000e: ldarg.2
IL_000f: stfld System.String PixelCrushers.DialogueSystem.CharacterInfo::nameInDatabase
IL_0014: ldarg.0
IL_0015: ldarg.s characterType
IL_0017: stfld PixelCrushers.DialogueSystem.CharacterType PixelCrushers.DialogueSystem.CharacterInfo::characterType
IL_001c: ldarg.0
IL_001d: ldarg.s portrait
IL_001f: stfld UnityEngine.Sprite PixelCrushers.DialogueSystem.CharacterInfo::portrait
IL_0024: ldarg.0
IL_0025: ldarg.3
IL_0026: stfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_002b: ldarg.3
IL_002c: ldnull
IL_002d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0032: brfalse.s IL_0059
IL_0034: ldarg.2
IL_0035: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_003a: brtrue.s IL_0059
IL_003c: ldarg.2
IL_003d: ldc.i4.1
IL_003e: call UnityEngine.GameObject PixelCrushers.DialogueSystem.SequencerTools::FindSpecifier(System.String,System.Boolean)
IL_0043: stloc.1
IL_0044: ldloc.1
IL_0045: ldnull
IL_0046: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_004b: brfalse.s IL_0059
IL_004d: ldarg.0
IL_004e: ldloc.1
IL_004f: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0054: stfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_0059: ldarg.3
IL_005a: call PixelCrushers.DialogueSystem.DialogueActor PixelCrushers.DialogueSystem.DialogueActor::GetDialogueActorComponent(UnityEngine.Transform)
IL_005f: stloc.0
IL_0060: ldloc.0
IL_0061: ldnull
IL_0062: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0067: brfalse.s IL_0076
IL_0069: ldarg.0
IL_006a: ldarg.2
IL_006b: call System.String PixelCrushers.DialogueSystem.CharacterInfo::GetLocalizedDisplayNameInDatabase(System.String)
IL_0070: call System.Void PixelCrushers.DialogueSystem.CharacterInfo::set_Name(System.String)
IL_0075: ret
IL_0076: ldarg.0
IL_0077: ldloc.0
IL_0078: callvirt System.String PixelCrushers.DialogueSystem.DialogueActor::GetActorName()
IL_007d: call System.Void PixelCrushers.DialogueSystem.CharacterInfo::set_Name(System.String)
IL_0082: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueManager::get_masterDatabase()
IL_0087: ldloc.0
IL_0088: ldfld System.String PixelCrushers.DialogueSystem.DialogueActor::actor
IL_008d: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.String)
IL_0092: stloc.2
IL_0093: ldloc.0
IL_0094: callvirt UnityEngine.Sprite PixelCrushers.DialogueSystem.DialogueActor::GetPortraitSprite()
IL_0099: stloc.3
IL_009a: ldloc.3
IL_009b: ldnull
IL_009c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00a1: brfalse.s IL_00ab
IL_00a3: ldarg.0
IL_00a4: ldloc.3
IL_00a5: stfld UnityEngine.Sprite PixelCrushers.DialogueSystem.CharacterInfo::portrait
IL_00aa: ret
IL_00ab: ldloc.2
IL_00ac: brfalse.s IL_00c4
IL_00ae: ldarg.s portrait
IL_00b0: ldnull
IL_00b1: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00b6: brfalse.s IL_00c4
IL_00b8: ldarg.0
IL_00b9: ldloc.2
IL_00ba: callvirt UnityEngine.Sprite PixelCrushers.DialogueSystem.Actor::GetPortraitSprite()
IL_00bf: stfld UnityEngine.Sprite PixelCrushers.DialogueSystem.CharacterInfo::portrait
IL_00c4: ret
METHOD System.String PixelCrushers.DialogueSystem.CharacterInfo::GetLocalizedDisplayNameInDatabase(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "Display Name"
IL_0006: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetLocalizedActorField(System.String,System.String)
IL_000b: stloc.1
IL_000c: ldloca.s V_1
IL_000e: call System.String PixelCrushers.DialogueSystem.Lua/Result::get_asString()
IL_0013: stloc.0
IL_0014: ldloc.0
IL_0015: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_001a: brtrue.s IL_0029
IL_001c: ldloc.0
IL_001d: ldstr "nil"
IL_0022: call System.Boolean System.String::Equals(System.String,System.String)
IL_0027: brfalse.s IL_003d
IL_0029: ldarg.0
IL_002a: ldstr "Name"
IL_002f: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetLocalizedActorField(System.String,System.String)
IL_0034: stloc.1
IL_0035: ldloca.s V_1
IL_0037: call System.String PixelCrushers.DialogueSystem.Lua/Result::get_asString()
IL_003c: stloc.0
IL_003d: ldloc.0
IL_003e: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0043: brtrue.s IL_0052
IL_0045: ldloc.0
IL_0046: ldstr "nil"
IL_004b: call System.Boolean System.String::Equals(System.String,System.String)
IL_0050: brfalse.s IL_0054
IL_0052: ldarg.0
IL_0053: stloc.0
IL_0054: ldloc.0
IL_0055: call System.String PixelCrushers.DialogueSystem.FormattedText::ParseCode(System.String)
IL_005a: ret
METHOD System.Void PixelCrushers.DialogueSystem.CharacterInfo::RegisterActorTransform(System.String,UnityEngine.Transform) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0006: brtrue.s IL_0011
IL_0008: ldarg.1
IL_0009: ldnull
IL_000a: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000f: brfalse.s IL_0012
IL_0011: ret
IL_0012: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform> PixelCrushers.DialogueSystem.CharacterInfo::registeredActorTransforms
IL_0017: ldarg.0
IL_0018: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform>::ContainsKey(!0)
IL_001d: brfalse.s IL_0069
IL_001f: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_0024: brfalse.s IL_005c
IL_0026: ldc.i4.5
IL_0027: newarr System.String
IL_002c: dup
IL_002d: ldc.i4.0
IL_002e: ldstr "Dialogue System: Registering transform "
IL_0033: stelem.ref
IL_0034: dup
IL_0035: ldc.i4.1
IL_0036: ldarg.1
IL_0037: callvirt System.String UnityEngine.Object::get_name()
IL_003c: stelem.ref
IL_003d: dup
IL_003e: ldc.i4.2
IL_003f: ldstr " as actor '"
IL_0044: stelem.ref
IL_0045: dup
IL_0046: ldc.i4.3
IL_0047: ldarg.0
IL_0048: stelem.ref
IL_0049: dup
IL_004a: ldc.i4.4
IL_004b: ldstr "' but another transform is already registered. Overwriting with new transform."
IL_0050: stelem.ref
IL_0051: call System.String System.String::Concat(System.String[])
IL_0056: ldarg.1
IL_0057: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_005c: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform> PixelCrushers.DialogueSystem.CharacterInfo::registeredActorTransforms
IL_0061: ldarg.0
IL_0062: ldarg.1
IL_0063: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform>::set_Item(!0,!1)
IL_0068: ret
IL_0069: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_006e: brfalse.s IL_00a6
IL_0070: ldc.i4.5
IL_0071: newarr System.String
IL_0076: dup
IL_0077: ldc.i4.0
IL_0078: ldstr "Dialogue System: Registering transform "
IL_007d: stelem.ref
IL_007e: dup
IL_007f: ldc.i4.1
IL_0080: ldarg.1
IL_0081: callvirt System.String UnityEngine.Object::get_name()
IL_0086: stelem.ref
IL_0087: dup
IL_0088: ldc.i4.2
IL_0089: ldstr " as actor '"
IL_008e: stelem.ref
IL_008f: dup
IL_0090: ldc.i4.3
IL_0091: ldarg.0
IL_0092: stelem.ref
IL_0093: dup
IL_0094: ldc.i4.4
IL_0095: ldstr "'."
IL_009a: stelem.ref
IL_009b: call System.String System.String::Concat(System.String[])
IL_00a0: ldarg.1
IL_00a1: call System.Void UnityEngine.Debug::Log(System.Object,UnityEngine.Object)
IL_00a6: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform> PixelCrushers.DialogueSystem.CharacterInfo::registeredActorTransforms
IL_00ab: ldarg.0
IL_00ac: ldarg.1
IL_00ad: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform>::Add(!0,!1)
IL_00b2: ret
METHOD System.Void PixelCrushers.DialogueSystem.CharacterInfo::UnregisterActorTransform(System.String,UnityEngine.Transform) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0006: brtrue.s IL_0011
IL_0008: ldarg.1
IL_0009: ldnull
IL_000a: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000f: brfalse.s IL_0012
IL_0011: ret
IL_0012: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform> PixelCrushers.DialogueSystem.CharacterInfo::registeredActorTransforms
IL_0017: ldarg.0
IL_0018: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform>::ContainsKey(!0)
IL_001d: brfalse.s IL_0068
IL_001f: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_0024: brfalse.s IL_005c
IL_0026: ldc.i4.5
IL_0027: newarr System.String
IL_002c: dup
IL_002d: ldc.i4.0
IL_002e: ldstr "Dialogue System: Unregistering transform "
IL_0033: stelem.ref
IL_0034: dup
IL_0035: ldc.i4.1
IL_0036: ldarg.1
IL_0037: callvirt System.String UnityEngine.Object::get_name()
IL_003c: stelem.ref
IL_003d: dup
IL_003e: ldc.i4.2
IL_003f: ldstr " from actor '"
IL_0044: stelem.ref
IL_0045: dup
IL_0046: ldc.i4.3
IL_0047: ldarg.0
IL_0048: stelem.ref
IL_0049: dup
IL_004a: ldc.i4.4
IL_004b: ldstr "'."
IL_0050: stelem.ref
IL_0051: call System.String System.String::Concat(System.String[])
IL_0056: ldarg.1
IL_0057: call System.Void UnityEngine.Debug::Log(System.Object,UnityEngine.Object)
IL_005c: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform> PixelCrushers.DialogueSystem.CharacterInfo::registeredActorTransforms
IL_0061: ldarg.0
IL_0062: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform>::Remove(!0)
IL_0067: pop
IL_0068: ret
METHOD UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::GetRegisteredActorTransform(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform> PixelCrushers.DialogueSystem.CharacterInfo::registeredActorTransforms
IL_0005: ldarg.0
IL_0006: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform>::ContainsKey(!0)
IL_000b: brtrue.s IL_000f
IL_000d: ldnull
IL_000e: ret
IL_000f: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform> PixelCrushers.DialogueSystem.CharacterInfo::registeredActorTransforms
IL_0014: ldarg.0
IL_0015: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform>::get_Item(!0)
IL_001a: ret
METHOD System.Void PixelCrushers.DialogueSystem.CharacterInfo::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform>::.ctor()
IL_0005: stsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.Transform> PixelCrushers.DialogueSystem.CharacterInfo::registeredActorTransforms
IL_000a: ret
