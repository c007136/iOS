//
//  ViewController.m
//  GCD
//
//  Created by muyu on 2017/2/24.
//  Copyright © 2017年 muyu. All rights reserved.
//
//  https://github.com/ming1016/study/wiki/%E7%BB%86%E8%AF%B4GCD%EF%BC%88Grand-Central-Dispatch%EF%BC%89%E5%A6%82%E4%BD%95%E7%94%A8

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self deadLockCase4];
}

- (void)dispatchApplyDemo
{
    // dispatch_apply按指定的次数将指定的Block追加到指定的Dispatch Queue中,并等到全部的处理执行结束
    dispatch_queue_t q = dispatch_queue_create("com.muyu.concurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(10, q, ^(size_t i) {
        NSLog(@"i = %@", @(i));
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"1234");
    });
    NSLog(@"dispatchApplyDemo end");
}

- (void)dispatchSetTargetQueueDemo
{
    dispatch_queue_t q1 = dispatch_queue_create("com.muyu.q1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t q2 = dispatch_queue_create("com.muyu.q2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t q3 = dispatch_queue_create("com.muyu.q3", DISPATCH_QUEUE_CONCURRENT);
    
    // 变成了同步执行
    // 使多个queue在目标queue上一次只有一个执行
    dispatch_set_target_queue(q2, q1);
    dispatch_set_target_queue(q3, q1);
    
    dispatch_async(q1, ^{
        NSLog(@"11 in %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:4];
        NSLog(@"11 out");
    });
    
    dispatch_async(q2, ^{
        NSLog(@"22 in %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:3];
        NSLog(@"22 out");
    });
    
    dispatch_async(q3, ^{
        NSLog(@"33-1 in %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"33-1 out");
    });
    
    dispatch_async(q3, ^{
        NSLog(@"33-2 in %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"33-2 out");
    });
}

- (void)dispatchBarrierAsyncDemo
{
    dispatch_queue_t q = dispatch_queue_create("com.muyu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(q, ^{
        NSLog(@"11 in %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"11 out");
    });
    dispatch_async(q, ^{
        NSLog(@"22 %@", [NSThread currentThread]);
    });
    
    // 等前面的执行完后，再执行后面的
    dispatch_barrier_sync(q, ^{
        NSLog(@"------barrier----- in");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"------barrier----- out");
    });
    
    dispatch_async(q, ^{
        NSLog(@"33 in %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"33 out");
    });
    dispatch_async(q, ^{
        NSLog(@"44 %@", [NSThread currentThread]);
    });
}

- (void)dispatchCreateBlockDemo
{
    dispatch_queue_t q = dispatch_queue_create("com.muyu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"run block");
    });
    dispatch_async(q, block);
    
    // qos
    dispatch_block_t qosBlock = dispatch_block_create_with_qos_class(0, QOS_CLASS_USER_INITIATED, -1, ^{
        NSLog(@"qos run block");
    });
    dispatch_async(q, qosBlock);
}

- (void)dispatchBlockWaitDemo
{
    dispatch_queue_t q = dispatch_queue_create("com.muyu", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"block in");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"block out");
    });
    dispatch_async(q, block);
    // 等待block执行完毕
    dispatch_block_wait(block, DISPATCH_TIME_FOREVER);
    NSLog(@"block done");
}

- (void)dispatchBlockNotifyDemo
{
    dispatch_queue_t q = dispatch_queue_create("com.muyu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_block_t firstBlock = dispatch_block_create(0, ^{
        NSLog(@"first block in");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"first block out");
    });
    dispatch_block_t secondBlock = dispatch_block_create(0, ^{
        NSLog(@"second block run");
    });
    dispatch_async(q, firstBlock);
    
    // second block会等待first block执行完毕后才开始执行
    dispatch_block_notify(firstBlock, q, secondBlock);
}

- (void)dispatchBlockCancelDemo
{
    dispatch_queue_t q = dispatch_queue_create("com.muyu", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t firstBlock = dispatch_block_create(0, ^{
        NSLog(@"first block in");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"first block out");
    });
    dispatch_block_t secondBlock = dispatch_block_create(0, ^{
        NSLog(@"second block run");
    });
    dispatch_async(q, firstBlock);
    dispatch_async(q, secondBlock);
    
    // iOS 8
    dispatch_block_cancel(secondBlock);
}

// group用来监听并行队列
- (void)dispatchGroupWaitDemo
{
    dispatch_queue_t q = dispatch_queue_create("com.muyu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, q, ^{
        NSLog(@"1_____1");
    });
    
    dispatch_queue_t globalQueue  =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"2_____2");
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"all done");
}

