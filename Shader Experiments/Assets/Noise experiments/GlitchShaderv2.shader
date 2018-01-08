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

			float Rand2D(float2 pos) 
			{
				return frac(sin(dot(pos.xy, float2(12.9898,78.233))) * 43758.5453123);
			}

			float circle(in float2 _st, in float _radius) 
			{
				float2 dist = _st - float2(0.5, .5);
				return 1. - smoothstep(_radius - (_radius*0.01),
					_radius + (_radius*0.01),
					dot(dist,dist)*4.0);
			}

			float roundedSquare(float2 uv)
			{
				return length(max(abs(uv) - .3,0));
			}

			float SDFRadial(float2 pos, float2 circCenter)
			{
				return length(pos - circCenter);
			}

			float SDFCircle(float2 pos, float2 circCenter, float radius)
			{
				return step(length(pos - circCenter), radius);
			}

			float SDFCircleSmooth(float2 pos, float2 circCenter, float radiusInner, float radiusOuter)
			{
				return smoothstep(radiusInner, radiusOuter, length(pos - circCenter));
			}

			float radialNorm(float2 uv)
			{
				return (atan2(uv.y, uv.x) / UNITY_PI) / 2 + 0.5;
			}

			float2x2 rotate2d(float _angle)
			{
				return float2x2 (cos(_angle),-sin(_angle),
					sin(_angle),cos(_angle));
			}

			inline float2 posToRadial(float3 coords) 
			{
				coords = normalize(coords);

				//calculate latitude:
				float lat = asin(coords.y); //distance from zenith to equator: remaps [0;1] to [PI/2;0]
				lat /= UNITY_PI; //remap to [1/2;0]
				lat *= 2; //remap to [1;0]

						  //calculate longitude:
				float lon = atan2(coords.z, coords.x) / UNITY_PI;//lon around xz plane from -1 to 1
				lon = lon / 2 + 0.5; //remap lon from [-1; 1] to [0; 1] interval

				return float2(lon, lat);
			}

			inline float3 radialToPos(float2 lonlat) 
			{
				float lon = lonlat.x * 2 - 1; //remap from [0; 1] to [-1, 1]
				lon *= UNITY_PI; // remap to [-PI; PI]
				float dx, dy;
				sincos(lon, dy, dx);
				float lat = cos(lonlat.y * UNITY_PI);
				return float3 (dx, lat, dy);
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

				float2 scaledUV = i.uv * 100;

				float2 centeredUV = i.uv - float2(.5, .5);
				float radNorm = radialNorm(centeredUV);			

				float randRadialInt = Rand1D(radNorm);

				float2 integerAtUV = floor(scaledUV);
				float2 fracAtUV = frac(scaledUV);

				float timeStepped = floor(_Time.z);

				float sdfRadial = SDFRadial(i.uv, float2(.5, .5));

				fixed4 col;



				/// Radial random rings		
				/*
				{
					float numRings = 6;
					float numRings2 = 8 + (((_SinTime.x +1)*.5) * 19);

					// random thickness rings
					float sdfRadShaped = sin(sdfRadial * numRings);
					float randRings = Rand1D(floor(sdfRadShaped * numRings2));
					randRings = pow(randRings,3);

					// Rotate the UVs so the 0 line isn't always on the left
					float2x2 rotationMatrix = rotate2d((randRings - (_Time.x*.005)) * 360);
					float2 rotatedUVS = mul(centeredUV, rotationMatrix);


					float radNormRings = radialNorm(rotatedUVS);
					//col = radNormRings;

					// different speed for each ring
					float radNormTime = (radNormRings * ( randRings-.5)) + (_Time.x*.25);
					//col = sin(radNormTime*UNITY_PI*2);
					//col *= col;

					float ringLength = 7;// 3 + ((((_SinTime.x*.1) + 1)*.5) * 4);
					float ringLength2 = 33;// 15 + ((((_SinTime.x*.1) + 1)*.5) * 18); // 33;
					// Turns teh ring gradients into a rand
					float radRandOffset = Rand1D(floor((radNormTime * (randRings * ringLength2)) * ringLength));
					
					radRandOffset =  radRandOffset;

					// shaping the whites higher
					radRandOffset = pow(radRandOffset, 15);

					col = radRandOffset;
				}
				*/
			



				// Sin Cos rounded diamonds				
				float sinU = tan(sin(centeredUV.x * UNITY_PI * 20));
				float cosV = cos(centeredUV.y * UNITY_PI * 20);

				float randU = Rand1D(floor(sinU));
				float randV = Rand1D(floor(cosV));

				//col = sinU  + cosV;
				col = sinU + cosV;
				
				{ // Experiment area
					
				}

				/*
				// Sin Cos circle
				float sinU = sin(i.uv.x * UNITY_PI);
				float cosV = cos((i.uv.y - .5) * UNITY_PI);
				col = sinU * cosV;
				*/

				// Nice noise circle
				//col = SDFCircleSmooth(i.uv, float2(.5, .5), .3, Rand1D(scaledUV.y + (_Time.x%12.31 )- timeStepped * 16.341) * .45);

				// 1D noise on x
				//col = float4(Rand1D(scaledUV.x),1);

				// 2D Noise
				//col = Rand2D(integerAtUV);
				
				// fractional scaled UVs
				//col = float4(fracAtUV, 0, 1);

				// fractional scaled UVs - Rimmed
				//col += float4(abs(fracAtUV - .5), 0, 1);

				// sample the texture
				//fixed4 col = tex2D(_MainTex, i.uv);
				
				// Adjust alpha randomly over time
				//col.a *= (pow(Rand1D(_Time.z * 3.94), 5));

				

				return col;
			}
			ENDCG
		}
	}
}
