//
//  YSTableV.m
//  YSKit
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSTableV.h"
#import <Masonry.h>

#import "YSCellM.h"
#import "YSTableL.h"
#import "MJRefresh.h"

#import "YSUtils.h"
#import "YSMarco.h"
#import "UITableView+Setting.h"

@interface YSTableV ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *noDataV;

@property (nonatomic, strong) UITableView *tableV;

@property (nonatomic, assign) YSTableType tableType;

@property (nonatomic, strong) YSTableL *layoutInfo;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YSTableV


#pragma mark --
#pragma mark life cycle method
- (id)initWithFrame:(CGRect)frame dataSource:(NSArray *)data CellType:(YSTableType)type{
    self = [super initWithFrame:frame];
    if (self) {
        _tableType = type;
        
        if (data &&
            ([data isKindOfClass:[NSArray class]] ||
             [data isKindOfClass:[NSMutableArray class]])) {
            _dataSource = [data mutableCopy];
        }else{
            _dataSource = [@[] mutableCopy];
        }
        
        [self initLayoutInfo];
    }
    return self;
}

- (void)initLayoutInfo{
    switch (_tableType) {
        case YSTypeUserInfo:{
            _layoutInfo = [YSTableL new];
            _layoutInfo.cellName = @"YSUserInfoCell";
            _layoutInfo.cellHeight = 80;
        }
            break;
            
        default:
            break;
    }
    
    [self.tableV reloadData];
}


#pragma mark --
#pragma mark init method
- (void)setHeaderRefresh:(void (^)(void))headerRefresh{
    _tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:headerRefresh];
}

- (void)setFooterRefresh:(void (^)(void))footerRefresh{
    _tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:footerRefresh];
}


#pragma mark --
#pragma mark interface method
- (void)resetData{
    [_dataSource removeAllObjects];
    [_tableV reloadData];
    
    [self showNoData];
}

- (void)addObjectFromArray:(NSArray *)dataArr{
    
    [self showContent];
    
    [_dataSource addObjectsFromArray:dataArr];
    [_tableV reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self endRefresh];
    });
}

- (void)replaceObject:(id)object WithIndex:(NSUInteger)idx{
    
}

- (void)endRefresh{
    [_tableV.mj_header endRefreshing];
    [_tableV.mj_footer endRefreshing];
}

- (void)clickLoadData{
    if (self.reClickData) {
        self.reClickData();
    }
}

#pragma mark --
#pragma mark logic method
- (void)showNoData{
    _noDataV.hidden = NO;
    _tableV.hidden = YES;
}

- (void)showContent{
    _noDataV.hidden = YES;
    _tableV.hidden = NO;
}

#pragma mark --
#pragma mark tableView delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _layoutInfo.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_layoutInfo.cellName];
    if (!cell) {
        Class ClassName = NSClassFromString(_layoutInfo.cellName);
        cell = [[ClassName alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:_layoutInfo.cellName];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (_tableType) {
        case YSTypeUserInfo:{
            YSUserInfoM *model = _dataSource[indexPath.row];
            [(YSUserInfoCell *)cell setModel:model];
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    kPreventRepeatClickTime(2.f);

    if(self.selectedRow){
        self.selectedRow(_dataSource[indexPath.row]);
    }
}

#pragma mark --
#pragma mark init
- (UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:self.bounds
                                               style:UITableViewStylePlain];
        [self addSubview:_tableV];
        
        _tableV.delegate = self;
        _tableV.dataSource = self;
        
        [_tableV setDay:TABLE_DAY Night:TABLE_NIGHT];
    }
    return _tableV;
}

- (UIView *)noDataV{
    if (!_noDataV) {
        _noDataV = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_noDataV];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_noDataV addSubview:btn];
        
        btn.backgroundColor = [UIColor redColor];
        
        [btn addTarget:self
                action:@selector(reClickData)
      forControlEvents:UIControlEventTouchUpInside];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataV.mas_centerX);
            make.centerY.equalTo(_noDataV.mas_centerY);
            make.width.height.mas_equalTo(80);
        }];
    }
    return _noDataV;
}

@end
