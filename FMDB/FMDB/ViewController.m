//
//  ViewController.m
//  FMDB
//
//  Created by muyu on 2017/2/24.
//  Copyright © 2017年 muyu. All rights reserved.
//
//  char varchar text的区别：
//  http://www.cnblogs.com/billyxp/p/3548540.html

#import "ViewController.h"
#import <FMDB.h>

@interface ViewController ()

@property (nonatomic, copy) NSString *dbPath;
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self p_createTable];
    
    [self queueInTransactionDemo];
}

- (void)dealloc
{
    [self p_destoryDB];
}

#pragma mark - demo

- (void)insertDBDemo
{
    NSString *sql = @"INSERT INTO student (uid, name, grade) VALUES ('0407001', 'zhangsan', '90')";
    BOOL b = [self.db executeUpdate:sql];
    if (b)
    {
        NSLog(@"insert demo success");
    }
    else
    {
        NSLog(@"insert demo failed %@", [self.db lastError]);
    }
}

- (void)deleteDBDemo
{
    NSString *sql = @"DELETE FROM student WHERE uid = '0407001'";
    BOOL b = [self.db executeUpdate:sql];
    if (b)
    {
        NSLog(@"delete demo success");
    }
    else
    {
        NSLog(@"delete demo failed %@", [self.db lastError]);
    }
}

- (void)queueInDatabaseDemo
{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        NSString *sql = @"INSERT INTO student (uid, name, grade) VALUES ('0407001', '张三', '90')";
        [db executeUpdate:sql];
        
        sql = @"INSERT INTO student (uid, name, grade) VALUES ('0407002', '李四', '80')";
        [db executeUpdate:sql];
        
        sql = @"INSERT INTO student (uid, name, grade) VALUES ('0407003', '王五', '70')";
        [db executeUpdate:sql];
        
        sql = @"INSERT INTO student (uid, name, grade) VALUES ('0407004', '赵六', '75')";
        [db executeUpdate:sql];
    }];
}

- (void)queueInTransactionDemo
{
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        BOOL b = NO;
        NSInteger count = 0;
        
        NSString *sql = @"INSERT INTO student (uid, name, grade) VALUES ('0307001', '张三', '90')";
        b = [db executeUpdate:sql];
        count = b ? count : count+1;
        
        sql = @"INSERT INTO student (uid, name, grade) VALUES ('0307002', '李四', '80')";
        b = [db executeUpdate:sql];
        count = b ? count : count+1;
        
        // 错误的数据库语句
        sql = @"INSERT INTO student VALUES ('0307003', '王五', '70')";
        b = [db executeUpdate:sql];
        count = b ? count : count+1;
        
        sql = @"INSERT INTO student (uid, name, grade) VALUES ('0307004', '赵六', '75')";
        b = [db executeUpdate:sql];
        count = b ? count : count+1;
        
        if (count > 0) {
            *rollback = YES;
            NSLog(@"something is wrong: %@", [db lastErrorMessage]);
        } else {
            NSLog(@"all done");
        }
    }];
}

// 索引的例子
// http://blog.51cto.com/zt/376
// http://4925054.blog.51cto.com/4915054/1097107
// http://zh.sqlzoo.net/
- (void)dbIndexDemo
{
    
}

#pragma mark - private method

- (void)p_createTable
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS student (id INTEGER primary key autoincrement, uid char(10), name TEXT, grade TEXT)";
    BOOL b = [self.db executeUpdate:sql];
    if (!b)
    {
        NSLog(@"create table failed %@", [self.db lastError]);
        [self p_destoryDB];
    }
    else
    {
        NSLog(@"create table success");
    }
}

- (void)p_destoryDB
{
    [self.db close];
    self.db = nil;
}

#pragma mark - getter and setter

- (NSString *)dbPath
{
    if (_dbPath == nil) {
        _dbPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.db"];
    }
    return _dbPath;
}

- (FMDatabase *)db
{
    if (_db == nil) {
        NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.db"];
        _db = [FMDatabase databaseWithPath:path];
        
        if (![_db open]) {
            _db = nil;
            NSLog(@"db open failed");
        }
    }
    return _db;
}

- (FMDatabaseQueue *)dbQueue
{
    if (_dbQueue == nil) {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    }
    return _dbQueue;
}

@end
