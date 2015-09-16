//
//  ZMessageModel.h
//  ZMessageKit
//
//  Created by zhuayi on 9/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, ZMessageOptions) {
    
    // 文本消息
    ZMessageTextMessage = 1 << 0,
    
    // 图片消息
    ZMessageImageMessage = 1 << 1
    
};

@interface ZMessageModel : NSObject

/**
 *  消息内容
 */
@property (nonatomic, strong, readonly) NSObject *messages;

/**
 *  是否自己发的消息
 */
@property (nonatomic, assign) BOOL mySelf;


@property (nonatomic, assign) CGSize messageSize;

/**
 *  头像地址
 */
@property (nonatomic, strong) NSURL *faceUrl;


/**
 *  message类型
 */
@property (nonatomic, assign, readonly) ZMessageOptions messageOptions;

/**
 *  写入 message
 *
 *  @param messages
 *  @param messageOptions 
 */
- (void)setMessages:(NSObject *)messages messageOptions:(ZMessageOptions)messageOptions;

/**
 *  重置消息
 */
- (void)resetMessageSize;
@end
