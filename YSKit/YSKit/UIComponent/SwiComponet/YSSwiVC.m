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
}

- (void)createView{
    
    NSMutableArray *arr = [@[] mutableCopy];
    for (int i = 0; i < 10; i++) {
        [arr addObject:[@(i) stringValue]];
    }
    
    _titleV = [[YSSwiTitleV alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)
                                            Data:arr
                                            font:[UIFont systemFontOfSize:14]];
    [self.view addSubview:_titleV];
    
    
    _scollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight - 40)];
    [self.view addSubview:_scollV];
    _scollV.delegate = self;
    _scollV.pagingEnabled = YES;
    _scollV.contentSize = CGSizeMake(kScreenWidth * arr.count, kScreenHeight - 40);

    for ( int i = 0; i < arr.count; i++) {
        CGRect frame = CGRectMake(kScreenWidth * i, 40, kScreenWidth, kScreenHeight - 40);
        YSTableV *tableV = [[YSTableV alloc] initWithFrame:frame
                                                dataSource:@[]
                                                  cellType:YSTypeUserInfo];
        [_scollV addSubview:tableV];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}


@end
