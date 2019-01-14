//
//  YSSwiVC.m
//  YSKit
//
//  Created by Bob on 2019/1/12.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSSwiVC.h"
#import "UIViewController+Setting.h"

#import "YSTableV.h"
#import "YSSwiTitleV.h"
#import "YSUtils.h"

#import "YSTableM.h"


@interface YSSwiVC ()
<
UIScrollViewDelegate
>
@property (nonatomic, strong) YSSwiTitleV *titleV;

@property (nonatomic, strong) UIScrollView *scollV;

@property (nonatomic, assign) CGFloat scrollH;

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
    for (int i = 0; i < 10; i++) {
        [arr addObject:[@(i) stringValue]];
    }
    
    _scrollH = 80;
    _titleV = [[YSSwiTitleV alloc] initWithFrame:CGRectMake(0, _scrollH, kScreenWidth, 40)
                                            Data:arr
                                            font:[UIFont systemFontOfSize:14]];
    [self.view addSubview:_titleV];
    
    CGFloat originY = _scrollH + 40;
    _scollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                             originY,
                                                             kScreenWidth,
                                                             kScreenHeight - originY)];
    [self.view addSubview:_scollV];
    _scollV.delegate = self;
    _scollV.pagingEnabled = YES;
    _scollV.contentSize = CGSizeMake(kScreenWidth * arr.count, kScreenHeight - originY + 16);
    
    for ( int i = 0; i < arr.count; i++) {
        CGRect frame = CGRectMake(kScreenWidth * i,
                                  0,
                                  kScreenWidth,
                                  CGRectGetHeight(_scollV.frame));
        YSTableV *tableV = [[YSTableV alloc] initWithFrame:frame
                                                dataSource:[self loadMoreData]
                                                  cellType:YSTypeUserInfo];
        
        __weak typeof(tableV) weakT = tableV;
        tableV.scrollOffset = ^(CGPoint offset) {
            CGRect frame = weakT.frame;

            if (offset.y > 0) {
                //上滑动
                CGFloat height = offset.y > 16 ? 16 : offset.y;
                frame.size.height = (kScreenHeight - originY) + height;
                weakT.frame = frame;
                
                CGRect frame1 = CGRectMake(0, _scrollH - height, kScreenWidth, 40);
                _titleV.frame = frame1;
                
                frame1 = _scollV.frame;
                frame1.origin.y = _scrollH - height + 40;
                _scollV.frame = frame1;
                
            }else if(offset.y < 0){
                //下滑动
                CGFloat height = offset.y < 16 ? -16 : offset.y;
                frame.size.height = (kScreenHeight - originY) + height;
                weakT.frame = frame;
                
                CGRect frame1 = CGRectMake(0, _scrollH - height, kScreenWidth, 40);
                _titleV.frame = frame1;
                
                frame1 = _scollV.frame;
                frame1.origin.y = _scrollH - height + 40;
                _scollV.frame = frame1;
            }
        };
        [_scollV addSubview:tableV];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"=====%@",NSStringFromClass([scrollView class]));
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//
//    for (UIView *childView in self.view.subviews) {
//        // 把当前控件上的坐标系转换成子控件上的坐标系
//        CGPoint childP = [self.view convertPoint:point toView:childView];
//        UIView *fitView = [childView hitTest:childP withEvent:event];
//        if (fitView) {
//            // 寻找到最合适的view
//            return fitView;
//        }
//    }
//
//    return self.view;
//}

@end
