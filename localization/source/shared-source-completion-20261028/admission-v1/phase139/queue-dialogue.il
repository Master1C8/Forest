TYPE TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode
METHOD System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode::.ctor(System.Int32,System.String) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.DataStructures.FastPriorityQueueNode::.ctor()
IL_0006: ldarg.0
IL_0007: ldarg.1
IL_0008: stfld System.Int32 TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode::conversationId
IL_000d: ldarg.0
IL_000e: ldarg.2
IL_000f: stfld System.String TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode::conversationTitle
IL_0014: ret
