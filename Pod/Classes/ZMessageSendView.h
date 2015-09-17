//
//  ZMessageSendView.h
//  ZMessageKit
//
//  Created by zhuayi on 9/15/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMessageDelegate.h"

@interface ZMessageSendView : UIView<UITextViewDelegate>

/**
 *  代理方法
 */
@property (nonatomic, weak) id<ZMessageSendDelete> delegate;


/**
 *  文本框
 */
@property (nonatomic, strong) UITextView *textField;

@end
