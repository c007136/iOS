//
//  ViewController.m
//  SQLInjection
//
//  Created by muyu on 2018/8/7.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "ViewController.h"
#import <MCCategory/UIView+MCFrame.h>
#import <FMDB.h>
#import <UIViewController+ZBToastHUD.h>

@interface ViewController ()

@property (nonatomic, strong) NSString *dbPath;
@property (nonatomic, strong) FMDatabase *db;

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *doneButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.doneButton];
    
    [self p_createTable];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.nameTextField.frame = CGRectMake(12, 80, self.view.width-24, 48);
    self.passwordTextField.frame = CGRectMake(12, self.nameTextField.bottom+20, self.nameTextField.width, 48);
    self.doneButton.frame = CGRectMake(12, self.passwordTextField.bottom+40, self.nameTextField.width, 48);
}

- (void)buttonClick
{
    if (self.nameTextField.text.length == 0) {
        return;
    }
    
    // name 输入： muyu1' or '1=1
    // password 不用输入
    NSString *sql = [NSString stringWithFormat:@"select * from `test` where name = '%@' and password = '%@'", self.nameTextField.text, self.passwordTextField.text];
    FMResultSet *resultSet = [self.db executeQuery:sql];
    if ([resultSet next])
    {
        [self zb_showWithMessage:@"登录成功"];
    }
    else
    {
        [self zb_showWithMessage:@"登录失败"];
    }
}

- (void)p_createTable
{
    NSString *sqlString = [NSString stringWithFormat:
                           @"CREATE TABLE IF NOT EXISTS %@          \
                           (%@ INTEGER primary key autoincrement,   \
                           %@ TEXT,                                 \
                           %@ TEXT                                  \
                           )", @"test", @"id", @"name", @"password"];
    if ([self.db executeUpdate:sqlString])
    {
        NSLog(@"ME create table success");
    }
    else
    {
        NSLog(@"ME create table failed error : %@", [self.db lastError]);
        [self p_destoryDB];
    }
    
    //[self p_insertTable];
}

- (void)p_insertTable
{
    NSString *sql = [NSString stringWithFormat:@"insert into `test` (name, password) values ('%@', '%@')", @"muyu1", @"muyu1"];
    [self.db executeUpdate:sql];
    
    sql = [NSString stringWithFormat:@"insert into `test` (name, password) values ('%@', '%@')", @"muyu2", @"muyu2"];
    [self.db executeUpdate:sql];
}

- (void)p_destoryDB
{
    [self.db close];
    self.db = nil;
}

- (NSString *)dbPath
{
    if (_dbPath == nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        _dbPath = [NSString stringWithFormat:@"%@/test.sqlite", documentsPath];
    }
    return _dbPath;
}

- (FMDatabase *)db
{
    if (_db == nil) {
        _db = [FMDatabase databaseWithPath:self.dbPath];
        
        if (![_db open]) {
            [self p_destoryDB];
            NSLog(@"db open failed error is %@", [_db lastError]);
        }
    }
    return _db;
}

- (UITextField *)nameTextField
{
    if (_nameTextField == nil) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.backgroundColor = [UIColor whiteColor];
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTextField.textColor = [UIColor blackColor];
        _nameTextField.font = [UIFont systemFontOfSize:15];
    }
    return _nameTextField;
}

- (UITextField *)passwordTextField
{
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.backgroundColor = [UIColor whiteColor];
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.textColor = [UIColor blackColor];
        _passwordTextField.font = [UIFont systemFontOfSize:15];
    }
    return _passwordTextField;
}

- (UIButton *)doneButton
{
    if (_doneButton == nil) {
        _doneButton = [[UIButton alloc] init];
        _doneButton.backgroundColor = [UIColor orangeColor];
        [_doneButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}


@end
