TYPE ForestProbe/<>c
METHOD System.Void ForestProbe/<>c::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: newobj System.Void ForestProbe/<>c::.ctor()
IL_0005: stsfld ForestProbe/<>c ForestProbe/<>c::<>9
IL_000a: ret
METHOD System.Void ForestProbe/<>c::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: nop
IL_0007: ret
METHOD System.String ForestProbe/<>c::<DumpIntro>b__60_0(ForestProbe/ResponseRow) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_0006: ret
METHOD System.String ForestProbe/<>c::<Dump>b__61_0(ForestProbe/ResponseRow) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_0006: ret
TYPE ForestProbe/<>c BASE System.Object
FIELD ForestProbe/<>c ForestProbe/<>c::<>9
FIELD System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__60_0
FIELD System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__61_0
