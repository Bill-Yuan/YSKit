//
//  YSTableV.h
//  YSKit
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019 YS. All rights reserved.
//  封装的表单（支持单一样式的表单）

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    YSTypeUserInfo = 1,
    YSTypeMarket,
    YSTypePosition,
} YSTableType;

@interface YSTableV : UIView

@property (nonatomic, copy) void(^selectedRow)(id data);

@property (nonatomic, copy) void(^reClickData)(void);

@property (nonatomic, copy) void(^headerRefresh)(void);

@property (nonatomic, copy) void(^footerRefresh)(void);

- (void)resetData;

- (void)addObjectFromArray:(NSArray *)dataArr;

- (void)replaceObject:(id)object WithIndex:(NSUInteger)idx;

- (id)initWithFrame:(CGRect)frame dataSource:(NSArray *)data CellType:(YSTableType)type;

@end

NS_ASSUME_NONNULL_END
