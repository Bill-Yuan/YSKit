//
//  UIViewController+Setting.h
//  UtilDemo
//
//  Created by Bob on 2018/4/25.
//  Copyright © 2018年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Setting)

@property (nonatomic, strong) UIColor *dayColor;
@property (nonatomic, strong) UIColor *nightColor;

- (void)setDay:(UIColor *)dColor Night:(UIColor *)nColor;

@end
