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

@end
