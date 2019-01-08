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


#define MJWeakSelf __weak typeof(self) weakSelf = self;

@interface YSLeftVC ()

@property (nonatomic, strong) YSTableV *tableV;

@property (nonatomic, assign) NSUInteger pageCnt;

@property (nonatomic, assign) NSUInteger curPage;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation YSLeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self makeNavTitle];
    
    [self makeContent];
}

- (void)makeNavTitle{
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"侧边栏";
    self.navigationController.navigationBar.barTintColor =[UIColor redColor];
    
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(closeSlide)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
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
    
    NSMutableArray *result = [@[] mutableCopy];
    for (int i = 1; i <= _pageCnt; i++) {
        NSString *uId = [@(_dataArr.count + 1) stringValue];
        
        YSUserInfoM *model = [YSUserInfoM new];
        model.userId = i;
        model.nickName = uId;
        model.signature = @"hello kitty";
        
        [result addObject:model];
        [_dataArr addObject:model];
    }
    
    [_tableV addObjectFromArray:result];
}


- (YSTableV *)tableV{
    if (!_tableV) {
        _tableV = [[YSTableV alloc] initWithFrame:self.view.bounds
                                       dataSource:@[]
                                         CellType:YSTypeUserInfo];
        [self.view addSubview:_tableV];
        
        MJWeakSelf;
        _tableV.selectedRow = ^(id  _Nonnull data) {
//            YSUserInfoM *model = (YSUserInfoM *)data;
//            YSLeftDetailVC *detailVC = [[YSLeftDetailVC alloc] initWithIdx:model.userId];
//            [weakSelf.navigationController pushViewController:detailVC animated:YES];
            
            YSUserInfoM *model = (YSUserInfoM *)data;
            NSString *msg = [@"选中用户ID：" stringByAppendingFormat:@"%lu",(unsigned long)model.userId];
            YSToastV *toastV = [[YSToastV alloc] initWithMsg:msg hdnAfter:.5f];
            [toastV showAnimation];
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
@end
