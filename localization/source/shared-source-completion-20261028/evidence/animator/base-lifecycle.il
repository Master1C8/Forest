TYPE Febucci.UI.Core.TAnimCore
METHOD System.Void Febucci.UI.Core.TAnimCore::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean Febucci.UI.Core.TAnimCore::requiresTagRefresh
IL_0007: ldarg.0
IL_0008: call System.Void Febucci.UI.Core.TAnimCore::TryInitializing()
IL_000d: ret
METHOD System.Void Febucci.UI.Core.TAnimCore::TryInitializing() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean Febucci.UI.Core.TAnimCore::initialized
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.1
IL_000b: stfld System.Boolean Febucci.UI.Core.TAnimCore::initialized
IL_0010: call System.Void Febucci.UI.Core.TextUtilities::Initialize()
IL_0015: ldarg.0
IL_0016: ldc.i4.0
IL_0017: stfld System.Int32 Febucci.UI.Core.TAnimCore::charactersCount
IL_001c: ldarg.0
IL_001d: ldc.i4.0
IL_001e: newarr Febucci.UI.Core.CharacterData
IL_0023: stfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_0028: ldarg.0
IL_0029: ldc.i4.0
IL_002a: stfld System.Int32 Febucci.UI.Core.TAnimCore::wordsCount
IL_002f: ldarg.0
IL_0030: ldc.i4.0
IL_0031: newarr Febucci.UI.Core.WordInfo
IL_0036: stfld Febucci.UI.Core.WordInfo[] Febucci.UI.Core.TAnimCore::words
IL_003b: ldarg.0
IL_003c: ldc.i4.0
IL_003d: newarr Febucci.UI.Core.Parsing.AnimationRegion
IL_0042: stfld Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::behaviors
IL_0047: ldarg.0
IL_0048: ldc.i4.0
IL_0049: newarr Febucci.UI.Core.Parsing.AnimationRegion
IL_004e: stfld Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::appearances
IL_0053: ldarg.0
IL_0054: ldc.i4.0
IL_0055: newarr Febucci.UI.Core.Parsing.AnimationRegion
IL_005a: stfld Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::disappearances
IL_005f: ldarg.0
IL_0060: ldc.i4.0
IL_0061: newarr Febucci.UI.Core.Parsing.ActionMarker
IL_0066: stfld Febucci.UI.Core.Parsing.ActionMarker[] Febucci.UI.Core.TAnimCore::actions
IL_006b: ldarg.0
IL_006c: ldc.i4.0
IL_006d: newarr Febucci.UI.Core.Parsing.EventMarker
IL_0072: stfld Febucci.UI.Core.Parsing.EventMarker[] Febucci.UI.Core.TAnimCore::events
IL_0077: ldarg.0
IL_0078: call Febucci.UI.Actions.ActionDatabase Febucci.UI.Core.TAnimCore::get_DatabaseActions()
IL_007d: call System.Boolean UnityEngine.Object::op_Implicit(UnityEngine.Object)
IL_0082: brfalse.s IL_008f
IL_0084: ldarg.0
IL_0085: call Febucci.UI.Actions.ActionDatabase Febucci.UI.Core.TAnimCore::get_DatabaseActions()
IL_008a: callvirt System.Void Febucci.UI.Core.Database`1<Febucci.UI.Actions.ActionScriptableBase>::ForceBuildRefresh()
IL_008f: ldarg.0
IL_0090: call Febucci.UI.Effects.AnimationsDatabase Febucci.UI.Core.TAnimCore::get_DatabaseAppearances()
IL_0095: call System.Boolean UnityEngine.Object::op_Implicit(UnityEngine.Object)
IL_009a: brfalse.s IL_00a7
IL_009c: ldarg.0
IL_009d: call Febucci.UI.Effects.AnimationsDatabase Febucci.UI.Core.TAnimCore::get_DatabaseAppearances()
IL_00a2: callvirt System.Void Febucci.UI.Core.Database`1<Febucci.UI.Effects.AnimationScriptableBase>::ForceBuildRefresh()
IL_00a7: ldarg.0
IL_00a8: call Febucci.UI.Effects.AnimationsDatabase Febucci.UI.Core.TAnimCore::get_DatabaseBehaviors()
IL_00ad: call System.Boolean UnityEngine.Object::op_Implicit(UnityEngine.Object)
IL_00b2: brfalse.s IL_00bf
IL_00b4: ldarg.0
IL_00b5: call Febucci.UI.Effects.AnimationsDatabase Febucci.UI.Core.TAnimCore::get_DatabaseBehaviors()
IL_00ba: callvirt System.Void Febucci.UI.Core.Database`1<Febucci.UI.Effects.AnimationScriptableBase>::ForceBuildRefresh()
IL_00bf: ldarg.0
IL_00c0: call Febucci.UI.Styles.StyleSheetScriptable Febucci.UI.Core.TAnimCore::get_StyleSheet()
IL_00c5: call System.Boolean UnityEngine.Object::op_Implicit(UnityEngine.Object)
IL_00ca: brfalse.s IL_00d7
IL_00cc: ldarg.0
IL_00cd: call Febucci.UI.Styles.StyleSheetScriptable Febucci.UI.Core.TAnimCore::get_StyleSheet()
IL_00d2: callvirt System.Void Febucci.UI.Styles.StyleSheetScriptable::ForceBuildRefresh()
IL_00d7: ldarg.0
IL_00d8: callvirt System.Void Febucci.UI.Core.TAnimCore::OnInitialized()
IL_00dd: ret
METHOD System.Void Febucci.UI.Core.TAnimCore::OnEnable() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean Febucci.UI.Core.TAnimCore::requiresMeshUpdate
IL_0007: ldarg.0
IL_0008: call System.Void Febucci.UI.Core.TAnimCore::AnimateText()
IL_000d: ret
METHOD System.Void Febucci.UI.Core.TAnimCore::ResetState() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldsfld System.String System.String::Empty
IL_0006: stfld System.String Febucci.UI.Core.TAnimCore::_text
IL_000b: ldarg.0
IL_000c: ldsfld System.String System.String::Empty
IL_0011: call System.Void Febucci.UI.Core.TAnimCore::set_textWithoutTextAnimTags(System.String)
IL_0016: ldarg.0
IL_0017: ldsfld System.String System.String::Empty
IL_001c: call System.Void Febucci.UI.Core.TAnimCore::set_textWithoutAnyTag(System.String)
IL_0021: ldarg.0
IL_0022: ldc.i4.0
IL_0023: stfld System.Int32 Febucci.UI.Core.TAnimCore::charactersCount
IL_0028: ldarg.0
IL_0029: ldc.i4.0
IL_002a: stfld System.Int32 Febucci.UI.Core.TAnimCore::wordsCount
IL_002f: ldarg.0
IL_0030: ldc.i4.0
IL_0031: stfld System.Boolean Febucci.UI.Core.TAnimCore::initialized
IL_0036: ldarg.0
IL_0037: call System.Void Febucci.UI.Core.TAnimCore::TryInitializing()
IL_003c: ret
