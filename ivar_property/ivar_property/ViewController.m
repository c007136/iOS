//
//  ViewController.m
//  ivar_property
//
//  Created by miniu on 15/6/12.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

//  赋值、浅拷贝、深拷贝的区别
//  参考链接：
//  http://segmentfault.com/q/1010000002396647/a-1020000002397371
//
//  ivar 和 property
//  http://segmentfault.com/q/1010000000185056
//  http://stackoverflow.com/questions/9086736/why-would-you-use-an-ivar
//
//  strong ptr 和 weak ptr
//  http://blog.csdn.net/q199109106q/article/details/8565017
//  强指针和弱指针的实现 可参考android的实现方式
//  http://blog.csdn.net/luoshengyang/article/details/6786239

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray * _mArray;
    
    NSString * _strongText;
    __weak NSString * _weakText;
}

@property (assign, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (id)initWithArray: (NSMutableArray *)mArray {
    self = [super init];
    if (self) {
        _mArray = mArray;  // 指针赋值，即不是深拷贝，也不是浅拷贝
        NSLog(@"mArray in ViewController is %p----%lu %@ ", _mArray, [_mArray retainCount], _mArray);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSInteger i = 0; i < _mArray.count; i++) {
        NSString * string = [_mArray objectAtIndex:i];
        NSLog(@"string in array in ViewController is %p----%@", string, string);
    }
    
    NSArray * arrayShallow = [_mArray copy];
    for (NSInteger i = 0; i < arrayShallow.count; i++) {
        NSString * string = [arrayShallow objectAtIndex:i];
        NSLog(@"string in arrayShallow in ViewController is %p----%@", string, string);
    }
    
    // 不要被骗了，这是浅拷贝
    NSArray * arrayDeep = [_mArray mutableCopy];
    for (NSInteger i = 0; i < arrayDeep.count; i++) {
        NSString * string = [arrayDeep objectAtIndex:i];
        NSLog(@"string in arrayDeep in ViewController is %p----%@", string, string);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _textField.text = @"mj";
    
    _strongText = _textField.text;
    _weakText = _textField.text;
    
    NSLog(@"textField's text ptr is %p --- mj ptr is %p --- strong ptr is %p --- weak ptr is %p in viewWillAppear", _textField.text, @"mj", _strongText, _weakText);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonClick:(id)sender {
    
    // 理解不来？？？ _weakText不为空 ？
    NSLog(@"strong ptr is %p --- weak ptr is %p in buttonClick", _strongText, _weakText);
    
    _strongText = _textField.text;
    NSLog(@"strongText is %@ --- ptr is %p", _strongText, _strongText);
    
    _weakText = _textField.text;
    NSLog(@"weakText is %@ --- ptr is %p", _weakText, _weakText);
    
}

- (IBAction)textFieldEditingChanged:(id)sender {
    
    //NSLog(@"strong ptr is %p --- weak ptr is %p", _strongText, _weakText);
    
}

@end
