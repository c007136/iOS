//
//  ViewController.m
//  Shaking
//
//  Created by muyu on 2019/6/25.
//  Copyright © 2019 muyu. All rights reserved.
//
// 连续震动
// https://wy19921005.iteye.com/blog/2379104

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>


void soundCompleteCallback(SystemSoundID sound, void * clientData) {
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);  //震动
//    AudioServicesPlaySystemSound(sound);
}


@interface ViewController ()
<
  UITableViewDelegate,
  UITableViewDataSource
>

@property (nonatomic, assign) SystemSoundID sound;
@property (nonatomic, strong) NSTimer *timer;

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
    if ([key isEqualToString:@"start"])
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"voip_default_call" ofType:@"caf"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &_sound);
        AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, soundCompleteCallback, NULL);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(self.sound);
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playVibrate) userInfo:nil repeats:YES];
    }
    else if ([key isEqualToString:@"stop"])
    {
        NSLog(@"....stop....");
        [self.timer invalidate];
        AudioServicesDisposeSystemSoundID(self.sound);
        AudioServicesRemoveSystemSoundCompletion(self.sound);
        NSLog(@"sound is is %@", @(self.sound));
    }
}

- (void)playVibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
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
                                @"title" : @"开始震动",
                                @"key" : @"start",
                                },
                            @{
                                @"title" : @"暂停震动",
                                @"key" : @"stop",
                                },
                            ];
    }
    return _tableViewDatas;
}

@end
