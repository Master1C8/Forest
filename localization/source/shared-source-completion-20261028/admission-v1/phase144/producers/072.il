TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerBotb
METHOD System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Events.TriggerHandlers.TriggerHandlerBotb::get_triggerFilters() | attributes=Public, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "Botb_"
IL_000b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0010: pop
IL_0011: dup
IL_0012: ldstr "BotbLore_"
IL_0017: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_001c: pop
IL_001d: dup
IL_001e: ldstr "BotbMabel_"
IL_0023: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0028: pop
IL_0029: ret
