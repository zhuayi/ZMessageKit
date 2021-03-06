//
//  ZMessageViewCell.h
//  ZMessageKit
//
//  Created by zhuayi on 9/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMessageModel.h"
#import "ZMessageDelegate.h"

@interface ZMessageViewCell : UICollectionViewCell

@property (nonatomic, strong) ZMessageModel *messageModel;


@property (nonatomic, strong) NSIndexPath *indexPath;

@end
