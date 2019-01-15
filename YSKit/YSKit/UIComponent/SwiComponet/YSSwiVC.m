//
//  YSSwiVC.m
//  YSKit
//
//  Created by Bob on 2019/1/12.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSSwiVC.h"
#import "UIViewController+Setting.h"

#import "YSTableM.h"
#import "YSTableV.h"
#import "YSSwiTitleV.h"

#import "YSUtils.h"

#define NavH   64
#define TitleH 88

@interface YSSwiVC ()
<
UIScrollViewDelegate
>
@property (nonatomic, strong) YSSwiTitleV *titleV;

@property (nonatomic, strong) UIScrollView *scollV;


@end

@implementation YSSwiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self createView];
}

- (NSMutableArray *)loadMoreData{
    NSMutableArray *result = [@[] mutableCopy];
    for (int i = 1; i <= 10; i++) {
 
        YSUserInfoM *model = [YSUserInfoM new];
        model.userId = i;
        model.nickName = [@(i) stringValue];
        model.signature = @"hello kitty";
        
        [result addObject:model];
    }
    return  result;
}

- (void)createView{
 
    NSMutableArray *arr = [@[] mutableCopy];
    for (int i = 0; i < 1; i++) {
        [arr addObject:[@(i) stringValue]];
    }
    
    CGRect tFrame = CGRectMake(0, NavH + TitleH, kScreenWidth, 40);
    _titleV = [[YSSwiTitleV alloc] initWithFrame:tFrame
                                            Data:arr
                                            font:[UIFont systemFontOfSize:14]];
    [self.view addSubview:_titleV];
    
    CGFloat originY = CGRectGetMaxY(tFrame);
    _scollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                             originY,
                                                             kScreenWidth,
                                                             kScreenHeight - originY)];
    [self.view addSubview:_scollV];
    _scollV.delegate = self;
    _scollV.pagingEnabled = YES;
 
    _scollV.backgroundColor = [UIColor yellowColor];
    
    for ( int i = 0; i < arr.count; i++) {
        CGRect frame = CGRectMake(kScreenWidth * i,
                                  0,
                                  kScreenWidth,
                                  CGRectGetHeight(_scollV.frame) + TitleH);
        YSTableV *tableV = [[YSTableV alloc] initWithFrame:frame
                                                dataSource:[self loadMoreData]
                                                  cellType:YSTypeUserInfo];
        [_scollV addSubview:tableV];


        tableV.scrollOffset = ^(CGPoint offset, CGFloat dir) {

            if (dir > 0) {
                //下滑动
                if(CGRectGetMinY(_titleV.frame) < NavH + TitleH){
                    CGFloat height = offset.y  < TitleH ? offset.y : TitleH;
                    
                    CGRect frame1 = CGRectMake(0,
                                               NavH + height,
                                               kScreenWidth,
                                               40);
                    _titleV.frame = frame1;
                    
                    frame1 = _scollV.frame;
                    frame1.origin.y = originY;
                    frame1.size.height = kScreenHeight - CGRectGetMaxY(_titleV.frame);
                    _scollV.frame = frame1;
                }
            }else if(dir < 0){
                //上滑动  offsetY > 0
                if (CGRectGetMinY(_titleV.frame) > NavH) {
                    CGFloat height = TitleH > offset.y ? TitleH : offset.y;
                    
                    CGRect frame1 = CGRectMake(0,
                                               NavH + TitleH - height,
                                               kScreenWidth,
                                               40);
                    _titleV.frame = frame1;
                    
                    frame1 = _scollV.frame;
                    frame1.origin.y = CGRectGetMaxY(_titleV.frame);
                    frame1.size.height = kScreenHeight - CGRectGetMaxY(_titleV.frame);
                    
                    _scollV.frame = frame1;
                }
            }
        };
    }
}

@end
