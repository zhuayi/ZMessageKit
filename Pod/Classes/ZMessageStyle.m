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


#pragma mark messageView Buttons

- (UIButton *)sendOtherButton {
    
    if (_sendOtherButton == nil) {
        _sendOtherButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_sendOtherButton setBackgroundImage:[UIImage imageNamed:@"sendotherHigh"] forState:UIControlStateHighlighted];
        [_sendOtherButton setBackgroundImage:[UIImage imageNamed:@"sendother"] forState:UIControlStateNormal];
    }
    [_sendOtherButton addTarget:self action:@selector(gotoCamera) forControlEvents:UIControlEventTouchUpInside];
    return _sendOtherButton;
}

- (UIButton *)voiceButton {
    if (_voiceButton == nil) {
        _voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_voiceButton setBackgroundImage:[UIImage imageNamed:@"voiceHigh"] forState:UIControlStateHighlighted];
        [_voiceButton setBackgroundImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    }
    return _voiceButton;
}

- (UIButton *)faceButton {
    if (_faceButton == nil) {
        _faceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_faceButton setBackgroundImage:[UIImage imageNamed:@"face"] forState:UIControlStateNormal];
        [_faceButton setBackgroundImage:[UIImage imageNamed:@"faceHigh"] forState:UIControlStateHighlighted];
    }
    return _faceButton;
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

- (void)gotoCamera {
    
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    ZCameraViewManager *camera = [[ZCameraViewManager alloc] init];
    camera.delegate = self;
    camera.maximum = 9;
    camera.threshold = 0;
    [camera show];
}

#pragma mark - ZCameraViewDelegate
- (void)didCameraUnavailable {
    
    [_delegate didCameraUnavailable];
}

- (void)didPhotoLibraryUnavailable {
    
    [_delegate didPhotoLibraryUnavailable];
}

- (void)didDismissViewController {
    
}

- (void)didSendPhotoWidthImage:(UIImage *)image {
    [_delegate didSendImageMessage:@[image]];
}

- (void)didSendPhotoWithImageArray:(NSArray *)imageArry {
    
    [ZCameraViewManager getImageAspectRatioThumbnaillWithArray:imageArry imageArray:^(NSArray *imageArray) {
        [_delegate didSendImageMessage:imageArray];
    }];
}

@end
