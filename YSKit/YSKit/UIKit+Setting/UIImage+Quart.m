//
//  UIImage+Quart.m
//  YSKit
//
//  Created by Bob on 2019/1/11.
//  Copyright © 2019 YS. All rights reserved.
//

#import "UIImage+Quart.h"

@implementation UIImage (Quart)

#warning on-screen-rendering/off-screen-rendering
- (UIImage *)imageWithCornerRadius:(CGFloat)radius{
    
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath;

    CGContextAddPath(context, path);
    CGContextClip(context);
    
    [self drawInRect:rect];
    
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
