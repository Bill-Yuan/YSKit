//
//  UIViewController+Setting.h
//  UtilDemo
//
//  Created by Bob on 2018/4/25.
//  Copyright © 2018年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Setting)

/**
 设置主题

 @param dColor 日间主题
 @param nColor 夜间主题
 */
- (void)setDay:(UIColor *)dColor Night:(UIColor *)nColor;

@end
