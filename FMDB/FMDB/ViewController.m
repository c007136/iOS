//
//  ViewController.m
//  FMDB
//
//  Created by muyu on 2017/2/24.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "ViewController.h"
#import <FMDB.h>

static const NSInteger aa = 10;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    if (![db open])
    {
        db = nil;
        NSLog(@"db open failed");
    }
    
    NSLog(@"db open successed");
}


@end
