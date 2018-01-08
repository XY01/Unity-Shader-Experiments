// Shader created with Shader Forge v1.37 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.37;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33352,y:32674,varname:node_3138,prsc:2|emission-6944-OUT,alpha-8229-OUT;n:type:ShaderForge.SFN_Noise,id:3150,x:32033,y:33551,varname:node_3150,prsc:2|XY-5380-OUT;n:type:ShaderForge.SFN_Time,id:8952,x:31330,y:33551,varname:node_8952,prsc:2;n:type:ShaderForge.SFN_Append,id:7766,x:31697,y:33551,varname:node_7766,prsc:2|A-8974-OUT,B-859-OUT;n:type:ShaderForge.SFN_Multiply,id:859,x:31520,y:33551,varname:node_859,prsc:2|A-5257-OUT,B-8952-T;n:type:ShaderForge.SFN_ValueProperty,id:5257,x:31330,y:33494,ptovrint:False,ptlb:AlphaFlickerSpeed,ptin:_AlphaFlickerSpeed,varname:node_5257,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:4;n:type:ShaderForge.SFN_Set,id:7714,x:32202,y:33551,varname:MaskHOffset,prsc:2|IN-3150-OUT;n:type:ShaderForge.SFN_TexCoord,id:8169,x:31548,y:32867,varname:node_8169,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:7928,x:31725,y:32785,varname:node_7928,prsc:2|A-8169-U,B-1562-OUT;n:type:ShaderForge.SFN_Append,id:3683,x:31900,y:32887,cmnt:offset uvs,varname:node_3683,prsc:2|A-7928-OUT,B-8169-V;n:type:ShaderForge.SFN_Get,id:9957,x:31725,y:32545,varname:node_9957,prsc:2|IN-7714-OUT;n:type:ShaderForge.SFN_Multiply,id:1562,x:31725,y:32660,varname:node_1562,prsc:2|A-9957-OUT,B-2548-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2548,x:31725,y:32613,ptovrint:False,ptlb:OffsetDist,ptin:_OffsetDist,varname:node_2548,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:-0.1;n:type:ShaderForge.SFN_Tex2dAsset,id:86,x:32110,y:32667,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_86,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7bf4dc07130c8dc4eb2b61f874a03065,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:5644,x:32360,y:32932,varname:node_5644,prsc:2,tex:7bf4dc07130c8dc4eb2b61f874a03065,ntxv:0,isnm:False|UVIN-3683-OUT,TEX-86-TEX;n:type:ShaderForge.SFN_Tex2d,id:8317,x:32623,y:32533,varname:node_8317,prsc:2,tex:7bf4dc07130c8dc4eb2b61f874a03065,ntxv:0,isnm:False|TEX-86-TEX;n:type:ShaderForge.SFN_Add,id:3704,x:32994,y:32935,varname:node_3704,prsc:2|A-8283-OUT,B-8317-A;n:type:ShaderForge.SFN_Clamp01,id:4188,x:33162,y:32935,varname:node_4188,prsc:2|IN-3704-OUT;n:type:ShaderForge.SFN_Multiply,id:8283,x:32567,y:33256,varname:node_8283,prsc:2|A-5644-A,B-4764-OUT,C-4697-OUT;n:type:ShaderForge.SFN_Get,id:4764,x:32567,y:33137,varname:node_4764,prsc:2|IN-7714-OUT;n:type:ShaderForge.SFN_Multiply,id:8545,x:33064,y:32779,varname:node_8545,prsc:2|A-8317-RGB,B-7166-OUT;n:type:ShaderForge.SFN_RemapRange,id:5385,x:32546,y:32932,varname:node_5385,prsc:2,frmn:0,frmx:1,tomn:0.7,tomx:1|IN-5644-RGB;n:type:ShaderForge.SFN_Subtract,id:7965,x:32546,y:32773,cmnt:offset mask,varname:node_7965,prsc:2|A-5644-A,B-8317-A;n:type:ShaderForge.SFN_Lerp,id:7166,x:32734,y:32932,varname:node_7166,prsc:2|A-5385-OUT,B-5644-RGB,T-7965-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4697,x:32567,y:33206,ptovrint:False,ptlb:AlphaFlickerOpacity,ptin:_AlphaFlickerOpacity,varname:node_4697,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.2;n:type:ShaderForge.SFN_Noise,id:7752,x:32033,y:33780,varname:node_7752,prsc:2|XY-202-OUT;n:type:ShaderForge.SFN_Time,id:4921,x:31140,y:33796,varname:node_4921,prsc:2;n:type:ShaderForge.SFN_Append,id:6910,x:31697,y:33780,varname:node_6910,prsc:2|A-4860-OUT,B-7671-OUT;n:type:ShaderForge.SFN_Multiply,id:9073,x:31330,y:33796,varname:node_9073,prsc:2|A-4905-OUT,B-4921-T;n:type:ShaderForge.SFN_ValueProperty,id:4905,x:31140,y:33739,ptovrint:False,ptlb:HNoiseSpeed,ptin:_HNoiseSpeed,varname:_AlphaFlickerSpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:4;n:type:ShaderForge.SFN_Set,id:5780,x:32202,y:33780,varname:MaskHLines,prsc:2|IN-7752-OUT;n:type:ShaderForge.SFN_TexCoord,id:1129,x:31293,y:33988,varname:node_1129,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:7671,x:31508,y:33796,varname:node_7671,prsc:2|A-9073-OUT,B-4266-OUT;n:type:ShaderForge.SFN_Get,id:6944,x:33067,y:32691,varname:node_6944,prsc:2|IN-8006-OUT;n:type:ShaderForge.SFN_Multiply,id:4266,x:31508,y:33988,varname:node_4266,prsc:2|A-1129-V,B-1171-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1171,x:31293,y:34156,ptovrint:False,ptlb:HNoiseRes,ptin:_HNoiseRes,varname:node_1171,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:20;n:type:ShaderForge.SFN_Noise,id:3406,x:31802,y:34346,varname:node_3406,prsc:2|XY-6291-OUT;n:type:ShaderForge.SFN_Time,id:8616,x:31095,y:34346,varname:node_8616,prsc:2;n:type:ShaderForge.SFN_Append,id:6484,x:31463,y:34346,varname:node_6484,prsc:2|A-2293-OUT,B-6988-OUT;n:type:ShaderForge.SFN_Multiply,id:6988,x:31285,y:34346,varname:node_6988,prsc:2|A-8436-OUT,B-8616-T;n:type:ShaderForge.SFN_ValueProperty,id:8436,x:31095,y:34289,ptovrint:False,ptlb:HBlockSpeed,ptin:_HBlockSpeed,varname:_HNoiseSpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:6;n:type:ShaderForge.SFN_Set,id:8186,x:31963,y:34346,varname:MaskHBlock,prsc:2|IN-3406-OUT;n:type:ShaderForge.SFN_Vector1,id:8229,x:33162,y:33219,varname:node_8229,prsc:2,v1:1;n:type:ShaderForge.SFN_Ceil,id:202,x:31859,y:33780,varname:node_202,prsc:2|IN-6910-OUT;n:type:ShaderForge.SFN_Ceil,id:5380,x:31859,y:33551,varname:node_5380,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_Ceil,id:6291,x:31636,y:34346,varname:node_6291,prsc:2|IN-6484-OUT;n:type:ShaderForge.SFN_TexCoord,id:9287,x:31275,y:34542,varname:node_9287,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:1795,x:31463,y:34552,varname:node_1795,prsc:2|A-9287-V,B-8076-OUT;n:type:ShaderForge.SFN_ValueProperty,id:8076,x:31275,y:34710,ptovrint:False,ptlb:HBlockSize,ptin:_HBlockSize,varname:_HNoiseRes_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:20;n:type:ShaderForge.SFN_Time,id:5205,x:30140,y:34171,varname:node_5205,prsc:2;n:type:ShaderForge.SFN_Ceil,id:7633,x:30315,y:34171,varname:node_7633,prsc:2|IN-5205-T;n:type:ShaderForge.SFN_Noise,id:5028,x:30658,y:34171,varname:node_5028,prsc:2|XY-8526-OUT;n:type:ShaderForge.SFN_Append,id:8526,x:30490,y:34171,varname:node_8526,prsc:2|A-6934-OUT,B-7633-OUT;n:type:ShaderForge.SFN_Set,id:7741,x:30824,y:34171,varname:NoiseLookup,prsc:2|IN-5028-OUT;n:type:ShaderForge.SFN_Get,id:2293,x:31463,y:34295,varname:node_2293,prsc:2|IN-7741-OUT;n:type:ShaderForge.SFN_Get,id:4860,x:31697,y:33730,varname:node_4860,prsc:2|IN-7741-OUT;n:type:ShaderForge.SFN_Get,id:8974,x:31697,y:33498,varname:node_8974,prsc:2|IN-7741-OUT;n:type:ShaderForge.SFN_Vector1,id:6934,x:30490,y:34108,varname:node_6934,prsc:2,v1:0.72;n:type:ShaderForge.SFN_Code,id:9696,x:30072,y:34652,varname:node_9696,prsc:2,code:cgBlAHQAdQByAG4AIABmAHIAYQBjACgAcwBpAG4AKAB0AGkAbQBlACkAKgBzAGMAYQBsAGUAcgApADsA,output:2,fname:RandFunc1D,width:295,height:112,input:0,input:0,input_1_label:time,input_2_label:scaler|A-3092-T,B-3752-OUT;n:type:ShaderForge.SFN_Time,id:3092,x:29864,y:34591,varname:node_3092,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:3752,x:29864,y:34754,ptovrint:False,ptlb:Scaler,ptin:_Scaler,varname:node_3752,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1.2;n:type:ShaderForge.SFN_Set,id:8328,x:30435,y:34651,varname:Rand1D,prsc:2|IN-9696-OUT;n:type:ShaderForge.SFN_Code,id:2973,x:30059,y:34906,varname:node_2973,prsc:2,code:cgBlAHQAdQByAG4AIABmAHIAYQBjACgAcwBpAG4AKABkAG8AdAAoAFAAbwBzAC4AeAB5ACwADQAgAHYAZQBjADIAKAAxADIALgA5ADgAOQA4ACwANwA4AC4AMgAzADMAKQApACkAIAAqAA0AIAA0ADMANwA1ADgALgA1ADQANQAzADEAMgAzACkAOwA=,output:2,fname:RandFunc2D,width:558,height:112,input:1,input_1_label:Pos|A-7795-OUT;n:type:ShaderForge.SFN_Time,id:3125,x:29701,y:34907,varname:node_3125,prsc:2;n:type:ShaderForge.SFN_Set,id:8006,x:30679,y:34906,varname:Rand2D,prsc:2|IN-2973-OUT;n:type:ShaderForge.SFN_Append,id:7795,x:29864,y:34907,varname:node_7795,prsc:2|A-3125-T,B-3125-TDB;proporder:5257-86-2548-4697-4905-1171-8436-3752;pass:END;sub:END;*/

Shader "Shader Forge/GlitchShader" {
    Properties {
        _AlphaFlickerSpeed ("AlphaFlickerSpeed", Float ) = 4
        _MainTex ("MainTex", 2D) = "white" {}
        _OffsetDist ("OffsetDist", Float ) = -0.1
        _AlphaFlickerOpacity ("AlphaFlickerOpacity", Float ) = 0.2
        _HNoiseSpeed ("HNoiseSpeed", Float ) = 4
        _HNoiseRes ("HNoiseRes", Float ) = 20
        _HBlockSpeed ("HBlockSpeed", Float ) = 6
        _Scaler ("Scaler", Float ) = 1.2
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            float3 RandFunc2D( float2 Pos ){
            return frac(sin(dot(Pos.xy,
 float2(12.9898,78.233))) *
 43758.5453123);
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 node_3125 = _Time + _TimeEditor;
                float3 Rand2D = RandFunc2D( float2(node_3125.g,node_3125.b) );
                float3 emissive = Rand2D;
                float3 finalColor = emissive;
                return fixed4(finalColor,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
