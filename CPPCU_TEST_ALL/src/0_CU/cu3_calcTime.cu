//
// Created by hk001 on 2021/11/5.
//

#include "../../include/0_CU/cu3_calcTime.cuh"


void generateNumbers_3( int *number, int size )
{
    for( int i = 0; i < size; i++ )
        number[i] = rand() % 10;
}

bool initCUDA_3()
{
    int count;

    cudaGetDeviceCount(&count);

    if (count == 0) return false;

    int i;
    for (i = 0; i < count; i++)
    {
        cudaDeviceProp prop;
        if( cudaGetDeviceProperties( &prop, i ) ==  cudaSuccess )
            if( prop.major >= 1 )
                break;
    }

    if( i == count ) return false;

    cudaSetDevice( i );

    return true;
}

__global__ static void sumOfSquares_3( int *num, int *result, clock_t *time )
{
    int sum = 0;
    int i;

    clock_t start = clock();

    for( i = 0; i < DATA_SIZE; i++ )
        sum += num[i] * num[i] * num[i] ;

    *result = sum;

    *time = clock() - start;
}

int cu3_calcTime()
{
    if( !initCUDA_3() ) return 0;

    generateNumbers_3( data, DATA_SIZE );

    int *gpuData, *result;
    clock_t *time;

    cudaMalloc( (void**)&gpuData, sizeof(int) * DATA_SIZE );
    cudaMalloc( (void**)&result, sizeof(int) );
    cudaMalloc( (void**)&time, sizeof( clock_t ) );
    cudaMemcpy( gpuData, data, sizeof(int) * DATA_SIZE, cudaMemcpyHostToDevice );

    sumOfSquares_3<<<1, 1, 0>>>(gpuData, result, time);

    int sum;
    clock_t time_used;
    cudaMemcpy( &sum, result, sizeof(int), cudaMemcpyDeviceToHost );
    cudaMemcpy( &time_used, time, sizeof(clock_t), cudaMemcpyDeviceToHost );

    cudaFree( gpuData );
    cudaFree( result );
    cudaFree( time );
    printf( "GPUsum: %d time: %ld \n", sum, time_used );

    sum = 0;
    for( int i = 0; i < DATA_SIZE; i++ )
        sum += data[i] * data[i] * data[i];
    printf( "CPUsum: %d \n", sum );

    return 0;
}























