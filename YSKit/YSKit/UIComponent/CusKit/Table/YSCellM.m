//
//  YSCellM.m
//  YSKit
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019 YS. All rights reserved.
//
//

/*
NSFontAttributeName               设置字体大小和字体的类型 默认12 Helvetica(Neue)
NSForegroundColorAttributeName    设置字体颜色，默认黑色 UIColor对象
NSBackgroundColorAttributeName    设置字体所在区域的背景颜色，默认为nil，透明色
NSLigatureAttributeName           设置连体属性，NSNumber对象 默认0 没有连体
NSKernAttributeName               设置字符间距， NSNumber浮点型属性 正数间距加大，负数间距缩小
NSStrikethroughStyleAttributeName 设置删除线，NSNumber对象
NSStrikethroughColorAttributeName 设置删除线颜色，UIColor对象，默认是黑色
NSUnderlineStyleAttributeName     设置下划线，NSNumber对象 NSUnderlineStyle枚举值
NSUnderlineColorAttributeName     设置下划线颜色，UIColor对象，默认是黑色
NSStrokeWidthAttributeName        设置笔画宽度，NSNumber对象 正数中空 负数填充
NSStrokeColorAttributeName        设置填充部分颜色，不是指字体颜色，UIColor对象
NSShadowAttributeName             设置阴影属性，取值为NSShadow对象
NSTextEffectAttributeName         设置文本特殊效果 NSString对象 只有图版印刷效果可用
NSBaselineOffsetAttributeName     设置基线偏移量，NSNumber float对象 正数向上偏移，负数向下偏移
NSObliquenessAttributeName        设置字体倾斜度，NSNumber float对象，正数右倾斜，负数左倾斜
NSExpansionAttributeName          设置文本横向拉伸属性，NSNumber float对象，正数横向拉伸文本，负数压缩
NSWritingDirectionAttributeName   设置文字书写方向，从左向右或者右向左
NSVerticalGlyphFormAttributeName  设置文本排版方向，NSNumber对象。0 横向排版，1 竖向排版
NSLinkAttributeName               设置文本超链接，点击可以打开指定URL地址
NSAttachmentAttributeName         设置文本附件，取值为NSTextAttachment对象，一般为图文混排
NSParagraphStyleAttributeName     设置文本段落排版，为NSParagraphStyle对象
*/

#import "YSCellM.h"
#import "YSTableM.h"
#import <Masonry.h>

#import "YSMarco.h"
#import "UILabel+Setting.h"

#import "YSKitUtils.h"
#import "UIImage+Quart.h"

@interface YSUserInfoCell ()

@property (nonatomic, strong) UILabel *nickLbl;

@property (nonatomic, strong) UILabel *signLbl;

@property (nonatomic, strong) UIImageView *photoImg;

@property (nonatomic, strong) UIButton *tipBtn;

@end

@implementation YSUserInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self tipBtn];
    }
    return self;
}

- (void)setModel:(YSUserInfoM *)model{
    self.nickLbl.text = model.nickName;
    self.signLbl.text = model.signature;
    
    if (!model.avator.length) {
        UIImage *image = [[YSKitUtils imageWithColor:[UIColor purpleColor] withFrame:CGRectMake(0, 0, 64, 64)] imageWithCornerRadius:10];
        
        NSDictionary *attDic = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor]};
        image = [YSKitUtils wMarkImage:image text:@"Bob"
                             textPoint:CGPointMake(8, 8)
                      attributedString:attDic];
        [_photoImg setImage:image];
    }
}

- (void)responeToBtn{
    if (self.clickSnap) {
        self.clickSnap(self.tag);
    }
}

#pragma mark --
#pragma mark init method
- (UIImageView *)photoImg{
    if (!_photoImg) {
        _photoImg = [UIImageView new];
        [self.contentView addSubview:_photoImg];

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

- (UIButton *)tipBtn{
    if (!_tipBtn) {
        _tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_tipBtn];
        _tipBtn.backgroundColor = [UIColor lightGrayColor];

        [_tipBtn addTarget:self
                    action:@selector(responeToBtn)
          forControlEvents:UIControlEventTouchUpInside];
        
        [_tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(40);
        }];
    }
    return _tipBtn;
}
@end
