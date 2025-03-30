Shader "ZZZ/ZZZSurface"
{
    Properties
    {
        [KeywordEnum(None, Face, Eye, Body)] _Domain ("Domain", Float) = 0

        [Header(Main Maps)]
        _Color ("Color", Color) = (1,1,1,1)
        [NoScaleOffset]_MainTex ("Texture", 2D) = "white" {}
        [NoScaleOffset]_LightTex ("Light Tex", 2D) = "linearGray" {}
        [NoScaleOffset]_OtherDataTex ("Other Data Tex", 2D) = "white" {}
        [NoScaleOffset]_OtherDataTex2 ("Other Data Tex", 2D) = "white" {}

        _NoseLineHorDisp ("Hori Disappear Value", Range(0.85, 0.98)) = 0.92
        _NoseLineKonDisp ("KonDisapear Value", Range(0.5, 0.7)) = 0.62
        _AlphaClip ("Alpha Clipping", Range(0,1)) = 0.333
        _BumpScale ("Normal Scale", Range(-5, 5)) = 1
        _Glossiness ("Smoothness", Range(0, 1)) = 0.5
        _Metallic ("Metallic", Range(0, 1)) = 0

        [HideInInspector] _HeadCenter ("Head Center", Vector) = (0,0,0)
        [HideInInspector] _HeadForward ("Head Forward", Vector) = (0,0,0)
        [HideInInspector] _HeadRight ("Head Right", Vector) = (0,0,0)
        _HeadSphereRange ("Head Sphere Range", Range(0, 1)) = 0

        _AmbientColorIntensity ("Ambient Intensity", Range(0, 1)) = 0.333

        [Enum(s0,0,s1,1,s2,2,s3,3,s4,4,s5,5)] _SkinMatId ("SkinMatId", Float) = 0

        _ModelSize ("Model Size 1", Range(0, 100)) = 1
        _ModelSize2 ("Model Size 2", Range(0, 100)) = 1
        _ModelSize3 ("Model Size 3", Range(0, 100)) = 1
        _ModelSize4 ("Model Size 4", Range(0, 100)) = 1
        _ModelSize5 ("Model Size 5", Range(0, 100)) = 1

        [Header(Screen Space Rim)]
        [Toggle(_SCREEN_SPACE_RIM)] _ScreenSpaceRim ("Screen Space Rim", Float) = 1
        _ScreenSpaceRimWidth ("Screen Space Rim Width", Range(0, 10)) = 1
        _ScreenSpaceRimThreshold ("Screen Space Rim Threshold", Range(0, 1)) = 0.01
        _ScreenSpaceRimFadeout ("Screen Space Rim Fadeout", Range(0, 10)) = 1
        _ScreenSpaceRimBrightness ("Screen Space Rim Brightness", Range(0, 10)) = 1

        [Header(Screen Space Shadow)]
        [Toggle(_SCREEN_SPACE_SHADOW)] _ScreenSpaceShadow ("Screen Space Shadow", Float) = 1
        _ScreenSpaceShadowWidth ("Screen Space Shadow Width", Range(0, 1)) = 0.2
        _ScreenSpaceShadowThreshold ("Screen Space Shadow Threshold", Range(0, 1)) = 0.015
        _ScreenSpaceShadowFadeout ("Screen Space Shadow Fadeout", Range(0, 10)) = 0.2
    }
    
    
    
}
