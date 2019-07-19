//
//  ViewController.m
//  WKWebviewDemo
//
//  Created by muyu on 2019/6/17.
//  Copyright © 2019 jkys. All rights reserved.
//

#import "ViewController.h"
#import "SailerViewController.h"
#import "UIWebviewViewController.h"

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
    if ([self.key isEqualToString:@"UIWebview"]) {
        NSString *urlString = dict[@"url"];
        UIWebviewViewController *vc = [[UIWebviewViewController alloc] init];
        vc.urlString = urlString;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([self.key isEqualToString:@"WKWebview"]) {
        NSString *urlString = dict[@"url"];
        SailerViewController *vc = [[SailerViewController alloc] init];
        vc.urlString = urlString;
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
                                @"title" : @"商城",
                                @"key" : @"shopping",
                                @"url" : @"https://static.91jkys.com/mall-wechat/build/www/shop/index.html#!/"
                                },
                            @{
                                @"title" : @"社区",
                                @"key" : @"community",
                                @"url" : @"https://static.mall-91jkys.com/community/dist/index.html#/"
                                },
                            @{
                                @"title" : @"百度",
                                @"key" : @"baidu",
                                @"url" : @"https://www.baidu.com"
                                },
                            @{
                                @"title" : @"VUE DEMO",
                                @"key" : @"VUE",
                                @"url" : @"http://static.qa.91jkys.com/collection/internetHospital/dist/testUrl/index.html"
                                },
                            @{
                                @"title" : @"Easy Demo",
                                @"key" : @"Easy",
                                @"url" : @"http://192.168.20.121/self/IOS_url_inteceptor.html"
                                },
                            ];
    }
    return _tableViewDatas;
}


@end
