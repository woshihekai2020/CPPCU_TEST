//
// Created by hk001 on 2021/11/5.
//

#include "../../include/0_CU/cu2_addSum.cuh"



void generateNumbers_2( int *number, int size )
{
    for( int i = 0; i < size; i++ )
        number[i] = rand() % 10;
}

bool initCUDA_2()
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

__global__ static void sumOfSquares_2( int *num, int *result )
{
    int sum = 0;
    int i;
    for( i = 0; i < DATA_SIZE; i++ )
        sum += num[i] * num[i] * num[i] ;

    *result = sum;
}

int cu2_addSum()
{
    if( !initCUDA_2() ) return 0;

    generateNumbers_2( data, DATA_SIZE );

    int *gpuData, *result;

    cudaMalloc( (void**)&gpuData, sizeof(int) * DATA_SIZE );
    cudaMalloc( (void**)&result, sizeof(int) );
    cudaMemcpy( gpuData, data, sizeof(int) * DATA_SIZE, cudaMemcpyHostToDevice );

    sumOfSquares_2<<<1, 1, 0>>>( gpuData, result );

    int sum;
    cudaMemcpy( &sum, result, sizeof( int ), cudaMemcpyDeviceToHost );

    cudaFree( gpuData );
    cudaFree( result );
    printf( "GPUsum: %d \n", sum );

    sum = 0;
    for( int i = 0; i < DATA_SIZE; i++ )
        sum += data[i] * data[i] * data[i];
    printf( "CPUsum: %d \n", sum );

    return 0;
}


















