//
//  main.m
//  DemoX
//
//  Created by miniu on 15/8/13.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#include <stdio.h>

//struct XXX {
//    int x;
//    struct XXX * y;
//};

typedef int (^blk_t)(int);


//blk_t func = ^(int rate) {
//    return rate * 10;
//};

int main()
{
    
    for (int rate = 0; rate < 10; rate++) {
        blk_t blk = ^(int count) {
            return rate * count;
        };
        printf("%d\n", blk(rate));
    }
    
//    struct XXX z = { 10, &z };
//    printf("z of value is %d %p %d %p", z.x, z.y, z.y->x, &z);
    
//    __block int value = 10;
//    void (^blk)(void) = ^{
//        value = 11;
//        printf("block %d\n", value);
//    };
//    blk();
    
    return 0;
}