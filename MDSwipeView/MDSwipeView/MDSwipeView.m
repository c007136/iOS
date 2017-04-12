//
//  MDSwipeView.m
//  MDSwipeView
//
//  Created by muyu on 2016/12/2.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "MDSwipeView.h"
#import "UICollectionViewCell+MDScrollView.h"

static NSString * const kMDSwipeViewCollectionViewCellIdentifier = @"kMDSwipeViewCollectionViewCellIdentifier";

@interface MDSwipeView () <UICollectionViewDelegate, UICollectionViewDataSource>

// UI
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;

@end

@implementation MDSwipeView

#pragma mark - lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    self.collectionLayout.itemSize = self.bounds.size;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"dddd");
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMDSwipeViewCollectionViewCellIdentifier forIndexPath:indexPath];
    
    UIScrollView *scrollView = [cell md_scrollView];
    
    if (0 == indexPath.row) {
        cell.backgroundColor = [UIColor redColor];
    } else if (1 == indexPath.row) {
        cell.backgroundColor = [UIColor greenColor];
    } else if (2 == indexPath.row) {
        cell.backgroundColor = [UIColor blueColor];
    }
    
    return cell;
}

#pragma mark - public method

- (void)reloadData
{
    [self.collectionView reloadData];
}

#pragma mark - private method
- (void)p_fun:(NSInteger)index
{
    if (0 == index)
    {
        
    }
}

#pragma mark - getter and setter

- (UICollectionView *)collectionView
{
    if (nil == _collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;  // Y??? 怕冲突？？？
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kMDSwipeViewCollectionViewCellIdentifier];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionLayout
{
    if (nil == _collectionLayout) {
        _collectionLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionLayout.minimumLineSpacing = 0;
        _collectionLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _collectionLayout;
}

@end
