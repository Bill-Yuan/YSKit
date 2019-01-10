//
//  YSCellM.m
//  YSKit
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSCellM.h"
#import "YSTableM.h"
#import <Masonry.h>

#import "YSMarco.h"
#import "UILabel+Setting.h"

@interface YSUserInfoCell ()

@property (nonatomic, strong) UILabel *nickLbl;

@property (nonatomic, strong) UILabel *signLbl;

@property (nonatomic, strong) UIImageView *photoImg;

@end

@implementation YSUserInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setModel:(YSUserInfoM *)model{
    self.nickLbl.text = model.nickName;
    self.signLbl.text = model.signature;
}


#pragma mark --
#pragma mark init method
- (UIImageView *)photoImg{
    if (!_photoImg) {
        _photoImg = [UIImageView new];
        [self.contentView addSubview:_photoImg];
        
        _photoImg.backgroundColor = [UIColor purpleColor];
        
        [_photoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(16);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(64);
        }];
        
    }
    return _photoImg;
}


- (UILabel *)nickLbl{
    if (!_nickLbl) {
        _nickLbl = [UILabel new];
        [self.contentView addSubview:_nickLbl];
        
        [_nickLbl setDay:UILABEL_DAY Night:UILABEL_NIGHT];
        _nickLbl.font = [UIFont boldSystemFontOfSize:16];

        [_nickLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.photoImg.mas_right).offset(8);
            make.top.mas_offset(16);
            make.height.mas_equalTo(20);
        }];
    }
    return _nickLbl;
}

- (UILabel *)signLbl{
    if (!_signLbl) {
        _signLbl = [UILabel new];
        [self.contentView addSubview:_signLbl];
        
        [_signLbl setDay:UILABEL_DAY Night:UILABEL_NIGHT];
        _signLbl.font = [UIFont boldSystemFontOfSize:16];
        
        [_signLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.photoImg.mas_right).offset(8);
            make.top.equalTo(self.nickLbl.mas_bottom).mas_offset(8);
            make.height.mas_equalTo(20);
        }];
    }
    return _signLbl;
}
@end
