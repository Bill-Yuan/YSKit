//
//  UITableView+Setting.h
//  YSKit
//
//  Created by Bob on 2019/1/10.
//  Copyright © 2019 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Setting)

/**
 设置主题
 
 @param dColor 日间主题
 @param nColor 夜间主题
 */
- (void)setDay:(UIColor *)dColor Night:(UIColor *)nColor;

@end

NS_ASSUME_NONNULL_END
