//
//  YSCGV.m
//  YSKit
//
//  Created by Bob on 2019/1/16.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSCGV.h"
#import<CoreText/CoreText.h>

@implementation YSCGV

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"__%s__",__func__);
    }
    return self;
}


- (void)setContent:(NSString *)content{
    _content = content;
    NSLog(@"__%s__",__func__);
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    NSLog(@"start...");
    
    CGContextRef context = UIGraphicsGetCurrentContext();

//    [self drawLine:context];
//    [self drawDashLine:context];

    [self drawText:context];

//    [self drawArc:context];
//    [self drawEllipse:context];
//
//    [self drawCurve:context];
//    [self drawQuadCurve:context];

    CGContextStrokePath(context);
 
    NSLog(@"end...");
}


/**
 画直线

 @param context 画布
 */
- (void)drawLine:(CGContextRef)context{
    
    CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint(context, 40, 20);
    CGContextAddLineToPoint(context, 80, 80);
}

/**
 画直线
 
 @param context 画布
 */
- (void)drawDashLine:(CGContextRef)context{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGFloat lengths[] = {10,10};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 40, 20);
    CGContextAddLineToPoint(context, 80, 80);
    CGContextStrokePath(context);

}


/**
 画圆弧

 @param context 画布
 */
- (void)drawArc:(CGContextRef)context{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextMoveToPoint(context, 20, 20);
    CGContextAddArcToPoint(context, 20, 40, 80, 60, 30);
}



/**
 画曲线
 
 @param context 画布
 */
- (void)drawCurve:(CGContextRef)context{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context,[UIColor blueColor].CGColor);
    CGContextMoveToPoint(context, 10, 10);
    CGContextAddCurveToPoint(context, 0, 40, 150, 80, 150, 200);
}


/**
 画虚线曲线
 
 @param context 画布
 */
- (void)drawQuadCurve:(CGContextRef)context{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context,[UIColor blueColor].CGColor);
    CGFloat dashArray[] = {2,6,4,2};
    CGContextSetLineDash(context, 3, dashArray, 4);
    CGContextMoveToPoint(context, 10, 10);
    CGContextAddQuadCurveToPoint(context, 0, 40, 150, 80);
}


/**
 画椭圆

 @param context 画布
 */
- (void)drawEllipse:(CGContextRef)context{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGRect rectangle = CGRectMake(20, 20, 200, 60);
    CGContextAddEllipseInRect(context, rectangle);
}


/**
 画文字
 
 @param context 画布
 */
- (void)drawText:(CGContextRef)context{

    CGRect frame = CGRectMake(20, 40, 280, 20);
    
    NSDictionary *attri = @{
                            NSFontAttributeName:[UIFont systemFontOfSize:12],
                            NSForegroundColorAttributeName:[UIColor redColor],
                            NSBackgroundColorAttributeName:[UIColor whiteColor]
                            };
    
    [_content drawInRect:frame
          withAttributes:attri];
}

@end
