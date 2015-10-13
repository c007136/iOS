//
//  ViewController.m
//  AttributedString
//
//  Created by miniu on 15/7/30.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  参考链接：
//  http://www.starfelix.com/blog/2014/07/20/ru-he-zai-ios5yi-shang-de-xi-tong-du-shi-yong-nsattributedstring/
//  http://blog.csdn.net/zhangao0086/article/details/7616385

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel          * textLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.textLabel];
    self.textLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, 50);
}

#pragma mark - getter and setter
- (UILabel *)textLabel
{
    if (nil == _textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor lightGrayColor];
        _textLabel.font = [UIFont systemFontOfSize:15.0f];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor redColor];
    }
    return _textLabel;
}

@end
