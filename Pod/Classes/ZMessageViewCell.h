//
//  ZMessageViewCell.h
//  ZMessageKit
//
//  Created by zhuayi on 9/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMessageViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *messages;

@property (nonatomic, assign) BOOL isSelf;

@end
