//
//  YSTableM.h
//  YSKit
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019 YS. All rights reserved.
//  表单使用的模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark --
#pragma mark 用户信息数据模型
@interface YSUserInfoM : NSObject

//用户Id
@property (nonatomic, assign) NSUInteger userId;

//用户头像
@property (nonatomic, copy) NSString *avator;

//用户昵称
@property (nonatomic, copy) NSString *nickName;

//用户签名
@property (nonatomic, copy) NSString *signature;


@property (nonatomic, copy) NSString *className;

@end

NS_ASSUME_NONNULL_END
