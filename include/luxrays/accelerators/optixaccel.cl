#line 2 "optixaccel.cl"

/***************************************************************************
 * Copyright 1998-2020 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxCoreRender.                                   *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

//------------------------------------------------------------------------------

typedef unsigned long long CUdeviceptr;

typedef unsigned long long OptixTraversableHandle;
typedef unsigned int OptixVisibilityMask;

//------------------------------------------------------------------------------

static __forceinline__ __device__ uint3 optixGetLaunchIndex()
{
    unsigned int u0, u1, u2;
    asm( "call (%0), _optix_get_launch_index_x, ();" : "=r"( u0 ) : );
    asm( "call (%0), _optix_get_launch_index_y, ();" : "=r"( u1 ) : );
    asm( "call (%0), _optix_get_launch_index_z, ();" : "=r"( u2 ) : );
    return make_uint3( u0, u1, u2 );
}

static __forceinline__ __device__ void optixTrace( OptixTraversableHandle handle,
                                                   float3                 rayOrigin,
                                                   float3                 rayDirection,
                                                   float                  tmin,
                                                   float                  tmax,
                                                   float                  rayTime,
                                                   OptixVisibilityMask    visibilityMask,
                                                   unsigned int           rayFlags,
                                                   unsigned int           SBToffset,
                                                   unsigned int           SBTstride,
                                                   unsigned int           missSBTIndex )
{
    float        ox = rayOrigin.x, oy = rayOrigin.y, oz = rayOrigin.z;
    float        dx = rayDirection.x, dy = rayDirection.y, dz = rayDirection.z;
    unsigned int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21,
        p22, p23, p24, p25, p26, p27, p28, p29, p30, p31;
    asm volatile(
        "call"
        "(%0,%1,%2,%3,%4,%5,%6,%7,%8,%9,%10,%11,%12,%13,%14,%15,%16,%17,%18,%19,%20,%21,%22,%23,%24,%25,%26,%27,%28,%"
        "29,%30,%31),"
        "_optix_trace_typed_32,"
        "(%32,%33,%34,%35,%36,%37,%38,%39,%40,%41,%42,%43,%44,%45,%46,%47,%48,%49,%50,%51,%52,%53,%54,%55,%56,%57,%58,%"
        "59,%60,%61,%62,%63,%64,%65,%66,%67,%68,%69,%70,%71,%72,%73,%74,%75,%76,%77,%78,%79,%80);"
        : "=r"( p0 ), "=r"( p1 ), "=r"( p2 ), "=r"( p3 ), "=r"( p4 ), "=r"( p5 ), "=r"( p6 ), "=r"( p7 ), "=r"( p8 ),
          "=r"( p9 ), "=r"( p10 ), "=r"( p11 ), "=r"( p12 ), "=r"( p13 ), "=r"( p14 ), "=r"( p15 ), "=r"( p16 ),
          "=r"( p17 ), "=r"( p18 ), "=r"( p19 ), "=r"( p20 ), "=r"( p21 ), "=r"( p22 ), "=r"( p23 ), "=r"( p24 ),
          "=r"( p25 ), "=r"( p26 ), "=r"( p27 ), "=r"( p28 ), "=r"( p29 ), "=r"( p30 ), "=r"( p31 )
        : "r"( 0 ), "l"( handle ), "f"( ox ), "f"( oy ), "f"( oz ), "f"( dx ), "f"( dy ), "f"( dz ), "f"( tmin ),
          "f"( tmax ), "f"( rayTime ), "r"( visibilityMask ), "r"( rayFlags ), "r"( SBToffset ), "r"( SBTstride ),
          "r"( missSBTIndex ), "r"( 0 ), "r"( p0 ), "r"( p1 ), "r"( p2 ), "r"( p3 ), "r"( p4 ), "r"( p5 ), "r"( p6 ),
          "r"( p7 ), "r"( p8 ), "r"( p9 ), "r"( p10 ), "r"( p11 ), "r"( p12 ), "r"( p13 ), "r"( p14 ), "r"( p15 ),
          "r"( p16 ), "r"( p17 ), "r"( p18 ), "r"( p19 ), "r"( p20 ), "r"( p21 ), "r"( p22 ), "r"( p23 ), "r"( p24 ),
          "r"( p25 ), "r"( p26 ), "r"( p27 ), "r"( p28 ), "r"( p29 ), "r"( p30 ), "r"( p31 )
        : );
    (void)p0, (void)p1, (void)p2, (void)p3, (void)p4, (void)p5, (void)p6, (void)p7, (void)p8, (void)p9, (void)p10, (void)p11,
        (void)p12, (void)p13, (void)p14, (void)p15, (void)p16, (void)p17, (void)p18, (void)p19, (void)p20, (void)p21,
        (void)p22, (void)p23, (void)p24, (void)p25, (void)p26, (void)p27, (void)p28, (void)p29, (void)p30, (void)p31;
}

static __forceinline__ __device__ float optixGetRayTmax()
{
    float f0;
    asm( "call (%0), _optix_get_ray_tmax, ();" : "=f"( f0 ) : );
    return f0;
}

static __forceinline__ __device__ float2 optixGetTriangleBarycentrics()
{
    float f0, f1;
    asm( "call (%0, %1), _optix_get_triangle_barycentrics, ();" : "=f"( f0 ), "=f"( f1 ) : );
    return make_float2( f0, f1 );
}

static __forceinline__ __device__ unsigned int optixGetPrimitiveIndex()
{
    unsigned int u0;
    asm( "call (%0), _optix_read_primitive_idx, ();" : "=r"( u0 ) : );
    return u0;
}

static __forceinline__ __device__ CUdeviceptr optixGetSbtDataPointer()
{
    unsigned long long ptr;
    asm( "call (%0), _optix_get_sbt_data_ptr_64, ();" : "=l"( ptr ) : );
    return (CUdeviceptr)ptr;
}

static __forceinline__ __device__ unsigned int optixGetInstanceId()
{
    unsigned int u0;
    asm( "call (%0), _optix_read_instance_id, ();" : "=r"( u0 ) : );
    return u0;
}

static __forceinline__ __device__ unsigned int optixGetInstanceIndex()
{
    unsigned int u0;
    asm( "call (%0), _optix_read_instance_idx, ();" : "=r"( u0 ) : );
    return u0;
}

//------------------------------------------------------------------------------
// This must match the definition in optixaccel.cpp

typedef struct Params {
	OptixTraversableHandle optixHandle;
	CUdeviceptr rayBuff;
	CUdeviceptr rayHitBuff;
} OptixAccelParams;

//------------------------------------------------------------------------------

extern "C" {
__constant__ OptixAccelParams optixAccelParams;
}

extern "C" __global__ void __raygen__OptixAccel() {
	const uint3 launchIndex = optixGetLaunchIndex();

	Ray *rayBuff = (Ray *)optixAccelParams.rayBuff;
	Ray *ray = &rayBuff[launchIndex.x];

	if (ray->flags & RAY_FLAGS_MASKED)
		return;

	optixTrace(
            optixAccelParams.optixHandle,
            make_float3(ray->o.x, ray->o.y, ray->o.z),
            make_float3(ray->d.x, ray->d.y, ray->d.z),
            ray->mint,
            ray->maxt,
            ray->time,
            OptixVisibilityMask(1),
            0,
            0, 1, 0);
}

extern "C" __global__ void __closesthit__OptixAccel() {
	const uint3 launchIndex = optixGetLaunchIndex();

	RayHit *rayHitBuff = (RayHit *)optixAccelParams.rayHitBuff;
	RayHit *rayHit = &rayHitBuff[launchIndex.x];

	const uint triangleIndex = optixGetPrimitiveIndex();

	if (triangleIndex == NULL_INDEX) {
		rayHit->meshIndex = NULL_INDEX;
		rayHit->triangleIndex = NULL_INDEX;
	} else {
		rayHit->t = optixGetRayTmax();

		const float2 barycentrics = optixGetTriangleBarycentrics();
		rayHit->b1 = barycentrics.x;
		rayHit->b2 = barycentrics.y;

		rayHit->meshIndex = optixGetInstanceId();
		rayHit->triangleIndex = triangleIndex;
	}
}

extern "C" __global__ void __miss__OptixAccel() {
	const uint3 launchIndex = optixGetLaunchIndex();

	RayHit *rayHitBuff = (RayHit *)optixAccelParams.rayHitBuff;
	RayHit *rayHit = &rayHitBuff[launchIndex.x];

	rayHit->meshIndex = NULL_INDEX;
	rayHit->triangleIndex = NULL_INDEX;
}
