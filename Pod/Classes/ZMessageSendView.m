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

        _textField = [[UITextView alloc] initWithFrame:CGRectMake(5, (self.height - 30) / 2, self.width - 10, 30)];
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
        
        if ((ZMessageSendViewVoice & [ZMessageStyle sharedManager].buttonsListOptions) == ZMessageSendViewVoice) {
            [self addSubview:[ZMessageStyle sharedManager].voiceButton];
            [ZMessageStyle sharedManager].voiceButton.left = 0;
            [ZMessageStyle sharedManager].voiceButton.top = (self.height - [ZMessageStyle sharedManager].voiceButton.height ) / 2;
            _textField.width -= [ZMessageStyle sharedManager].voiceButton.width;
            _textField.left += [ZMessageStyle sharedManager].voiceButton.width;
        }
        
        if ((ZMessageSendViewOthor & [ZMessageStyle sharedManager].buttonsListOptions) == ZMessageSendViewOthor) {
            [self addSubview:[ZMessageStyle sharedManager].sendOtherButton];
            [ZMessageStyle sharedManager].sendOtherButton.left = self.width - [ZMessageStyle sharedManager].sendOtherButton.width;
            [ZMessageStyle sharedManager].sendOtherButton.top = (self.height - [ZMessageStyle sharedManager].sendOtherButton.height ) / 2;
            _textField.width -= [ZMessageStyle sharedManager].sendOtherButton.width;
        }
        
        if ((ZMessageSendViewFace & [ZMessageStyle sharedManager].buttonsListOptions) == ZMessageSendViewFace) {
            
            [ZMessageStyle sharedManager].faceButton.top = (self.height - [ZMessageStyle sharedManager].faceButton.height ) / 2;
            [self addSubview:[ZMessageStyle sharedManager].faceButton];
            _textField.width -= [ZMessageStyle sharedManager].faceButton.width;
            [ZMessageStyle sharedManager].faceButton.left = _textField.left + _textField.width + 3;
        }
        
        
        NSLog(@"");
    }
    return self;
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
