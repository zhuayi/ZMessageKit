//
//  ZMessageKit.h
//  ZMessageKit
//
//  Created by zhuayi on 9/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMessageStyle.h"
#import "ZMessageModel.h"
#import "ZMessageSendView.h"
#import "ZMessageDelegate.h"
#import "MWPhotoBrowser.h"

@interface ZMessageKit : UIView<UICollectionViewDelegate,
UICollectionViewDataSource,
UITextFieldDelegate,
MWPhotoBrowserDelegate,
ZMessageSendDelete>

/**
 *  代理方法
 */
@property (nonatomic, weak) id<ZMessageDelegate> delegate;

/**
 *  样式
 */
@property (nonatomic, strong) ZMessageStyle *style;

/**
 *  消息列表
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  发送消息框
 */
@property (nonatomic, strong) ZMessageSendView *sendView;


/**
 *  新增消息
 *
 *  @param count 新增消息数组
 */
- (void)insertMessageWithArray:(NSArray *)messageArray;


/**
 *  滚动到底部
 */
- (void)scrollToBottom:(BOOL)animated;
@end
