//
//  YSToastV.h
//  CF_GTS2
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSToastV : UIView


/**
 初始化弹框

 @param msg 提示语
 @param hdnTime 消失时间
 @return 弹框
 */
- (instancetype)initWithMsg:(NSString *)msg
                   hdnAfter:(NSTimeInterval)hdnTime;


/**
 加载弹框
 */
- (void)showAnimation;

@end

NS_ASSUME_NONNULL_END
