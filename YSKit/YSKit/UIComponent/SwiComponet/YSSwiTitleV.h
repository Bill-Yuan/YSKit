//
//  YSSwiTitleV.h
//  YSKit
//
//  Created by Bob on 2019/1/12.
//  Copyright © 2019 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSSwiTitleV : UIView

/**
 初始化表单

 @param frame 表单大小
 @param dataArr 数组
 @param fontinfo 字体信息
 @return 表单
 */
- (instancetype)initWithFrame:(CGRect)frame
                         Data:(NSArray *)dataArr
                         font:(UIFont *)fontinfo;
@end

NS_ASSUME_NONNULL_END
