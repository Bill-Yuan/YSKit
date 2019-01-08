//
//  YSKitCase.m
//  UtilDemo
//
//  Created by Bob on 2018/5/30.
//  Copyright © 2018年 YS. All rights reserved.
//

#import "YSKitCase.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation YSKitCase

+ (void)enumateFont
{
    for (id family in [UIFont familyNames]) {
        NSArray* fonts = [UIFont fontNamesForFamilyName:family];
        for (id font in fonts){
            NSLog(@"字体名:%@",font);
        }
    }
}


- (void)getVarList
{
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i< count; i++) {
        Ivar ivar = *(ivars + i);
        NSLog(@"varName:%s", ivar_getName(ivar));
        NSLog(@"varType:%s", ivar_getTypeEncoding(ivar));
    }
    free(ivars);
}


- (void)getProperty
{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++){
        objc_property_t property = properties[i];
        NSLog(@"pName:%s",property_getName(property));
        NSLog(@"pAttributes:%s",property_getAttributes(property));
    }
    free(properties);
}


- (void)getMethodList
{
    unsigned int methCount = 0;
    Method *meths = class_copyMethodList([UITextField class], &methCount);
    for(int i = 0; i < methCount; i++) {
        Method meth = meths[i];
        SEL sel = method_getName(meth);
        const char *name = sel_getName(sel);
        NSLog(@"%s", name);
    }
    free(meths);
}

+ (void)logScreenInfo:(UIViewController *)vc{
    CGFloat navH = CGRectGetHeight(vc.navigationController.navigationBar.frame);
    CGFloat statusH = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor redColor];
    }
    
    vc.navigationController.navigationBar.backgroundColor = [UIColor yellowColor];
    
    vc.tabBarController.tabBar.backgroundColor = [UIColor redColor];
    
    CGFloat tabBarH = CGRectGetHeight(vc.tabBarController.tabBar.frame);
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        insets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
    } else {
        // Fallback on earlier versions
    }
    
    NSLog(@"---- %lf ---- %lf ---- %lf --- %@",navH,statusH,tabBarH,NSStringFromUIEdgeInsets(insets));
    // iphoneX ---- 44.000000 ---- 44.000000 ---- 83.000000 ---- {44, 0, 34, 0}
    // iphone6 ---- 44.000000 ---- 20.000000 ---- 49.000000 --- {20, 0, 0, 0}
    // iphoneP ---- 44.000000 ---- 20.000000 ---- 49.000000 --- {20, 0, 0, 0}
}
@end
