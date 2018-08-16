//
//  BarChartViewController.m
//  ChartDemo
//
//  Created by muyu on 2018/8/15.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "BarChartViewController.h"
#import "ChartDemo-Bridging-Header.h"

@interface BarChartViewController ()
<
  IChartAxisValueFormatter
>

@property (nonatomic, strong) NSMutableArray *xAxisArray;

@property (nonatomic, strong) BarChartView *chartView;

@end

@implementation BarChartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.chartView];
    
    [self addCharData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.chartView.frame = CGRectMake(0, 100, self.view.frame.size.width, 150);
}

- (void)addCharData
{
    NSMutableArray *yValues = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 7; i++) {
        NSInteger x = arc4random() % 6;
        NSInteger y = arc4random() % 100;
        NSInteger value = x*100 + y;
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i+1 y:value];
        [yValues addObject:entry];
    }
    for (NSInteger i = 7; i < 30; i++) {
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i+1 y:0];
        [yValues addObject:entry];
    }
    
    BarChartDataSet *set1 = nil;
    set1 = [[BarChartDataSet alloc] initWithValues:yValues label:@"DataSet"];
    set1.colors = @[ [UIColor orangeColor] ];
    set1.drawValuesEnabled = NO;
    set1.axisDependency = AxisDependencyLeft;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    self.chartView.data = data;
    self.chartView.fitBars = YES;
    
    [self.chartView setNeedsDisplay];
    
//    return;
//    
//    NSMutableArray *yVals = [[NSMutableArray alloc] init];
//    
//    NSInteger count = 10;
//    NSInteger range = 100;
//    for (int i = 0; i < count; i++)
//    {
//        double mult = (range + 1);
//        double val = (double) (arc4random_uniform(mult)) + mult / 3.0;
//        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
//    }
//    
//    BarChartDataSet *set1 = nil;
//    if (self.chartView.data.dataSetCount > 0)
//    {
//        set1 = (BarChartDataSet *)self.chartView.data.dataSets[0];
//        set1.values = yVals;
//        [self.chartView.data notifyDataChanged];
//        [self.chartView notifyDataSetChanged];
//    }
//    else
//    {
//        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"DataSet"];
//        set1.colors = @[ [UIColor orangeColor] ];
//        set1.drawValuesEnabled = NO;
//        
//        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//        [dataSets addObject:set1];
//        
//        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
//        
//        self.chartView.data = data;
//        self.chartView.fitBars = YES;
//    }
//    
//    [self.chartView setNeedsDisplay];
}

//- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
//{
//    NSLog(@"value is %@", @(value));
//
//    for (NSString *string in self.xAxisArray) {
//        double stringValue = [string doubleValue];
//        if (stringValue == value) {
//            return string;
//        }
//    }
//
//    return @"";
//}

- (BarChartView *)chartView
{
    if (_chartView == nil) {
        _chartView = [[BarChartView alloc] init];
        _chartView.maxVisibleCount = 60;
        _chartView.pinchZoomEnabled = NO;
        _chartView.drawBarShadowEnabled = NO;
        _chartView.drawGridBackgroundEnabled = NO;
        _chartView.dragEnabled = NO;
        _chartView.legend.enabled = NO;
        _chartView.chartDescription.enabled = NO;
        _chartView.rightAxis.enabled = NO;
        _chartView.userInteractionEnabled = NO;
        _chartView.noDataText = @"暂无数据";
        //_chartView.
        
        _chartView.xAxis.labelPosition = XAxisLabelPositionBottom;
        _chartView.xAxis.drawGridLinesEnabled = NO;
        _chartView.xAxis.axisLineColor = [UIColor blueColor];
        //_chartView.xAxis.valueFormatter = self;
        //_chartView.xAxis.labelCount = 11;
        _chartView.xAxis.labelFont = [UIFont systemFontOfSize:10];
        ChartIndexAxisValueFormatter *formatter = [[ChartIndexAxisValueFormatter alloc] init];
        formatter.values = self.xAxisArray;
        _chartView.xAxis.valueFormatter = formatter;
        //_chartView.xAxis.granularity = 1;
        
        _chartView.leftAxis.axisLineColor = [UIColor blueColor];
        _chartView.leftAxis.drawGridLinesEnabled = NO;
        _chartView.leftAxis.axisMinimum = 0;
        _chartView.leftAxis.labelCount = 6;
    }
    return _chartView;
}

- (NSMutableArray *)xAxisArray
{
    if (_xAxisArray == nil) {
        _xAxisArray = [[NSMutableArray alloc] init];
        
        [_xAxisArray addObject:@"1"];
        [_xAxisArray addObject:@"3"];
        [_xAxisArray addObject:@"6"];
        [_xAxisArray addObject:@"9"];
        [_xAxisArray addObject:@"12"];
        [_xAxisArray addObject:@"15"];
        [_xAxisArray addObject:@"18"];
        [_xAxisArray addObject:@"21"];
        [_xAxisArray addObject:@"24"];
        [_xAxisArray addObject:@"27"];
        [_xAxisArray addObject:@"30"];
    }
    return _xAxisArray;
}

@end
