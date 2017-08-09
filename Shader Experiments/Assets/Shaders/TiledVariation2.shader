// Implmented from
// http://www.iquilezles.org/www/articles/texturerepetition/texturerepetition.htm


Shader "Unlit/Tiled/Variation2"
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

			float sum(float3 v) { return v.x + v.y + v.z; }

			float3 textureNoTile3(in float2 x, float v)
			{
				// sample variation pattern    
				float k = tex2D(_MainTex, 0.005*x).x; // cheap (cache friendly) lookup    

				// compute index    
				float index = k*8.0;
				float i = floor(index);
				float f = frac(index);

				// offsets for the different virtual patterns    
				float2 offa = sin(float2(3.0, 7.0)*(i + 0.0)); // can replace with any other hash    
				float2 offb = sin(float2(3.0, 7.0)*(i + 1.0)); // can replace with any other hash    

				// compute derivatives for mip-mapping    
				float2 dx = ddx(x), dy = ddy(x);

				// sample the two closest virtual patterns    
				float3 cola = tex2D(_MainTex, x + offa, dx, dy).xxx;
				float3 colb = tex2D(_MainTex, x + offb, dx, dy).xxx;

				// interpolate between the two virtual patterns    
				return lerp( cola, colb, smoothstep(0.2, 0.8, f - 0.1 * sum(cola - colb)) );
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
		
				float3 colSample = textureNoTile3(i.uv, 1).xyz;
				fixed4 col = fixed4(colSample.x, colSample.y, colSample.z, 1);

				return col;
			}
			ENDCG
		}
	}
}
