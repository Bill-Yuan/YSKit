
//
//  YSTSArray.m
//  YSKit
//
//  Created by Bob on 2017/11/28.
//  Copyright © 2017年 YS. All rights reserved.
//

#import "YSTSArray.h"

@interface YSTSArray()
{
   CFMutableArrayRef _array;
}

@end

@implementation YSTSArray

- (id)init
{
    self = [super init];
    if (self) {
        _array = CFArrayCreateMutable(kCFAllocatorDefault, 10,  &kCFTypeArrayCallBacks);
    }
    return self;
}

- (NSUInteger)count
{
    __block NSUInteger result;
    [self synBlockF:^{
        result = CFArrayGetCount(_array);
    }];
    return result;
}

- (id)objectAtIndex:(NSUInteger)index
{
    __block id result;
    [self synBlockF:^{
        NSUInteger count = CFArrayGetCount(_array);
        result = index < count ? CFArrayGetValueAtIndex(_array, index) : nil;
    }];
    return result;
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject)
        return;
    
    __block NSUInteger blockindex = index;
    [self barAsynBlockF:^{
        NSUInteger count = CFArrayGetCount(_array);
        if (blockindex < count) {
            CFArrayInsertValueAtIndex(_array, blockindex, (__bridge const void *)anObject);
        }
    }];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    [self barAsynBlockF:^{
        NSUInteger count = CFArrayGetCount(_array);
        if (index < count) {
            CFArrayRemoveValueAtIndex(_array, index);
        }
    }];
}

- (void)addObject:(id)anObject
{
    if (!anObject)
        return;
    [self barAsynBlockF:^{
        CFArrayAppendValue(_array, (__bridge const void *)anObject);
    }];
}

- (void)removeLastObject
{
    [self barAsynBlockF:^{
        NSUInteger count = CFArrayGetCount(_array);
        if (count > 0) {
            CFArrayRemoveValueAtIndex(_array, count-1);
        }
    }];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (!anObject)
        return;
    [self barAsynBlockF:^{
        NSUInteger count = CFArrayGetCount(_array);
        if (count > index) {
            CFArraySetValueAtIndex(_array, index, (__bridge const void*)anObject);
        }
    }];
}

- (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [self synBlockF:^{
        [super enumerateObjectsUsingBlock:block];
    }];
}

#pragma mark Optional
- (void)removeAllObjects
{
    [self barAsynBlockF:^{
        CFArrayRemoveAllValues(_array);
    }];
}

- (NSUInteger)indexOfObject:(id)anObject
{
    if (!anObject)
        return NSNotFound;
    
    __block NSUInteger result;
    [self synBlockF:^{
        NSUInteger count = CFArrayGetCount(_array);
        result = CFArrayGetFirstIndexOfValue(_array, CFRangeMake(0, count), (__bridge const void *)(anObject));
    }];
    return result;
}

#pragma mark - Private
- (dispatch_queue_t)syncQueue
{
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.safearray", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}

typedef void(^synBlock)(void);

- (void)synBlockF:(synBlock)a{
    dispatch_sync(self.syncQueue, a);
}

- (void)barAsynBlockF:(synBlock)a{
    dispatch_barrier_async(self.syncQueue, a);
}

@end
