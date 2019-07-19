//
//  ViewController.m
//  CollectionView
//
//  Created by miniu on 15/6/8.
//  Copyright (c) 2015年 miniu. All rights reserved.
//  CollectionView
//  http://blog.csdn.net/u010165653/article/details/42168363
//  http://rainbownight.blog.51cto.com/1336585/1323780
//  http://blog.csdn.net/ljh910329/article/details/42421923

#import "ViewController.h"
#import "MyCollectionCell.h"
#import "MyCollectionLayout.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView * myCollectionView;

@end

static NSString * indentify = @"indentify";

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.myCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionCell * cell = (MyCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    
    if (0 == indexPath.item) {
        cell.backgroundColor = [UIColor redColor];
    } else if (1 == indexPath.item) {
        cell.backgroundColor = [UIColor greenColor];
    } else if (2 == indexPath.item) {
        cell.backgroundColor = [UIColor yellowColor];
    } else if (3 == indexPath.item) {
        cell.backgroundColor = [UIColor blueColor];
    }
    
    cell.titleLable.text = [NSString stringWithFormat:@"{ %d - %d }", indexPath.section, indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"<%d, %d>", indexPath.section, indexPath.row);
}

#pragma mark - getter/setter
- (UICollectionView *)myCollectionView {
    
    if ( _myCollectionView == nil ) {
        
        MyCollectionLayout * layout = [[MyCollectionLayout alloc] init];
        
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.backgroundColor = [UIColor brownColor];
        
        // 注册单元格
        [_myCollectionView registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:indentify];
        
    }
    
    return _myCollectionView;
}

@end
