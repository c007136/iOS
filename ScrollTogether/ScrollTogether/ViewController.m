//
//  ViewController.m
//  ScrollTogether
//
//  Created by miniu on 15/9/25.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  研究怎么让多个scrollView一起滑动
//
//  方法一 在代理scrollViewDidScroll判断哪个scrollView滑动了，其他的跟着滑动
//  缺点：需要每个scrollView都处理
//
//  方法二 用手势解决
//  重点代码：[self.view addGestureRecognizer:self.scrollViewA.panGestureRecognizer];
//  缺点：速度不好控制
//
//  方法三 创建一个大的scrollView覆盖在小的上面，
//  在代理scrollViewDidScroll中处理小的scrollview跟着滑动，
//  注：最佳方法

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView         * scrollViewA;
@property (nonatomic, strong) UIScrollView         * scrollViewB;
@property (nonatomic, strong) UIScrollView         * scrollViewC;

@property (nonatomic, strong) UIPanGestureRecognizer * panGestureRecognizer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollViewA];
    [self.view addSubview:self.scrollViewB];
    //[self.view addSubview:self.scrollViewC];
    
    self.scrollViewA.frame = CGRectMake(0, 50, self.view.frame.size.width, 100);
    self.scrollViewB.frame = CGRectMake(0, 180, self.view.frame.size.width, 100);
    self.scrollViewC.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    for (int i = 0; i < 10; i++) {
        UILabel * labelA = [[UILabel alloc] init];
        labelA.backgroundColor = [UIColor grayColor];
        labelA.font = [UIFont systemFontOfSize:16.0];
        labelA.textColor = [UIColor blackColor];
        labelA.frame = CGRectMake(50*i, 0, 48, 100);
        labelA.text = [NSString stringWithFormat:@"%d", i];
        [self.scrollViewA addSubview:labelA];
        
        UILabel * labelB = [[UILabel alloc] init];
        labelB.backgroundColor = [UIColor grayColor];
        labelB.font = [UIFont systemFontOfSize:16.0];
        labelB.textColor = [UIColor blackColor];
        labelB.frame = CGRectMake(50*i, 0, 48, 100);
        labelB.text = [NSString stringWithFormat:@"%d", i];
        [self.scrollViewB addSubview:labelB];
    }
    
    self.scrollViewA.contentSize = CGSizeMake(500, 100);
    self.scrollViewB.contentSize = CGSizeMake(500, 100);
    self.scrollViewC.contentSize = CGSizeMake(500, self.view.frame.size.height);
}

- (void)viewDidAppear:(BOOL)animated
{
    //[self.view addGestureRecognizer:self.panGestureRecognizer];
    
    [self.view addGestureRecognizer:self.scrollViewA.panGestureRecognizer];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([scrollView isEqual:self.scrollViewA])
    {
        CGPoint offset = self.scrollViewB.contentOffset;
        offset.x = self.scrollViewA.contentOffset.x;
        [self.scrollViewB setContentOffset:offset];
    }
    
//    else if ([scrollView isEqual:self.scrollViewB])
//    {
//        CGPoint offset = self.scrollViewA.contentOffset;
//        offset.x = self.scrollViewB.contentOffset.x;
//        [self.scrollViewA setContentOffset:offset];
//        [self.scrollViewC setContentOffset:offset];
//    }
//    if ([scrollView isEqual:self.scrollViewC])
//    {
//        //CGPoint offset = self.scrollViewA.contentOffset;
//        //offset.x = self.scrollViewC.contentOffset.x;
//        
//        CGPoint offset = self.scrollViewC.contentOffset;
//        [self.scrollViewA setContentOffset:offset];
//        [self.scrollViewB setContentOffset:offset];
//    }
}

#pragma mark - UIGestureRecognizerDelegate
- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if ( UIGestureRecognizerStateBegan == gesture.state )
    {
    }
    else if ( UIGestureRecognizerStateChanged == gesture.state )
    {
        CGPoint translation = [gesture translationInView:self.view];
        CGPoint offset = CGPointMake(-translation.x/2, 0);
        offset.x = self.scrollViewA.contentOffset.x + offset.x;
        if (offset.x < 0) {
            offset.x = 0;
        }
        if (offset.x > self.scrollViewA.contentSize.width-self.scrollViewA.frame.size.width) {
            offset.x = self.scrollViewA.contentSize.width-self.scrollViewA.frame.size.width;
        }
        [self.scrollViewA setContentOffset:offset];
        [self.scrollViewB setContentOffset:offset];
        
        NSLog(@"translation x is %lf, offset x is %lf, scrollView contentOffset x is %lf", translation.x, offset.x, self.scrollViewA.contentOffset.x);
    }
}

#pragma mark - getter and setter
- (UIScrollView *)scrollViewA
{
    if (nil == _scrollViewA) {
        _scrollViewA = [[UIScrollView alloc] init];
        _scrollViewA.backgroundColor = [UIColor redColor];
        _scrollViewA.delegate = self;
        _scrollViewA.bounces = NO;
        _scrollViewA.scrollEnabled = YES;
    }
    return _scrollViewA;
}

- (UIScrollView *)scrollViewB
{
    if (nil == _scrollViewB) {
        _scrollViewB = [[UIScrollView alloc] init];
        _scrollViewB.backgroundColor = [UIColor yellowColor];
        _scrollViewB.delegate = self;
        _scrollViewB.bounces = NO;
        _scrollViewB.scrollEnabled = YES;
    }
    return _scrollViewB;
}

- (UIScrollView *)scrollViewC
{
    if (nil == _scrollViewC) {
        _scrollViewC = [[UIScrollView alloc] init];
        _scrollViewC.backgroundColor = [UIColor clearColor];
        _scrollViewC.delegate = self;
        _scrollViewC.bounces = NO;
        _scrollViewC.showsHorizontalScrollIndicator = NO;
        //_scrollViewC.scrollEnabled = NO;
    }
    return _scrollViewC;
}

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    if (nil == _panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        _panGestureRecognizer.delegate = self;
    }
    return _panGestureRecognizer;
}

@end
