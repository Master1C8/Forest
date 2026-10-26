TYPE TheForestOfLove.Interaction.InteractionTrigger
METHOD System.String TheForestOfLove.Interaction.InteractionTrigger::get_TriggerDbName() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld BOC.BTagged.Tag TheForestOfLove.Interaction.InteractionTrigger::trigger
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_0025
IL_000e: ldarg.0
IL_000f: ldfld BOC.BTagged.Tag TheForestOfLove.Interaction.InteractionTrigger::trigger
IL_0014: callvirt System.String BOC.BTagged.BTaggedSO::get_ShortName()
IL_0019: ldstr "- Untagged -"
IL_001e: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0023: brtrue.s IL_002c
IL_0025: ldarg.0
IL_0026: ldfld System.String TheForestOfLove.Interaction.InteractionTrigger::triggerDbName
IL_002b: ret
IL_002c: ldarg.0
IL_002d: ldfld BOC.BTagged.Tag TheForestOfLove.Interaction.InteractionTrigger::trigger
IL_0032: callvirt System.String BOC.BTagged.BTaggedSO::get_ShortName()
IL_0037: ret
