//
//  UITableView+Setting.m
//  YSKit
//
//  Created by Bob on 2019/1/10.
//  Copyright © 2019 YS. All rights reserved.
//

#import "UITableView+Setting.h"
#import <objc/runtime.h>
#import "YSSettingMgr.h"

@interface UITableView ()

@property (nonatomic, strong) UIColor *dayColor;
@property (nonatomic, strong) UIColor *nightColor;

@property (nonatomic, assign) BOOL regTheme;

@end

@implementation UITableView (Setting)


#pragma mark --
#pragma mark life cycle
- (void)dealloc{
    NSLog(@"__%s__",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --
#pragma mark notification
- (void)observerTheme{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.regTheme) {
            self.regTheme = YES;
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(dayTheme)
                                                         name:KSDTNOTIFY
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(nightTheme)
                                                         name:KSNTNOTIFY
                                                       object:nil];
        }
    });
}

- (void)dayTheme{
    self.backgroundColor = self.dayColor;
    [self reloadData];
}

- (void)nightTheme{
    self.backgroundColor = self.nightColor;
    [self reloadData];
}

#pragma mark --
#pragma mark init dataSource
- (void)setDay:(UIColor *)dColor Night:(UIColor *)nColor{
    self.dayColor = dColor;
    self.nightColor = nColor;
    if ([YSSettingMgr shareInstance].isDay) {
        self.backgroundColor = self.dayColor;
    }else{
        self.backgroundColor = self.nightColor;
    }
    [self observerTheme];
}

#pragma mark --
#pragma mark dynamic properity
- (void)setRegTheme:(BOOL)themeColor{
    objc_setAssociatedObject(self, @selector(regTheme), @(themeColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)regTheme{
    return [objc_getAssociatedObject(self, @selector(regTheme)) boolValue];
}

- (void)setDayColor:(UIColor *)dayColor{
    objc_setAssociatedObject(self, @selector(dayColor), dayColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)dayColor{
    return objc_getAssociatedObject(self, @selector(dayColor));
}

- (void)setNightColor:(UIColor *)nightColor{
    objc_setAssociatedObject(self, @selector(nightColor), nightColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)nightColor{
    return objc_getAssociatedObject(self, @selector(nightColor));
}

@end
