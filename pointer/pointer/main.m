//
//  main.m
//  pointer
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  Objective-C下的二级指针
//  参考链接：
//  http://blog.csdn.net/kevinpake/article/details/17058965

#import <Foundation/Foundation.h>

NSString * _globalString = nil;

void changeStringValue(NSString ** string) {
    
    // 参数 string： pointer of pointer
    // 参数 *string: pointer
    NSLog(@"pointer of pointer is : %p--%p", string, *string);
    *string = [NSString stringWithFormat:@"456"];//@"123";
}

// 参考链接：
// http://www.fenesky.com/blog/2014/07/03/pointers-to-pointers.html
void increase(int ** p)
{
    NSLog(@"in increase function count is: %d--%p--%p", **p, *p, p);
    
    // 值＋1
    **p = **p + 7;
    // 指针指＝NULL
    *p = NULL;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString * string = [NSString stringWithFormat:@"123"];//@"456"
        NSLog(@"%@--%p--%p", string, string, &string);
        changeStringValue( &string );
        NSLog(@"%@--%p--%p", string, string, &string);
        
        //
        int count = 7;
        int * p = NULL;
        p = &count;
        NSLog(@"in main count is %p---%p---%p", &count, p, &p);
        increase( &p );
        NSLog(@"in main count is %d---%p---%p", count, p, &p);
    }
    return 0;
}
