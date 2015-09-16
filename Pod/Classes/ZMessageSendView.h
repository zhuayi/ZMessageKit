//
//  ZMessageSendView.h
//  ZMessageKit
//
//  Created by zhuayi on 9/15/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMessageDelegate.h"
#import "ZCameraViewManager.h"

@interface ZMessageSendView : UIView<UITextViewDelegate, ZCameraViewDelegate>

/**
 *  代理方法
 */
@property (nonatomic, weak) id<ZMessageSendDelete> delegate;

/**
 *  语音按钮
 */
@property (nonatomic, strong) UIButton *voiceButton;

/**
 *  发送其他类型
 */
@property (nonatomic, strong) UIButton *sendOtherButton;

/**
 *  头像按钮
 */
@property (nonatomic, strong) UIButton *faceButton;

/**
 *  文本框
 */
@property (nonatomic, strong) UITextView *textField;

@end
