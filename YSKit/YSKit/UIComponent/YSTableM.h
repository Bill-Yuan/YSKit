//
//  YSTableM.h
//  YSKit
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019 YS. All rights reserved.
//  表单使用的模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSTableM : NSObject

@end



@interface YSUserInfoM : NSObject

@property (nonatomic, assign) NSUInteger userId;

@property (nonatomic, copy) NSString *avator;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *signature;

@end

NS_ASSUME_NONNULL_END
