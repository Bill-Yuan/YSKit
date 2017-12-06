//
//  GesCell.m
//  YSKit
//
//  Created by Bob on 2017/11/27.
//  Copyright © 2017年 YS. All rights reserved.
//

#import "GesCell.h"
#import <Masonry.h>

#define SEPLINEH 1.0/[[UIScreen mainScreen] scale]

@interface GesCell()

@property (nonatomic, strong) UIButton *swipeBtn;

@property (nonatomic, strong) UILabel *tipLbl;

@property (nonatomic, strong) UIImageView *sepLineImg;

@end

@implementation GesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sepLineImg];
    }
    return self;
}

#pragma mark --
#pragma mark init method
- (void)setTip:(NSString *)tip
{
    _tip = tip;
    self.tipLbl.text = tip;
}

- (void)showSepLine
{
    self.sepLineImg.hidden = NO;
}

- (void)hidSepLine
{
    self.sepLineImg.hidden = YES;
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
        _swipeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_swipeBtn];

        [_swipeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_swipeBtn.superview.mas_right);
            make.top.equalTo(_swipeBtn.superview);
            make.height.equalTo(_swipeBtn.superview);
            make.width.equalTo(@(44));
        }];
        _swipeBtn.backgroundColor = [UIColor redColor];
        [_swipeBtn addTarget:self
                      action:@selector(responeseBtnAction)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _swipeBtn;
}

- (UILabel *)tipLbl
{
    if (!_tipLbl) {
        _tipLbl = [UILabel new];
        [self.contentView addSubview:_tipLbl];
        [_tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(_tipLbl.superview.mas_centerY);
        }];
    }
    return _tipLbl;
}

- (UIImageView *)sepLineImg
{
    if (!_sepLineImg) {
        _sepLineImg = [UIImageView new];
        [self.contentView addSubview:_sepLineImg];
        [_sepLineImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.offset(0);
            make.bottom.equalTo(_sepLineImg.superview).offset(0);
            make.height.offset(SEPLINEH);
        }];
        _sepLineImg.backgroundColor = [UIColor brownColor];
    }
    return _sepLineImg;
}
@end
