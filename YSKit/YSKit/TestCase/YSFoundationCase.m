//
//  YSFoundationCase.m
//  UtilDemo
//
//  Created by Bob on 2018/5/30.
//  Copyright © 2018年 YS. All rights reserved.
//

#import "YSFoundationCase.h"

@implementation YSFoundationCase

+ (void)testDecimalNumber
{
    NSDecimalNumber *fir = [NSDecimalNumber decimalNumberWithString:@""];
    NSDecimalNumber *Sec = [NSDecimalNumber decimalNumberWithString:@"123"];
    
    NSLog(@"=====(%@)=======",[fir decimalNumberBySubtracting:Sec]);
    NSLog(@"~~~~~(%@)~~~~~~~",[Sec decimalNumberBySubtracting:fir]);
}

+ (void)testGCD
{
    NSObject *obj = [[NSObject alloc] init];
    dispatch_queue_t queue = dispatch_queue_create([@"DownLoad" UTF8String], NULL);
    dispatch_async(queue, ^{
        @synchronized(obj) {
            NSLog(@"需要线程同步的操作1 开始");
            sleep(1);
            NSLog(@"需要线程同步的操作1 结束");
        }
    });
    
    dispatch_async(queue, ^{
        sleep(1);
        @synchronized(obj) {
            NSLog(@"需要线程同步的操作2");
        }
    });
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(1);
        NSLog(@"需要线程同步的操作1 结束");
        dispatch_semaphore_signal(signal);
    });
    dispatch_async(queue, ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作2");
        dispatch_semaphore_signal(signal);
    });
    
    NSLock *lock = [[NSLock alloc] init];
    dispatch_async(queue, ^{
        [lock lock];
        [lock lockBeforeDate:[NSDate date]];
        NSLog(@"需要线程同步的操作1 开始");
        sleep(2);
        NSLog(@"需要线程同步的操作1 结束");
        [lock unlock];
    });
    
    dispatch_async(queue, ^{
        sleep(1);
        if ([lock tryLock]) {
            //尝试获取锁，如果获取不到返回NO，不会阻塞该线程
            NSLog(@"锁可用的操作");
            [lock unlock];
        }else{
            NSLog(@"锁不可用的操作");
        }
        
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:1];
        if ([lock lockBeforeDate:date]) {
            //尝试在未来的1s内获取锁，并阻塞该线程，如果1s内获取不到恢复线程, 返回NO,不会阻塞该线程
            NSLog(@"没有超时，获得锁");
            [lock unlock];
        }else{
            NSLog(@"超时，没有获得锁");
        }
    });
}



@end
