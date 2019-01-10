//
//  YSCenterVC.m
//  UtilDemo
//
//  Created by Bob on 2018/6/12.
//  Copyright © 2018年 YS. All rights reserved.
//

#import "YSCenterVC.h"
#import "YSCenterDetailVC.h"

#import <objc/runtime.h>

#import "YSSettingMgr.h"

#import "YSMarco.h"
#import "UIButton+Setting.h"
#import "UIViewController+Setting.h"


#import "YSSafeAryVC.h"
#import "YSSpeechVC.h"

@interface YSCenterVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;

@end

@implementation YSCenterVC

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL oSelector = @selector(viewDidLoad);
        SEL sSelector = @selector(s_viewDidLoad);

        Method oMethod = class_getInstanceMethod(class, oSelector);
        Method sMethod = class_getInstanceMethod(class, sSelector);

        BOOL didAddMethod = class_addMethod(class, oSelector, method_getImplementation(sMethod), method_getTypeEncoding(sMethod));
        if (didAddMethod) {
            class_replaceMethod(class, sSelector, method_getImplementation(oMethod), method_getTypeEncoding(oMethod));
        }else{
            method_exchangeImplementations(oMethod, sMethod);
        }
    });
}


- (void)s_viewDidLoad{
    NSLog(@"替换的方法");
    [self s_viewDidLoad];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self createView];
    [self createNavTitle];

    [self setBtnTitle];
}

- (void)createNavTitle{
    self.title = @"主页";
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"打开" style:UIBarButtonItemStyleDone target:self action:@selector(openSlide)];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
}

- (void)createView{
    [self setDay:THEME_DAY Night:THEME_NIGHT];
    
    [self btn1];
    [self btn2];
    [self btn3];
}


- (void)setBtnTitle{
    NSString *title = [YSSettingMgr shareInstance].isDay ? @"切换夜间" : @"切换日间";
    [self.btn3 setTitle:title forState:UIControlStateNormal];
}

- (void)openSlide{
    if(self.openBlk){
        self.openBlk();
    }
}

- (void)btnAction:(UIButton *)sender{
    UIViewController *desVC = nil;
    switch (sender.tag) {
        case 1:{
            desVC = [YSSafeAryVC new];
  
        }
            break;
        case 2:{
            desVC = [YSSpeechVC new];
        }
            break;
        default:
            break;
    }
    
    if (desVC) {
        [self.navigationController pushViewController:desVC animated:YES];
    }else{
        [[YSSettingMgr shareInstance] changeTheme];
        [self setBtnTitle];
    }
}

- (UIButton *)btn1{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn1];
        
        [_btn1 setDay:UIBUTTON_DAY TxtColor:UIBUTTON_NIGHT];
        [_btn1 setNight:UILABEL_DAY TxtColor:UILABEL_NIGHT];
        
        _btn1.frame = CGRectMake(15, 150, 345, 40);
        [_btn1.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btn1 setTitle:@"线程安全数组" forState:UIControlStateNormal];
        _btn1.tag = 1;
    }
    return _btn1;
}

- (UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn2];
        
        [_btn2 setDay:UIBUTTON_DAY TxtColor:UIBUTTON_NIGHT];
        [_btn2 setNight:UILABEL_DAY TxtColor:UILABEL_NIGHT];

        _btn2.frame = CGRectMake(15, 200, 345, 40);
        [_btn2.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btn2 setTitle:@"语音交互" forState:UIControlStateNormal];
        _btn2.tag = 2;
    }
    return _btn2;
}

- (UIButton *)btn3{
    if (!_btn3) {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn3];
        
        [_btn3 setDay:UIBUTTON_DAY TxtColor:UIBUTTON_NIGHT];
        [_btn3 setNight:UILABEL_DAY TxtColor:UILABEL_NIGHT];

        _btn3.frame = CGRectMake(15, 250, 345, 40);
        [_btn3.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}


@end
