//
//  YSTSArray.h
//  YSKit
//
//  Created by Bob on 2017/11/28.
//  Copyright © 2017年 YS. All rights reserved.
//  线程安全数组 : 遍历的时候，修改数组

#import <Foundation/Foundation.h>

@interface YSTSArray : NSMutableArray

- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;

- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;

- (void)enumerateObjectsUsingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block;
@end
