//
//  ZMessageStyle.h
//  ZMessageKit
//
//  Created by zhuayi on 9/15/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCameraViewManager.h"
#import "ZMessageDelegate.h"

typedef NS_OPTIONS(NSUInteger, ZMessageSendViewButtons) {
    
    // 文本消息
    ZMessageSendViewVoice = 1 << 0,
    
    // 远程图片消息
    ZMessageSendViewFace = 1 << 1,
    
    // 本地图片消息
    ZMessageSendViewOthor = 1 << 2,
    
};

@interface ZMessageStyle : NSObject<ZCameraViewDelegate>

/**
 *  单例方法
 *
 *  @return
 */
+ (ZMessageStyle *)sharedManager;

+ (void)dellocInstance;

/**
 *  代理方法
 */
@property (nonatomic, weak) id<ZMessageSendDelete> delegate;

/**
 *  按钮类型
 */
@property (nonatomic, assign) NSInteger buttonsListOptions;

/**
 *  文本内容字体
 */
@property (nonatomic, strong) UIFont *messageFont;

/**
 *  文本消息颜色
 */
@property (nonatomic, strong) UIColor *messageColor;

/**
 *  发送其他类型
 */
@property (nonatomic, strong) UIButton *sendOtherButton;

/**
 *  语音按钮
 */
@property (nonatomic, strong) UIButton *voiceButton;

/**
 *  头像按钮
 */
@property (nonatomic, strong) UIButton *faceButton;

/**
 *  左侧消息气泡
 */
@property (nonatomic, strong) UIImage *messageLeftPaopaoImage;


/**
 *  右侧消息气泡
 */
@property (nonatomic, strong) UIImage *messageRightPaopaoImage;



@end
