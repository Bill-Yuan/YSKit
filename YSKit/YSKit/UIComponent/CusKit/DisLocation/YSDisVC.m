//
//  YSDisVC.m
//  YSKit
//
//  Created by mac on 2019/1/12.
//  Copyright © 2019年 YS. All rights reserved.
//

#import "YSDisVC.h"
#import "YSTableV.h"
#import "YSUtils.h"

@interface YSDisVC ()
<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate
>

@property (nonatomic, strong) UIView *tableHead;

@property (nonatomic, strong) YSTableV *contentV;

@property (nonatomic, strong) UITableView *tableV;

@property (nonatomic, assign) CGFloat headH;

@end


@implementation YSDisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _headH = 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y - _headH;
    if (offsetY) {
        [_contentV scrollToPoint:CGPointMake(0, offsetY)];
    }
}

#pragma mark --
#pragma mark init
- (UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_tableV];
        
        _tableV.delegate = self;
        _tableV.dataSource = self;
        
        _tableV.tableHeaderView = self.tableHead;
    }
    
    return _tableV;
}

- (UIView *)tableHead{
    if (!_tableHead) {
        _tableHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _headH)];
        _tableHead.backgroundColor = [UIColor purpleColor];
    }
    return _tableHead;
}
@end
