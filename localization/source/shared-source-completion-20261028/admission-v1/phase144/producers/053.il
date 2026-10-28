TYPE TheForestOfLove.CritterLog
METHOD System.Void TheForestOfLove.CritterLog::UpdateResidentLabelState(TheForestOfLove.CritterLog/NamedResident) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: callvirt TheForestOfLove.Narrative.Actor TheForestOfLove.CritterLog/NamedResident::get_actor()
IL_0007: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_000c: brtrue.s IL_0015
IL_000e: ldstr "???"
IL_0013: br.s IL_0020
IL_0015: ldarg.0
IL_0016: callvirt TheForestOfLove.Narrative.Actor TheForestOfLove.CritterLog/NamedResident::get_actor()
IL_001b: callvirt System.String TheForestOfLove.Narrative.Actor::get_NameplateName()
IL_0020: callvirt System.Void TheForestOfLove.CritterLog/NamedResident::SetText(System.String)
IL_0025: ldarg.0
IL_0026: callvirt TheForestOfLove.Narrative.Actor TheForestOfLove.CritterLog/NamedResident::get_actor()
IL_002b: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_0030: brtrue.s IL_0047
IL_0032: ldarg.0
IL_0033: callvirt TheForestOfLove.Narrative.Actor TheForestOfLove.CritterLog/NamedResident::get_actor()
IL_0038: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsEncounteredOnce()
IL_003d: brtrue.s IL_0047
IL_003f: ldarg.0
IL_0040: ldc.i4.2
IL_0041: callvirt System.Void TheForestOfLove.CritterLog/NamedResident::SetStatus(TheForestOfLove.CritterLog/NamedResidentStatus)
IL_0046: ret
IL_0047: ldarg.0
IL_0048: ldc.i4.1
IL_0049: callvirt System.Void TheForestOfLove.CritterLog/NamedResident::SetStatus(TheForestOfLove.CritterLog/NamedResidentStatus)
IL_004e: ret
