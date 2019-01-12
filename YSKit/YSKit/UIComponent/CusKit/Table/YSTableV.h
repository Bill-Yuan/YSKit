//
//  YSTableV.h
//  YSKit
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019 YS. All rights reserved.
//  封装的表单（固定行高固定样式的表单）

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    YSTypeUserInfo = 1,
    YSTypeMarket,
    YSTypePosition,
} YSTableType;

@interface YSTableV : UIView

//选中某行回调
@property (nonatomic, copy) void(^selectedRow)(NSUInteger row,id data);

//重复点击获取数据
@property (nonatomic, copy) void(^reClickData)(void);

//头部刷新
@property (nonatomic, copy) void(^headerRefresh)(void);

//底部刷新
@property (nonatomic, copy) void(^footerRefresh)(void);


/**
 重置数据
 */
- (void)resetData;


/**
 装载数据源

 @param dataArr 数组
 */
- (void)addObjectFromArray:(NSArray *)dataArr;


/**
 更新某个元素

 @param object 元素
 @param idx 序号
 */
- (void)replaceObject:(id)object WithIndex:(NSUInteger)idx;



/**
 初始化对象

 @param frame 框大小
 @param data 数据
 @param type 类型
 @return 数据结果
 */
- (id)initWithFrame:(CGRect)frame dataSource:(NSArray *)data cellType:(YSTableType)type;


@end

NS_ASSUME_NONNULL_END
