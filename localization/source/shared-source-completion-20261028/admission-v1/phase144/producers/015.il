TYPE TheForestOfLove.BlendModeColorFader
METHOD System.Void TheForestOfLove.BlendModeColorFader::SetColorImmediately(UnityEngine.Color) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.BlendModeColorFader::firstUpdate
IL_0006: brtrue.s IL_0017
IL_0008: ldarg.0
IL_0009: ldarg.1
IL_000a: stfld UnityEngine.Color TheForestOfLove.BlendModeColorFader::tmpColor
IL_000f: ldarg.0
IL_0010: ldc.i4.1
IL_0011: stfld System.Boolean TheForestOfLove.BlendModeColorFader::needsInit
IL_0016: ret
IL_0017: ldarg.0
IL_0018: ldarg.0
IL_0019: ldfld BlendModes.BlendModeEffect TheForestOfLove.BlendModeColorFader::blendModeEffect
IL_001e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0023: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Renderer>()
IL_0028: stfld UnityEngine.Renderer TheForestOfLove.BlendModeColorFader::blendModeRenderer
IL_002d: ldarg.0
IL_002e: ldfld UnityEngine.Renderer TheForestOfLove.BlendModeColorFader::blendModeRenderer
IL_0033: callvirt UnityEngine.Material UnityEngine.Renderer::get_sharedMaterial()
IL_0038: ldstr "_Color"
IL_003d: ldarg.1
IL_003e: callvirt System.Void UnityEngine.Material::SetColor(System.String,UnityEngine.Color)
IL_0043: ret
METHOD System.Void TheForestOfLove.BlendModeColorFader::LerpToColor(UnityEngine.Color,System.Single) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Renderer TheForestOfLove.BlendModeColorFader::blendModeRenderer
IL_0006: callvirt UnityEngine.Material UnityEngine.Renderer::get_sharedMaterial()
IL_000b: ldstr "_Color"
IL_0010: callvirt UnityEngine.Color UnityEngine.Material::GetColor(System.String)
IL_0015: stloc.0
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Renderer TheForestOfLove.BlendModeColorFader::blendModeRenderer
IL_001c: callvirt UnityEngine.Material UnityEngine.Renderer::get_sharedMaterial()
IL_0021: ldstr "_Color"
IL_0026: ldloc.0
IL_0027: ldarg.1
IL_0028: ldarg.2
IL_0029: call UnityEngine.Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,System.Single)
IL_002e: callvirt System.Void UnityEngine.Material::SetColor(System.String,UnityEngine.Color)
IL_0033: ret
