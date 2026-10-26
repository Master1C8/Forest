TYPE TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger
METHOD System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger::Execute() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger::get_isExecuted()
IL_0006: brtrue.s IL_0015
IL_0008: ldarg.0
IL_0009: ldc.i4.1
IL_000a: call System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger::set_isExecuted(System.Boolean)
IL_000f: ldarg.0
IL_0010: callvirt System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger::OnExecute()
IL_0015: ret
