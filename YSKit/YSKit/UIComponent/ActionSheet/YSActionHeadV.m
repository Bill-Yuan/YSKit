//
//  YSActionHeadV.m
//  GW_GTS2_iOS
//
//  Created by Bob on 2018/12/10.
//  Copyright © 2018 gw. All rights reserved.
//

#import "YSActionHeadV.h"
#import <Masonry.h>
#import "YSUtils.h"

@interface YSActionHeadV ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, copy) NSString *titleContent;

@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, strong) NSMutableArray *detailArr;

@property (nonatomic, strong) UITableView *tableV;

@property (nonatomic, copy) void (^closeBlock)(void) ;

@end

@implementation YSActionHeadV


//36 --- 32 + 60
- (id)initWithFrame:(CGRect)frame title:(NSString *)title
           textData:(NSArray *)textArr
         detailData:(NSArray *)detailArr
         closeBlock:(void(^)(void))closeAction
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = THEMECOLOR;
        
        _titleContent = title;
        _closeBlock = closeAction;
        [self setData:textArr detailData:detailArr];
     }
    return self;
}


- (void)setData:(NSArray *)textArr detailData:(NSArray *)detailArr{
    _titleArr = [textArr mutableCopy];
    _detailArr = [detailArr mutableCopy];
    
    [self.tableV reloadData];
}

#pragma mark --
#pragma mark btn action
- (void)responseToClose
{
    if(self.closeBlock){
        self.closeBlock();
    }
}

#pragma mrak --
#pragma mark delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MIN(_titleArr.count , _detailArr.count);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger cnt = MIN(_titleArr.count , _detailArr.count);
    if (row == 0) {
        return 36;
    }else if (row == cnt - 1){
        return 48;
    }
    return 32;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *leftLbl = [UILabel new];
        [cell.contentView addSubview:leftLbl];
        leftLbl.tag = 1000;
        leftLbl.font = [UIFont systemFontOfSize:14];
        leftLbl.textColor = [UIColor lightGrayColor];
        
    
        UILabel *rightLbl = [UILabel new];
        [cell.contentView addSubview:rightLbl];
        rightLbl.tag = 1001;
        rightLbl.font = [UIFont boldSystemFontOfSize:14];
        rightLbl.textColor = [UIColor blackColor];
    }
    
    UILabel *leftLbl = [cell.contentView viewWithTag:1000];
    leftLbl.text = _titleArr[indexPath.row];
    
    UILabel *rightLbl = [cell.contentView viewWithTag:1001];
    rightLbl.text = _detailArr[indexPath.row];
   
    CGFloat originY = (0 == indexPath.row) ? 16 : 12;
    [leftLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView).offset(16);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(originY);
    }];
    
    [rightLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.contentView).offset(-34);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(originY);
    }];
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect headFrame = _tableV.frame;
    headFrame.size.height = 60;
    UIView *headV = [[UIView alloc] initWithFrame:headFrame];
   
    UILabel *title = [UILabel new];
    [headV addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headV);
        make.height.mas_equalTo(28);
        make.centerY.equalTo(headV.mas_centerY);
    }];
    
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:20];
    title.textColor = [UIColor blackColor];
    
    title.text = _titleContent;
    
    UIButton *clickBtn = [UIButton new];
    [headV addSubview:clickBtn];
    [clickBtn setBackgroundColor:[UIColor redColor]];

    [clickBtn addTarget:self
                 action:@selector(responseToClose)
       forControlEvents:UIControlEventTouchUpInside];

    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(27);
        make.height.mas_equalTo(27);
        make.top.mas_equalTo(18);
        make.right.equalTo(headV).offset(-32);
    }];
    
    
    UIImageView *sepLineImg = [UIImageView new];
    [headV addSubview:sepLineImg];
    
    [sepLineImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headV);
        make.top.mas_offset(59);
        make.height.mas_offset(1);
    }];
    
    sepLineImg.backgroundColor = [UIColor lightGrayColor];
    
    return headV;
}


- (UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [self addSubview:_tableV];
        
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.scrollEnabled = NO;
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableV;
}
@end
