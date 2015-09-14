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

@end
