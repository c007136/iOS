//
//  ViewController.m
//  NSCalendar
//
//  Created by muyu on 2017/10/30.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *nowDate = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday fromDate:nowDate];
    NSLog(@"year : %@", @(components.year));
    NSLog(@"month : %@", @(components.month));
    NSLog(@"weekday:%@", @(components.weekday));
}

@end
