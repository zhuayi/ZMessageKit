//
//  ZMessageSendView.m
//  ZMessageKit
//
//  Created by zhuayi on 9/15/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZMessageSendView.h"
#import "ZMacro.h"
#import "UIView+Util.h"
#import "ZMessageStyle.h"
@implementation ZMessageSendView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sendViewBg"]];
        
        
        
        if ([ZMessageStyle sharedManager].isNeedVoice) {
            [self addSubview:self.voiceButton];
        }
        
        [self addSubview:self.sendOtherButton];
        
        if ([ZMessageStyle sharedManager].isNeedFace) {
            
            [self addSubview:self.faceButton];
        }
        
        _textField = [[UITextView alloc] initWithFrame:CGRectMake(5 + _voiceButton.left + _voiceButton.width, (self.height - 30) / 2, self.width - (_voiceButton.width + _faceButton.width + _sendOtherButton.width) - 10, 30)];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _textField.keyboardType = UIKeyboardTypeWebSearch;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.layer.cornerRadius = 4;
        _textField.layer.masksToBounds = YES;
        _textField.delegate = self;
        _textField.layer.borderWidth = 1;
        _textField.font = [UIFont boldSystemFontOfSize:14.0];
        _textField.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        [self addSubview:_textField];
        
        _faceButton.left = _textField.left + _textField.width + 2;
        _sendOtherButton.left = _textField.left + _textField.width + _faceButton.width + 2;

    }
    return self;
}

- (UIButton *)faceButton {
    if (_faceButton == nil) {
        
        _faceButton = [[UIButton alloc] initWithFrame:CGRectMake(_sendOtherButton.left - _sendOtherButton.width, (self.height - 30 ) / 2, 30, 30)];
        [_faceButton setBackgroundImage:[UIImage imageNamed:@"face"] forState:UIControlStateNormal];
        [_faceButton setBackgroundImage:[UIImage imageNamed:@"faceHigh"] forState:UIControlStateHighlighted];
    }
    return _faceButton;
}

- (UIButton *)sendOtherButton {
    
    if (_sendOtherButton == nil) {
        
        _sendOtherButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 32, (self.height - 30 ) / 2, 30, 30)];
        
        [_sendOtherButton addTarget:self action:@selector(gotoCamera) forControlEvents:UIControlEventTouchUpInside];
        [_sendOtherButton setBackgroundImage:[UIImage imageNamed:@"sendotherHigh"] forState:UIControlStateHighlighted];
        [_sendOtherButton setBackgroundImage:[UIImage imageNamed:@"sendother"] forState:UIControlStateNormal];
    }
    return _sendOtherButton;
}

- (UIButton *)voiceButton {
    if (_voiceButton == nil) {
        
        _voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, (self.height - 30 ) / 2, 30, 30)];
        [_voiceButton setBackgroundImage:[UIImage imageNamed:@"voiceHigh"] forState:UIControlStateHighlighted];
        [_voiceButton setBackgroundImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    }
    return _voiceButton;
}


- (void)gotoCamera {
    
    [_textField resignFirstResponder];
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

#pragma mark -textFieldDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        if ([textView.text isEqualToString:@""]) {
            return NO;
        }
        
        [_delegate didSendTextMessage:textView.text];
        textView.text = @"";
        
        return NO;
    }
    
    return YES;
}


@end
