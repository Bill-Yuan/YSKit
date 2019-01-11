//
//  UIImage+Quart.h
//  YSKit
//
//  Created by Bob on 2019/1/11.
//  Copyright © 2019 YS. All rights reserved.
//  x

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Quart)

/**
 
 @param radius 圆角弧度
 @return 添加圆角后的图片
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
