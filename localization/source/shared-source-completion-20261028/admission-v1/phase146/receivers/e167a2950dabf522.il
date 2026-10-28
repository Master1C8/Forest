TYPE TheForestOfLove.MabelSoloStory
METHOD System.Void TheForestOfLove.MabelSoloStory::OnShowPanel2() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Animator TheForestOfLove.MabelSoloStory::panelAnimator
IL_0006: ldsfld System.String TheForestOfLove.MabelSoloStory::ANIMATOR_TRIGGER_IDLE2
IL_000b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0010: ret
METHOD System.Void TheForestOfLove.MabelSoloStory::OnShowPanel3() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Animator TheForestOfLove.MabelSoloStory::panelAnimator
IL_0006: ldsfld System.String TheForestOfLove.MabelSoloStory::ANIMATOR_TRIGGER_IDLE3
IL_000b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0010: ret
