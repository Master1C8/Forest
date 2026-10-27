TYPE PixelCrushers.DialogueSystem.DialogueSystemSceneEvents
METHOD PixelCrushers.DialogueSystem.DialogueSystemSceneEvents PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::get_sceneInstance() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld PixelCrushers.DialogueSystem.DialogueSystemSceneEvents PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::m_sceneInstance
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_0017
IL_000d: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.DialogueSystem.DialogueSystemSceneEvents>()
IL_0012: stsfld PixelCrushers.DialogueSystem.DialogueSystemSceneEvents PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::m_sceneInstance
IL_0017: ldsfld PixelCrushers.DialogueSystem.DialogueSystemSceneEvents PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::m_sceneInstance
IL_001c: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::set_sceneInstance(PixelCrushers.DialogueSystem.DialogueSystemSceneEvents) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: stsfld PixelCrushers.DialogueSystem.DialogueSystemSceneEvents PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::m_sceneInstance
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::InitStaticVariables() | attributes=Private, Static, HideBySig | impl=IL
ATTRIBUTE UnityEngine.RuntimeInitializeOnLoadMethodAttribute
IL_0000: ldnull
IL_0001: stsfld PixelCrushers.DialogueSystem.DialogueSystemSceneEvents PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::m_sceneInstance
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: stsfld PixelCrushers.DialogueSystem.DialogueSystemSceneEvents PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::m_sceneInstance
IL_0006: ret
METHOD PixelCrushers.DialogueSystem.DialogueEntrySceneEvent PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::GetDialogueEntrySceneEvent(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.DialogueSystemSceneEvents/<>c__DisplayClass9_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld System.String PixelCrushers.DialogueSystem.DialogueSystemSceneEvents/<>c__DisplayClass9_0::guid
IL_000d: call PixelCrushers.DialogueSystem.DialogueSystemSceneEvents PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::get_sceneInstance()
IL_0012: ldnull
IL_0013: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0018: brfalse.s IL_001c
IL_001a: ldnull
IL_001b: ret
IL_001c: call PixelCrushers.DialogueSystem.DialogueSystemSceneEvents PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::get_sceneInstance()
IL_0021: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntrySceneEvent> PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::dialogueEntrySceneEvents
IL_0026: ldloc.0
IL_0027: ldftn System.Boolean PixelCrushers.DialogueSystem.DialogueSystemSceneEvents/<>c__DisplayClass9_0::<GetDialogueEntrySceneEvent>b__0(PixelCrushers.DialogueSystem.DialogueEntrySceneEvent)
IL_002d: newobj System.Void System.Predicate`1<PixelCrushers.DialogueSystem.DialogueEntrySceneEvent>::.ctor(System.Object,System.IntPtr)
IL_0032: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntrySceneEvent>::Find(System.Predicate`1<!0>)
IL_0037: ret
METHOD System.Int32 PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::GetDialogueEntrySceneEventIndex(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.DialogueSystemSceneEvents/<>c__DisplayClass10_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld System.String PixelCrushers.DialogueSystem.DialogueSystemSceneEvents/<>c__DisplayClass10_0::guid
IL_000d: call PixelCrushers.DialogueSystem.DialogueSystemSceneEvents PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::get_sceneInstance()
IL_0012: ldnull
IL_0013: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0018: brfalse.s IL_001c
IL_001a: ldc.i4.m1
IL_001b: ret
IL_001c: call PixelCrushers.DialogueSystem.DialogueSystemSceneEvents PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::get_sceneInstance()
IL_0021: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntrySceneEvent> PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::dialogueEntrySceneEvents
IL_0026: ldloc.0
IL_0027: ldftn System.Boolean PixelCrushers.DialogueSystem.DialogueSystemSceneEvents/<>c__DisplayClass10_0::<GetDialogueEntrySceneEventIndex>b__0(PixelCrushers.DialogueSystem.DialogueEntrySceneEvent)
IL_002d: newobj System.Void System.Predicate`1<PixelCrushers.DialogueSystem.DialogueEntrySceneEvent>::.ctor(System.Object,System.IntPtr)
IL_0032: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntrySceneEvent>::FindIndex(System.Predicate`1<!0>)
IL_0037: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntrySceneEvent>::.ctor()
IL_0006: stfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntrySceneEvent> PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::dialogueEntrySceneEvents
IL_000b: ldarg.0
IL_000c: call System.Void UnityEngine.MonoBehaviour::.ctor()
IL_0011: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemSceneEvents::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ret
