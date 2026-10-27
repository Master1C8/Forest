TYPE PixelCrushers.DialogueSystem.ConversationView
METHOD System.Void PixelCrushers.DialogueSystem.ConversationView::OnCancelSubtitle() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationView::lastSubtitle
IL_0006: brtrue.s IL_002b
IL_0008: ldnull
IL_0009: ldnull
IL_000a: ldnull
IL_000b: ldsfld System.String System.String::Empty
IL_0010: ldsfld System.String System.String::Empty
IL_0015: ldnull
IL_0016: newobj System.Void PixelCrushers.DialogueSystem.Subtitle::.ctor(PixelCrushers.DialogueSystem.CharacterInfo,PixelCrushers.DialogueSystem.CharacterInfo,PixelCrushers.DialogueSystem.FormattedText,System.String,System.String,PixelCrushers.DialogueSystem.DialogueEntry)
IL_001b: stloc.0
IL_001c: ldarg.0
IL_001d: ldstr "OnConversationLineCancelled"
IL_0022: ldloc.0
IL_0023: ldc.i4.1
IL_0024: call System.Void UnityEngine.Component::BroadcastMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_0029: br.s IL_003d
IL_002b: ldarg.0
IL_002c: ldstr "OnConversationLineCancelled"
IL_0031: ldarg.0
IL_0032: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationView::lastSubtitle
IL_0037: ldc.i4.1
IL_0038: call System.Void UnityEngine.Component::BroadcastMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_003d: ldarg.0
IL_003e: ldc.i4.0
IL_003f: stfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::waitForContinue
IL_0044: ldarg.0
IL_0045: call System.Void PixelCrushers.DialogueSystem.ConversationView::FinishSubtitle()
IL_004a: ret
METHOD System.String PixelCrushers.DialogueSystem.ConversationView::GetDefaultSequence(PixelCrushers.DialogueSystem.Subtitle) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.Sequencer PixelCrushers.DialogueSystem.ConversationView::m_sequencer
IL_0006: callvirt System.Single PixelCrushers.DialogueSystem.Sequencer::get_subtitleEndTime()
IL_000b: stloc.0
IL_000c: ldarg.1
IL_000d: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0012: ldfld PixelCrushers.DialogueSystem.CharacterType PixelCrushers.DialogueSystem.CharacterInfo::characterType
IL_0017: ldc.i4.0
IL_0018: ceq
IL_001a: stloc.1
IL_001b: ldloc.1
IL_001c: brfalse.s IL_0067
IL_001e: ldarg.0
IL_001f: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_0024: callvirt System.Boolean PixelCrushers.DialogueSystem.DisplaySettings::GetShowPCSubtitlesDuringLine()
IL_0029: brfalse.s IL_0040
IL_002b: ldarg.0
IL_002c: ldfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::_lastModeWasResponseMenu
IL_0031: brfalse.s IL_0067
IL_0033: ldarg.0
IL_0034: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_0039: callvirt System.Boolean PixelCrushers.DialogueSystem.DisplaySettings::GetSkipPCSubtitleAfterResponseMenu()
IL_003e: brfalse.s IL_0067
IL_0040: ldarg.0
IL_0041: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_0046: callvirt System.String PixelCrushers.DialogueSystem.DisplaySettings::GetDefaultPlayerSequence()
IL_004b: call System.String PixelCrushers.DialogueSystem.Sequencer::ReplaceShortcuts(System.String)
IL_0050: ldstr "{{end}}"
IL_0055: ldloca.s V_0
IL_0057: call System.Globalization.CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()
IL_005c: call System.String System.Single::ToString(System.IFormatProvider)
IL_0061: callvirt System.String System.String::Replace(System.String,System.String)
IL_0066: ret
IL_0067: ldarg.0
IL_0068: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_006d: callvirt System.String PixelCrushers.DialogueSystem.DisplaySettings::GetDefaultSequence()
IL_0072: stloc.2
IL_0073: ldloc.1
IL_0074: brfalse.s IL_0094
IL_0076: ldarg.0
IL_0077: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_007c: callvirt System.String PixelCrushers.DialogueSystem.DisplaySettings::GetDefaultPlayerSequence()
IL_0081: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0086: brtrue.s IL_0094
IL_0088: ldarg.0
IL_0089: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_008e: callvirt System.String PixelCrushers.DialogueSystem.DisplaySettings::GetDefaultPlayerSequence()
IL_0093: stloc.2
IL_0094: ldloc.2
IL_0095: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_009a: brfalse.s IL_00bb
IL_009c: call System.Globalization.CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()
IL_00a1: ldstr "Delay({0})"
IL_00a6: ldc.i4.1
IL_00a7: newarr System.Object
IL_00ac: dup
IL_00ad: ldc.i4.0
IL_00ae: ldloc.0
IL_00af: box System.Single
IL_00b4: stelem.ref
IL_00b5: call System.String System.String::Format(System.IFormatProvider,System.String,System.Object[])
IL_00ba: ret
IL_00bb: ldloc.2
IL_00bc: call System.String PixelCrushers.DialogueSystem.Sequencer::ReplaceShortcuts(System.String)
IL_00c1: ldstr "{{end}}"
IL_00c6: ldloca.s V_0
IL_00c8: call System.Globalization.CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()
IL_00cd: call System.String System.Single::ToString(System.IFormatProvider)
IL_00d2: callvirt System.String System.String::Replace(System.String,System.String)
IL_00d7: ret
METHOD System.Void PixelCrushers.DialogueSystem.ConversationView::NotifyParticipants(System.String,PixelCrushers.DialogueSystem.Subtitle) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: brfalse.s IL_007b
IL_0003: ldarg.0
IL_0004: ldarg.2
IL_0005: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_000a: call System.Boolean PixelCrushers.DialogueSystem.ConversationView::CharacterInfoHasValidTransform(PixelCrushers.DialogueSystem.CharacterInfo)
IL_000f: ldarg.0
IL_0010: ldarg.2
IL_0011: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::listenerInfo
IL_0016: call System.Boolean PixelCrushers.DialogueSystem.ConversationView::CharacterInfoHasValidTransform(PixelCrushers.DialogueSystem.CharacterInfo)
IL_001b: stloc.0
IL_001c: dup
IL_001d: ldloc.0
IL_001e: and
IL_001f: brfalse.s IL_003e
IL_0021: ldarg.2
IL_0022: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0027: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_002c: ldarg.2
IL_002d: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::listenerInfo
IL_0032: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_0037: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_003c: br.s IL_003f
IL_003e: ldc.i4.0
IL_003f: stloc.1
IL_0040: brfalse.s IL_0055
IL_0042: ldarg.2
IL_0043: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0048: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_004d: ldarg.1
IL_004e: ldarg.2
IL_004f: ldc.i4.1
IL_0050: callvirt System.Void UnityEngine.Component::BroadcastMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_0055: ldloc.0
IL_0056: brfalse.s IL_006e
IL_0058: ldloc.1
IL_0059: brtrue.s IL_006e
IL_005b: ldarg.2
IL_005c: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::listenerInfo
IL_0061: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_0066: ldarg.1
IL_0067: ldarg.2
IL_0068: ldc.i4.1
IL_0069: callvirt System.Void UnityEngine.Component::BroadcastMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_006e: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0073: ldarg.1
IL_0074: ldarg.2
IL_0075: ldc.i4.1
IL_0076: callvirt System.Void UnityEngine.Component::BroadcastMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_007b: ret
