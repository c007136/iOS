//
//  ViewController.m
//  Operation
//
//  Created by miniu on 15/7/16.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "ViewController.h"

#define kURL @"http://avatar.csdn.net/2/C/D/1_totogo2010.jpg"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInvocationOperation * operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:kURL];
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

    NSLog(@"count is %d...", queue.maxConcurrentOperationCount);
}

- (void)downloadImage:(NSString *)urlString
{
    NSURL * url = [NSURL URLWithString:urlString];
    NSData * data = [[NSData alloc] initWithContentsOfURL:url];   // 下载数据
    UIImage * image = [[UIImage alloc] initWithData:data];
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
}

- (void)updateUI:(UIImage *)image
{
    self.imageView.image = image;
}

@end
