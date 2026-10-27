TYPE PixelCrushers.DialogueSystem.ConversationModel
METHOD System.String PixelCrushers.DialogueSystem.ConversationModel::GetActorName(PixelCrushers.DialogueSystem.Actor) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0009
IL_0003: ldstr "null"
IL_0008: ret
IL_0009: ldarg.1
IL_000a: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_000f: ret
METHOD System.Void PixelCrushers.DialogueSystem.ConversationModel::SetParticipants(PixelCrushers.DialogueSystem.Conversation,UnityEngine.Transform,UnityEngine.Transform) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: callvirt System.Int32 PixelCrushers.DialogueSystem.Conversation::get_ActorID()
IL_0008: ldarg.2
IL_0009: call PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::GetCharacterInfo(System.Int32,UnityEngine.Transform)
IL_000e: stfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_actorInfo
IL_0013: ldarg.0
IL_0014: ldarg.0
IL_0015: ldarg.1
IL_0016: callvirt System.Int32 PixelCrushers.DialogueSystem.Conversation::get_ConversantID()
IL_001b: ldarg.3
IL_001c: call PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::GetCharacterInfo(System.Int32,UnityEngine.Transform)
IL_0021: stfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_conversantInfo
IL_0026: ldarg.0
IL_0027: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_actorInfo
IL_002c: callvirt System.String PixelCrushers.DialogueSystem.CharacterInfo::get_Name()
IL_0031: ldarg.0
IL_0032: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_conversantInfo
IL_0037: callvirt System.String PixelCrushers.DialogueSystem.CharacterInfo::get_Name()
IL_003c: ldarg.0
IL_003d: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_actorInfo
IL_0042: ldfld System.String PixelCrushers.DialogueSystem.CharacterInfo::nameInDatabase
IL_0047: ldarg.0
IL_0048: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_conversantInfo
IL_004d: ldfld System.String PixelCrushers.DialogueSystem.CharacterInfo::nameInDatabase
IL_0052: call System.Void PixelCrushers.DialogueSystem.DialogueLua::SetParticipants(System.String,System.String,System.String,System.String)
IL_0057: ldarg.0
IL_0058: ldarg.1
IL_0059: call System.Void PixelCrushers.DialogueSystem.ConversationModel::IdentifyPCPortrait(PixelCrushers.DialogueSystem.Conversation)
IL_005e: ret
METHOD System.Void PixelCrushers.DialogueSystem.ConversationModel::UpdateParticipantsOnLinkedConversation(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_0006: ldarg.1
IL_0007: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.Int32)
IL_000c: stloc.0
IL_000d: ldloc.0
IL_000e: brtrue.s IL_0011
IL_0010: ret
IL_0011: ldloc.0
IL_0012: callvirt System.Int32 PixelCrushers.DialogueSystem.Conversation::get_ActorID()
IL_0017: stloc.1
IL_0018: ldloc.1
IL_0019: ldarg.0
IL_001a: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_actorInfo
IL_001f: ldfld System.Int32 PixelCrushers.DialogueSystem.CharacterInfo::id
IL_0024: beq.s IL_0053
IL_0026: ldarg.0
IL_0027: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_002c: ldloc.1
IL_002d: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32)
IL_0032: stloc.3
IL_0033: ldloc.3
IL_0034: brfalse.s IL_0053
IL_0036: ldloc.3
IL_0037: callvirt System.Boolean PixelCrushers.DialogueSystem.Actor::get_IsPlayer()
IL_003c: brfalse.s IL_0053
IL_003e: ldarg.0
IL_003f: ldarg.0
IL_0040: ldloc.1
IL_0041: call PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::GetCharacterInfo(System.Int32)
IL_0046: stfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_actorInfo
IL_004b: ldarg.0
IL_004c: ldloc.0
IL_004d: call System.Void PixelCrushers.DialogueSystem.ConversationModel::IdentifyPCPortrait(PixelCrushers.DialogueSystem.Conversation)
IL_0052: ret
IL_0053: ldloc.0
IL_0054: callvirt System.Int32 PixelCrushers.DialogueSystem.Conversation::get_ConversantID()
IL_0059: stloc.2
IL_005a: ldloc.2
IL_005b: ldarg.0
IL_005c: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_conversantInfo
IL_0061: ldfld System.Int32 PixelCrushers.DialogueSystem.CharacterInfo::id
IL_0066: beq.s IL_0098
IL_0068: ldarg.0
IL_0069: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_006e: ldloc.2
IL_006f: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32)
IL_0074: stloc.s V_4
IL_0076: ldloc.s V_4
IL_0078: brfalse.s IL_0098
IL_007a: ldloc.s V_4
IL_007c: callvirt System.Boolean PixelCrushers.DialogueSystem.Actor::get_IsPlayer()
IL_0081: brfalse.s IL_0098
IL_0083: ldarg.0
IL_0084: ldarg.0
IL_0085: ldloc.2
IL_0086: call PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::GetCharacterInfo(System.Int32)
IL_008b: stfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_conversantInfo
IL_0090: ldarg.0
IL_0091: ldloc.0
IL_0092: call System.Void PixelCrushers.DialogueSystem.ConversationModel::IdentifyPCPortrait(PixelCrushers.DialogueSystem.Conversation)
IL_0097: ret
IL_0098: ret
METHOD PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::GetCharacterInfo(System.Int32,UnityEngine.Transform) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.CharacterInfo> PixelCrushers.DialogueSystem.ConversationModel::m_characterInfoCache
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.CharacterInfo>::ContainsKey(!0)
IL_000c: brtrue IL_010d
IL_0011: newobj System.Void PixelCrushers.DialogueSystem.ConversationModel/<>c__DisplayClass74_0::.ctor()
IL_0016: stloc.0
IL_0017: ldnull
IL_0018: stloc.1
IL_0019: ldarg.2
IL_001a: call PixelCrushers.DialogueSystem.DialogueActor PixelCrushers.DialogueSystem.DialogueActor::GetDialogueActorComponent(UnityEngine.Transform)
IL_001f: stloc.2
IL_0020: ldloc.2
IL_0021: ldnull
IL_0022: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0027: brfalse.s IL_003b
IL_0029: ldarg.0
IL_002a: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_002f: ldloc.2
IL_0030: ldfld System.String PixelCrushers.DialogueSystem.DialogueActor::actor
IL_0035: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.String)
IL_003a: stloc.1
IL_003b: ldloc.1
IL_003c: brtrue.s IL_004b
IL_003e: ldarg.0
IL_003f: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_0044: ldarg.1
IL_0045: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32)
IL_004a: stloc.1
IL_004b: ldloc.1
IL_004c: brtrue.s IL_0055
IL_004e: ldsfld System.String System.String::Empty
IL_0053: br.s IL_005b
IL_0055: ldloc.1
IL_0056: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_005b: stloc.3
IL_005c: ldarg.2
IL_005d: ldnull
IL_005e: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0063: brfalse.s IL_0075
IL_0065: ldloc.3
IL_0066: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_006b: brtrue.s IL_0075
IL_006d: ldloc.3
IL_006e: call UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::GetRegisteredActorTransform(System.String)
IL_0073: starg.s character
IL_0075: ldloc.1
IL_0076: brtrue.s IL_007b
IL_0078: ldarg.1
IL_0079: br.s IL_0081
IL_007b: ldloc.1
IL_007c: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0081: stloc.s V_4
IL_0083: ldloc.2
IL_0084: ldnull
IL_0085: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_008a: brtrue.s IL_008f
IL_008c: ldnull
IL_008d: br.s IL_0095
IL_008f: ldloc.2
IL_0090: callvirt UnityEngine.Sprite PixelCrushers.DialogueSystem.DialogueActor::GetPortraitSprite()
IL_0095: stloc.s V_5
IL_0097: ldloc.s V_5
IL_0099: ldnull
IL_009a: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_009f: brfalse.s IL_00ab
IL_00a1: ldarg.0
IL_00a2: ldarg.2
IL_00a3: ldloc.1
IL_00a4: call UnityEngine.Sprite PixelCrushers.DialogueSystem.ConversationModel::GetPortrait(UnityEngine.Transform,PixelCrushers.DialogueSystem.Actor)
IL_00a9: stloc.s V_5
IL_00ab: ldloc.0
IL_00ac: ldloc.s V_4
IL_00ae: ldloc.3
IL_00af: ldarg.2
IL_00b0: ldarg.0
IL_00b1: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_00b6: ldarg.1
IL_00b7: callvirt PixelCrushers.DialogueSystem.CharacterType PixelCrushers.DialogueSystem.DialogueDatabase::GetCharacterType(System.Int32)
IL_00bc: ldloc.s V_5
IL_00be: newobj System.Void PixelCrushers.DialogueSystem.CharacterInfo::.ctor(System.Int32,System.String,UnityEngine.Transform,PixelCrushers.DialogueSystem.CharacterType,UnityEngine.Sprite)
IL_00c3: stfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel/<>c__DisplayClass74_0::characterInfo
IL_00c8: ldloc.0
IL_00c9: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel/<>c__DisplayClass74_0::characterInfo
IL_00ce: ldfld UnityEngine.Sprite PixelCrushers.DialogueSystem.CharacterInfo::portrait
IL_00d3: ldnull
IL_00d4: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00d9: brfalse.s IL_00f0
IL_00db: ldloc.1
IL_00dc: brfalse.s IL_00f0
IL_00de: ldloc.1
IL_00df: ldloc.0
IL_00e0: ldftn System.Void PixelCrushers.DialogueSystem.ConversationModel/<>c__DisplayClass74_0::<GetCharacterInfo>b__0(UnityEngine.Sprite)
IL_00e6: newobj System.Void PixelCrushers.DialogueSystem.Actor/AssignSpriteDelegate::.ctor(System.Object,System.IntPtr)
IL_00eb: callvirt System.Void PixelCrushers.DialogueSystem.Actor::AssignPortraitSprite(PixelCrushers.DialogueSystem.Actor/AssignSpriteDelegate)
IL_00f0: ldarg.1
IL_00f1: ldc.i4.m1
IL_00f2: bne.un.s IL_00fb
IL_00f4: ldloc.0
IL_00f5: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel/<>c__DisplayClass74_0::characterInfo
IL_00fa: ret
IL_00fb: ldarg.0
IL_00fc: ldfld System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.CharacterInfo> PixelCrushers.DialogueSystem.ConversationModel::m_characterInfoCache
IL_0101: ldarg.1
IL_0102: ldloc.0
IL_0103: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel/<>c__DisplayClass74_0::characterInfo
IL_0108: callvirt System.Void System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.CharacterInfo>::Add(!0,!1)
IL_010d: ldarg.0
IL_010e: ldfld System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.CharacterInfo> PixelCrushers.DialogueSystem.ConversationModel::m_characterInfoCache
IL_0113: ldarg.1
IL_0114: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.CharacterInfo>::get_Item(!0)
IL_0119: ret
METHOD PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::GetCharacterInfo(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.0
IL_0003: ldarg.1
IL_0004: call UnityEngine.Transform PixelCrushers.DialogueSystem.ConversationModel::GetCharacterTransform(System.Int32)
IL_0009: call PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::GetCharacterInfo(System.Int32,UnityEngine.Transform)
IL_000e: ret
METHOD UnityEngine.Transform PixelCrushers.DialogueSystem.ConversationModel::GetCharacterTransform(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldarg.0
IL_0002: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_actorInfo
IL_0007: ldfld System.Int32 PixelCrushers.DialogueSystem.CharacterInfo::id
IL_000c: bne.un.s IL_001a
IL_000e: ldarg.0
IL_000f: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_actorInfo
IL_0014: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_0019: ret
IL_001a: ldarg.1
IL_001b: ldarg.0
IL_001c: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_conversantInfo
IL_0021: ldfld System.Int32 PixelCrushers.DialogueSystem.CharacterInfo::id
IL_0026: bne.un.s IL_0034
IL_0028: ldarg.0
IL_0029: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_conversantInfo
IL_002e: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_0033: ret
IL_0034: ldnull
IL_0035: ret
METHOD System.String PixelCrushers.DialogueSystem.ConversationModel::GetPCName() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_0006: ldarg.0
IL_0007: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_actorInfo
IL_000c: ldfld System.Int32 PixelCrushers.DialogueSystem.CharacterInfo::id
IL_0011: callvirt System.Boolean PixelCrushers.DialogueSystem.DialogueDatabase::IsPlayerID(System.Int32)
IL_0016: brfalse.s IL_0024
IL_0018: ldarg.0
IL_0019: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_actorInfo
IL_001e: callvirt System.String PixelCrushers.DialogueSystem.CharacterInfo::get_Name()
IL_0023: ret
IL_0024: ldarg.0
IL_0025: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_002a: ldarg.0
IL_002b: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_conversantInfo
IL_0030: ldfld System.Int32 PixelCrushers.DialogueSystem.CharacterInfo::id
IL_0035: callvirt System.Boolean PixelCrushers.DialogueSystem.DialogueDatabase::IsPlayerID(System.Int32)
IL_003a: brfalse.s IL_0048
IL_003c: ldarg.0
IL_003d: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.ConversationModel::m_conversantInfo
IL_0042: callvirt System.String PixelCrushers.DialogueSystem.CharacterInfo::get_Name()
IL_0047: ret
IL_0048: ldarg.0
IL_0049: ldfld System.String PixelCrushers.DialogueSystem.ConversationModel::pcPortraitName
IL_004e: ret
