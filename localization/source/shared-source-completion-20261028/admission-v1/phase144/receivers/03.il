TYPE TheForestOfLove.Utility.ContentManagementExtensions
METHOD System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(AreaContent,System.String,System.String,System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.ExtensionAttribute
IL_0000: ldarg.0
IL_0001: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0006: ldarg.1
IL_0007: ldarg.2
IL_0008: ldarg.3
IL_0009: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(UnityEngine.GameObject,System.String,System.String,System.String)
IL_000e: ret
METHOD System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(AreaContentSet,System.String,System.String,System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.ExtensionAttribute
IL_0000: ldarg.0
IL_0001: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0006: ldarg.1
IL_0007: ldarg.2
IL_0008: ldarg.3
IL_0009: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(UnityEngine.GameObject,System.String,System.String,System.String)
IL_000e: ret
METHOD System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(UnityEngine.GameObject,System.String,System.String,System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<TheForestOfLove.Gameplay.ObjectActor>()
IL_0006: stloc.0
IL_0007: ldc.i4.0
IL_0008: stloc.1
IL_0009: br.s IL_001a
IL_000b: ldloc.0
IL_000c: ldloc.1
IL_000d: ldelem.ref
IL_000e: ldarg.1
IL_000f: ldarg.2
IL_0010: ldarg.3
IL_0011: callvirt System.Void TheForestOfLove.Gameplay.ObjectActor::SetTargetDialogue(System.String,System.String,System.String)
IL_0016: ldloc.1
IL_0017: ldc.i4.1
IL_0018: add
IL_0019: stloc.1
IL_001a: ldloc.1
IL_001b: ldloc.0
IL_001c: ldlen
IL_001d: conv.i4
IL_001e: blt.s IL_000b
IL_0020: ldarg.0
IL_0021: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<TheForestOfLove.Gameplay.CritterActor>()
IL_0026: stloc.2
IL_0027: ldc.i4.0
IL_0028: stloc.1
IL_0029: br.s IL_003a
IL_002b: ldloc.2
IL_002c: ldloc.1
IL_002d: ldelem.ref
IL_002e: ldarg.1
IL_002f: ldarg.2
IL_0030: ldarg.3
IL_0031: callvirt System.Void TheForestOfLove.Gameplay.CritterActor::SetTargetDialogue(System.String,System.String,System.String)
IL_0036: ldloc.1
IL_0037: ldc.i4.1
IL_0038: add
IL_0039: stloc.1
IL_003a: ldloc.1
IL_003b: ldloc.2
IL_003c: ldlen
IL_003d: conv.i4
IL_003e: blt.s IL_002b
IL_0040: ret
