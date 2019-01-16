//
//  YSCGV.m
//  YSKit
//
//  Created by Bob on 2019/1/16.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSCGV.h"

@implementation YSCGV

- (void)drawRect:(CGRect)rect{
    
    NSLog(@"start...");
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    dispatch_queue_t queue1 = dispatch_queue_create("group1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group1 = dispatch_group_create();
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_sync(queue1, ^{
            [self drawLine:context];
            [self drawDashLine:context];
        });
    });
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_sync(queue1, ^{
            [self drawText:context content:@"Hello Context"];
        });
    });
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_sync(queue1, ^{
            [self drawArc:context];
            [self drawEllipse:context];
            
        });
    });
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_sync(queue1, ^{
            [self drawCurve:context];
            [self drawQuadCurve:context];
            
        });
    });
    
    dispatch_group_wait(group1, DISPATCH_TIME_FOREVER);
    
    //等待上面的任务全部完成后，会收到通知执行block中的代码 （不会阻塞线程）
    dispatch_group_notify(group1, queue1, ^{
        CGContextStrokePath(context);
        CGContextClosePath(context);
        NSLog(@"end...");
    });
    
    NSLog(@"22222");
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
- (void)drawText:(CGContextRef)context content:(NSString *)content{
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;

    NSDictionary *attri = @{
                            NSParagraphStyleAttributeName:style,
                            NSFontAttributeName:[UIFont systemFontOfSize:12],
                            NSForegroundColorAttributeName:[UIColor redColor],
                            NSBackgroundColorAttributeName:[UIColor whiteColor]
                            };
    
    CGRect frame = CGRectMake(20, 40, 280, 20);
    
    [content drawInRect:frame
         withAttributes:attri];
}

@end
