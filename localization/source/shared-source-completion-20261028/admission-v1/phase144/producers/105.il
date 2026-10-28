TYPE TheForestOfLove.KoreographerEventHandler
METHOD System.Void TheForestOfLove.KoreographerEventHandler::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: call SonicBloom.Koreo.Koreographer SonicBloom.Koreo.Koreographer::get_Instance()
IL_0005: ldstr "Beat"
IL_000a: ldarg.0
IL_000b: ldftn System.Void TheForestOfLove.KoreographerEventHandler::OnKoreographerEvent(SonicBloom.Koreo.KoreographyEvent)
IL_0011: newobj System.Void SonicBloom.Koreo.KoreographyEventCallback::.ctor(System.Object,System.IntPtr)
IL_0016: callvirt System.Void SonicBloom.Koreo.Koreographer::RegisterForEvents(System.String,SonicBloom.Koreo.KoreographyEventCallback)
IL_001b: ret
