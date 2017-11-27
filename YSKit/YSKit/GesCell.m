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

@end

@implementation GesCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake( 0, 0, [[UIScreen mainScreen] bounds].size.width, 44)];
        [self.contentView addSubview:tip];
        
        tip.textColor = [UIColor grayColor];
        tip.textAlignment = NSTextAlignmentCenter;
        tip.backgroundColor = [UIColor greenColor];
    }
    return self;
}


- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILabel class]]) {
            [(UILabel *)obj setText:titleStr];
            *stop = YES;
        }
    }];
}


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

- (void)layoutSubviews
{
    [self swipeBtn];
}


- (void)responeseBtnAction
{
    if (self.alertAction) {
        self.alertAction();
    }
}

- (UIButton *)swipeBtn
{
    if (!_swipeBtn) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _swipeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _swipeBtn.frame = CGRectMake( width, 0, 44, 44);
        _swipeBtn.backgroundColor = [UIColor redColor];
        [_swipeBtn addTarget:self
                      action:@selector(responeseBtnAction)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_swipeBtn];
    }
    return _swipeBtn;
}

@end
