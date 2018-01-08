// Implmented from
// http://www.iquilezles.org/www/articles/texturerepetition/texturerepetition.htm


Shader "Unlit/Tiled/Variation0"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{				
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			float4 hash4(float2 p)
			{
				return frac(sin(float4(1.0 + dot(p, float2(37.0, 17.0)),
					2.0 + dot(p, float2(11.0, 47.0)),
					3.0 + dot(p, float2(41.0, 29.0)),
					4.0 + dot(p, float2(23.0, 31.0))))*103.0); 
			}

			float4 textureNoTile1(sampler2D samp, in float2 uv)
			{
				float2 iuv = floor(uv);
				float2 fuv = frac(uv);

				float4 ofa = hash4(iuv + float2(0.0, 0.0));
				float4 ofb = hash4(iuv + float2(1.0, 0.0));
				float4 ofc = hash4(iuv + float2(0.0, 1.0));
				float4 ofd = hash4(iuv + float2(1.0, 1.0));

				float2 ddxVar = ddx(uv);
				float2 ddyVar = ddy(uv);

				// transform per-tile uvs
				ofa.zw = sign(ofa.zw - 0.5);
				ofb.zw = sign(ofb.zw - 0.5);
				ofc.zw = sign(ofc.zw - 0.5);
				ofd.zw = sign(ofd.zw - 0.5);

				// uv's, and derivarives (for correct mipmapping)
				float2 uva = uv*ofa.zw + ofa.xy; float2 ddxVara = ddxVar*ofa.zw; float2 ddyVara = ddyVar*ofa.zw;
				float2 uvb = uv*ofb.zw + ofb.xy; float2 ddxVarb = ddxVar*ofb.zw; float2 ddyVarb = ddyVar*ofb.zw;
				float2 uvc = uv*ofc.zw + ofc.xy; float2 ddxVarc = ddxVar*ofc.zw; float2 ddyVarc = ddyVar*ofc.zw;
				float2 uvd = uv*ofd.zw + ofd.xy; float2 ddxVard = ddxVar*ofd.zw; float2 ddyVard = ddyVar*ofd.zw;

				// fetch and blend
				float2 b = smoothstep(0.25, 0.75, fuv);

				return lerp(lerp(tex2D(samp, uva, ddxVara, ddyVara),  
					tex2D(samp, uvb, ddxVarb, ddyVarb), b.x),
					lerp(tex2D(samp, uvc, ddxVarc, ddyVarc),
						tex2D(samp, uvd, ddxVard, ddyVard), b.x), b.y);
			}

			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = textureNoTile1(_MainTex, i.uv);
			

				return col;
			}
			ENDCG
		}
	}
}
