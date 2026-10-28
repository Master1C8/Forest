TYPE TheForestOfLove.FinleyAct3IntroCutscene
METHOD System.Void TheForestOfLove.FinleyAct3IntroCutscene::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldstr "FinleyQuest_IntroFromFinley"
IL_000b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0010: brtrue IL_00f8
IL_0015: ldsfld TheForestOfLove.Content.MountainsSpawner TheForestOfLove.Content.MountainsSpawner::instance
IL_001a: callvirt AreaContent TheForestOfLove.Content.MountainsSpawner::get_Finley()
IL_001f: ldc.i4.2
IL_0020: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::AddDisallowedInteractionOptionInChildren(AreaContent,TheForestOfLove.InteractionUiOption)
IL_0025: ldsfld TheForestOfLove.Content.MountainsSpawner TheForestOfLove.Content.MountainsSpawner::instance
IL_002a: callvirt AreaContent TheForestOfLove.Content.MountainsSpawner::get_Finley()
IL_002f: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.Gameplay.SwapCameraSettingsDuringDialogue>()
IL_0034: ldarg.0
IL_0035: ldfld TheForestOfLove.Cameras.CameraSettings TheForestOfLove.FinleyAct3IntroCutscene::cutsceneCameraSettings
IL_003a: callvirt System.Void TheForestOfLove.Gameplay.SwapCameraSettingsDuringDialogue::set_targetCameraSettings(TheForestOfLove.Cameras.CameraSettings)
IL_003f: ldarg.0
IL_0040: ldfld TheForestOfLove.CollisionEventListener TheForestOfLove.FinleyAct3IntroCutscene::collisionTrigger
IL_0045: ldfld TheForestOfLove.Collider2DEvent TheForestOfLove.CollisionEventListener::onTriggerEnter2D
IL_004a: ldarg.0
IL_004b: ldftn System.Void TheForestOfLove.FinleyAct3IntroCutscene::CollisionTrigger_OnTriggerEnter2d(UnityEngine.Collider2D)
IL_0051: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Collider2D>::.ctor(System.Object,System.IntPtr)
IL_0056: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Collider2D>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_005b: ldstr "Finley"
IL_0060: call TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Gameplay.SpawnableActor::FindActorByName(System.String)
IL_0065: stloc.0
IL_0066: ldsfld TheForestOfLove.Content.MountainsSpawner TheForestOfLove.Content.MountainsSpawner::instance
IL_006b: callvirt AreaContent TheForestOfLove.Content.MountainsSpawner::get_GlyphStones()
IL_0070: callvirt UnityEngine.Transform AreaContent::get_Content()
IL_0075: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<TheForestOfLove.Interaction.DialogueInteractionTrigger>()
IL_007a: stloc.1
IL_007b: ldc.i4.0
IL_007c: stloc.2
IL_007d: br.s IL_00f1
IL_007f: ldloc.1
IL_0080: ldloc.2
IL_0081: ldelem.ref
IL_0082: stloc.3
IL_0083: ldloc.3
IL_0084: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0089: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_008e: ldloc.0
IL_008f: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0094: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0099: call UnityEngine.Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)
IL_009e: stloc.s V_4
IL_00a0: ldloca.s V_4
IL_00a2: call System.Single UnityEngine.Vector3::get_magnitude()
IL_00a7: ldc.r4 1
IL_00ac: bge.un.s IL_00ed
IL_00ae: ldloc.3
IL_00af: callvirt System.Void TheForestOfLove.Interaction.InteractionTrigger::DisableTriggerActivation()
IL_00b4: ldloc.3
IL_00b5: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.InteractionUiController>()
IL_00ba: stloc.s V_5
IL_00bc: ldloc.s V_5
IL_00be: ldnull
IL_00bf: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00c4: brfalse.s IL_00d3
IL_00c6: ldloc.s V_5
IL_00c8: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::disallowedOptions
IL_00cd: ldc.i4.3
IL_00ce: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_00d3: ldloc.3
IL_00d4: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.InteractionIcon>()
IL_00d9: stloc.s V_6
IL_00db: ldloc.s V_6
IL_00dd: ldnull
IL_00de: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00e3: brfalse.s IL_00ed
IL_00e5: ldloc.s V_6
IL_00e7: ldc.i4.1
IL_00e8: callvirt System.Void TheForestOfLove.InteractionIcon::set_disableIconVisibility(System.Boolean)
IL_00ed: ldloc.2
IL_00ee: ldc.i4.1
IL_00ef: add
IL_00f0: stloc.2
IL_00f1: ldloc.2
IL_00f2: ldloc.1
IL_00f3: ldlen
IL_00f4: conv.i4
IL_00f5: blt.s IL_007f
IL_00f7: ret
IL_00f8: ldarg.0
IL_00f9: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00fe: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0103: ret
