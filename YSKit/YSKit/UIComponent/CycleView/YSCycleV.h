//
//  YSCycleV.h
//  YSKit
//
//  Created by mac on 2019/1/24.
//  Copyright © 2019年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSCycleV : UIView


@property (nonatomic, copy) void(^selectedBlock)(NSUInteger idx);

@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, assign) NSTimeInterval timeInterval;


@end
