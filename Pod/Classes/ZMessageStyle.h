//
//  ZMessageStyle.h
//  ZMessageKit
//
//  Created by zhuayi on 9/15/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMessageStyle : NSObject

/**
 *  单例方法
 *
 *  @return
 */
+ (ZMessageStyle *)sharedManager;


+ (void)dellocInstance;

/**
 *  文本内容字体
 */
@property (nonatomic, strong) UIFont *messageFont;

/**
 *  文本消息颜色
 */
@property (nonatomic, strong) UIColor *messageColor;

/**
 *  是否需要语音输入
 */
@property (nonatomic, assign) BOOL isNeedVoice;


/**
 *  是否需要表情输入
 */
@property (nonatomic, assign) BOOL isNeedFace;

/**
 *  左侧消息气泡
 */
@property (nonatomic, strong) UIImage *messageLeftPaopaoImage;


/**
 *  右侧消息气泡
 */
@property (nonatomic, strong) UIImage *messageRightPaopaoImage;


@end
