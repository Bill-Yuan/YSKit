//
//  YSAnimationVC.m
//  YSKit
//
//  Created by Bob on 2019/1/15.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSAnimationVC.h"
#import "YSAnimation.h"

#import "YSCGV.h"

@interface YSAnimationVC ()

@property (nonatomic, strong) UIImageView *cycleImg;

@property (nonatomic, assign) NSUInteger disCnt;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation YSAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self cycleImg];
 }

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self keyAnimation];
    //    [self startDisplayLink];
}

- (void)keyAnimation{
    [UIView animateKeyframesWithDuration:2.0 delay:0.f options:UIViewKeyframeAnimationOptionRepeat animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0
                                relativeDuration:0.15 animations:^{
                                    //顺时针旋转90度
                                    _cycleImg.transform = CGAffineTransformMakeRotation(M_PI *
                                                                                       -1.5);
                                }];
        [UIView addKeyframeWithRelativeStartTime:0.15
                                relativeDuration:0.10 animations:^{
                                    //180度
                                    _cycleImg.transform = CGAffineTransformMakeRotation(M_PI *
                                                                                       1.0);
                                }];
        [UIView addKeyframeWithRelativeStartTime:0.25
                                relativeDuration:0.20 animations:^{
                                    //摆过中点，225度
                                    _cycleImg.transform = CGAffineTransformMakeRotation(M_PI *
                                                                                       1.3);
                                }];
        [UIView addKeyframeWithRelativeStartTime:0.45
                                relativeDuration:0.20 animations:^{
                                    //再摆回来，140度
                                    _cycleImg.transform = CGAffineTransformMakeRotation(M_PI *
                                                                                       0.8);
                                }];
        [UIView addKeyframeWithRelativeStartTime:0.65
                                relativeDuration:0.35 animations:^{
                                    //旋转后掉落
                                    //最后一步，视图淡出并消失
                                    CGAffineTransform shift =
                                    CGAffineTransformMakeTranslation(180.0, 0.0);
                                    CGAffineTransform rotate =
                                    CGAffineTransformMakeRotation(M_PI * 0.3);
                                    _cycleImg.transform = CGAffineTransformConcat(shift,
                                                                                 rotate);
                                    _cycleImg.alpha = 0.0;
                                }];
        
    } completion:^(BOOL finished) {
        NSLog(@"completion...");
    }];
    
}

- (void)startDisplayLink{
    _disCnt = 0;
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshImage)];
    if (@available(iOS 10.0, *)) {
        _displayLink.preferredFramesPerSecond = 10;
    } else {
        // Fallback on earlier versions
        _displayLink.frameInterval = 10;
    }
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    _displayLink.paused = NO;
}

- (void)endDisplayLink{
    _displayLink.paused = YES;
    [_displayLink invalidate];
    _displayLink = nil;
}

- (void)refreshImage{
    if (_disCnt > 119) {
        [self endDisplayLink];
    }else{
        _disCnt++;
        _cycleImg.transform = CGAffineTransformRotate(_cycleImg.transform, M_PI/2);
    }
}

#pragma mark --
#pragma mark init method
- (UIImageView *)cycleImg{
    if (!_cycleImg) {
        _cycleImg = [[UIImageView alloc] initWithFrame:CGRectMake(80, 100, 100, 100)];
        [self.view addSubview:_cycleImg];
        [_cycleImg setImage:[UIImage imageNamed:@"cyle"]];
    }
    return _cycleImg;
}
@end
