//
//  ViewController.m
//  ViewArchitecture
//
//  Created by miniu on 15/6/8.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

// view controller代码规范的思考
// 要点：
//    1.所有的属性都使用getter和setter
//    2.viewDidLoad只做addSubView，viewWillAppear做布局的事情，viewDidAppear里面做Notification等监听之类的事情
//    3.代码块分配：先是life cycle，然后是Delegate方法实现，然后是event response，最后是getters和setters
//    4.event response专门开一个代码区域
//    5.每一个delegate都将协议名称写上，如：#pragma mark - UITableViewDelegate
//    6.正常情况下，ViewController是没有private methods
//
//
// 参考链接：
// http://casatwy.com/iosying-yong-jia-gou-tan-viewceng-de-zu-zhi-he-diao-yong-fang-an.html

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton * testButton;
@property (nonatomic, strong) UILabel * testLabel;

@end

@implementation ViewController

#pragma - life cycle
// 只做addSubViews
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.testButton];
    [self.view addSubview:self.testLabel];
}

// 做布局的事情
// 放在getter里？不好，布局放在一起才直观
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.testLabel.frame = CGRectMake(50, 50, 100, 100);
    self.testButton.frame = CGRectMake(200, 200, 100, 100);
}

// 其实在viewWillAppear这里改变UI元素不是很可靠，Autolayout发生在viewWillAppear之后，严格来说这里通常不做视图位置的修改，而用来更新Form数据。改变位置可以放在viewWilllayoutSubview或者didLayoutSubview里，而且在viewDidLayoutSubview确定UI位置关系之后设置autoLayout比较稳妥。另外，viewWillAppear在每次页面即将显示都会调用，viewWillLayoutSubviews虽然在lifeCycle里调用顺序在viewWillAppear之后，但是只有在页面元素需要调整时才会调用，避免了Constraints的重复添加。
// todo muyu 有待思考上面的话 ？？？
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

// 做Notification等监听消息
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_testButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
}

// event response 放在一起
#pragma - event response
- (void)buttonClicked {
    NSLog(@"button is click");
}

// getter和setter放在最后
#pragma - getters and setters
- (UIButton *)testButton {
    if (nil == _testButton) {
        _testButton = [[UIButton alloc] init];
        _testButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _testButton.titleLabel.textColor = [UIColor blackColor];
        _testButton.backgroundColor = [UIColor brownColor];
        [_testButton setTitle:@"Button" forState:UIControlStateNormal];
    }
    return _testButton;
}

- (UILabel *)testLabel {
    if (nil == _testLabel) {
        _testLabel = [[UILabel alloc] init];
        _testLabel.text = @"Label";
        _testLabel.font = [UIFont boldSystemFontOfSize:12];
        _testLabel.backgroundColor = [UIColor purpleColor];
        _testLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _testLabel;
}


@end
