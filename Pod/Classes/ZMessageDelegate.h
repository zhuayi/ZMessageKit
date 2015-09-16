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
 *  发送消息
 *
 *  @param message 
 */
- (void)didSendMessage:(NSObject *)message;

@end