- (void)dispatchGroupNotifyDemo
{
    dispatch_queue_t q = dispatch_queue_create("com.muyu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, q, ^{
        NSLog(@"1*****1");
    });
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"2*****2");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all done");
    });
}


// dispatch_semaphore_signal信号量+1
// dispatch_semaphore_wait信号量-1
// http://www.cnblogs.com/snailHL/p/3906112.html
// http://www.tanhao.me/pieces/392.html/
- (void)dipatchSemaphoreDemo
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    __block long x = 0;
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSLog(@"waiting first");
        [NSThread sleepForTimeInterval:1];
        
        x = dispatch_semaphore_signal(semaphore);
        NSLog(@"x = %@ first", @(x));
        
        NSLog(@"waiting second");
        [NSThread sleepForTimeInterval:2];
        
        x = dispatch_semaphore_signal(semaphore);
        NSLog(@"x = %@ second", @(x));
    });
    
    
    NSLog(@"dispatch_semaphore_wait in first");
    x = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"dispatch_semaphore_wait out first, x = %@", @(x));
    
    NSLog(@"dispatch_semaphore_wait in second");
    x = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"dispatch_semaphore_wait out second, x = %@", @(x));
    
    NSLog(@"dispatch_semaphore_wait in third");
    x = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"dispatch_semaphore_wait out third, x = %@", @(x));
    
    // 不加上此代码会崩溃
    // 原因是最终的semphore值不能小于初始值
    // http://stackoverflow.com/questions/8287621/why-does-this-code-cause-exc-bad-instruction
    // 但为什么x=0？？？
    // 有更好的解决方法吗？
    x = dispatch_semaphore_signal(semaphore);
    NSLog(@"x = %@ end", @(x));

    
    
    // demo
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    for (NSInteger i = 0; i < 100; i++)
//    {
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_group_async(group, globalQueue, ^{
//            NSLog(@"semaphore demo block %@", @(i));
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"semaphore demo block %@ semphore increment", @(i));
//            dispatch_semaphore_signal(semaphore);
//        });
//    }
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    NSLog(@"all done");
    
    // demo
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(globalQueue, ^{
//        NSLog(@"semaphore demo block in");
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"semaphore demo block out");
//        // 信号量+1
//        dispatch_semaphore_signal(semaphore);
//    });
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    NSLog(@"continue");
}

// http://blog.csdn.net/pingshw/article/details/16940009
- (void)dispatchSourceTimerDemo
{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    
    // dispatch_time和dispatch_walltime区别
    // dispatch_time stops running when your computer goes to sleep. dispatch_walltime continues running
    // http://stackoverflow.com/questions/26062702/what-is-the-difference-between-dispatch-time-and-dispatch-walltime-and-in-what-s
    
    //dispatch_time_t start = dispatch_walltime(NULL, 0);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 0);
    dispatch_source_set_timer(timer, start, 1*NSEC_PER_SEC, 0);
    
    __block int time = 60;
    dispatch_source_set_event_handler(timer, ^{
        if (time == 0) {
            // 一定要有dispatch_source_cancel否则不执行
            dispatch_source_cancel(timer);
        }
        NSLog(@"time = %@", @(time));
        time--;
    });
    
    dispatch_resume(timer);
}

// DISPATCH_SOURCE_TYPE_DATA_ADD、DISPATCH_SOURCE_TYPE_DATA_OR用户自定义且自己触发的
// DISPATCH_SOURCE_TYPE_DATA_ADD可以用于更新进度
- (void)dispatchSourceDataAddDemo
{
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_event_handler(source, ^{
        long l = dispatch_source_get_data(source);
        NSLog(@"监听函数： %@", @(l));
    });
    
    dispatch_resume(source);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        for (NSInteger i = 0; i < 10; i++)
        {
            NSLog(@">>>>> %@", @(i));
            // i = 0不会触发监听函数
            dispatch_source_merge_data(source, i);
            
            [NSThread sleepForTimeInterval:1];
        }
    });
}

- (void)deadLockCase1
{
    NSLog(@"1");
    // 按照先进先出原则，2会等待3，然而又因为“同步线程”，3又会等待2，相互等待，故死锁
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

- (void)deadLockCase2
{
    NSLog(@"1");
    // 相对1来说，这就不是“同步线程”了
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(globalQueue, ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

- (void)deadLockCase3
{
    dispatch_queue_t q = dispatch_queue_create("com.muyu", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    
    dispatch_async(q, ^{
        NSLog(@"2");
        // 这个死锁类似案例一
        dispatch_sync(q, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)deadLockCase4
{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSLog(@"1");
        // 回到主线程发现死循环，没法执行了
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    NSLog(@"4");
    
    while (1) {
        NSLog(@"死循环");
        
        [NSThread sleepForTimeInterval:5];
    }
}

@end
