//
//  MyCollectionLayout.m
//  CollectionView
//
//  Created by miniu on 15/6/26.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  collection view 学习
//  参考链接：
//  http://www.cocoachina.com/industry/20131122/7401.html
//
//  http://www.onevcat.com/2012/08/advanced-collection-view/
//  http://objccn.io/issue-12-5/

#import "MyCollectionLayout.h"

@interface MyCollectionLayout ()
{
}

@end

@implementation MyCollectionLayout

- (id)init
{
    self = [super init];
    if (self) {
        //CGFloat width = self.collectionView.frame.size.width;
        //self.itemSize = CGSizeMake((width-20)/2, 100);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 上／左／下／右边距
        // 与父窗口的边距
        //self.sectionInset = UIEdgeInsetsMake(50.0, 0.0, 2.0, 0.0);
    }
    return self;
}

//- (CGSize)collectionViewContentSize
//{
//    NSInteger count = [self.collectionView numberOfItemsInSection:0];
//    return CGSizeMake(self.collectionView.frame.size.width, 200*count);
//}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    NSMutableArray * attributes = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * atrributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = self.collectionView.frame.size.width;
    atrributes.size = CGSizeMake((width-20)/2, width*0.2);
    
    CGFloat halfCellWidth = (width-20)/4;
    CGFloat halfCellHeight = (width-20)*0.1;
    NSInteger x = (indexPath.item%2 == 0) ? 1 : 3;
    NSInteger y = indexPath.item/2;
    atrributes.center = CGPointMake(halfCellWidth*x+10, (2*halfCellHeight+10)*y+halfCellHeight);
    
    return atrributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if ( CGRectGetWidth(oldBounds) != CGRectGetWidth(newBounds) ) {
        return YES;
    }
    
    return NO;
}

@end
