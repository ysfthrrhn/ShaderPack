Shader "Custom/3DGrayscale_Unlit"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _Color ("Color Tint", Color) = (1,1,1,1)
        _GrayscaleAmount ("Grayscale Amount", Range (0, 1)) = 1.0
    }

    SubShader
    {
        Tags 
        { 
            "RenderType"="Opaque" 
            "Queue" = "Transparent+1"
            "UniversalMaterialType" = "Lit"    
        }
        LOD 300

        Pass
        {
            Name "ForwardLit"
            Tags { "LightMode"="UniversalForward" }


            HLSLPROGRAM
            #pragma target 2.0
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            float4 _Color;
            float _GrayscaleAmount;

            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS);
                OUT.uv = IN.uv;
                return OUT;
            }

            half4 frag(Varyings IN) : SV_Target
            {
                half4 texcol = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, IN.uv);
                float gray = dot(texcol.rgb, float3(0.3, 0.59, 0.11));
                texcol.rgb = lerp(texcol.rgb, gray, _GrayscaleAmount);
                texcol *= _Color;
                return texcol;
            }
            ENDHLSL
        }
    }
    Fallback "Hidden/InternalErrorShader"
}