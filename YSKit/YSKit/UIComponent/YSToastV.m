//
//  YSToastV.m
//  CF_GTS2
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019 gw. All rights reserved.
//

#import "YSToastV.h"
#import <Masonry.h>
#import "YSUtils.h"

@interface YSToastV ()

@property (nonatomic, strong) UILabel *tip;

@property (nonatomic, strong) UIView *contentV;

@property (nonatomic, strong) NSString *msg;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSTimeInterval afterTime;

@end

@implementation YSToastV

- (instancetype)initWithMsg:(NSString *)msg hdnAfter:(NSTimeInterval)hdnTime{
    if (self = [super init]) {
        _msg = msg;
        _afterTime = hdnTime;
        [self addMsg];
    }
    
    return self;
}

- (void)addMsg{
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.alpha = 0.f;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGFloat width = [YSUtils getFontWidth:_msg
                                 fontInfo:[UIFont boldSystemFontOfSize:16]];
    
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(width + 30);
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self).mas_offset(-KTabbarHeight -30);
    }];
    
    self.tip.text = _msg;
    
    [self.tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentV).mas_offset(15);
        make.right.equalTo(self.contentV).mas_offset(-15);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(self.contentV.mas_centerY);
    }];
}

- (void)showAnimation{
    [UIView animateWithDuration:.4f animations:^{
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        [self timer];
    }];
}

- (void)hdnAnimation{
    [UIView animateWithDuration:.4f animations:^{
        self.alpha = .5f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark --
#pragma mark init
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_afterTime
                                                  target:self
                                                selector:@selector(hdnAnimation)
                                                userInfo:nil
                                                 repeats:NO];
    }
    return _timer;
}
 
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [UIView new];
        [self addSubview:_contentV];
        
        _contentV.backgroundColor = [UIColor blackColor];
        
        _contentV.layer.masksToBounds = YES;
        _contentV.layer.cornerRadius = 4;
    }
    return _contentV;
}

- (UILabel *)tip{
    if (!_tip) {
        _tip = [UILabel new];
        [self.contentV addSubview:_tip];
        
        _tip.font = [UIFont boldSystemFontOfSize:16];
        _tip.textColor = THEMECOLOR;
        _tip.textAlignment = NSTextAlignmentCenter;
    }
    return _tip;
}
@end
