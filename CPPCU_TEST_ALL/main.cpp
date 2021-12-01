//
// Created by hk001 on 2021/10/31.
//
#include <iostream>
#include "All.h"


int main()
{
    std::cout << "hello world CPPcu" << std::endl;

    ParameterReader pd;
    int excuteNum = atoi( pd.getData("excuteStr").c_str() );

    //0_cuda
    if( excuteNum < 10 )
        switch (excuteNum)
        {
            case 1:
                {
                cu1_init();
                break;
            }  //cuda_init
            case 2:
            {
                cu2_addSum();
                break;
            }  //cuda_addSum
            case 3:
            {
                cu3_calcTime();
                break;
            }  //cuda_calcTime
            default:
                cout << "CUDA NOT RUN" << endl;
        }

    //cu1_init();


    return 0;
}