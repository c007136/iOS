//
//  SuperViewController.m
//  Runtime
//
//  Created by muyu on 2018/11/28.
//  Copyright © 2018 miniu. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@", [self class]);
    NSLog(@"%@", [super class]);
}

@end



