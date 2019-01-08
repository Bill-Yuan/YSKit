//
//  YSUtils.h
//  YSKit
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019 YS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define  KTabbarHeight          [YSUtils tabBarHeight]
#define  THEMECOLOR             UIColorHexFromRGB(0xFFFFFF)
#define  kScreenWidth           [[UIScreen mainScreen] bounds].size.width

#define UIColorHexFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


// 防止多次调用
#define kPreventRepeatClickTime(_seconds_) \
static BOOL shouldPrevent; \
if (shouldPrevent) return; \
shouldPrevent = YES; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_seconds_) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
shouldPrevent = NO; \
}); \
 
@interface YSUtils : NSObject

+ (NSUInteger)getFontWidth:(NSString *)text fontInfo:(UIFont *)font;

+ (CGFloat)tabBarHeight;

@end

NS_ASSUME_NONNULL_END
