//
//  YSAnimationVC.m
//  YSKit
//
//  Created by Bob on 2019/1/15.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSAnimationVC.h"
#import "YSAnimation.h"

@interface YSAnimationVC ()

@property (nonatomic, strong) UIView *desV;
@property (nonatomic, strong) UIView *startV;

@end

@implementation YSAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    
    
    [YSAnimation touchAnimation:point inView:self.startV];
}


#pragma mark --
#pragma mark init method
- (UIView *)startV{
    if (!_startV) {
        _startV = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 200, 100)];
        [self.view addSubview:_startV];
        
        _startV.backgroundColor = [UIColor redColor];
    }
    return _startV;
}
@end
