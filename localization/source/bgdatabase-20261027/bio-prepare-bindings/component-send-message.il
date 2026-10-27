TYPE UnityEngine.Component
METHOD System.Void UnityEngine.Component::SendMessage(System.String,System.Object) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: ldarg.2
IL_0004: ldc.i4.0
IL_0005: call System.Void UnityEngine.Component::SendMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_000a: nop
IL_000b: ret
METHOD System.Void UnityEngine.Component::SendMessage(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: ldnull
IL_0004: ldc.i4.0
IL_0005: call System.Void UnityEngine.Component::SendMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_000a: nop
IL_000b: ret
METHOD System.Void UnityEngine.Component::SendMessage(System.String,System.Object,UnityEngine.SendMessageOptions) | attributes=Public, HideBySig | impl=InternalCall
ATTRIBUTE UnityEngine.Bindings.FreeFunctionAttribute
METHOD System.Void UnityEngine.Component::SendMessage(System.String,UnityEngine.SendMessageOptions) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: ldnull
IL_0004: ldarg.2
IL_0005: call System.Void UnityEngine.Component::SendMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_000a: nop
IL_000b: ret
