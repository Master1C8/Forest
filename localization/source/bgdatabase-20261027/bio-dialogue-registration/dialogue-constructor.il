TYPE TheForestOfLove.Narrative.Dialogue
METHOD System.Void TheForestOfLove.Narrative.Dialogue::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor>::.ctor()
IL_0006: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.Dialogue::dateActors
IL_000b: ldarg.0
IL_000c: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::.ctor()
IL_0011: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Dialogue::relatedTags
IL_0016: ldarg.0
IL_0017: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::.ctor()
IL_001c: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Dialogue::tagsAnyInformationalOnly
IL_0021: ldarg.0
IL_0022: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::.ctor()
IL_0027: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Dialogue::tagsAllInformationalOnly
IL_002c: ldarg.0
IL_002d: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::.ctor()
IL_0032: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0037: ldarg.0
IL_0038: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Arc>::.ctor()
IL_003d: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcsByDbArcSuffix
IL_0042: ldarg.0
IL_0043: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Arc>::.ctor()
IL_0048: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcsBySavekey
IL_004d: ldarg.0
IL_004e: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor()
IL_0053: stfld System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Narrative.Dialogue::arcSuffixesDisallowSkip
IL_0058: ldarg.0
IL_0059: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::.ctor()
IL_005e: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_0063: ldarg.0
IL_0064: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::.ctor()
IL_0069: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::secondaryArcs
IL_006e: ldarg.0
IL_006f: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::.ctor()
IL_0074: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::idleArcs
IL_0079: ldarg.0
IL_007a: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::.ctor()
IL_007f: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::namedArcs
IL_0084: ldarg.0
IL_0085: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::.ctor()
IL_008a: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition> TheForestOfLove.Narrative.Dialogue::preconditions
IL_008f: ldarg.0
IL_0090: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::.ctor()
IL_0095: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger> TheForestOfLove.Narrative.Dialogue::dialogueTriggers
IL_009a: ldarg.0
IL_009b: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::.ctor()
IL_00a0: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_00a5: ldarg.0
IL_00a6: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::.ctor()
IL_00ab: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.Dialogue::triggersSkipDuringDialogueSkip
IL_00b0: ldarg.0
IL_00b1: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::.ctor()
IL_00b6: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.Dialogue::triggersSkipDuringChapterSelect
IL_00bb: ldarg.0
IL_00bc: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::.ctor()
IL_00c1: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.Dialogue::triggersSkipDuringCheatCode
IL_00c6: ldarg.0
IL_00c7: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00cc: stfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.Dialogue::triggersRequireAny_bugfix
IL_00d1: ldarg.0
IL_00d2: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00d7: stfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.Dialogue::triggersRequireAll_bugfix
IL_00dc: ldarg.0
IL_00dd: call System.Void System.Object::.ctor()
IL_00e2: ret
