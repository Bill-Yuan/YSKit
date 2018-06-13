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

#import "YSCusBtn.h"
#import "YSSettingMgr.h"
#import "UIViewController+Setting.h"


#import "YSSafeAryVC.h"
#import "YSSpeechVC.h"

@interface YSCenterVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) YSCusBtn *btn;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;

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
    self.view.backgroundColor = [UIColor blackColor];
    [self s_viewDidLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self settingMethod];
    [self initControl];
}

- (void)settingMethod
{
    self.title = @"主页";
    self.navigationController.navigationBar.barTintColor =[UIColor yellowColor];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"打开" style:UIBarButtonItemStyleDone target:self action:@selector(openSlide)];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
}

- (void)initControl
{
    [self.btn setDay:[UIColor blackColor] TxtColor:[UIColor whiteColor]];
    [self.btn setNight:[UIColor grayColor] TxtColor:[UIColor blackColor]];
    
    [self.btn1 setDay:[UIColor grayColor] TxtColor:[UIColor blackColor]];
    [self.btn1 setNight:[UIColor blackColor] TxtColor:[UIColor whiteColor]];
    
    [self.btn2 setDay:[UIColor blackColor] TxtColor:[UIColor whiteColor]];
    [self.btn2 setNight:[UIColor grayColor] TxtColor:[UIColor blackColor]];
    
    [self.btn3 setDay:[UIColor grayColor] TxtColor:[UIColor blackColor]];
    [self.btn3 setNight:[UIColor blackColor] TxtColor:[UIColor whiteColor]];
    
    [self.btn4 setDay:[UIColor brownColor] TxtColor:[UIColor whiteColor]];
    [self.btn4 setNight:[UIColor purpleColor] TxtColor:[UIColor greenColor]];
    
    [self setDay:[UIColor blueColor] Night:[UIColor lightGrayColor]];
}

- (void)openSlide
{
    if(self.openBlk){
        self.openBlk();
    }
}

- (void)btnAction:(UIButton *)sender
{
    [[YSSettingMgr shareInstance] changeTheme];
    
    switch (sender.tag) {
        case 1:{
            [self.navigationController pushViewController:[YSSafeAryVC new] animated:YES];
        }
            break;
        case 2:{
            [self.navigationController pushViewController:[YSSpeechVC new] animated:YES];
        }
            break;
        default:
            break;
    }
}

- (YSCusBtn *)btn
{
    if (!_btn) {
        _btn = [YSCusBtn buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn];
        
        _btn.frame = CGRectMake(15, 100, 345, 40);
        [_btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btn setTitle:@"First" forState:UIControlStateNormal];
    }
    return _btn;
}

- (UIButton *)btn1
{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn1];
        
        _btn1.frame = CGRectMake(15, 150, 345, 40);
        [_btn1.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btn1 setTitle:@"线程安全数组" forState:UIControlStateNormal];
        _btn1.tag = 1;
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
        [_btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btn2 setTitle:@"语音交互" forState:UIControlStateNormal];
        _btn1.tag = 2;
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
        [_btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
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
        [_btn4 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btn4 setTitle:@"Fifth" forState:UIControlStateNormal];
    }
    return _btn4;
}
@end
