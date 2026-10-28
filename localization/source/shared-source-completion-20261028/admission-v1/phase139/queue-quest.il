TYPE TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1
METHOD System.Void TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1::.ctor(T,System.Int32,System.String) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.DataStructures.FastPriorityQueueNode::.ctor()
IL_0006: ldarg.0
IL_0007: ldarg.1
IL_0008: stfld T TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<T>::item
IL_000d: ldarg.0
IL_000e: ldarg.2
IL_000f: stfld System.Int32 TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<T>::id
IL_0014: ldarg.0
IL_0015: ldarg.3
IL_0016: stfld System.String TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<T>::title
IL_001b: ret
