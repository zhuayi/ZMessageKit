//
//  ZMessageDelegate.h
//  ZMessageKit
//
//  Created by zhuayi on 9/15/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZMessageModel;

@protocol ZMessageDelegate <NSObject>

/**
 *  消息数
 *
 *  @return
 */
- (NSInteger)numberOfItemsInMessageKit;


/**
 *  获取对应的index消息
 *
 *  @param indexPath
 *  @param messageModel
 *
 *  @return
 */
- (ZMessageModel *)messageModelOfItems:(NSIndexPath *)indexPath messageModel:(ZMessageModel *)messageModel;

/**
 *  发送消息
 *
 *  @param message 
 */
- (void)didSendMessage:(NSObject *)message;

@end
