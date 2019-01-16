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

@property (nonatomic, strong) UIView *toV;
@property (nonatomic, strong) UIView *fromV;

@property (nonatomic, strong) YSCGV *cgV;
@end

@implementation YSAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.cgV = [[YSCGV alloc] initWithFrame:CGRectMake( 0, 64, 375, 100)];
    [self.view addSubview:self.cgV];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    
    
    [YSAnimation touchAnimation:point inView:self.fromV];
}


#pragma mark --
#pragma mark init method
- (UIView *)fromV{
    if (!_fromV) {
        _fromV = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 200, 100)];
        [self.view addSubview:_fromV];
        
        _fromV.backgroundColor = [UIColor redColor];
    }
    return _fromV;
}

- (UIView *)toV{
    if (!_toV) {
        _toV = [[UIView alloc] initWithFrame:CGRectMake(20, 300, 200, 100)];
        [self.view addSubview:_toV];
        
        _toV.backgroundColor = [UIColor yellowColor];
    }
    return _toV;
}
@end
