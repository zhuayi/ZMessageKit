//
//  ZMessageKit.m
//  ZMessageKit
//
//  Created by zhuayi on 9/14/15.
//  Copyright (c) 2015 renxin. All rights reserved.
//

#import "ZMessageKit.h"
#import "MessageViewCell.h"

@implementation ZMessageKit

 static NSString * CellIdentifier = @"GradientCell";

- (instancetype)initWithFrame:(CGRect)frame {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[MessageViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    }
    return self;
}


- (void)didMoveToSuperview {
    [super didMoveToSuperview];
            
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:29 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
}

#pragma mark -- UICollectionViewDataSource

/**
 *  定义展示的UICollectionViewCell的个数
 *
 *  @param collectionView
 *  @param section
 *
 *  @return
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

/**
 *  定义展示的Section的个数
 *
 *  @param collectionView
 *
 *  @return
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/**
 *  每个UICollectionView展示的内容
 *
 *  @param collectionView
 *  @param indexPath
 *
 *  @return
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    MessageViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.messages = @"UICollectionView 和 UICollectionViewController 类是iOS6 新引进的API";
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout

/**
 *  定义每个UICollectionView 的大小
 *
 *  @param collectionView
 *  @param collectionViewLayout
 *  @param indexPath
 *
 *  @return
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.frame.size.width - 20, 200);
}

/**
 *  定义每个UICollectionView 的 margin
 *
 *  @param collectionView
 *  @param collectionViewLayout
 *  @param section
 *
 *  @return
 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

@end
