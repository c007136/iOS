//
//  ViewController.m
//  Sqlite
//
//  Created by muyu on 2019/8/14.
//  Copyright © 2019 muyu. All rights reserved.
//
//  WAL模式原理
//  https://www.cnblogs.com/cchust/p/4754619.html
//
//  SQLite在多线程环境下的应用
//  https://www.keakon.net/2011/10/25/SQLite%E5%9C%A8%E5%A4%9A%E7%BA%BF%E7%A8%8B%E7%8E%AF%E5%A2%83%E4%B8%8B%E7%9A%84%E5%BA%94%E7%94%A8
//  https://www.cnblogs.com/jaejaking/p/5383403.html

//  exec step
//  多线程
//  wal模式

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()
<
  UITableViewDelegate,
  UITableViewDataSource
>

@property (nonatomic, unsafe_unretained) sqlite3 *database;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableViewDatas;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    
    NSString *pathString = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    pathString = [pathString stringByAppendingString:@"/school.sqlite"];
    const char *path = [pathString UTF8String];
    int result = sqlite3_open_v2(path, &_database, SQLITE_OPEN_CREATE|SQLITE_OPEN_READWRITE|SQLITE_OPEN_NOMUTEX|SQLITE_OPEN_SHAREDCACHE, NULL);
    if (result != SQLITE_OK) {
        NSString *sqliteErrorString = [NSString stringWithCString:sqlite3_errmsg(self.database) encoding:NSUTF8StringEncoding];
        NSLog(@"sqliteErrorString is %@", sqliteErrorString);
    }
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *dict = self.tableViewDatas[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.tableViewDatas[indexPath.row];
    NSString *key = dict[@"key"];
    if ([key isEqualToString:@"wal_mode"])
    {
        NSString *sql = @"PRAGMA journal_mode=WAL;";
        [self p_execWithSqlString:sql];
    }
    else if ([key isEqualToString:@"delete_mode"])
    {
        NSString *sql = @"PRAGMA journal_mode=DELETE;";
        [self p_execWithSqlString:sql];
    }
    else if ([key isEqualToString:@"create_table"])
    {
        NSString *sql = @"CREATE TABLE schlool_table (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(255));";
        [self p_execWithSqlString:sql];
    }
    else if ([key isEqualToString:@"insert_table"])
    {
        NSInteger value = arc4random() % 100000;
        NSString *name = [NSString stringWithFormat:@"%@", @(value)];
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO schlool_table (name) VALUES ('%@')", name];
        [self p_execWithSqlString:sql];
    }
}

#pragma mark - Private Metho

- (void)p_execWithSqlString:(NSString *)sqlString
{
    sqlite3_stmt *statement = NULL;
    int result = sqlite3_prepare_v2(self.database, [sqlString UTF8String], -1, &statement, NULL);
    if (result != SQLITE_OK) {
        NSString *sqliteErrorString = [NSString stringWithCString:sqlite3_errmsg(self.database) encoding:NSUTF8StringEncoding];
        NSLog(@"sqlString is %@ sqliteErrorString is %@", sqlString, sqliteErrorString);
        sqlite3_finalize(statement);
        statement = nil;
        return;
    }
    
    result = sqlite3_step(statement);
    if (result != SQLITE_DONE) {
        NSString *sqliteErrorString = [NSString stringWithCString:sqlite3_errmsg(self.database) encoding:NSUTF8StringEncoding];
        NSLog(@"sqlString is %@ sqliteErrorString is %@", sqlString, sqliteErrorString);
        sqlite3_finalize(statement);
        statement = nil;
        return;
    }
    
    sqlite3_finalize(statement);
    statement = nil;
}

#pragma mark - Getter

- (UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor grayColor];
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

- (NSArray *)tableViewDatas
{
    if (_tableViewDatas == nil) {
        _tableViewDatas = @[
                            @{
                                @"title" : @"打开数据库",
                                @"key" : @"create",
                                },
                            @{
                                @"title" : @"WAL模式",
                                @"key" : @"wal_mode",
                                },
                            @{
                                @"title" : @"DELETE模式",
                                @"key" : @"delete_mode",
                                },
                            @{
                                @"title" : @"创建表",
                                @"key" : @"create_table",
                                },
                            @{
                                @"title" : @"插入数据",
                                @"key" : @"insert_table",
                                },
                            ];
    }
    return _tableViewDatas;
}


@end
