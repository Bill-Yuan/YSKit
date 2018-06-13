//
//  UIButton+Setting.m
//  UtilDemo
//
//  Created by Bob on 2018/4/17.
//  Copyright © 2018年 YS. All rights reserved.
//

#import "UIButton+Setting.h"
#import <objc/runtime.h>
#import "YSSettingMgr.h"

@implementation UIButton (Setting)

#pragma mark --
#pragma mark life cycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --
#pragma mark notification
- (void)observerTheme
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dayTheme)
                                                 name:KSDTNOTIFY
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(nightTheme)
                                                 name:KSNTNOTIFY
                                               object:nil];
}

- (void)dayTheme
{
    [self setBackgroundColor:self.dayColor];
    [self setTitleColor:self.txtDColor forState:UIControlStateNormal];
}

- (void)nightTheme
{
    [self setBackgroundColor:self.nightColor];
    [self setTitleColor:self.txtNColor forState:UIControlStateNormal];
}

#pragma mark --
#pragma mark init dataSource
- (void)setDay:(UIColor *)bgColor TxtColor:(UIColor *)tColor
{
    self.dayColor = bgColor;
    self.txtDColor = tColor;
    
    if ([YSSettingMgr shareInstance].isDay) {
        self.backgroundColor = self.dayColor;
        [self setTitleColor:self.txtDColor forState:UIControlStateNormal];
    }
    [self observerTheme];
}

- (void)setNight:(UIColor *)bgColor TxtColor:(UIColor *)tColor
{
    self.nightColor = bgColor;
    self.txtNColor = tColor;
    
    if (![YSSettingMgr shareInstance].isDay) {
        self.backgroundColor = self.nightColor;
        [self setTitleColor:self.txtNColor forState:UIControlStateNormal];
    }
    [self observerTheme];
}


#pragma mark --
#pragma mark dynamic properity
- (void)setDayColor:(UIColor *)dayColor
{
    objc_setAssociatedObject(self, @selector(dayColor), dayColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)dayColor
{
    return objc_getAssociatedObject(self, @selector(dayColor));
}

- (void)setNightColor:(UIColor *)nightColor
{
    objc_setAssociatedObject(self, @selector(nightColor), nightColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)nightColor
{
    return objc_getAssociatedObject(self, @selector(nightColor));
}

- (void)setTxtDColor:(UIColor *)txtDColor
{
    objc_setAssociatedObject(self, @selector(txtDColor), txtDColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)txtDColor
{
    return objc_getAssociatedObject(self, @selector(txtDColor));
}

- (void)setTxtNColor:(UIColor *)txtNColor
{
    objc_setAssociatedObject(self, @selector(txtNColor), txtNColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)txtNColor
{
    return objc_getAssociatedObject(self, @selector(txtNColor));
}

@end
