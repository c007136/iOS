//
//  ViewController.m
//  Runloop
//
//  Created by muyu on 2019/8/21.
//  Copyright © 2019 muyu. All rights reserved.
//
//  iOS Runloop详解
//  https://juejin.im/entry/587c2c4ab123db005df459a1
//  深入理解Runloop
//  https://blog.ibireme.com/2015/05/18/runloop/

#import "ViewController.h"
#import "ROperation.h"
#import "RTask1.h"
#import "RTask2.h"

@interface ViewController ()
<
  UITableViewDelegate,
  UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableViewDatas;

@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSMutableArray *taskArray;
@property (nonatomic, assign) NSInteger taskId;
@property (nonatomic, strong) Task *currentTask;

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
    if ([key isEqualToString:@"base"])
    {
        // 基本概要
        // 就是一个do...while循环
        // 主线程默认打开，子线程默认关闭
    }
    else if ([key isEqualToString:@"thread"])
    {
        self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadStart) object:nil];
        [self.thread start];
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(taskTimerFire) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    else if ([key isEqualToString:@"task1"])
    {
        RTask1 *task1 = [[RTask1 alloc] init];
        self.taskId++;
        task1.dataDict = @{
                           @"id" : @(self.taskId),
                           @"value" : @"task1",
                           };
        [self.taskArray addObject:task1];
    }
    else if ([key isEqualToString:@"task2"])
    {
        RTask2 *task2 = [[RTask2 alloc] init];
        self.taskId++;
        task2.dataDict = @{
                           @"id" : @(self.taskId),
                           @"value" : @"task2",
                           };
        [self.taskArray addObject:task2];
    }
    else if ([key isEqualToString:@"timer"])
    {
        // [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(show) userInfo:nil repeats:YES];
        NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
        // 加入到RunLoop中才可以运行
        // 1. 把定时器添加到RunLoop中，并且选择默认运行模式NSDefaultRunLoopMode = kCFRunLoopDefaultMode
        // [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        // 当textFiled滑动的时候，timer失效，停止滑动时，timer恢复
        // 原因：当textFiled滑动的时候，RunLoop的Mode会自动切换成UITrackingRunLoopMode模式，因此timer失效，当停止滑动，RunLoop又会切换回NSDefaultRunLoopMode模式，因此timer又会重新启动了
        
        // 2. 当我们将timer添加到UITrackingRunLoopMode模式中，此时只有我们在滑动textField时timer才会运行
        // [[NSRunLoop mainRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
        
        // 3. 那个如何让timer在两个模式下都可以运行呢？
        // 3.1 在两个模式下都添加timer 是可以的，但是timer添加了两次，并不是同一个timer
        // 3.2 使用站位的运行模式 NSRunLoopCommonModes标记，凡是被打上NSRunLoopCommonModes标记的都可以运行，下面两种模式被打上标签
        //0 : <CFString 0x10b7fe210 [0x10a8c7a40]>{contents = "UITrackingRunLoopMode"}
        //2 : <CFString 0x10a8e85e0 [0x10a8c7a40]>{contents = "kCFRunLoopDefaultMode"}
        // 因此也就是说如果我们使用NSRunLoopCommonModes，timer可以在UITrackingRunLoopMode，kCFRunLoopDefaultMode两种模式下运行
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        //NSLog(@"%@",[NSRunLoop mainRunLoop]);
    }
    else if ([key isEqualToString:@"gcd_timer"])
    {
        //创建队列
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        //1.创建一个GCD定时器
        /*
         第一个参数:表明创建的是一个定时器
         第四个参数:队列
         */
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        // 需要对timer进行强引用，保证其不会被释放掉，才会按时调用block块
        // 局部变量，让指针强引用
        self.timer = timer;
        //2.设置定时器的开始时间,间隔时间,精准度
        /*
         第1个参数:要给哪个定时器设置
         第2个参数:开始时间
         第3个参数:间隔时间
         第4个参数:精准度 一般为0 在允许范围内增加误差可提高程序的性能
         GCD的单位是纳秒 所以要*NSEC_PER_SEC
         */
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        
        //3.设置定时器要执行的事情
        dispatch_source_set_event_handler(timer, ^{
            NSLog(@"---%@--",[NSThread currentThread]);
        });
        // 启动
        dispatch_resume(timer);
    }
    else if ([key isEqualToString:@"observer"])
    {
        //创建监听者
        /*
         第一个参数 CFAllocatorRef allocator：分配存储空间 CFAllocatorGetDefault()默认分配
         第二个参数 CFOptionFlags activities：要监听的状态 kCFRunLoopAllActivities 监听所有状态
         第三个参数 Boolean repeats：YES:持续监听 NO:不持续
         第四个参数 CFIndex order：优先级，一般填0即可
         第五个参数 ：回调 两个参数observer:监听者 activity:监听的事件
         */
        /*
         所有事件
         typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
         kCFRunLoopEntry = (1UL << 0),   //   即将进入RunLoop
         kCFRunLoopBeforeTimers = (1UL << 1), // 即将处理Timer
         kCFRunLoopBeforeSources = (1UL << 2), // 即将处理Source
         kCFRunLoopBeforeWaiting = (1UL << 5), //即将进入休眠
         kCFRunLoopAfterWaiting = (1UL << 6),// 刚从休眠中唤醒
         kCFRunLoopExit = (1UL << 7),// 即将退出RunLoop
         kCFRunLoopAllActivities = 0x0FFFFFFFU
         };
         */
        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            switch (activity) {
                case kCFRunLoopEntry:
                    NSLog(@"RunLoop进入");
                    break;
                case kCFRunLoopBeforeTimers:
                    NSLog(@"RunLoop要处理Timers了");
                    break;
                case kCFRunLoopBeforeSources:
                    NSLog(@"RunLoop要处理Sources了");
                    break;
                case kCFRunLoopBeforeWaiting:
                    NSLog(@"RunLoop要休息了");
                    break;
                case kCFRunLoopAfterWaiting:
                    NSLog(@"RunLoop醒来了");
                    break;
                case kCFRunLoopExit:
                    NSLog(@"RunLoop退出了");
                    break;
                    
                default:
                    break;
            }
        });
        
        // 给RunLoop添加监听者
        /*
         第一个参数 CFRunLoopRef rl：要监听哪个RunLoop,这里监听的是主线程的RunLoop
         第二个参数 CFRunLoopObserverRef observer 监听者
         第三个参数 CFStringRef mode 要监听RunLoop在哪种运行模式下的状态
         */
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
        /*
         CF的内存管理（Core Foundation）
         凡是带有Create、Copy、Retain等字眼的函数，创建出来的对象，都需要在最后做一次release
         GCD本来在iOS6.0之前也是需要我们释放的，6.0之后GCD已经纳入到了ARC中，所以我们不需要管了
         */
        CFRelease(observer);
    }
    else if ([key isEqualToString:@"operate_queue"])
    {
        ROperation *r = [[ROperation alloc] init];
        [self.operationQueue addOperation:r];
    }
}

