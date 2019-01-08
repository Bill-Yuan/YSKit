//
//  YSUtils.m
//  YSKit
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSUtils.h"
#import "AppDelegate.h"

@implementation YSUtils

+ (NSUInteger)getFontWidth:(NSString *)text fontInfo:(UIFont *)font{
    CGSize maxSize = CGSizeMake(kScreenWidth - 16, MAXFLOAT);
    CGSize nameSize = [text boundingRectWithSize:maxSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil].size;
    return ceil(nameSize.width);
}

+ (CGFloat)tabBarHeight{
 
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *tabBarC = (UITabBarController *)del.window.rootViewController;
    CGFloat tabBarH = CGRectGetHeight(tabBarC.tabBar.frame);
    return tabBarH;
}
@end
