//
//  ViewController.m
//  Timestamp
//
//  Created by muyu on 2018/9/13.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self maxTimestamp];
}


// 时区不同，时间戳始终一致
- (void)differentTimeZoneSameTimestamp
{
    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
    NSLog(@"系统当前的时区: %@",  timeZone.name);
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSLog(@"当前时间戳:%f", timeInterval);
}

// 在不同时区下，时间戳转成时间字符串
- (void)timestampToTimeString
{
    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
    NSLog(@"系统当前的时区: %@",  timeZone.name);
    
    NSTimeInterval timeInterval = 1536806089;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    NSLog(@"timeString is %@", timeString);
}

// 时间戳的最大值
- (void)maxTimestamp
{
    // 最大值在这个范围10^14 - 2*10^14
    //
    // 3170843-11-07 17:46:40
    long long timeInterval = 100000000000000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    NSLog(@"timeString is %@", timeString);
}

// ISO 8601标准时间转换成当地时间
- (void)ISO8601ToTimeString
{
    NSString *timeTEXT = @"2017-06-08T11:29:29.209Z";
    NSString *formateTEXT =  @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formateTEXT];
    
    // 获取当前对应时区的时间
    NSDate *curDate = [dateFormatter dateFromString:timeTEXT];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *timeString = [formatter stringFromDate:curDate];
    NSLog(@"timeString is %@", timeString);
}

@end
