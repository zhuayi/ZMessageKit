//
//  ZMessageDelegate.h
//  ZMessageKit
//
//  Created by zhuayi on 9/15/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMessageModel.h"

@protocol ZMessageDelegate <NSObject>

/**
 *  发送图片消息
 *
 *  @param imageArray 
 */
- (void)didfinishSendMessage:(NSArray *)messageModelArray;

/**
 *  相机不可用
 */
- (void)didCameraUnavailable;

/**
 *  相册不可用
 */
- (void)didPhotoLibraryUnavailable;
@end


@protocol ZMessageSendDelete <NSObject>

/**
 *  发送消息
 *
 *  @param message
 */
- (void)didSendTextMessage:(NSString *)message;

/**
 *  发送图片信息
 *
 *  @param imageArray 
 */
- (void)didSendImageMessage:(NSArray *)imageArray;

/**
 *  相机不可用
 */
- (void)didCameraUnavailable;

/**
 *  相册不可用
 */
- (void)didPhotoLibraryUnavailable;

@end