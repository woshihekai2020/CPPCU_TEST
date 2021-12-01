#include "../../include/0_CU/cu1_init.cuh"

//#define DATA_SIZE 1048576
#define THREAD_NUM 256
#define BLOCK_NUM 32

void printDeviceProp( const cudaDeviceProp &prop )
{
    printf( "Device name: %s.\n", prop.name);
    printf( "totalGlobalMem: %d.\n", prop.totalGlobalMem);
    printf( "sharedMemPerBlock: %d.\n", prop.sharedMemPerBlock );
    printf( "regsPerBlock: %d.\n", prop.regsPerBlock );
    printf( "warpSize: %d.\n", prop.warpSize );
    printf( "memPitch: %d.\n", prop.memPitch );
    printf( "maxThreadsPerBlock: %d.\n", prop.maxThreadsPerBlock );
    printf( "maxThreadsDim[0 - 2]: %d %d %d.\n", prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2] );
    printf( "maxGridSize[0 - 2]: %d %d %d.\n", prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2] );
    printf( "totalConstMem: %d.\n", prop.totalConstMem );
    printf( "major.minor: %d, %d.\n", prop.major, prop.minor );
    printf( "clockRate: %d.\n", prop.clockRate );
    printf( "textureALignment: %d.\n", prop.textureAlignment );
    printf( "deviceOverlap: %d.\n", prop.deviceOverlap );
    printf( "multiProcessorCount: %d.\n", prop.multiProcessorCount );
}

bool InitCUDA()
{
    int count ;
    cudaGetDeviceCount( &count );

    if( count == 0 ) return false;

    int i;
    for( i = 0; i < count; i++ )
    {
        cudaDeviceProp prop;
        if( cudaGetDeviceProperties(&prop, i) == cudaSuccess )
        {
            printDeviceProp( prop );
            if( prop.major >= 1 ) break;
        }
    }

    if( i == count ) return false;

    cudaSetDevice( i );

    return true;
}

__global__ void sumOfSquares( int *num, int *result, clock_t * time )
{
    const int tid = threadIdx.x;
}

int cu1_init()
{
    std::cout << "Hello, World!" << std::endl;

    if( !InitCUDA() )
        return -1;
    printf( "InitCUDA is over.\n");

    return 0;
}
