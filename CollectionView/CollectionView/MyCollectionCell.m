//
//  MyCollectionCell.m
//  CollectionView
//
//  Created by miniu on 15/6/8.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "MyCollectionCell.h"

@interface MyCollectionCell ()

@end

@implementation MyCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLable = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLable.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = [UIFont boldSystemFontOfSize:50];
        //_titleLable.backgroundColor = [UIColor grayColor];
        _titleLable.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLable];
    }
    return self;
}

@end
