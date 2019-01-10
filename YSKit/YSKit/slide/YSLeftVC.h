//
//  YSLeftVC.h
//  UtilDemo
//
//  Created by Bob on 2018/6/12.
//  Copyright © 2018年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSLeftVC : UIViewController

//点击关闭按钮回调
@property (nonatomic, copy) void(^closeBlk)(void);

@end
