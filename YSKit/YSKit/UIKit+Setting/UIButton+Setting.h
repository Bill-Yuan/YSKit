//
//  UIButton+Setting.h
//  UtilDemo
//
//  Created by Bob on 2018/4/17.
//  Copyright © 2018年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface UIButton (Setting)


/**
 设置日间主题

 @param bgColor 日间背景色
 @param tColor 日间文字
 */
- (void)setDay:(UIColor *)bgColor TxtColor:(UIColor *)tColor;

/**
 设置夜间主题
 
 @param bgColor 夜间背景色
 @param tColor 夜间文字
 */
- (void)setNight:(UIColor *)bgColor TxtColor:(UIColor *)tColor;

@end
