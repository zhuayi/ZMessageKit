//
//  ZMessageStyle.m
//  ZMessageKit
//
//  Created by zhuayi on 9/15/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZMessageStyle.h"

@implementation ZMessageStyle


static ZMessageStyle *sharedAccountManagerInstance = nil;


+ (ZMessageStyle *)sharedManager {
    
    @synchronized (self) {
        if (sharedAccountManagerInstance == nil)
        {
            sharedAccountManagerInstance = [[self alloc] init];
        }
    }
    return sharedAccountManagerInstance;
}


+ (void)dellocInstance {
    sharedAccountManagerInstance = nil;
}

- (UIFont *)messageFont {
    
    if (_messageFont == nil) {
        _messageFont = [UIFont systemFontOfSize:14.0];
    }
    return _messageFont;
}

- (UIColor *)messageColor {
    if (_messageColor == nil) {
        _messageColor = [UIColor blackColor];
    }
    return _messageColor;
}

- (UIImage *)messageLeftPaopaoImage {
    if (_messageLeftPaopaoImage == nil) {
        
        _messageLeftPaopaoImage = [[UIImage imageNamed:@"chatto_bg_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(35, 10, 10, 22)];
    }
    return _messageLeftPaopaoImage;
}


- (UIImage *)messageRightPaopaoImage {
    if (_messageRightPaopaoImage == nil) {
        
        _messageRightPaopaoImage = [[UIImage imageNamed:@"chatfrom_bg_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(35, 22, 10, 10)];
    }
    return _messageRightPaopaoImage;
}
@end
