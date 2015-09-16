//
//  ZMessageModel.h
//  ZMessageKit
//
//  Created by zhuayi on 9/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMessageModel : NSObject

/**
 *  消息内容
 */
@property (nonatomic, strong) NSObject *messages;

/**
 *  是否自己发的消息
 */
@property (nonatomic, assign) BOOL mySelf;


@property (nonatomic, assign) CGSize messageSize;

/**
 *  头像地址
 */
@property (nonatomic, strong) NSURL *faceUrl;


- (void)resetMessageSize;
@end
