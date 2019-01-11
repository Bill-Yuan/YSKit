//
//  YSKitUtils.h
//  YSKit
//
//  Created by Bob on 2019/1/11.
//  Copyright © 2019 YS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSKitUtils : NSObject


/**
 颜色转图片

 @param color 颜色
 @param frame 图片大小
 @return 颜色对应的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color
                  withFrame:(CGRect)frame;


/**
 给图片添加文字水印

 @param image 图片
 @param text 水印内容
 @param point 水印开始坐标
 @param attributed 水印内容属性
 @return 添加了水印后的图片
 */
+ (UIImage *)wMarkImage:(UIImage *)image
                   text:(NSString *)text
              textPoint:(CGPoint)point
       attributedString:(NSDictionary * )attributed;


/**
 截图
 
 @param view 需要截屏的图
 @param block 成功回调
 */
+ (void)snapShot:(UIView *)view successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block;

@end

NS_ASSUME_NONNULL_END
