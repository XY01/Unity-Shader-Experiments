Shader "Unlit/GlitchShaderv2"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags 
		{
			"IgnoreProjector" = "True"
			"Queue" = "Transparent"
			"RenderType" = "Transparent"
		}

		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			

			// Concentrate rands
			// y = rand(x);			Middle
			//y = rand(x)*rand(x);	Low
			//y = sqrt(rand(x));	High
			//y = pow(rand(x),5.);	Very Low
			float3 Rand1D(float x)
			{
				return frac(sin(x)*1000.321);
			}

		
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}


			
			
			fixed4 frag (v2f i) : SV_Target
			{
				float2 centeredUV = i.uv - float2(.5, .5);

				// Sin Cos rounded diamonds				
				float sinU = tan(sin(centeredUV.x * UNITY_PI * 20));
				float cosV = cos(centeredUV.y * UNITY_PI * 20);

				float randU = Rand1D(floor(sinU));
				float randV = Rand1D(floor(cosV));

				//col = sinU  + cosV;
				fixed4 col = sinU + cosV;
				
				return col;
			}
			ENDCG
		}
	}
}
