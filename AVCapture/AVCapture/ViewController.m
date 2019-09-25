//
//  ViewController.m
//  AVCapture
//
//  Created by muyu on 2019/8/27.
//  Copyright © 2019 muyu. All rights reserved.
//

#import "ViewController.h"
#import "CaptureViewController.h"
#import "FlyViewController.h"
#import "DlibViewController.h"
#import "BaiduViewController.h"
#import "FaceParameterConfig.h"
#import <IDLFaceSDK/IDLFaceSDK.h>

@interface ViewController ()
<
  UITableViewDelegate,
  UITableViewDataSource
>

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
    if ([key isEqualToString:@"capture"])
    {
        CaptureViewController *vc = [[CaptureViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([key isEqualToString:@"fly"])
    {
        FlyViewController *vc = [[FlyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([key isEqualToString:@"dlib"])
    {
        DlibViewController *vc = [[DlibViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([key isEqualToString:@"baidu"])
    {
        [[IDLFaceLivenessManager sharedInstance] livenesswithList:@[] order:NO numberOfLiveness:0];
        
        BaiduViewController *vc = [[BaiduViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
                                @"title" : @"捕捉视频",
                                @"key" : @"capture",
                                },
                            @{
                                @"title" : @"科大讯飞",
                                @"key" : @"fly",
                                },
                            @{
                                @"title" : @"DLib",
                                @"key" : @"dlib",
                                },
                            @{
                                @"title" : @"百度AI",
                                @"key" : @"baidu",
                                },
                            ];
    }
    return _tableViewDatas;
}

@end
