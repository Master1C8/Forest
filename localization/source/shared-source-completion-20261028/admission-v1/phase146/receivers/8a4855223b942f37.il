TYPE TheForestOfLove.Gameplay.ObjectActor
METHOD System.Void TheForestOfLove.Gameplay.ObjectActor::SetTargetDialogue(System.String,System.String,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.Gameplay.ObjectActor::interactionObjects
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_0042
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.GameObject TheForestOfLove.Gameplay.ObjectActor::interactionObjects
IL_0014: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren<TheForestOfLove.DialogueSettings>()
IL_0019: stloc.0
IL_001a: ldloc.0
IL_001b: ldnull
IL_001c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0021: brfalse.s IL_0042
IL_0023: ldloc.0
IL_0024: ldarg.1
IL_0025: callvirt System.Void TheForestOfLove.DialogueSettings::SetDialogueDbName(System.String)
IL_002a: ldloc.0
IL_002b: ldarg.2
IL_002c: callvirt System.Void TheForestOfLove.DialogueSettings::SetArcDbName(System.String)
IL_0031: ldloc.0
IL_0032: ldarg.3
IL_0033: dup
IL_0034: brtrue.s IL_003d
IL_0036: pop
IL_0037: ldloc.0
IL_0038: callvirt System.String TheForestOfLove.DialogueSettings::get_InitialConversantActorDbName()
IL_003d: callvirt System.Void TheForestOfLove.DialogueSettings::SetInitialConversant(System.String)
IL_0042: ret
