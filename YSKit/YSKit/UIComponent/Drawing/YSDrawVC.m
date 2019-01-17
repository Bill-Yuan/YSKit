//
//  YSDrawVC.m
//  YSKit
//
//  Created by Bob on 2019/1/17.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSDrawVC.h"
#import "YSCGV.h"

@interface YSDrawVC ()

@property (nonatomic, strong) YSCGV *cgV;

@end

@implementation YSDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self cgV];
}



#pragma mark --
#pragma mark init
- (YSCGV *)cgV{
    if (!_cgV) {
        _cgV = [[YSCGV alloc] initWithFrame:CGRectMake(0, 100, 375, 80)];
        _cgV.content = @"Hello World";
        [self.view addSubview:_cgV];
    }
    return _cgV;
}

@end
