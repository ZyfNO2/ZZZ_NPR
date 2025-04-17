Shader "ZZZ/ZZZSurfaceEZ"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags {
            "RenderPipeline" = "UniversalPipeline"
            "RenderType"="Opaque"
        }
        LOD 100
        
        HLSLINCLUDE

        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"

        //常量区域
        CBUFFER_START(UnityPerMaterial)
        sampler2D _MainTex;
        CBUFFER_END

        // 定义输入结构体 appdata to Vertex
        struct UniversalAttributes
        {
            float4 positionOS : POSITION;
            float4 tangentOS : TANGENT;
            float3 normalOS : NORMAL;
            float2 texcoord : TEXCOORD0;
        };

        
         // 定义输出结构体 Vertex to frag
        struct UniversalVaryings
        {
            float2 uv : TEXCOORD0;
            float4 positionWSAndFogFactor : TEXCOORD1;
            float3 normalWS : TEXCOORD2;
            float4 tangentWS : TEXCOORD3;
            float3 viewDirectionWS : TEXCOORD4;
            float4 positionCS : SV_POSITION;
        };
        // Vertex
        UniversalVaryings MainVS(UniversalAttributes input)
        {
            VertexPositionInputs positionInputs = GetVertexPositionInputs(input.positionOS.xyz);
            VertexNormalInputs normalInputs = GetVertexNormalInputs(input.normalOS, input.tangentOS);

            UniversalVaryings output;
            output.positionCS = positionInputs.positionCS;
            output.positionWSAndFogFactor = float4(positionInputs.positionWS, ComputeFogFactor(positionInputs.positionCS.z));
            output.normalWS = normalInputs.normalWS;
            output.tangentWS.xyz = normalInputs.tangentWS;
            output.tangentWS.w = input.tangentOS.w * GetOddNegativeScale();
            output.viewDirectionWS = unity_OrthoParams.w == 0 ? GetCameraPositionWS() - positionInputs.positionWS : GetWorldToViewMatrix()[2].xyz;
            output.uv = input.texcoord;
            return output;
        }
        // frag
        float4 MainPS(UniversalVaryings input, bool isFrontFace : SV_IsFrontFace) : SV_Target
        {
            float4 mainTex = tex2D(_MainTex,input.uv);
            return mainTex;
        }

        ENDHLSL

        
        Pass
        {
            Name "Base"
            Tags
            {
                "LightMode" = "UniversalForward"
            }
            HLSLPROGRAM
            

            #pragma vertex MainVS
            #pragma fragment MainPS

            #pragma multi_compile_fog
            ENDHLSL
        }
    }
}
