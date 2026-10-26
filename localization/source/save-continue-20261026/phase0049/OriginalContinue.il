TYPE TheForestOfLove.CustomTypewriterEffectTextMeshPro
METHOD System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.CustomTypewriterEffectTextMeshPro>()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldnull
IL_0008: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000d: brfalse.s IL_0015
IL_000f: ldloc.0
IL_0010: callvirt System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue_Internal()
IL_0015: ret
