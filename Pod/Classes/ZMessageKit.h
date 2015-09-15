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

@property (nonatomic, weak) id<ZMessageDelegate> messageDelegate;

@property (nonatomic, strong) ZMessageStyle *style;

@end
