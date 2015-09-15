//
//  ZMessageKit.m
//  ZMessageKit
//
//  Created by zhuayi on 9/14/15.
//  Copyright (c) 2015 renxin. All rights reserved.
//

#import "ZMessageKit.h"
#import "ZMessageViewCell.h"
#import "ZMessageSendView.h"
#import "ZMacro.h"
#import "UIView+Util.h"

@implementation ZMessageKit {
    
    // 数据对象字典
    NSMutableDictionary *_messageModelDict;
    
    // 数据总数
    NSInteger _dataCount;
    
    UICollectionView *_collectionView;
}

static NSString *CellIdentifier = @"GradientCell";
static NSString *kfooterIdentifier =  @"kfooterIdentifier";

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        _messageModelDict = [NSMutableDictionary new];
        
        ZMessageSendView *sendView = [[ZMessageSendView alloc] initWithFrame:CGRectMake(0, frame.size.height - 50, SCREEN_WIDTH, 50)];
        [self addSubview:sendView];
        
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - sendView.height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ZMessageViewCell class] forCellWithReuseIdentifier:CellIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
  
    }
    return self;
}

- (ZMessageStyle *)style {
    return [ZMessageStyle sharedManager];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    _dataCount = [_messageDelegate numberOfItemsInMessageKit];
    [self scrollToBottom:NO];
}

/**
 *  滚动到底部
 */
- (void)scrollToBottom:(BOOL)animated {
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(_dataCount - 1) inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:animated];
}

- (void)insertMessage:(NSInteger)count {

    _dataCount += count;
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (int i = 0 ; i < count; i++) {
        
        [array addObject:[NSIndexPath indexPathForItem:_dataCount - i - 1 inSection:0]];
    }
    [_collectionView performBatchUpdates:^{
        
        [_collectionView insertItemsAtIndexPaths:array];
        
    } completion:^(BOOL finished) {
        
        [self scrollToBottom:YES];
        
    }];
    
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
    return _dataCount;
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
    
    ZMessageViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.messageModel = _messageModelDict[@(indexPath.row)];
    
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
    
    ZMessageModel *messageModel;
    
    messageModel = _messageModelDict[@(indexPath.row)];
    if (messageModel == nil) {
        messageModel = [[ZMessageModel alloc] init];
        [_messageModelDict setObject:messageModel forKey:@(indexPath.row)];
    }
   
    messageModel = [_messageDelegate messageModelOfItems:indexPath messageModel:messageModel];

    return CGSizeMake(self.frame.size.width - 20, messageModel.height);
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
    return UIEdgeInsetsMake(0, 10, 20, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

@end