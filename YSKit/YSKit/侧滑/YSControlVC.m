//
//  YSControlVC.m
//  UtilDemo
//
//  Created by Bob on 2018/6/12.
//  Copyright © 2018年 YS. All rights reserved.
//

#import "YSControlVC.h"

#import "YSLeftVC.h"
#import "YSCenterVC.h"

@interface YSControlVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) YSLeftVC *leftVC;
@property (nonatomic, strong) YSCenterVC *centerVC;

@property (nonatomic, assign) CGFloat startPoint;

@end

@implementation YSControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Left";
    [self addView];
}

- (void)addView{
//添加中间
    _centerVC = [YSCenterVC new];
    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:_centerVC];
    [self addChildViewController:centerNav];
    [self.view addSubview:centerNav.view];
    
    __weak __typeof(&*self)wVC = self;
    _centerVC.openBlk = ^{
        [UIView animateWithDuration:.5f animations:^{
            CGRect frame = wVC.leftVC.navigationController.view.frame;
            frame.origin.x = 0;
            wVC.leftVC.navigationController.view.frame = frame;
        }];
    };

//添加侧边
    _leftVC = [YSLeftVC new];
    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:_leftVC];
    [self addChildViewController:leftNav];
    [self.view addSubview:leftNav.view];
    
    leftNav.view.layer.shadowColor = [UIColor blackColor].CGColor;
    leftNav.view.layer.shadowOpacity = 0.8;
    leftNav.view.layer.shadowRadius = 5;
 
    _leftVC.closeBlk = ^{
        [UIView animateWithDuration:.5f animations:^{
            CGRect frame = wVC.leftVC.navigationController.view.frame;
            frame.origin.x = -[UIScreen mainScreen].bounds.size.width - 5;
            wVC.leftVC.navigationController.view.frame = frame;
        }];
    };
    
    UIPanGestureRecognizer *ges = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(responseGes:)];
    ges.delegate = self;
    [self.view addGestureRecognizer:ges];
}

#pragma mark --
#pragma mark 响应手势
- (void)responseGes:(UIPanGestureRecognizer *)ges
{
    
    CGFloat curX = [ges locationInView:self.view].x;
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:{
            _startPoint = curX;
        }
            break;
        case UIGestureRecognizerStateChanged:{
            CGRect frame = _leftVC.navigationController.view.frame;
            frame.origin.x += (curX - _startPoint);
            _startPoint = curX;
            if (frame.origin.x > 0) {
                frame.origin.x = 0;
            }
            _leftVC.navigationController.view.frame = frame;
        }
            break;
        case UIGestureRecognizerStateEnded:{
            [UIView animateWithDuration:.5f animations:^{
                CGRect frame = _leftVC.navigationController.view.frame;
                CGFloat width = [UIScreen mainScreen].bounds.size.width;
                CGFloat offsetX = width/2;
                if (CGRectGetMaxX(frame) + offsetX > width) {
                    //滑动页右靠基准页右 --
                    frame.origin.x = 0;
                }else if (CGRectGetMaxX(frame) < offsetX) {
                    //滑动页右靠基准页左 --
                    frame.origin.x = -width - 5;
                }else if (CGRectGetMaxX(frame) > offsetX){
                    frame.origin.x = 0;
                }else{
                    frame.origin.x = -width - 5;
                }
                _leftVC.navigationController.view.frame = frame;
            }];
           
        }
            break;
        default:
            break;
    }
    //置位，保证不闪
    [ges setTranslation:CGPointMake(0, 0) inView:self.view];
}

@end
