//
//  YSAnimation.m
//  YSKit
//
//  Created by Bob on 2019/1/15.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSAnimation.h"

@implementation YSAnimation

+ (void)touchAnimation:(CGPoint)point inView:(UIView *)desV{
    
    [UIView beginAnimations:@"testAnimation" context:nil];
    
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationDelegate:self];
    
    //设置动画将开始时代理对象执行的SEL
    [UIView setAnimationWillStartSelector:@selector(animationDidStart:)];
    
    //设置动画延迟执行的时间
    [UIView setAnimationDelay:0];
    
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    //设置动画是否继续执行相反的动画
    [UIView setAnimationRepeatAutoreverses:YES];
    
    desV.center = point;
    desV.transform = CGAffineTransformMakeScale(1.5, 1.5);
    desV.transform = CGAffineTransformMakeRotation(M_PI);
    
    [UIView commitAnimations];
}


-(void)animationDidStart:(CAAnimation *)anim{
     NSLog(@"animation is start ...");
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animation is over ...");
}

@end
