// Implmented from
// http://www.iquilezles.org/www/articles/texturerepetition/texturerepetition.htm


Shader "Unlit/Tiled/Variation1"
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

			float4 textureNoTile2(sampler2D samp, in float2 uv)
			{
				float2 p = floor(uv);
				float2 f = frac(uv);

				// derivatives (for correct mipmapping)
				float2 ddxVar = ddx(uv);
				float2 ddyVar = ddy(uv);

				// voronoi contribution
				float4 va = float4(0,0,0,0);
				float wt = 0.0;
				for (int j = -1; j <= 1; j++)
				{
					for (int i = -1; i <= 1; i++)
					{
						float2 g = float2(float(i), float(j));
						float4 o = hash4(p + g);
						float2 r = g - f + o.xy;
						float d = dot(r, r);
						float w = exp(-5.0*d);
						float4 c = tex2D(samp, uv + o.zw, ddxVar, ddyVar);
						va += w*c;
						wt += w;
					}
				}

				// normalization
				return va / wt;
			}

			float sum(float3 v) { return v.x + v.y + v.z; }

			fixed4 frag (v2f i) : SV_Target
			{
				//fixed4 col = textureNoTile1(_MainTex, i.uv);
				fixed4 col = textureNoTile2(_MainTex, i.uv);
			

				return col;
			}
			ENDCG
		}
	}
}
