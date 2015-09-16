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
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(5 + 30 + 5, (self.height - 30) / 2, self.width - 3 * 34, 30)];
        _textField.delegate = self;
        [_textField setBorderStyle:UITextBorderStyleRoundedRect];
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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    _textField.text = text;
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([_textField.text isEqualToString:@""]) {
        return NO;
    }
    
    [_delegate didSendMessage:textField.text];
    _textField.text = @"";
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    

}

@end
