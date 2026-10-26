TYPE BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0
METHOD System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::<Read>b__0() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::repo
IL_0006: callvirt BansheeGz.BGDatabase.BGRepoAddons BansheeGz.BGDatabase.BGRepo::get_Addons()
IL_000b: ldarg.0
IL_000c: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_0011: call BansheeGz.BGDatabase.BGAddon BansheeGz.BGDatabase.BGAddon::FromBinary(BansheeGz.BGDatabase.BGBinaryReader)
IL_0016: callvirt System.Void BansheeGz.BGDatabase.BGRepoAddons::Add(BansheeGz.BGDatabase.BGAddon)
IL_001b: ret
