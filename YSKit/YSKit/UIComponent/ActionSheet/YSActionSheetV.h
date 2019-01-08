//
//  YSActionSheetV.h
//  UtilDemo
//
//  Created by Bob on 2018/5/5.
//  Copyright © 2017年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSActionSheetV : UIView

- (instancetype)initWithTitleView:(UIView*)titleView
                       optionsArr:(NSArray*)optionsArr
                      cancelTitle:(NSString*)cancelTitle
                    selectedBlock:(void(^)(NSInteger))selectedBlock
                      cancelBlock:(void(^)(void))cancelBlock;

- (void)dismiss;

@end
