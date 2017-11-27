//
//  ViewController.m
//  YSKit
//
//  Created by Bob on 2017/11/27.
//  Copyright © 2017年 YS. All rights reserved.
//

#import "ViewController.h"
#import "GesCell.h"


@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIGestureRecognizerDelegate
>

@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSIndexPath *sIdxPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableV reloadData];
}

#pragma mark --
#pragma mark ges action
static double pointX = 0;
- (void)swipe:(UIPanGestureRecognizer *)ges
{
    CGPoint point = [ges locationInView:_tableV];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:floor(point.y/44) inSection:0];
    if (!_sIdxPath) {
        _sIdxPath = indexPath;
    }else{
        if (_sIdxPath.row != indexPath.row) {
            GesCell *cell = [_tableV cellForRowAtIndexPath:_sIdxPath];
            [cell swipeLeftOffsetX:0];
        }
        _sIdxPath = indexPath;
    }
    
    GesCell *cell = [_tableV cellForRowAtIndexPath:_sIdxPath];
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:{
            pointX = point.x;
        }
            break;
        case UIGestureRecognizerStateChanged:{
            double offsetX =  point.x - pointX;
            if (offsetX > 0) {
                if (offsetX >= 2 * SWIPEWIDTH) {
                    offsetX = 2 * SWIPEWIDTH;
                }
                [cell swipeRightOffsetX:offsetX];
            }else{
                if(offsetX <= -(2 * SWIPEWIDTH)){
                    offsetX = -(2 * SWIPEWIDTH);
                }
                [cell swipeLeftOffsetX:offsetX];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:{
            [UIView animateWithDuration:.3f animations:^{
                double offsetX =  point.x - pointX;
                if (offsetX > 0) {
                    if (offsetX >= SWIPEWIDTH) {
                        offsetX = SWIPEWIDTH;
                    }
                    [cell swipeRightOffsetX:offsetX];
                }else{
                    if(offsetX <= -SWIPEWIDTH){
                        offsetX = -SWIPEWIDTH;
                    }
                    [cell swipeLeftOffsetX:offsetX];
                }
            }];
        }
            break;
        default:{
            
        }
            break;
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark --
#pragma mark tableView delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GesCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tip = [NSString stringWithFormat:@"当前:%ld行",(long)indexPath.row];
    __weak ViewController *wSelf = self;
    cell.alertAction = ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击侧滑" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"重置" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:resetAction];
        [wSelf presentViewController:alert animated:YES completion:nil];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:[NSString stringWithFormat:@"%ld",(long)indexPath.row]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"重置"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:nil];
    [alert addAction:resetAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark --
#pragma mark lazy load
- (UITableView *)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_tableV];
        _tableV.backgroundColor = [UIColor brownColor];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [_tableV registerClass:[GesCell class] forCellReuseIdentifier:NSStringFromClass([GesCell class])];
        _tableV.estimatedRowHeight = 44;
        
        UISwipeGestureRecognizer *lGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(swipe:)];
        lGes.direction = UISwipeGestureRecognizerDirectionLeft;
        lGes.delegate = self;
        [_tableV addGestureRecognizer:lGes];
        
        UIPanGestureRecognizer *rGes = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(swipe:)];
        rGes.delegate = self;
        [_tableV addGestureRecognizer:rGes];
    }
    return _tableV;
}

@end
