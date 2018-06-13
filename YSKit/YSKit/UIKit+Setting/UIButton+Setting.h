//
//  UIButton+Setting.h
//  UtilDemo
//
//  Created by Bob on 2018/4/17.
//  Copyright © 2018年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface UIButton (Setting)

@property (nonatomic, strong) UIColor *dayColor;
@property (nonatomic, strong) UIColor *nightColor;

@property (nonatomic, strong) UIColor *txtDColor;
@property (nonatomic, strong) UIColor *txtNColor;

- (void)setDay:(UIColor *)bgColor TxtColor:(UIColor *)tColor;
- (void)setNight:(UIColor *)bgColor TxtColor:(UIColor *)tColor;

@end
