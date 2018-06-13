//
//  YSCenterDetailVC.m
//  UtilDemo
//
//  Created by Bob on 2018/6/12.
//  Copyright © 2018年 YS. All rights reserved.
//

#import "YSCenterDetailVC.h"

#import <objc/runtime.h>
#import "YSSettingMgr.h"
#import "UIButton+Setting.h"

@interface YSCenterDetailVC ()

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;


@end

@implementation YSCenterDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initControl];
}

- (void)initControl
{
    [self.btn1 setDay:[UIColor grayColor] TxtColor:[UIColor blackColor]];
    [self.btn1 setNight:[UIColor blackColor] TxtColor:[UIColor whiteColor]];

    [self.btn2 setDay:[UIColor blackColor] TxtColor:[UIColor whiteColor]];
    [self.btn2 setNight:[UIColor grayColor] TxtColor:[UIColor blackColor]];

    [self.btn3 setDay:[UIColor grayColor] TxtColor:[UIColor blackColor]];
    [self.btn3 setNight:[UIColor blackColor] TxtColor:[UIColor whiteColor]];

    [self.btn4 setDay:[UIColor brownColor] TxtColor:[UIColor whiteColor]];
    [self.btn4 setNight:[UIColor purpleColor] TxtColor:[UIColor greenColor]];
}

- (void)btnAction
{
    [[YSSettingMgr shareInstance] changeTheme];
}


- (UIButton *)btn1
{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn1];

        _btn1.frame = CGRectMake(15, 150, 345, 40);
        [_btn1.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_btn1 addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [_btn1 setTitle:@"Second" forState:UIControlStateNormal];
    }
    return _btn1;
}

- (UIButton *)btn2
{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn2];

        _btn2.frame = CGRectMake(15, 200, 345, 40);
        [_btn2.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_btn2 addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [_btn2 setTitle:@"Third" forState:UIControlStateNormal];
    }
    return _btn2;
}

- (UIButton *)btn3
{
    if (!_btn3) {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn3];

        _btn3.frame = CGRectMake(15, 250, 345, 40);
        [_btn3.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_btn3 addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [_btn3 setTitle:@"Forth" forState:UIControlStateNormal];
    }
    return _btn3;
}

- (UIButton *)btn4
{
    if (!_btn4) {
        _btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn4];

        _btn4.frame = CGRectMake(15, 300, 345, 40);
        [_btn4.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_btn4 addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [_btn4 setTitle:@"Fifth" forState:UIControlStateNormal];
    }
    return _btn4;
}

@end
