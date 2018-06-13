//
//  YSSettingMgr.m
//  UtilDemo
//
//  Created by Bob on 2018/4/17.
//  Copyright © 2018年 YS. All rights reserved.
//

#import "YSSettingMgr.h"

@implementation YSSettingMgr

static YSSettingMgr *share;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!share) {
            share = [[YSSettingMgr alloc] init];
        }
    });
    return share;
}

- (id)init
{
    self = [super init];
    if (self) {
        _isDay = YES;
    }
    return self;
}

- (void)changeTheme
{
    _isDay = !_isDay;
    if (_isDay) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KSDTNOTIFY object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:KSNTNOTIFY object:nil];
    }
}

@end
