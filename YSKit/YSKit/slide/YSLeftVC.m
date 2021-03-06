//
//  YSLeftVC.m
//  UtilDemo
//
//  Created by Bob on 2018/6/12.
//  Copyright © 2018年 YS. All rights reserved.
//

#import "YSLeftVC.h"
#import "YSLeftDetailVC.h"


#import "YSTableV.h"
#import "YSTableM.h"
#import "YSToastV.h"

#import "YSUtils.h"
#import "YSActionHeadV.h"
#import "YSActionSheetV.h"


#import "YSMarco.h"
#import "UIViewController+Setting.h"


#import "YSSwiVC.h"
#import "YSDrawVC.h"
#import "YSAnimationVC.h"

#define MJWeakSelf __weak typeof(self) weakSelf = self;

@interface YSLeftVC ()

@property (nonatomic, strong) YSTableV *tableV;

@property (nonatomic, assign) NSUInteger pageCnt;

@property (nonatomic, assign) NSUInteger curPage;

@property (nonatomic, strong) NSMutableArray *dataArr;


@property (nonatomic, strong) YSActionSheetV *actionSheetV;

@end

@implementation YSLeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self makeNavTitle];
    
    [self makeContent];
}

- (void)makeNavTitle{
    self.title = @"侧边栏";
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(closeSlide)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    [self setDay:THEME_DAY Night:THEME_NIGHT];
}

- (void)makeContent{
    
    _curPage = 1;
    _pageCnt = 10;
    _dataArr = [@[] mutableCopy];
    
    [self tableV];
    [self loadMoreData];
}

- (void)closeSlide
{
    if(self.closeBlk){
        self.closeBlk();
    }
}

- (void)loadMoreData{
    
    if (_curPage <= 1) {
        [_dataArr removeAllObjects];
        [_tableV resetData];
    }
    
    NSArray *classArr = @[@"YSSwiVC",@"YSAnimationVC",@"YSDrawVC"];
    NSMutableArray *result = [@[] mutableCopy];
    for (NSString *className in classArr) {
        NSString *uId = [@(_dataArr.count + 1) stringValue];
        
        YSUserInfoM *model = [YSUserInfoM new];
        model.userId = 0;
        model.nickName = uId;
        model.signature = @"hello kitty";
        model.className = className;
        
        [result addObject:model];
        [_dataArr addObject:model];
    }
    
    [_tableV addObjectFromArray:result];
}


- (YSTableV *)tableV{
    if (!_tableV) {
        _tableV = [[YSTableV alloc] initWithFrame:self.view.bounds
                                       dataSource:@[]
                                         cellType:YSTypeUserInfo];
        [self.view addSubview:_tableV];
        
    
        MJWeakSelf;
        _tableV.selectedRow = ^(NSUInteger row,id  _Nonnull data) {

            YSUserInfoM *model  = (YSUserInfoM *)data;
            Class class = NSClassFromString(model.className);            
            [weakSelf.navigationController pushViewController:[class new] animated:YES];
        };
        
        _tableV.headerRefresh = ^{
            weakSelf.curPage = 1;
            [weakSelf loadMoreData];
        };
        
        _tableV.footerRefresh = ^{
            weakSelf.curPage++;
            [weakSelf loadMoreData];
        };
        
    }
    return _tableV;
}

- (YSActionSheetV *)actionSheetV{
    MJWeakSelf;
    
    CGFloat height = 60 + (4 - 2) * 32 + 36 * 2 + 12;
    CGRect frame = CGRectMake( 0, 0, kScreenWidth, height);
    
    YSActionHeadV *headV = [[YSActionHeadV alloc] initWithFrame:frame title:@"开仓成功" textData:@[@"持仓号",@"币种",@"开仓价",@"开仓数量"] detailData:@[@"#123",@"BTC/USD",@"3918.34",@"0.1"] closeBlock:^{
        [weakSelf.actionSheetV dismiss];
    }];
    _actionSheetV = [[YSActionSheetV alloc] initWithTitleView:headV optionsArr:@[@"查看持仓",@"继续交易"] cancelTitle:nil selectedBlock:^(NSInteger index) {
        YSToastV *toastV = [[YSToastV alloc] initWithMsg:@"选中用户ID:123" hdnAfter:.5f];
        [toastV showAnimation];
    } cancelBlock:^{
        ;
    }];

    return _actionSheetV;
}









@end
