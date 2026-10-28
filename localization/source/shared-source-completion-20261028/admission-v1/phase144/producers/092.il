TYPE TheForestOfLove.Gator
METHOD System.Void TheForestOfLove.Gator::OnFlip() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_000f
IL_000e: ret
IL_000f: ldarg.0
IL_0010: call System.Void TheForestOfLove.Gator::ClearTriggers()
IL_0015: ldarg.0
IL_0016: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_001b: ldarg.0
IL_001c: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0021: callvirt System.Boolean TheForestOfLove.Gameplay.DirectionController::get_flipped()
IL_0026: brtrue.s IL_002f
IL_0028: ldstr "flip_right"
IL_002d: br.s IL_0034
IL_002f: ldstr "flip_left"
IL_0034: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0039: ldarg.0
IL_003a: ldfld UnityEngine.Animator TheForestOfLove.Gator::shadowAnimatorX
IL_003f: call System.Boolean UnityEngine.Object::op_Implicit(UnityEngine.Object)
IL_0044: brfalse.s IL_006a
IL_0046: ldarg.0
IL_0047: ldfld UnityEngine.Animator TheForestOfLove.Gator::shadowAnimatorX
IL_004c: ldarg.0
IL_004d: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0052: callvirt System.Boolean TheForestOfLove.Gameplay.DirectionController::get_flipped()
IL_0057: brtrue.s IL_0060
IL_0059: ldstr "flip_right"
IL_005e: br.s IL_0065
IL_0060: ldstr "flip_left"
IL_0065: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006a: ret
METHOD System.Void TheForestOfLove.Gator::OnConversationStarted_Handler(TheForestOfLove.Narrative.Dialogue) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_000f
IL_000e: ret
IL_000f: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentActorDbName()
IL_0014: ldarg.0
IL_0015: call System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_001a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_001f: brfalse.s IL_007c
IL_0021: ldarg.0
IL_0022: call System.Void TheForestOfLove.Gator::ClearTriggers()
IL_0027: ldarg.0
IL_0028: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_002d: ldarg.0
IL_002e: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0033: callvirt System.Boolean TheForestOfLove.Gameplay.DirectionController::get_flipped()
IL_0038: brtrue.s IL_0041
IL_003a: ldstr "flip_right"
IL_003f: br.s IL_0046
IL_0041: ldstr "flip_left"
IL_0046: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.Animator TheForestOfLove.Gator::shadowAnimatorX
IL_0051: call System.Boolean UnityEngine.Object::op_Implicit(UnityEngine.Object)
IL_0056: brfalse.s IL_007c
IL_0058: ldarg.0
IL_0059: ldfld UnityEngine.Animator TheForestOfLove.Gator::shadowAnimatorX
IL_005e: ldarg.0
IL_005f: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0064: callvirt System.Boolean TheForestOfLove.Gameplay.DirectionController::get_flipped()
IL_0069: brtrue.s IL_0072
IL_006b: ldstr "flip_right"
IL_0070: br.s IL_0077
IL_0072: ldstr "flip_left"
IL_0077: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_007c: ret
