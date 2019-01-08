//
//  YSActionHeadV.h
//  UtilDemo
//
//  Created by Bob on 2018/12/10.
//  Copyright © 2018 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSActionHeadV : UIView


/**
 初始化交易结果页的公共头部

 @param frame 头部大小
 @param title 头部标题
 @param textArr @[...]
 @param detailArr @[...]
 @param closeAction 点击回调

 @return 初始化结果
 */
- (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
           textData:(NSArray *)textArr
         detailData:(NSArray *)detailArr
         closeBlock:(void(^)(void))closeAction;

@end

NS_ASSUME_NONNULL_END
