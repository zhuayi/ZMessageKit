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
@protocol ZMessageDelegate <NSObject>

/**
 *  消息数
 *
 *  @return 
 */
- (NSInteger)numberOfItemsInMessageKit;

- (ZMessageModel *)messageModelOfItems:(NSIndexPath *)indexPath messageModel:(ZMessageModel *)messageModel;

@end

@interface ZMessageKit : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 *  代理方法
 */
@property (nonatomic, weak) id<ZMessageDelegate> messageDelegate;

/**
 *  样式
 */
@property (nonatomic, strong) ZMessageStyle *style;


/**
 *  新增消息
 *
 *  @param count 新增消息数
 */
- (void)insertMessage:(NSInteger)count;

/**
 *  滚动到底部
 */
- (void)scrollToBottom:(BOOL)animated;
@end
