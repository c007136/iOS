//
//  LoginViewController.m
//  ChuXichun
//
//  Created by miniu on 15/10/1.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UITextField            * textField;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.textField];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.textField.frame = CGRectMake((kWindowWidth-200)/2, 100, 200, 50);
}

- (void)textFieldChanged:(UITextField *)textField
{
    if ( textField.text.length == 4 )
    {
        if ([textField.text isEqualToString:@"8888"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            textField.text = @"";
        }
    }
}

- (UITextField *)textField
{
    if (nil == _textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"输入密码";
        _textField.secureTextEntry = YES;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [_textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField.layer.borderColor = [UIColor grayColor].CGColor;
        _textField.layer.borderWidth = 0.5;
    }
    return _textField;
}

@end
