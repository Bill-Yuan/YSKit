//
//  YSKitUtils.m
//  YSKit
//
//  Created by Bob on 2019/1/11.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSKitUtils.h"

@implementation YSKitUtils

+ (UIImage *)imageWithColor:(UIColor *)color withFrame:(CGRect)rect{
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    // 渲染上下文
    CGContextFillRect(context, rect);
    
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)wMarkImage:(UIImage *)image text:(NSString *)text
              textPoint:(CGPoint)point
       attributedString:(NSDictionary * )attributed{
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    //绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    //添加水印文字
    [text drawAtPoint:point withAttributes:attributed];
    
    //从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    //返回图片
    return newImage;
}

+ (void)snapShot:(UIView *)view successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block{
    //1、开启上下文
    UIGraphicsBeginImageContext(view.bounds.size);
    
    //2.获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //3.截屏
    [view.layer renderInContext:ctx];
    
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //5.转化成为Data
    //compressionQuality:表示压缩比 0 - 1的取值范围
    NSData * data = UIImageJPEGRepresentation(newImage, 1);
    
    //6、关闭上下文
    UIGraphicsEndImageContext();
    
    //7.回调
    block(newImage,data);
}

+ (void)borderInView:(UIView *)view
               width:(CGFloat)width
               color:(UIColor *)color
{
    view.layer.borderWidth = width;
    view.layer.borderColor = color.CGColor;
}


+ (void)shdowInView:(UIView *)view
             offset:(CGSize)size
              color:(UIColor *)color
{
    view.layer.shadowOffset = size;
    view.layer.shadowOpacity = YES;
    view.layer.shadowColor = color.CGColor;
}
@end
