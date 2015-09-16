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

@implementation ZMessageSendView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sendViewBg"]];
        
        
        [self addSubview:self.faceButton];
        [self addSubview:self.sendOtherButton];
        [self addSubview:self.voiceButton];
        
        _textField = [[UITextView alloc] initWithFrame:CGRectMake(5 + 30 + 5, (self.height - 30) / 2, self.width - 3 * 34, 30)];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        _textField.keyboardType = UIKeyboardTypeTwitter;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.layer.cornerRadius = 4;
        _textField.layer.masksToBounds = YES;
        _textField.delegate = self;
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
//        _textField.adjustsFontSizeToFitWidth = YES;
//        [_textField setBorderStyle:UITextBorderStyleRoundedRect];
        [self addSubview:_textField];
    }
    return self;
}

- (UIButton *)faceButton {
    if (_faceButton == nil) {
        
        _faceButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 30 * 2, (self.height - 30 ) / 2, 30, 30)];
        [_faceButton setBackgroundImage:[UIImage imageNamed:@"face"] forState:UIControlStateNormal];
        [_faceButton setBackgroundImage:[UIImage imageNamed:@"faceHigh"] forState:UIControlStateHighlighted];
    }
    return _faceButton;
}

- (UIButton *)sendOtherButton {
    
    if (_sendOtherButton == nil) {
        
        _sendOtherButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 30, (self.height - 30 ) / 2, 30, 30)];
        
        [_sendOtherButton addTarget:self action:@selector(gotoCamera) forControlEvents:UIControlEventTouchUpInside];
        [_sendOtherButton setBackgroundImage:[UIImage imageNamed:@"sendotherHigh"] forState:UIControlStateHighlighted];
        [_sendOtherButton setBackgroundImage:[UIImage imageNamed:@"sendother"] forState:UIControlStateNormal];
    }
    return _sendOtherButton;
}

- (UIButton *)voiceButton {
    if (_voiceButton == nil) {
        
        _voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(5, (self.height - 30 ) / 2, 30, 30)];
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
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [_delegate didSendTextMessage:textView.text];
        textView.text = @"";
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    _textField.text = text;
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([_textField.text isEqualToString:@""]) {
        return NO;
    }
    
    [_delegate didSendTextMessage:textField.text];
    _textField.text = @"";
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    

}

@end
