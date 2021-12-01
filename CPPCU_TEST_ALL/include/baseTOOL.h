//
// Created by hk001 on 2021/11/5.
//

#ifndef CPP_CU_TEST_BASETOOL_H
#define CPP_CU_TEST_BASETOOL_H

#pragma once

#include <fstream>
#include <vector>
#include <map>
using namespace std;

class ParameterReader
{
public:
    map<string, string> data;
public:
    ParameterReader( string filename = "../data/parameters.txt" )
    {
        ifstream fin( filename.c_str() );
        if( !fin ) return ;

        while( !fin.eof() )
        {
            string str;
            getline( fin, str );
            if( str[0] == '#')
                continue;

            int pos = str.find( "=" );
            if( pos == -1 )
                continue;

            string key   = str.substr(0, pos);
            string value = str.substr( pos +1, str.length() );
            data[ key ] = value;

            if( !fin.good() )
                break;
        }
    }

    string getData( string key )
    {
        map<string, string>::iterator  iter = data.find( key );
        if( iter == data.end() )
            return string( "NOT FOUND" );

        return iter->second;
    }
};




#define DATA_SIZE 1048576
int data[DATA_SIZE];


#endif //CPP_CU_TEST_BASETOOL_H
