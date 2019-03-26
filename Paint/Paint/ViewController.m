//
//  ViewController.m
//  Paint
//
//  Created by muyu on 2019/1/30.
//  Copyright © 2019 muyu. All rights reserved.
//

#import "ViewController.h"
#import "DrawPolygonView.h"
#import "BezierPathView.h"
#import "CoreGraphicsView.h"

@interface ViewController ()

@property (nonatomic, strong) DrawPolygonView *polygonView;
@property (nonatomic, strong) BezierPathView *bezierPathView;
@property (nonatomic, strong) CoreGraphicsView *coreGraphicsView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //[self.view addSubview:self.polygonView];
    //self.polygonView.frame = CGRectMake(0, 100, self.view.frame.size.width, 400);
    
//    [self.view addSubview:self.bezierPathView];
//    self.bezierPathView.frame = self.view.bounds;
    
    [self.view addSubview:self.coreGraphicsView];
    self.coreGraphicsView.frame = self.view.bounds;
}

- (DrawPolygonView *)polygonView
{
    if (_polygonView == nil) {
        _polygonView = [[DrawPolygonView alloc] init];
    }
    return _polygonView;
}

- (BezierPathView *)bezierPathView
{
    if (_bezierPathView == nil) {
        _bezierPathView = [[BezierPathView alloc] init];
    }
    return _bezierPathView;
}

- (CoreGraphicsView *)coreGraphicsView
{
    if (_coreGraphicsView == nil) {
        _coreGraphicsView = [[CoreGraphicsView alloc] init];
    }
    return _coreGraphicsView;
}

@end