- (void)threadStart
{
    @autoreleasepool
    {
        NSLog(@"autoreleasepool");
        
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }
}

- (void)threadRun:(Task *)task
{
    NSLog(@"thread run start");
    
    [task run];
    task.finished = YES;
    
    NSLog(@"thread run end");
}

- (void)timerFire
{
    NSLog(@"----- timer fire -----");
}

- (void)taskTimerFire
{
    if (self.taskArray.count == 0) {
        return;
    }
    
    if (self.currentTask != nil && !self.currentTask.finished) {
        NSLog(@"taskTimerFire current task is running");
        return;
    }
    
    Task *task = self.taskArray.firstObject;
    self.currentTask = task;
    [self.taskArray removeObjectAtIndex:0];
    [self performSelector:@selector(threadRun:) onThread:self.thread withObject:task waitUntilDone:NO];
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
                                @"title" : @"基本概要",
                                @"key" : @"base",
                                },
                            @{
                                @"title" : @"常驻线程",
                                @"key" : @"thread",
                                },
                            @{
                                @"title" : @"任务1",
                                @"key" : @"task1",
                                },
                            @{
                                @"title" : @"任务2",
                                @"key" : @"task2",
                                },
                            @{
                                @"title" : @"Runloop Timer",
                                @"key" : @"timer",
                                },
                            @{
                                @"title" : @"GCD Timer",
                                @"key" : @"gcd_timer",
                                },
                            @{
                                @"title" : @"Runloop Observer",
                                @"key" : @"observer",
                                },
                            @{
                                @"title" : @"Operate Queue",
                                @"key" : @"operate_queue"
                                },
                            ];
    }
    return _tableViewDatas;
}

- (NSOperationQueue *)operationQueue
{
    if (_operationQueue == nil) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
    }
    return _operationQueue;
}

- (NSMutableArray *)taskArray
{
    if (_taskArray == nil) {
        _taskArray = [[NSMutableArray alloc] init];
    }
    return _taskArray;
}

@end
