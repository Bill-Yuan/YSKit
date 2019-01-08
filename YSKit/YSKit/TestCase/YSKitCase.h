//
//  YSKitCase.h
//  UtilDemo
//
//  Created by Bob on 2018/5/30.
//  Copyright © 2018年 YS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YSKitCase : NSObject


/**
 枚举系统字体库
 */
+ (void)enumateFont;


/**
 打印控件Screen

 @param vc VC
 */
+ (void)logScreenInfo:(UIViewController *)vc;

@end
