//
//  MessageViewCell.m
//  ZMessageKit
//
//  Created by zhuayi on 9/14/15.
//  Copyright (c) 2015 renxin. All rights reserved.
//

#import "MessageViewCell.h"

@implementation MessageViewCell {
    UILabel *_messageLabel;
    
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 40, 40)];
        _imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:_imageView];
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, 10, 200, frame.size.height - 20)];
        _messageLabel.backgroundColor = [UIColor redColor];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_messageLabel];
    }
    return self;
}

- (void)setMessages:(NSString *)messages {
    _messages = messages;
    _messageLabel.text = messages;
}

- (void)setIsSelf:(BOOL)isSelf {
    
    if (isSelf) {
        
        
    }
    
}

@end
