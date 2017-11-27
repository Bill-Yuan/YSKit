//
//  GesCell.m
//  YSKit
//
//  Created by Bob on 2017/11/27.
//  Copyright © 2017年 YS. All rights reserved.
//

#import "GesCell.h"

@interface GesCell()

@property (nonatomic, strong) UIButton *swipeBtn;

@property (nonatomic, strong) UILabel *tipLbl;

@end

@implementation GesCell

#pragma mark --
#pragma mark init method
- (void)setTip:(NSString *)tip
{
    _tipLbl.text = tip;
}


#pragma mark --
#pragma mark call method
/**
 往左移
 
 @param offset 小于0的x便移
 */
- (void)swipeLeftOffsetX:(CGFloat)offset
{
    CGRect frame = self.contentView.frame;
    frame.origin.x = offset;
    self.contentView.frame = frame;
    
    frame = self.swipeBtn.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width + offset;
    self.swipeBtn.frame = frame;
}


/**
 往右移
 
 @param offset 大于0的x便移
 */
- (void)swipeRightOffsetX:(CGFloat)offset
{
    
    CGRect frame = self.contentView.frame;
    if (frame.origin.x >= 0) {
        return;
    }
    
    double change = offset;
    if (change + frame.origin.x > 0) {
        change = -frame.origin.x;
    }
    frame.origin.x += change;
    self.contentView.frame = frame;
    
    frame = self.swipeBtn.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width + change;
    self.swipeBtn.frame = frame;
}


#pragma mark --
#pragma mark btn action
- (void)responeseBtnAction
{
    if (self.alertAction) {
        self.alertAction();
    }
}


- (void)layoutSubviews
{
    [self tipLbl];
    [self swipeBtn];
}


#pragma mark --
#pragma mark lazy load
- (UIButton *)swipeBtn
{
    if (!_swipeBtn) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _swipeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _swipeBtn.frame = CGRectMake( width, 0, SWIPEWIDTH, 44);
        _swipeBtn.backgroundColor = [UIColor redColor];
        [_swipeBtn addTarget:self
                      action:@selector(responeseBtnAction)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_swipeBtn];
    }
    return _swipeBtn;
}

- (UILabel *)tipLbl{
    if (!_tipLbl) {
        _tipLbl = [[UILabel alloc] initWithFrame:CGRectMake( 10, 0, [[UIScreen mainScreen] bounds].size.width - 10, 44)];
        [self.contentView addSubview:_tipLbl];
    }
    return _tipLbl;
}
@end
