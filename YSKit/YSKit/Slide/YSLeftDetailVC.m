//
//  YSLeftDetailVC.m
//  UtilDemo
//
//  Created by Bob on 2018/6/12.
//  Copyright © 2018年 YS. All rights reserved.
//

#import "YSLeftDetailVC.h"

@interface YSLeftDetailVC ()

@end

@implementation YSLeftDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
}

- (instancetype)initWithIdx:(NSInteger)idx
{
    self = [super init];
    if (self) {
        self.title = [@(idx) stringValue];
    }
    return self;
}

@end
