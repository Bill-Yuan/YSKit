//
//  UIViewController+Setting.m
//  UtilDemo
//
//  Created by Bob on 2018/4/25.
//  Copyright © 2018年 YS. All rights reserved.
//

#import "UIViewController+Setting.h"
#import <objc/runtime.h>
#import "YSSettingMgr.h"

@implementation UIViewController (Setting)

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
    self.view.backgroundColor = self.dayColor;
}

- (void)nightTheme
{
    self.view.backgroundColor = self.nightColor;
}

#pragma mark --
#pragma mark init dataSource
- (void)setDay:(UIColor *)dColor Night:(UIColor *)nColor
{
    self.dayColor = dColor;
    self.nightColor = nColor;
    if ([YSSettingMgr shareInstance].isDay) {
        self.view.backgroundColor = self.dayColor;
    }else{
        self.view.backgroundColor = self.nightColor;
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
@end
