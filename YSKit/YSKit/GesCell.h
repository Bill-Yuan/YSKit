//
//  GesCell.h
//  YSKit
//
//  Created by Bob on 2017/11/27.
//  Copyright © 2017年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SWIPEWIDTH 44

@interface GesCell : UITableViewCell

@property (nonatomic, copy) NSString *tip;

@property (nonatomic, copy) void(^alertAction)(void);

- (void)swipeLeftOffsetX:(CGFloat)offset;
- (void)swipeRightOffsetX:(CGFloat)offset;

@end
