//
//  LineChartViewController.m
//  ChartDemo
//
//  Created by muyu on 2018/8/15.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "LineChartViewController.h"
#import "ChartDemo-Bridging-Header.h"

@interface LineChartViewController ()
<
  IChartAxisValueFormatter
>

@property (nonatomic, assign) NSInteger dataCount;
@property (nonatomic, strong) LineChartView *chartView;
@property (nonatomic, strong) UILabel *time1Label;
@property (nonatomic, strong) UILabel *time2Label;
@property (nonatomic, strong) UILabel *time3Label;
@property (nonatomic, strong) UILabel *time4Label;


@property (nonatomic, strong) NSMutableArray *xAxisArray;

@end

@implementation LineChartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.chartView];
    [self.view addSubview:self.time1Label];
    [self.view addSubview:self.time2Label];
    [self.view addSubview:self.time3Label];
    [self.view addSubview:self.time4Label];
    
    self.dataCount = 26;
    [self addCharData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat width = self.view.frame.size.width;
    self.chartView.frame = CGRectMake(0, 100, width, 150);
    self.time1Label.frame = CGRectMake(40, 100+125, 60, 20);
    self.time2Label.frame = CGRectMake(width*2/5, 100+135, 60, 20);
    self.time3Label.frame = CGRectMake(width*3/5, 100+135, 60, 20);
    self.time4Label.frame = CGRectMake(width-50, 100+135, 60, 20);
}

- (void)addCharData
{
    NSMutableArray *yValues = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.dataCount; i++) {
        NSInteger x = arc4random() % 6;
        NSInteger y = arc4random() % 100;
        NSInteger value = x*100 + y;
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:value];
        [yValues addObject:entry];
    }
    for (NSInteger i = self.dataCount; i < 4; i++) {
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:0];
        [yValues addObject:entry];
    }
    
    LineChartDataSet *set1 = nil;
    set1 = [[LineChartDataSet alloc] initWithValues:yValues label:@"DataSet 1"];
    set1.drawIconsEnabled = NO;
    set1.colors = @[ [UIColor orangeColor] ];
    set1.drawCirclesEnabled = NO;
    set1.drawValuesEnabled = NO;
    set1.valueFont = [UIFont systemFontOfSize:10];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    self.chartView.data = data;
    
    [self.chartView setNeedsDisplay];
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    return @"";
}

- (LineChartView *)chartView
{
    if (_chartView == nil) {
        _chartView = [[LineChartView alloc] init];
        _chartView.backgroundColor = [UIColor lightGrayColor];
        _chartView.maxVisibleCount = 120;
        _chartView.pinchZoomEnabled = NO;
        _chartView.drawGridBackgroundEnabled = NO;
        _chartView.dragEnabled = NO;
        _chartView.legend.enabled = NO;
        _chartView.chartDescription.enabled = NO;
        _chartView.rightAxis.enabled = NO;
        _chartView.userInteractionEnabled = NO;
        _chartView.noDataText = @"暂无数据";
        
        _chartView.xAxis.labelPosition = XAxisLabelPositionBottom;
        _chartView.xAxis.drawGridLinesEnabled = NO;
        _chartView.xAxis.axisLineColor = [UIColor blueColor];
        _chartView.xAxis.drawLabelsEnabled = YES;
        _chartView.xAxis.valueFormatter = self;
        _chartView.xAxis.labelCount = 4;
        _chartView.xAxis.labelFont = [UIFont systemFontOfSize:10];
        
        _chartView.leftAxis.axisLineColor = [UIColor blueColor];
        _chartView.leftAxis.drawGridLinesEnabled = NO;
        _chartView.leftAxis.axisMinimum = 0;
        _chartView.leftAxis.labelCount = 6;
    }
    return _chartView;
}

- (UILabel *)time1Label
{
    if (_time1Label == nil) {
        _time1Label = [[UILabel alloc] init];
        _time1Label.textColor = [UIColor blackColor];
        _time1Label.text = @"10:11";
        _time1Label.font = [UIFont systemFontOfSize:11];
    }
    return _time1Label;
}

- (UILabel *)time2Label
{
    if (_time2Label == nil) {
        _time2Label = [[UILabel alloc] init];
        _time2Label.textColor = [UIColor blackColor];
        _time2Label.text = @"20";
        _time2Label.font = [UIFont systemFontOfSize:11];
    }
    return _time2Label;
}

- (UILabel *)time3Label
{
    if (_time3Label == nil) {
        _time3Label = [[UILabel alloc] init];
        _time3Label.textColor = [UIColor blackColor];
        _time3Label.text = @"40";
        _time3Label.font = [UIFont systemFontOfSize:11];
    }
    return _time3Label;
}

- (UILabel *)time4Label
{
    if (_time4Label == nil) {
        _time4Label = [[UILabel alloc] init];
        _time4Label.textColor = [UIColor blackColor];
        _time4Label.text = @"11:11";
        _time4Label.font = [UIFont systemFontOfSize:11];
    }
    return _time4Label;
}

- (NSMutableArray *)xAxisArray
{
    if (_xAxisArray == nil) {
        _xAxisArray = [[NSMutableArray alloc] init];
    }
    return _xAxisArray;
}

@end
