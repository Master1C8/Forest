METHOD System.String[] ForestProbe::BuckyInteractionDiagnostics() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0006: stloc.0
IL_0007: ldnull
IL_0008: stloc.1
IL_0009: nop
IL_000a: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.Gameplay.SpawnableActor>()
IL_000f: stloc.s V_16
IL_0011: ldc.i4.0
IL_0012: stloc.s V_17
IL_0014: br.s IL_0076
IL_0016: ldloc.s V_16
IL_0018: ldloc.s V_17
IL_001a: ldelem.ref
IL_001b: stloc.s V_18
IL_001d: ldloc.s V_18
IL_001f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0024: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0029: stloc.s V_20
IL_002b: ldloca.s V_20
IL_002d: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0032: brfalse.s IL_004c
IL_0034: ldloc.s V_18
IL_0036: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_003b: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0040: ldstr "SpawnedContent/Critters/Bucky/Content/BuckyOnNorthShore(Clone)"
IL_0045: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_004a: br.s IL_004d
IL_004c: ldc.i4.0
IL_004d: stloc.s V_19
IL_004f: ldloc.s V_19
IL_0051: brfalse.s IL_0070
IL_0053: nop
IL_0054: ldloc.1
IL_0055: ldnull
IL_0056: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_005b: stloc.s V_21
IL_005d: ldloc.s V_21
IL_005f: brfalse.s IL_006c
IL_0061: ldstr "Ambiguous Bucky actor"
IL_0066: newobj System.Void System.Exception::.ctor(System.String)
IL_006b: throw
IL_006c: ldloc.s V_18
IL_006e: stloc.1
IL_006f: nop
IL_0070: ldloc.s V_17
IL_0072: ldc.i4.1
IL_0073: add
IL_0074: stloc.s V_17
IL_0076: ldloc.s V_17
IL_0078: ldloc.s V_16
IL_007a: ldlen
IL_007b: conv.i4
IL_007c: blt.s IL_0016
IL_007e: ldnull
IL_007f: stloc.2
IL_0080: nop
IL_0081: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.InteractionUiController>()
IL_0086: stloc.s V_22
IL_0088: ldc.i4.0
IL_0089: stloc.s V_23
IL_008b: br.s IL_00ed
IL_008d: ldloc.s V_22
IL_008f: ldloc.s V_23
IL_0091: ldelem.ref
IL_0092: stloc.s V_24
IL_0094: ldloc.s V_24
IL_0096: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_009b: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_00a0: stloc.s V_20
IL_00a2: ldloca.s V_20
IL_00a4: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_00a9: brfalse.s IL_00c3
IL_00ab: ldloc.s V_24
IL_00ad: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00b2: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_00b7: ldstr "SpawnedContent/Critters/Bucky/Content/BuckyOnNorthShore(Clone)/Interaction/InteractionUiController"
IL_00bc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00c1: br.s IL_00c4
IL_00c3: ldc.i4.0
IL_00c4: stloc.s V_25
IL_00c6: ldloc.s V_25
IL_00c8: brfalse.s IL_00e7
IL_00ca: nop
IL_00cb: ldloc.2
IL_00cc: ldnull
IL_00cd: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00d2: stloc.s V_26
IL_00d4: ldloc.s V_26
IL_00d6: brfalse.s IL_00e3
IL_00d8: ldstr "Ambiguous Bucky controller"
IL_00dd: newobj System.Void System.Exception::.ctor(System.String)
IL_00e2: throw
IL_00e3: ldloc.s V_24
IL_00e5: stloc.2
IL_00e6: nop
IL_00e7: ldloc.s V_23
IL_00e9: ldc.i4.1
IL_00ea: add
IL_00eb: stloc.s V_23
IL_00ed: ldloc.s V_23
IL_00ef: ldloc.s V_22
IL_00f1: ldlen
IL_00f2: conv.i4
IL_00f3: blt.s IL_008d
IL_00f5: ldloc.1
IL_00f6: ldnull
IL_00f7: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00fc: brtrue.s IL_0107
IL_00fe: ldloc.2
IL_00ff: ldnull
IL_0100: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0105: br.s IL_0108
IL_0107: ldc.i4.1
IL_0108: stloc.s V_27
IL_010a: ldloc.s V_27
IL_010c: brfalse.s IL_0119
IL_010e: ldstr "Bucky actor/controller absent"
IL_0113: newobj System.Void System.Exception::.ctor(System.String)
IL_0118: throw
IL_0119: ldloc.2
IL_011a: ldstr "dialogueInteractionTrigger"
IL_011f: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0124: isinst TheForestOfLove.Interaction.DialogueInteractionTrigger
IL_0129: stloc.3
IL_012a: ldloc.2
IL_012b: ldstr "interactionUi"
IL_0130: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0135: isinst TheForestOfLove.InteractionUi
IL_013a: stloc.s V_4
IL_013c: ldloc.2
IL_013d: ldstr "collisionEventListener"
IL_0142: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0147: isinst TheForestOfLove.CollisionEventListener
IL_014c: stloc.s V_5
IL_014e: ldloc.3
IL_014f: ldnull
IL_0150: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0155: brtrue.s IL_0169
IL_0157: ldloc.3
IL_0158: ldstr "settings"
IL_015d: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0162: isinst TheForestOfLove.DialogueSettings
IL_0167: br.s IL_016a
IL_0169: ldnull
IL_016a: stloc.s V_6
IL_016c: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0171: stloc.s V_7
IL_0173: ldloc.3
IL_0174: ldnull
IL_0175: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_017a: brtrue.s IL_01a4
IL_017c: ldloc.s V_4
IL_017e: ldnull
IL_017f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0184: brtrue.s IL_01a4
IL_0186: ldloc.s V_5
IL_0188: ldnull
IL_0189: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_018e: brtrue.s IL_01a4
IL_0190: ldloc.s V_6
IL_0192: ldnull
IL_0193: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0198: brtrue.s IL_01a4
IL_019a: ldloc.s V_7
IL_019c: ldnull
IL_019d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_01a2: br.s IL_01a5
IL_01a4: ldc.i4.1
IL_01a5: stloc.s V_28
IL_01a7: ldloc.s V_28
IL_01a9: brfalse.s IL_01b6
IL_01ab: ldstr "Missing loaded Bucky bindings/Player"
IL_01b0: newobj System.Void System.Exception::.ctor(System.String)
IL_01b5: throw
IL_01b6: ldloc.s V_5
IL_01b8: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.CapsuleCollider2D>()
IL_01bd: stloc.s V_8
IL_01bf: ldloc.s V_7
IL_01c1: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.CircleCollider2D>()
IL_01c6: stloc.s V_9
IL_01c8: ldloc.s V_7
IL_01ca: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Rigidbody2D>()
IL_01cf: stloc.s V_10
IL_01d1: ldloc.s V_8
IL_01d3: ldnull
IL_01d4: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_01d9: brtrue.s IL_01ef
IL_01db: ldloc.s V_9
IL_01dd: ldnull
IL_01de: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_01e3: brtrue.s IL_01ef
IL_01e5: ldloc.s V_10
IL_01e7: ldnull
IL_01e8: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_01ed: br.s IL_01f0
IL_01ef: ldc.i4.1
IL_01f0: stloc.s V_29
IL_01f2: ldloc.s V_29
IL_01f4: brfalse.s IL_0201
IL_01f6: ldstr "Missing loaded Bucky/Player physics"
IL_01fb: newobj System.Void System.Exception::.ctor(System.String)
IL_0200: throw
IL_0201: ldtoken TheForestOfLove.InteractionUiController
IL_0206: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_020b: ldstr "authorityId"
IL_0210: ldc.i4.s 56
IL_0212: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0217: ldnull
IL_0218: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_021d: unbox.any System.Int32
IL_0222: stloc.s V_11
IL_0224: ldtoken TheForestOfLove.Interaction.DialogueInteractionTrigger
IL_0229: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_022e: ldstr "authorityId"
IL_0233: ldc.i4.s 56
IL_0235: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_023a: ldnull
IL_023b: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0240: unbox.any System.Int32
IL_0245: stloc.s V_12
IL_0247: ldloc.0
IL_0248: ldc.i4.6
IL_0249: newarr System.String
IL_024e: dup
IL_024f: ldc.i4.0
IL_0250: ldstr "buckyGuards | gameplay="
IL_0255: stelem.ref
IL_0256: dup
IL_0257: ldc.i4.1
IL_0258: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_025d: stloc.s V_30
IL_025f: ldloca.s V_30
IL_0261: call System.String System.Boolean::ToString()
IL_0266: stelem.ref
IL_0267: dup
IL_0268: ldc.i4.2
IL_0269: ldstr " | anyEvent="
IL_026e: stelem.ref
IL_026f: dup
IL_0270: ldc.i4.3
IL_0271: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0276: stloc.s V_30
IL_0278: ldloca.s V_30
IL_027a: call System.String System.Boolean::ToString()
IL_027f: stelem.ref
IL_0280: dup
IL_0281: ldc.i4.4
IL_0282: ldstr " | conversation="
IL_0287: stelem.ref
IL_0288: dup
IL_0289: ldc.i4.5
IL_028a: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_028f: stloc.s V_30
IL_0291: ldloca.s V_30
IL_0293: call System.String System.Boolean::ToString()
IL_0298: stelem.ref
IL_0299: call System.String System.String::Concat(System.String[])
IL_029e: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_02a3: nop
IL_02a4: ldloc.0
IL_02a5: ldc.i4.s 16
IL_02a7: newarr System.String
IL_02ac: dup
IL_02ad: ldc.i4.0
IL_02ae: ldstr "buckyActor | path="
IL_02b3: stelem.ref
IL_02b4: dup
IL_02b5: ldc.i4.1
IL_02b6: ldloc.1
IL_02b7: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_02bc: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_02c1: stelem.ref
IL_02c2: dup
IL_02c3: ldc.i4.2
IL_02c4: ldstr " | id="
IL_02c9: stelem.ref
IL_02ca: dup
IL_02cb: ldc.i4.3
IL_02cc: ldloc.1
IL_02cd: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_02d2: stloc.s V_31
IL_02d4: ldloca.s V_31
IL_02d6: call System.String System.Int32::ToString()
IL_02db: stelem.ref
IL_02dc: dup
IL_02dd: ldc.i4.4
IL_02de: ldstr " | gameObject="
IL_02e3: stelem.ref
IL_02e4: dup
IL_02e5: ldc.i4.5
IL_02e6: ldloc.1
IL_02e7: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_02ec: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_02f1: stloc.s V_31
IL_02f3: ldloca.s V_31
IL_02f5: call System.String System.Int32::ToString()
IL_02fa: stelem.ref
IL_02fb: dup
IL_02fc: ldc.i4.6
IL_02fd: ldstr " | type="
IL_0302: stelem.ref
IL_0303: dup
IL_0304: ldc.i4.7
IL_0305: ldloc.1
IL_0306: callvirt System.Type System.Object::GetType()
IL_030b: callvirt System.String System.Type::get_FullName()
IL_0310: stelem.ref
IL_0311: dup
IL_0312: ldc.i4.8
IL_0313: ldstr " | dbName="
IL_0318: stelem.ref
IL_0319: dup
IL_031a: ldc.i4.s 9
IL_031c: ldloc.1
IL_031d: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_0322: stelem.ref
IL_0323: dup
IL_0324: ldc.i4.s 10
IL_0326: ldstr " | active="
IL_032b: stelem.ref
IL_032c: dup
IL_032d: ldc.i4.s 11
IL_032f: ldloc.1
IL_0330: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0335: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_033a: stloc.s V_30
IL_033c: ldloca.s V_30
IL_033e: call System.String System.Boolean::ToString()
IL_0343: stelem.ref
IL_0344: dup
IL_0345: ldc.i4.s 12
IL_0347: ldstr " | enabled="
IL_034c: stelem.ref
IL_034d: dup
IL_034e: ldc.i4.s 13
IL_0350: ldloc.1
IL_0351: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0356: stloc.s V_30
IL_0358: ldloca.s V_30
IL_035a: call System.String System.Boolean::ToString()
IL_035f: stelem.ref
IL_0360: dup
IL_0361: ldc.i4.s 14
IL_0363: ldstr " | position="
IL_0368: stelem.ref
IL_0369: dup
IL_036a: ldc.i4.s 15
IL_036c: ldloc.1
IL_036d: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0372: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0377: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_037c: stelem.ref
IL_037d: call System.String System.String::Concat(System.String[])
IL_0382: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0387: nop
IL_0388: ldloc.0
IL_0389: ldc.i4.s 20
IL_038b: newarr System.String
IL_0390: dup
IL_0391: ldc.i4.0
IL_0392: ldstr "buckyController | path="
IL_0397: stelem.ref
IL_0398: dup
IL_0399: ldc.i4.1
IL_039a: ldloc.2
IL_039b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_03a0: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_03a5: stelem.ref
IL_03a6: dup
IL_03a7: ldc.i4.2
IL_03a8: ldstr " | id="
IL_03ad: stelem.ref
IL_03ae: dup
IL_03af: ldc.i4.3
IL_03b0: ldloc.2
IL_03b1: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_03b6: stloc.s V_31
IL_03b8: ldloca.s V_31
IL_03ba: call System.String System.Int32::ToString()
IL_03bf: stelem.ref
IL_03c0: dup
IL_03c1: ldc.i4.4
IL_03c2: ldstr " | gameObject="
IL_03c7: stelem.ref
IL_03c8: dup
IL_03c9: ldc.i4.5
IL_03ca: ldloc.2
IL_03cb: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_03d0: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_03d5: stloc.s V_31
IL_03d7: ldloca.s V_31
IL_03d9: call System.String System.Int32::ToString()
IL_03de: stelem.ref
IL_03df: dup
IL_03e0: ldc.i4.6
IL_03e1: ldstr " | type="
IL_03e6: stelem.ref
IL_03e7: dup
IL_03e8: ldc.i4.7
IL_03e9: ldloc.2
IL_03ea: callvirt System.Type System.Object::GetType()
IL_03ef: callvirt System.String System.Type::get_FullName()
IL_03f4: stelem.ref
IL_03f5: dup
IL_03f6: ldc.i4.8
IL_03f7: ldstr " | active="
IL_03fc: stelem.ref
IL_03fd: dup
IL_03fe: ldc.i4.s 9
IL_0400: ldloc.2
IL_0401: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0406: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_040b: stloc.s V_30
IL_040d: ldloca.s V_30
IL_040f: call System.String System.Boolean::ToString()
IL_0414: stelem.ref
IL_0415: dup
IL_0416: ldc.i4.s 10
IL_0418: ldstr " | enabled="
IL_041d: stelem.ref
IL_041e: dup
IL_041f: ldc.i4.s 11
IL_0421: ldloc.2
IL_0422: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0427: stloc.s V_30
IL_0429: ldloca.s V_30
IL_042b: call System.String System.Boolean::ToString()
IL_0430: stelem.ref
IL_0431: dup
IL_0432: ldc.i4.s 12
IL_0434: ldstr " | authorityId="
IL_0439: stelem.ref
IL_043a: dup
IL_043b: ldc.i4.s 13
IL_043d: ldloca.s V_11
IL_043f: call System.String System.Int32::ToString()
IL_0444: stelem.ref
IL_0445: dup
IL_0446: ldc.i4.s 14
IL_0448: ldstr " | touching="
IL_044d: stelem.ref
IL_044e: dup
IL_044f: ldc.i4.s 15
IL_0451: ldloc.2
IL_0452: ldstr "isPlayerTouching"
IL_0457: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_045c: dup
IL_045d: brtrue.s IL_0463
IL_045f: pop
IL_0460: ldnull
IL_0461: br.s IL_0468
IL_0463: callvirt System.String System.Object::ToString()
IL_0468: stelem.ref
IL_0469: dup
IL_046a: ldc.i4.s 16
IL_046c: ldstr " | available="
IL_0471: stelem.ref
IL_0472: dup
IL_0473: ldc.i4.s 17
IL_0475: ldloc.2
IL_0476: ldstr "availableOptions"
IL_047b: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0480: isinst System.Collections.IEnumerable
IL_0485: call System.String ForestProbe::ListValues(System.Collections.IEnumerable)
IL_048a: stelem.ref
IL_048b: dup
IL_048c: ldc.i4.s 18
IL_048e: ldstr " | disallowed="
IL_0493: stelem.ref
IL_0494: dup
IL_0495: ldc.i4.s 19
IL_0497: ldloc.2
IL_0498: ldstr "disallowedOptions"
IL_049d: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_04a2: isinst System.Collections.IEnumerable
IL_04a7: call System.String ForestProbe::ListValues(System.Collections.IEnumerable)
IL_04ac: stelem.ref
IL_04ad: call System.String System.String::Concat(System.String[])
IL_04b2: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_04b7: nop
IL_04b8: ldloc.0
IL_04b9: ldc.i4.s 32
IL_04bb: newarr System.String
IL_04c0: dup
IL_04c1: ldc.i4.0
IL_04c2: ldstr "buckyTrigger | path="
IL_04c7: stelem.ref
IL_04c8: dup
IL_04c9: ldc.i4.1
IL_04ca: ldloc.3
IL_04cb: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04d0: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_04d5: stelem.ref
IL_04d6: dup
IL_04d7: ldc.i4.2
IL_04d8: ldstr " | id="
IL_04dd: stelem.ref
IL_04de: dup
IL_04df: ldc.i4.3
IL_04e0: ldloc.3
IL_04e1: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_04e6: stloc.s V_31
IL_04e8: ldloca.s V_31
IL_04ea: call System.String System.Int32::ToString()
IL_04ef: stelem.ref
IL_04f0: dup
IL_04f1: ldc.i4.4
IL_04f2: ldstr " | gameObject="
IL_04f7: stelem.ref
IL_04f8: dup
IL_04f9: ldc.i4.5
IL_04fa: ldloc.3
IL_04fb: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0500: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0505: stloc.s V_31
IL_0507: ldloca.s V_31
IL_0509: call System.String System.Int32::ToString()
IL_050e: stelem.ref
IL_050f: dup
IL_0510: ldc.i4.6
IL_0511: ldstr " | type="
IL_0516: stelem.ref
IL_0517: dup
IL_0518: ldc.i4.7
IL_0519: ldloc.3
IL_051a: callvirt System.Type System.Object::GetType()
IL_051f: callvirt System.String System.Type::get_FullName()
IL_0524: stelem.ref
IL_0525: dup
IL_0526: ldc.i4.8
IL_0527: ldstr " | active="
IL_052c: stelem.ref
IL_052d: dup
IL_052e: ldc.i4.s 9
IL_0530: ldloc.3
IL_0531: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0536: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_053b: stloc.s V_30
IL_053d: ldloca.s V_30
IL_053f: call System.String System.Boolean::ToString()
IL_0544: stelem.ref
IL_0545: dup
IL_0546: ldc.i4.s 10
IL_0548: ldstr " | enabled="
IL_054d: stelem.ref
IL_054e: dup
IL_054f: ldc.i4.s 11
IL_0551: ldloc.3
IL_0552: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0557: stloc.s V_30
IL_0559: ldloca.s V_30
IL_055b: call System.String System.Boolean::ToString()
IL_0560: stelem.ref
IL_0561: dup
IL_0562: ldc.i4.s 12
IL_0564: ldstr " | authorityId="
IL_0569: stelem.ref
IL_056a: dup
IL_056b: ldc.i4.s 13
IL_056d: ldloca.s V_12
IL_056f: call System.String System.Int32::ToString()
IL_0574: stelem.ref
IL_0575: dup
IL_0576: ldc.i4.s 14
IL_0578: ldstr " | touching="
IL_057d: stelem.ref
IL_057e: dup
IL_057f: ldc.i4.s 15
IL_0581: ldloc.3
IL_0582: ldstr "isPlayerTouching"
IL_0587: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_058c: dup
IL_058d: brtrue.s IL_0593
IL_058f: pop
IL_0590: ldnull
IL_0591: br.s IL_0598
IL_0593: callvirt System.String System.Object::ToString()
IL_0598: stelem.ref
IL_0599: dup
IL_059a: ldc.i4.s 16
IL_059c: ldstr " | mode="
IL_05a1: stelem.ref
IL_05a2: dup
IL_05a3: ldc.i4.s 17
IL_05a5: ldloc.3
IL_05a6: callvirt TheForestOfLove.Narrative.QuestManagerInteractionMode TheForestOfLove.Interaction.DialogueInteractionTrigger::get_interactionMode()
IL_05ab: stloc.s V_31
IL_05ad: ldloca.s V_31
IL_05af: call System.String System.Int32::ToString()
IL_05b4: stelem.ref
IL_05b5: dup
IL_05b6: ldc.i4.s 18
IL_05b8: ldstr " | triggered="
IL_05bd: stelem.ref
IL_05be: dup
IL_05bf: ldc.i4.s 19
IL_05c1: ldloc.3
IL_05c2: ldstr "isTriggered"
IL_05c7: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_05cc: dup
IL_05cd: brtrue.s IL_05d3
IL_05cf: pop
IL_05d0: ldnull
IL_05d1: br.s IL_05d8
IL_05d3: callvirt System.String System.Object::ToString()
IL_05d8: stelem.ref
IL_05d9: dup
IL_05da: ldc.i4.s 20
IL_05dc: ldstr " | cooldown="
IL_05e1: stelem.ref
IL_05e2: dup
IL_05e3: ldc.i4.s 21
IL_05e5: ldloc.3
IL_05e6: ldstr "cooldownLoopsRemaining"
IL_05eb: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_05f0: dup
IL_05f1: brtrue.s IL_05f7
IL_05f3: pop
IL_05f4: ldnull
IL_05f5: br.s IL_05fc
IL_05f7: callvirt System.String System.Object::ToString()
IL_05fc: stelem.ref
IL_05fd: dup
IL_05fe: ldc.i4.s 22
IL_0600: ldstr " | blocked="
IL_0605: stelem.ref
IL_0606: dup
IL_0607: ldc.i4.s 23
IL_0609: ldloc.3
IL_060a: callvirt System.Boolean TheForestOfLove.Interaction.InteractionTrigger::get_interactionBlocked()
IL_060f: stloc.s V_30
IL_0611: ldloca.s V_30
IL_0613: call System.String System.Boolean::ToString()
IL_0618: stelem.ref
IL_0619: dup
IL_061a: ldc.i4.s 24
IL_061c: ldstr " | onCollision="
IL_0621: stelem.ref
IL_0622: dup
IL_0623: ldc.i4.s 25
IL_0625: ldloc.3
IL_0626: ldstr "triggerOnCollision"
IL_062b: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0630: dup
IL_0631: brtrue.s IL_0637
IL_0633: pop
IL_0634: ldnull
IL_0635: br.s IL_063c
IL_0637: callvirt System.String System.Object::ToString()
IL_063c: stelem.ref
IL_063d: dup
IL_063e: ldc.i4.s 26
IL_0640: ldstr " | withoutUi="
IL_0645: stelem.ref
IL_0646: dup
IL_0647: ldc.i4.s 27
IL_0649: ldloc.3
IL_064a: ldstr "allowTriggeringWithoutUi"
IL_064f: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0654: dup
IL_0655: brtrue.s IL_065b
IL_0657: pop
IL_0658: ldnull
IL_0659: br.s IL_0660
IL_065b: callvirt System.String System.Object::ToString()
IL_0660: stelem.ref
IL_0661: dup
IL_0662: ldc.i4.s 28
IL_0664: ldstr " | namedTrigger="
IL_0669: stelem.ref
IL_066a: dup
IL_066b: ldc.i4.s 29
IL_066d: ldloc.3
IL_066e: callvirt System.String TheForestOfLove.Interaction.InteractionTrigger::get_TriggerDbName()
IL_0673: stelem.ref
IL_0674: dup
IL_0675: ldc.i4.s 30
IL_0677: ldstr " | maxTimes="
IL_067c: stelem.ref
IL_067d: dup
IL_067e: ldc.i4.s 31
IL_0680: ldtoken TheForestOfLove.Interaction.InteractionTrigger
IL_0685: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_068a: ldloc.3
IL_068b: ldstr "maxTimesTriggerable"
IL_0690: call System.Object ForestProbe::ReadField(System.Type,System.Object,System.String)
IL_0695: dup
IL_0696: brtrue.s IL_069c
IL_0698: pop
IL_0699: ldnull
IL_069a: br.s IL_06a1
IL_069c: callvirt System.String System.Object::ToString()
IL_06a1: stelem.ref
IL_06a2: call System.String System.String::Concat(System.String[])
IL_06a7: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_06ac: nop
IL_06ad: ldloc.0
IL_06ae: ldc.i4.s 16
IL_06b0: newarr System.String
IL_06b5: dup
IL_06b6: ldc.i4.0
IL_06b7: ldstr "buckySettings | path="
IL_06bc: stelem.ref
IL_06bd: dup
IL_06be: ldc.i4.1
IL_06bf: ldloc.s V_6
IL_06c1: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_06c6: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_06cb: stelem.ref
IL_06cc: dup
IL_06cd: ldc.i4.2
IL_06ce: ldstr " | id="
IL_06d3: stelem.ref
IL_06d4: dup
IL_06d5: ldc.i4.3
IL_06d6: ldloc.s V_6
IL_06d8: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_06dd: stloc.s V_31
IL_06df: ldloca.s V_31
IL_06e1: call System.String System.Int32::ToString()
IL_06e6: stelem.ref
IL_06e7: dup
IL_06e8: ldc.i4.4
IL_06e9: ldstr " | type="
IL_06ee: stelem.ref
IL_06ef: dup
IL_06f0: ldc.i4.5
IL_06f1: ldloc.s V_6
IL_06f3: callvirt System.Type System.Object::GetType()
IL_06f8: callvirt System.String System.Type::get_FullName()
IL_06fd: stelem.ref
IL_06fe: dup
IL_06ff: ldc.i4.6
IL_0700: ldstr " | active="
IL_0705: stelem.ref
IL_0706: dup
IL_0707: ldc.i4.7
IL_0708: ldloc.s V_6
IL_070a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_070f: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0714: stloc.s V_30
IL_0716: ldloca.s V_30
IL_0718: call System.String System.Boolean::ToString()
IL_071d: stelem.ref
IL_071e: dup
IL_071f: ldc.i4.8
IL_0720: ldstr " | enabled="
IL_0725: stelem.ref
IL_0726: dup
IL_0727: ldc.i4.s 9
IL_0729: ldloc.s V_6
IL_072b: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0730: stloc.s V_30
IL_0732: ldloca.s V_30
IL_0734: call System.String System.Boolean::ToString()
IL_0739: stelem.ref
IL_073a: dup
IL_073b: ldc.i4.s 10
IL_073d: ldstr " | actor="
IL_0742: stelem.ref
IL_0743: dup
IL_0744: ldc.i4.s 11
IL_0746: ldloc.s V_6
IL_0748: callvirt System.String TheForestOfLove.DialogueSettings::get_ActorDbName()
IL_074d: stelem.ref
IL_074e: dup
IL_074f: ldc.i4.s 12
IL_0751: ldstr " | dialogue="
IL_0756: stelem.ref
IL_0757: dup
IL_0758: ldc.i4.s 13
IL_075a: ldloc.s V_6
IL_075c: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_0761: stelem.ref
IL_0762: dup
IL_0763: ldc.i4.s 14
IL_0765: ldstr " | arc="
IL_076a: stelem.ref
IL_076b: dup
IL_076c: ldc.i4.s 15
IL_076e: ldloc.s V_6
IL_0770: callvirt System.String TheForestOfLove.DialogueSettings::get_ArcDbName()
IL_0775: stelem.ref
IL_0776: call System.String System.String::Concat(System.String[])
IL_077b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0780: nop
IL_0781: ldc.i4.0
IL_0782: stloc.s V_13
IL_0784: nop
IL_0785: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.InteractionUi>()
IL_078a: stloc.s V_32
IL_078c: ldc.i4.0
IL_078d: stloc.s V_33
IL_078f: br.s IL_07d0
IL_0791: ldloc.s V_32
IL_0793: ldloc.s V_33
IL_0795: ldelem.ref
IL_0796: stloc.s V_34
IL_0798: ldloc.s V_34
IL_079a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_079f: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_07a4: stloc.s V_20
IL_07a6: ldloca.s V_20
IL_07a8: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_07ad: brfalse.s IL_07bd
IL_07af: ldloc.s V_34
IL_07b1: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_07b6: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_07bb: br.s IL_07be
IL_07bd: ldc.i4.0
IL_07be: stloc.s V_35
IL_07c0: ldloc.s V_35
IL_07c2: brfalse.s IL_07ca
IL_07c4: ldloc.s V_13
IL_07c6: ldc.i4.1
IL_07c7: add
IL_07c8: stloc.s V_13
IL_07ca: ldloc.s V_33
IL_07cc: ldc.i4.1
IL_07cd: add
IL_07ce: stloc.s V_33
IL_07d0: ldloc.s V_33
IL_07d2: ldloc.s V_32
IL_07d4: ldlen
IL_07d5: conv.i4
IL_07d6: blt.s IL_0791
IL_07d8: ldloc.s V_4
IL_07da: ldstr "onOptionSelected"
IL_07df: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_07e4: isinst System.Delegate
IL_07e9: stloc.s V_14
IL_07eb: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_07f0: stloc.s V_15
IL_07f2: ldloc.s V_14
IL_07f4: ldnull
IL_07f5: cgt.un
IL_07f7: stloc.s V_36
IL_07f9: ldloc.s V_36
IL_07fb: brfalse.s IL_0830
IL_07fd: nop
IL_07fe: ldloc.s V_14
IL_0800: callvirt System.Delegate[] System.Delegate::GetInvocationList()
IL_0805: stloc.s V_37
IL_0807: ldc.i4.0
IL_0808: stloc.s V_38
IL_080a: br.s IL_0828
IL_080c: ldloc.s V_37
IL_080e: ldloc.s V_38
IL_0810: ldelem.ref
IL_0811: stloc.s V_39
IL_0813: ldloc.s V_15
IL_0815: ldloc.s V_39
IL_0817: call System.String ForestProbe::BuckyCallback(System.Delegate)
IL_081c: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0821: nop
IL_0822: ldloc.s V_38
IL_0824: ldc.i4.1
IL_0825: add
IL_0826: stloc.s V_38
IL_0828: ldloc.s V_38
IL_082a: ldloc.s V_37
IL_082c: ldlen
IL_082d: conv.i4
IL_082e: blt.s IL_080c
IL_0830: ldloc.0
IL_0831: ldc.i4.s 22
IL_0833: newarr System.String
IL_0838: dup
IL_0839: ldc.i4.0
IL_083a: ldstr "buckyUi | path="
IL_083f: stelem.ref
IL_0840: dup
IL_0841: ldc.i4.1
IL_0842: ldloc.s V_4
IL_0844: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0849: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_084e: stelem.ref
IL_084f: dup
IL_0850: ldc.i4.2
IL_0851: ldstr " | id="
IL_0856: stelem.ref
IL_0857: dup
IL_0858: ldc.i4.3
IL_0859: ldloc.s V_4
IL_085b: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0860: stloc.s V_31
IL_0862: ldloca.s V_31
IL_0864: call System.String System.Int32::ToString()
IL_0869: stelem.ref
IL_086a: dup
IL_086b: ldc.i4.4
IL_086c: ldstr " | type="
IL_0871: stelem.ref
IL_0872: dup
IL_0873: ldc.i4.5
IL_0874: ldloc.s V_4
IL_0876: callvirt System.Type System.Object::GetType()
IL_087b: callvirt System.String System.Type::get_FullName()
IL_0880: stelem.ref
IL_0881: dup
IL_0882: ldc.i4.6
IL_0883: ldstr " | active="
IL_0888: stelem.ref
IL_0889: dup
IL_088a: ldc.i4.7
IL_088b: ldloc.s V_4
IL_088d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0892: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0897: stloc.s V_30
IL_0899: ldloca.s V_30
IL_089b: call System.String System.Boolean::ToString()
IL_08a0: stelem.ref
IL_08a1: dup
IL_08a2: ldc.i4.8
IL_08a3: ldstr " | enabled="
IL_08a8: stelem.ref
IL_08a9: dup
IL_08aa: ldc.i4.s 9
IL_08ac: ldloc.s V_4
IL_08ae: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_08b3: stloc.s V_30
IL_08b5: ldloca.s V_30
IL_08b7: call System.String System.Boolean::ToString()
IL_08bc: stelem.ref
IL_08bd: dup
IL_08be: ldc.i4.s 10
IL_08c0: ldstr " | activeCount="
IL_08c5: stelem.ref
IL_08c6: dup
IL_08c7: ldc.i4.s 11
IL_08c9: ldloca.s V_13
IL_08cb: call System.String System.Int32::ToString()
IL_08d0: stelem.ref
IL_08d1: dup
IL_08d2: ldc.i4.s 12
IL_08d4: ldstr " | visible="
IL_08d9: stelem.ref
IL_08da: dup
IL_08db: ldc.i4.s 13
IL_08dd: call System.Boolean TheForestOfLove.InteractionUi::get_visible()
IL_08e2: stloc.s V_30
IL_08e4: ldloca.s V_30
IL_08e6: call System.String System.Boolean::ToString()
IL_08eb: stelem.ref
IL_08ec: dup
IL_08ed: ldc.i4.s 14
IL_08ef: ldstr " | locked="
IL_08f4: stelem.ref
IL_08f5: dup
IL_08f6: ldc.i4.s 15
IL_08f8: ldloc.s V_4
IL_08fa: callvirt System.Boolean TheForestOfLove.InteractionUi::get_locked()
IL_08ff: stloc.s V_30
IL_0901: ldloca.s V_30
IL_0903: call System.String System.Boolean::ToString()
IL_0908: stelem.ref
IL_0909: dup
IL_090a: ldc.i4.s 16
IL_090c: ldstr " | selected="
IL_0911: stelem.ref
IL_0912: dup
IL_0913: ldc.i4.s 17
IL_0915: ldloc.s V_4
IL_0917: callvirt TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_091c: stloc.s V_31
IL_091e: ldloca.s V_31
IL_0920: call System.String System.Int32::ToString()
IL_0925: stelem.ref
IL_0926: dup
IL_0927: ldc.i4.s 18
IL_0929: ldstr " | available="
IL_092e: stelem.ref
IL_092f: dup
IL_0930: ldc.i4.s 19
IL_0932: ldloc.s V_4
IL_0934: ldstr "availableOptions"
IL_0939: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_093e: isinst System.Collections.IEnumerable
IL_0943: call System.String ForestProbe::ListValues(System.Collections.IEnumerable)
IL_0948: stelem.ref
IL_0949: dup
IL_094a: ldc.i4.s 20
IL_094c: ldstr " | callbacks="
IL_0951: stelem.ref
IL_0952: dup
IL_0953: ldc.i4.s 21
IL_0955: ldstr ","
IL_095a: ldloc.s V_15
IL_095c: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0961: call System.String System.String::Join(System.String,System.String[])
IL_0966: stelem.ref
IL_0967: call System.String System.String::Concat(System.String[])
IL_096c: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0971: nop
IL_0972: ldloc.0
IL_0973: ldc.i4.s 14
IL_0975: newarr System.String
IL_097a: dup
IL_097b: ldc.i4.0
IL_097c: ldstr "buckyBindings | actor="
IL_0981: stelem.ref
IL_0982: dup
IL_0983: ldc.i4.1
IL_0984: ldloc.2
IL_0985: ldstr "character"
IL_098a: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_098f: ldloc.1
IL_0990: ceq
IL_0992: stloc.s V_30
IL_0994: ldloca.s V_30
IL_0996: call System.String System.Boolean::ToString()
IL_099b: stelem.ref
IL_099c: dup
IL_099d: ldc.i4.2
IL_099e: ldstr " | listener="
IL_09a3: stelem.ref
IL_09a4: dup
IL_09a5: ldc.i4.3
IL_09a6: ldloc.3
IL_09a7: ldstr "collisionEventListener"
IL_09ac: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_09b1: ldloc.s V_5
IL_09b3: ceq
IL_09b5: stloc.s V_30
IL_09b7: ldloca.s V_30
IL_09b9: call System.String System.Boolean::ToString()
IL_09be: stelem.ref
IL_09bf: dup
IL_09c0: ldc.i4.4
IL_09c1: ldstr " | actorParent="
IL_09c6: stelem.ref
IL_09c7: dup
IL_09c8: ldc.i4.5
IL_09c9: ldloc.2
IL_09ca: callvirt !!0 UnityEngine.Component::GetComponentInParent<TheForestOfLove.Gameplay.SpawnableActor>()
IL_09cf: ldloc.1
IL_09d0: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_09d5: stloc.s V_30
IL_09d7: ldloca.s V_30
IL_09d9: call System.String System.Boolean::ToString()
IL_09de: stelem.ref
IL_09df: dup
IL_09e0: ldc.i4.6
IL_09e1: ldstr " | settingsObject="
IL_09e6: stelem.ref
IL_09e7: dup
IL_09e8: ldc.i4.7
IL_09e9: ldloc.s V_6
IL_09eb: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_09f0: ldloc.3
IL_09f1: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_09f6: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_09fb: stloc.s V_30
IL_09fd: ldloca.s V_30
IL_09ff: call System.String System.Boolean::ToString()
IL_0a04: stelem.ref
IL_0a05: dup
IL_0a06: ldc.i4.8
IL_0a07: ldstr " | controllerDescendant="
IL_0a0c: stelem.ref
IL_0a0d: dup
IL_0a0e: ldc.i4.s 9
IL_0a10: ldloc.2
IL_0a11: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0a16: ldloc.1
IL_0a17: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0a1c: callvirt System.Boolean UnityEngine.Transform::IsChildOf(UnityEngine.Transform)
IL_0a21: stloc.s V_30
IL_0a23: ldloca.s V_30
IL_0a25: call System.String System.Boolean::ToString()
IL_0a2a: stelem.ref
IL_0a2b: dup
IL_0a2c: ldc.i4.s 10
IL_0a2e: ldstr " | triggerDescendant="
IL_0a33: stelem.ref
IL_0a34: dup
IL_0a35: ldc.i4.s 11
IL_0a37: ldloc.3
IL_0a38: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0a3d: ldloc.1
IL_0a3e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0a43: callvirt System.Boolean UnityEngine.Transform::IsChildOf(UnityEngine.Transform)
IL_0a48: stloc.s V_30
IL_0a4a: ldloca.s V_30
IL_0a4c: call System.String System.Boolean::ToString()
IL_0a51: stelem.ref
IL_0a52: dup
IL_0a53: ldc.i4.s 12
IL_0a55: ldstr " | listenerDescendant="
IL_0a5a: stelem.ref
IL_0a5b: dup
IL_0a5c: ldc.i4.s 13
IL_0a5e: ldloc.s V_5
IL_0a60: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0a65: ldloc.1
IL_0a66: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0a6b: callvirt System.Boolean UnityEngine.Transform::IsChildOf(UnityEngine.Transform)
IL_0a70: stloc.s V_30
IL_0a72: ldloca.s V_30
IL_0a74: call System.String System.Boolean::ToString()
IL_0a79: stelem.ref
IL_0a7a: call System.String System.String::Concat(System.String[])
IL_0a7f: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0a84: nop
IL_0a85: ldloc.0
IL_0a86: ldc.i4.s 34
IL_0a88: newarr System.String
IL_0a8d: dup
IL_0a8e: ldc.i4.0
IL_0a8f: ldstr "buckyCollision | path="
IL_0a94: stelem.ref
IL_0a95: dup
IL_0a96: ldc.i4.1
IL_0a97: ldloc.s V_5
IL_0a99: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0a9e: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0aa3: stelem.ref
IL_0aa4: dup
IL_0aa5: ldc.i4.2
IL_0aa6: ldstr " | id="
IL_0aab: stelem.ref
IL_0aac: dup
IL_0aad: ldc.i4.3
IL_0aae: ldloc.s V_5
IL_0ab0: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0ab5: stloc.s V_31
IL_0ab7: ldloca.s V_31
IL_0ab9: call System.String System.Int32::ToString()
IL_0abe: stelem.ref
IL_0abf: dup
IL_0ac0: ldc.i4.4
IL_0ac1: ldstr " | type="
IL_0ac6: stelem.ref
IL_0ac7: dup
IL_0ac8: ldc.i4.5
IL_0ac9: ldloc.s V_5
IL_0acb: callvirt System.Type System.Object::GetType()
IL_0ad0: callvirt System.String System.Type::get_FullName()
IL_0ad5: stelem.ref
IL_0ad6: dup
IL_0ad7: ldc.i4.6
IL_0ad8: ldstr " | active="
IL_0add: stelem.ref
IL_0ade: dup
IL_0adf: ldc.i4.7
IL_0ae0: ldloc.s V_5
IL_0ae2: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0ae7: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0aec: stloc.s V_30
IL_0aee: ldloca.s V_30
IL_0af0: call System.String System.Boolean::ToString()
IL_0af5: stelem.ref
IL_0af6: dup
IL_0af7: ldc.i4.8
IL_0af8: ldstr " | enabled="
IL_0afd: stelem.ref
IL_0afe: dup
IL_0aff: ldc.i4.s 9
IL_0b01: ldloc.s V_5
IL_0b03: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0b08: stloc.s V_30
IL_0b0a: ldloca.s V_30
IL_0b0c: call System.String System.Boolean::ToString()
IL_0b11: stelem.ref
IL_0b12: dup
IL_0b13: ldc.i4.s 10
IL_0b15: ldstr " | collider="
IL_0b1a: stelem.ref
IL_0b1b: dup
IL_0b1c: ldc.i4.s 11
IL_0b1e: ldloc.s V_8
IL_0b20: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0b25: stloc.s V_31
IL_0b27: ldloca.s V_31
IL_0b29: call System.String System.Int32::ToString()
IL_0b2e: stelem.ref
IL_0b2f: dup
IL_0b30: ldc.i4.s 12
IL_0b32: ldstr " | colliderType="
IL_0b37: stelem.ref
IL_0b38: dup
IL_0b39: ldc.i4.s 13
IL_0b3b: ldloc.s V_8
IL_0b3d: callvirt System.Type System.Object::GetType()
IL_0b42: callvirt System.String System.Type::get_FullName()
IL_0b47: stelem.ref
IL_0b48: dup
IL_0b49: ldc.i4.s 14
IL_0b4b: ldstr " | colliderCount="
IL_0b50: stelem.ref
IL_0b51: dup
IL_0b52: ldc.i4.s 15
IL_0b54: ldloc.s V_5
IL_0b56: callvirt !!0[] UnityEngine.Component::GetComponents<UnityEngine.Collider2D>()
IL_0b5b: ldlen
IL_0b5c: conv.i4
IL_0b5d: stloc.s V_31
IL_0b5f: ldloca.s V_31
IL_0b61: call System.String System.Int32::ToString()
IL_0b66: stelem.ref
IL_0b67: dup
IL_0b68: ldc.i4.s 16
IL_0b6a: ldstr " | colliderEnabled="
IL_0b6f: stelem.ref
IL_0b70: dup
IL_0b71: ldc.i4.s 17
IL_0b73: ldloc.s V_8
IL_0b75: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0b7a: stloc.s V_30
IL_0b7c: ldloca.s V_30
IL_0b7e: call System.String System.Boolean::ToString()
IL_0b83: stelem.ref
IL_0b84: dup
IL_0b85: ldc.i4.s 18
IL_0b87: ldstr " | isTrigger="
IL_0b8c: stelem.ref
IL_0b8d: dup
IL_0b8e: ldc.i4.s 19
IL_0b90: ldloc.s V_8
IL_0b92: callvirt System.Boolean UnityEngine.Collider2D::get_isTrigger()
IL_0b97: stloc.s V_30
IL_0b99: ldloca.s V_30
IL_0b9b: call System.String System.Boolean::ToString()
IL_0ba0: stelem.ref
IL_0ba1: dup
IL_0ba2: ldc.i4.s 20
IL_0ba4: ldstr " | size="
IL_0ba9: stelem.ref
IL_0baa: dup
IL_0bab: ldc.i4.s 21
IL_0bad: ldloc.s V_8
IL_0baf: callvirt UnityEngine.Vector2 UnityEngine.CapsuleCollider2D::get_size()
IL_0bb4: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0bb9: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0bbe: stelem.ref
IL_0bbf: dup
IL_0bc0: ldc.i4.s 22
IL_0bc2: ldstr " | offset="
IL_0bc7: stelem.ref
IL_0bc8: dup
IL_0bc9: ldc.i4.s 23
IL_0bcb: ldloc.s V_8
IL_0bcd: callvirt UnityEngine.Vector2 UnityEngine.Collider2D::get_offset()
IL_0bd2: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0bd7: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0bdc: stelem.ref
IL_0bdd: dup
IL_0bde: ldc.i4.s 24
IL_0be0: ldstr " | scale="
IL_0be5: stelem.ref
IL_0be6: dup
IL_0be7: ldc.i4.s 25
IL_0be9: ldloc.s V_8
IL_0beb: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0bf0: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_lossyScale()
IL_0bf5: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0bfa: stelem.ref
IL_0bfb: dup
IL_0bfc: ldc.i4.s 26
IL_0bfe: ldstr " | boundsCenter="
IL_0c03: stelem.ref
IL_0c04: dup
IL_0c05: ldc.i4.s 27
IL_0c07: ldloc.s V_8
IL_0c09: callvirt UnityEngine.Bounds UnityEngine.Collider2D::get_bounds()
IL_0c0e: stloc.s V_40
IL_0c10: ldloca.s V_40
IL_0c12: call UnityEngine.Vector3 UnityEngine.Bounds::get_center()
IL_0c17: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0c1c: stelem.ref
IL_0c1d: dup
IL_0c1e: ldc.i4.s 28
IL_0c20: ldstr " | boundsSize="
IL_0c25: stelem.ref
IL_0c26: dup
IL_0c27: ldc.i4.s 29
IL_0c29: ldloc.s V_8
IL_0c2b: callvirt UnityEngine.Bounds UnityEngine.Collider2D::get_bounds()
IL_0c30: stloc.s V_40
IL_0c32: ldloca.s V_40
IL_0c34: call UnityEngine.Vector3 UnityEngine.Bounds::get_size()
IL_0c39: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0c3e: stelem.ref
IL_0c3f: dup
IL_0c40: ldc.i4.s 30
IL_0c42: ldstr " | rootTouch="
IL_0c47: stelem.ref
IL_0c48: dup
IL_0c49: ldc.i4.s 31
IL_0c4b: ldloc.s V_8
IL_0c4d: ldloc.s V_9
IL_0c4f: callvirt System.Boolean UnityEngine.Collider2D::IsTouching(UnityEngine.Collider2D)
IL_0c54: stloc.s V_30
IL_0c56: ldloca.s V_30
IL_0c58: call System.String System.Boolean::ToString()
IL_0c5d: stelem.ref
IL_0c5e: dup
IL_0c5f: ldc.i4.s 32
IL_0c61: ldstr " | ignoredPair="
IL_0c66: stelem.ref
IL_0c67: dup
IL_0c68: ldc.i4.s 33
IL_0c6a: ldloc.s V_8
IL_0c6c: ldloc.s V_9
IL_0c6e: call System.Boolean UnityEngine.Physics2D::GetIgnoreCollision(UnityEngine.Collider2D,UnityEngine.Collider2D)
IL_0c73: stloc.s V_30
IL_0c75: ldloca.s V_30
IL_0c77: call System.String System.Boolean::ToString()
IL_0c7c: stelem.ref
IL_0c7d: call System.String System.String::Concat(System.String[])
IL_0c82: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0c87: nop
IL_0c88: ldloc.0
IL_0c89: ldstr "buckyEnter | "
IL_0c8e: ldloc.s V_5
IL_0c90: ldfld TheForestOfLove.Collider2DEvent TheForestOfLove.CollisionEventListener::onTriggerEnter2D
IL_0c95: call System.String ForestProbe::BuckyRuntimeListeners(UnityEngine.Events.UnityEventBase)
IL_0c9a: call System.String System.String::Concat(System.String,System.String)
IL_0c9f: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0ca4: nop
IL_0ca5: ldloc.0
IL_0ca6: ldstr "buckyStay | "
IL_0cab: ldloc.s V_5
IL_0cad: ldfld TheForestOfLove.Collider2DEvent TheForestOfLove.CollisionEventListener::onTriggerStay2D
IL_0cb2: call System.String ForestProbe::BuckyRuntimeListeners(UnityEngine.Events.UnityEventBase)
IL_0cb7: call System.String System.String::Concat(System.String,System.String)
IL_0cbc: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0cc1: nop
IL_0cc2: ldloc.0
IL_0cc3: ldstr "buckyExit | "
IL_0cc8: ldloc.s V_5
IL_0cca: ldfld TheForestOfLove.Collider2DEvent TheForestOfLove.CollisionEventListener::onTriggerExit2D
IL_0ccf: call System.String ForestProbe::BuckyRuntimeListeners(UnityEngine.Events.UnityEventBase)
IL_0cd4: call System.String System.String::Concat(System.String,System.String)
IL_0cd9: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0cde: nop
IL_0cdf: ldloc.0
IL_0ce0: ldc.i4.s 30
IL_0ce2: newarr System.String
IL_0ce7: dup
IL_0ce8: ldc.i4.0
IL_0ce9: ldstr "buckyPlayer | path="
IL_0cee: stelem.ref
IL_0cef: dup
IL_0cf0: ldc.i4.1
IL_0cf1: ldloc.s V_7
IL_0cf3: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0cf8: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0cfd: stelem.ref
IL_0cfe: dup
IL_0cff: ldc.i4.2
IL_0d00: ldstr " | id="
IL_0d05: stelem.ref
IL_0d06: dup
IL_0d07: ldc.i4.3
IL_0d08: ldloc.s V_7
IL_0d0a: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0d0f: stloc.s V_31
IL_0d11: ldloca.s V_31
IL_0d13: call System.String System.Int32::ToString()
IL_0d18: stelem.ref
IL_0d19: dup
IL_0d1a: ldc.i4.4
IL_0d1b: ldstr " | type="
IL_0d20: stelem.ref
IL_0d21: dup
IL_0d22: ldc.i4.5
IL_0d23: ldloc.s V_7
IL_0d25: callvirt System.Type System.Object::GetType()
IL_0d2a: callvirt System.String System.Type::get_FullName()
IL_0d2f: stelem.ref
IL_0d30: dup
IL_0d31: ldc.i4.6
IL_0d32: ldstr " | active="
IL_0d37: stelem.ref
IL_0d38: dup
IL_0d39: ldc.i4.7
IL_0d3a: ldloc.s V_7
IL_0d3c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0d41: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0d46: stloc.s V_30
IL_0d48: ldloca.s V_30
IL_0d4a: call System.String System.Boolean::ToString()
IL_0d4f: stelem.ref
IL_0d50: dup
IL_0d51: ldc.i4.8
IL_0d52: ldstr " | enabled="
IL_0d57: stelem.ref
IL_0d58: dup
IL_0d59: ldc.i4.s 9
IL_0d5b: ldloc.s V_7
IL_0d5d: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0d62: stloc.s V_30
IL_0d64: ldloca.s V_30
IL_0d66: call System.String System.Boolean::ToString()
IL_0d6b: stelem.ref
IL_0d6c: dup
IL_0d6d: ldc.i4.s 10
IL_0d6f: ldstr " | canInteract="
IL_0d74: stelem.ref
IL_0d75: dup
IL_0d76: ldc.i4.s 11
IL_0d78: ldloc.s V_7
IL_0d7a: callvirt System.Boolean TheForestOfLove.Player::get_canInteract()
IL_0d7f: stloc.s V_30
IL_0d81: ldloca.s V_30
IL_0d83: call System.String System.Boolean::ToString()
IL_0d88: stelem.ref
IL_0d89: dup
IL_0d8a: ldc.i4.s 12
IL_0d8c: ldstr " | body="
IL_0d91: stelem.ref
IL_0d92: dup
IL_0d93: ldc.i4.s 13
IL_0d95: ldloc.s V_10
IL_0d97: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0d9c: stloc.s V_31
IL_0d9e: ldloca.s V_31
IL_0da0: call System.String System.Int32::ToString()
IL_0da5: stelem.ref
IL_0da6: dup
IL_0da7: ldc.i4.s 14
IL_0da9: ldstr " | bodyType="
IL_0dae: stelem.ref
IL_0daf: dup
IL_0db0: ldc.i4.s 15
IL_0db2: ldloc.s V_10
IL_0db4: callvirt UnityEngine.RigidbodyType2D UnityEngine.Rigidbody2D::get_bodyType()
IL_0db9: stloc.s V_41
IL_0dbb: ldloca.s V_41
IL_0dbd: constrained. UnityEngine.RigidbodyType2D
IL_0dc3: callvirt System.String System.Object::ToString()
IL_0dc8: stelem.ref
IL_0dc9: dup
IL_0dca: ldc.i4.s 16
IL_0dcc: ldstr " | bodySimulated="
IL_0dd1: stelem.ref
IL_0dd2: dup
IL_0dd3: ldc.i4.s 17
IL_0dd5: ldloc.s V_10
IL_0dd7: callvirt System.Boolean UnityEngine.Rigidbody2D::get_simulated()
IL_0ddc: stloc.s V_30
IL_0dde: ldloca.s V_30
IL_0de0: call System.String System.Boolean::ToString()
IL_0de5: stelem.ref
IL_0de6: dup
IL_0de7: ldc.i4.s 18
IL_0de9: ldstr " | rootCollider="
IL_0dee: stelem.ref
IL_0def: dup
IL_0df0: ldc.i4.s 19
IL_0df2: ldloc.s V_9
IL_0df4: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0df9: stloc.s V_31
IL_0dfb: ldloca.s V_31
IL_0dfd: call System.String System.Int32::ToString()
IL_0e02: stelem.ref
IL_0e03: dup
IL_0e04: ldc.i4.s 20
IL_0e06: ldstr " | rootColliderEnabled="
IL_0e0b: stelem.ref
IL_0e0c: dup
IL_0e0d: ldc.i4.s 21
IL_0e0f: ldloc.s V_9
IL_0e11: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0e16: stloc.s V_30
IL_0e18: ldloca.s V_30
IL_0e1a: call System.String System.Boolean::ToString()
IL_0e1f: stelem.ref
IL_0e20: dup
IL_0e21: ldc.i4.s 22
IL_0e23: ldstr " | rootIsTrigger="
IL_0e28: stelem.ref
IL_0e29: dup
IL_0e2a: ldc.i4.s 23
IL_0e2c: ldloc.s V_9
IL_0e2e: callvirt System.Boolean UnityEngine.Collider2D::get_isTrigger()
IL_0e33: stloc.s V_30
IL_0e35: ldloca.s V_30
IL_0e37: call System.String System.Boolean::ToString()
IL_0e3c: stelem.ref
IL_0e3d: dup
IL_0e3e: ldc.i4.s 24
IL_0e40: ldstr " | rootTag="
IL_0e45: stelem.ref
IL_0e46: dup
IL_0e47: ldc.i4.s 25
IL_0e49: ldloc.s V_9
IL_0e4b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0e50: callvirt System.String UnityEngine.GameObject::get_tag()
IL_0e55: stelem.ref
IL_0e56: dup
IL_0e57: ldc.i4.s 26
IL_0e59: ldstr " | position="
IL_0e5e: stelem.ref
IL_0e5f: dup
IL_0e60: ldc.i4.s 27
IL_0e62: ldloc.s V_7
IL_0e64: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0e69: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0e6e: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0e73: stelem.ref
IL_0e74: dup
IL_0e75: ldc.i4.s 28
IL_0e77: ldstr " | velocity="
IL_0e7c: stelem.ref
IL_0e7d: dup
IL_0e7e: ldc.i4.s 29
IL_0e80: ldloc.s V_10
IL_0e82: callvirt UnityEngine.Vector2 UnityEngine.Rigidbody2D::get_velocity()
IL_0e87: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0e8c: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0e91: stelem.ref
IL_0e92: call System.String System.String::Concat(System.String[])
IL_0e97: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0e9c: nop
IL_0e9d: ldloc.0
IL_0e9e: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0ea3: stloc.s V_42
IL_0ea5: br.s IL_0ea7
IL_0ea7: ldloc.s V_42
IL_0ea9: ret
