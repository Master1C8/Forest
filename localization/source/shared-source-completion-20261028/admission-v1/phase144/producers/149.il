TYPE TheForestOfLove.SmashableCrystalTest
METHOD System.Void TheForestOfLove.SmashableCrystalTest::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "reset"
IL_0006: stfld System.String TheForestOfLove.SmashableCrystalTest::ANIMATOR_TRIGGER_RESET
IL_000b: ldarg.0
IL_000c: ldstr "smash"
IL_0011: stfld System.String TheForestOfLove.SmashableCrystalTest::ANIMATOR_TRIGGER_SMASH
IL_0016: ldarg.0
IL_0017: call System.Void TheForestOfLove.Core.BaseBehavior::.ctor()
IL_001c: ret
