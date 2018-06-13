//
//  YSSettingMgr.h
//  UtilDemo
//
//  Created by Bob on 2018/4/17.
//  Copyright © 2018年 YS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KSDTNOTIFY  @"kSdtNotify"
#define KSNTNOTIFY  @"kSntNotify"

@interface YSSettingMgr : NSObject

@property (nonatomic, assign) BOOL isDay;

+ (instancetype)shareInstance;

- (void)changeTheme;

@end
