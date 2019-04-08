
//
//  YSCycleV.m
//  YSKit
//
//  Created by mac on 2019/1/24.
//  Copyright © 2019年 YS. All rights reserved.
//

#import "YSCycleV.h"



#define kPageControl_H      40
#define kCellIdentifier     @"CycleImageViewCell"


@interface YSCycleV ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation YSCycleV


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:self.imageArr[indexPath.row]];
    imageV.frame = cell.contentView.bounds;
    [cell.contentView addSubview:imageV];
    return cell;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    if (_isScrol) {
//        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:_scrollPosition animated:NO];
//        _isScrol = NO;
//    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = 0;
    
    currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;

    
    currentPage = currentPage % self.imageArr.count;
    
//    self.pageControl.currentPage = currentPage;
//    _index = currentPage;
//    
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentPage inSection:1] atScrollPosition:_scrollPosition animated:NO];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - timer action
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(self.timeInterval ? self.timeInterval : 1) target:self selector:@selector(timerCycleImageAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)timerCycleImageAction:(NSTimer *)timer
{
    if (_index == self.images.count) {
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:_scrollPosition animated:YES];
        self.pageControl.currentPage = 0;
        _index = 1;
        _isScrol = YES;
        
    }else
    {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_index inSection:1] atScrollPosition:_scrollPosition animated:YES];
        self.pageControl.currentPage = _index;
        _index += 1;
    }
}
#pragma mark - setter
- (void)setMovementDirection:(MovementDirectionType)movementDirection
{
    _movementDirection = movementDirection;
    
    if (!movementDirection) {
        
        _scrollPosition = UICollectionViewScrollPositionCenteredHorizontally;
        _scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
    }else
    {
        _scrollPosition = UICollectionViewScrollPositionCenteredVertically;
        _scrollDirection = UICollectionViewScrollDirectionVertical;
    }
}
- (void)setImages:(NSArray *)images
{
    _images = images;
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = images.count;
    [self startTimer];
}
- (void)setHidePageControl:(BOOL)hidePageControl
{
    _hidePageControl = hidePageControl;
    self.pageControl.hidden = hidePageControl;
}
- (void)setCanFingersSliding:(BOOL)canFingersSliding
{
    _canFingersSliding = canFingersSliding;
    self.collectionView.scrollEnabled = canFingersSliding;
}
#pragma mark - getter
- (CycleImageViewPageControl *)pageControl
{
    if (!_pageControl) {
        
        _pageControl = [[CycleImageViewPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - kPageControl_H, self.bounds.size.width, kPageControl_H)];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.enabled = NO;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        flowLayout.scrollDirection = _scrollDirection;
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil] forCellWithReuseIdentifier:kCellIdentifier];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_collectionView];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:_scrollPosition animated:NO];
        
    }
    return _collectionView;
}
#pragma mark - dealloc
- (void)dealloc
{
    [self stopTimer];
}

@end
