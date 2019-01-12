
//
//  YSSwiTitleV.m
//  YSKit
//
//  Created by Bob on 2019/1/12.
//  Copyright © 2019 YS. All rights reserved.
//

#import "YSSwiTitleV.h"

#import "YSUtils.h"

@interface YSSwiTitleV ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) UICollectionView *collectionV;

@property (nonatomic, strong) UIFont *tFont;

@end

@implementation YSSwiTitleV

- (instancetype)initWithFrame:(CGRect)frame Data:(NSArray *)dataArr
                     font:(UIFont *)fontinfo
{
    self  = [super initWithFrame:frame];
    if (self) {
        self.tFont = fontinfo;
        self.dataArr = [dataArr copy];
     
        [self.collectionV reloadData];
    }
    return self;
}


#pragma mark --
#pragma mark collectionView delegate method
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = [YSUtils getFontWidth:_dataArr[indexPath.row]
                                 fontInfo:_tFont];
    
    return CGSizeMake(width, CGRectGetHeight(self.frame));
}

#pragma mark --
#pragma mark init
- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (UICollectionViewFlowLayout *)getFlowLayout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    return layout;
}


- (UICollectionView *)collectionV{
    if (!_collectionV) {
        _collectionV = [[UICollectionView alloc] initWithFrame:self.bounds
                                          collectionViewLayout:[self getFlowLayout]];
        [self addSubview:_collectionV];
        
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        
        [_collectionV registerClass:[UICollectionViewCell class]
         forCellWithReuseIdentifier:@"cell"];
    }
    
    return _collectionV;
}






@end
