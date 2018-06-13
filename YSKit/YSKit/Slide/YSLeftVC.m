//
//  YSLeftVC.m
//  UtilDemo
//
//  Created by Bob on 2018/6/12.
//  Copyright © 2018年 YS. All rights reserved.
//

#import "YSLeftVC.h"
#import "YSLeftDetailVC.h"

@interface YSLeftVC ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableV;

@end

@implementation YSLeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"侧边栏";
    self.navigationController.navigationBar.barTintColor =[UIColor redColor];
    
    [self.tableV reloadData];
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(closeSlide)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}


- (void)closeSlide
{
    if(self.closeBlk){
        self.closeBlk();
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = NSStringFromClass([UITableViewCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [@(indexPath.row) stringValue];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSLeftDetailVC *detailVC = [[YSLeftDetailVC alloc] initWithIdx:(indexPath.row+1)];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UITableView *)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_tableV];
        
        _tableV.delegate = self;
        _tableV.dataSource = self;
    }
    return _tableV;
}
@end
