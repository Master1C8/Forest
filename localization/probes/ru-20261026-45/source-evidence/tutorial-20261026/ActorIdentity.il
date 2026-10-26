TYPE TheForestOfLove.Gameplay.SpawnableActor
METHOD System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_0000: ldarg.0
IL_0001: ldfld BOC.BTagged.Tag TheForestOfLove.Gameplay.SpawnableActor::actorName
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_0015
IL_000e: ldarg.0
IL_000f: ldfld System.String TheForestOfLove.Gameplay.SpawnableActor::actorDbName
IL_0014: ret
IL_0015: ldarg.0
IL_0016: ldfld BOC.BTagged.Tag TheForestOfLove.Gameplay.SpawnableActor::actorName
IL_001b: callvirt System.String BOC.BTagged.BTaggedSO::get_ShortName()
IL_0020: ret
