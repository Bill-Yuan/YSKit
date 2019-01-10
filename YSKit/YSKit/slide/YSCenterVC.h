//
//  YSCenterVC.h
//  UtilDemo
//
//  Created by Bob on 2018/6/12.
//  Copyright © 2018年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSCenterVC : UIViewController

//点击打开按钮回调
@property (nonatomic, copy) void(^openBlk)(void);

@end
