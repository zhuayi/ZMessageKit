//
//  ZMessageViewCell.m
//  ZMessageKit
//
//  Created by zhuayi on 9/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZMessageViewCell.h"
#import "UIView+Util.h"
#import "UIImageView+WebCache.h"
#import "ZMessageStyle.h"
@interface ZMessageViewCell()

/**
 *  文本消息容器
 */
@property (nonatomic, strong) UILabel *messageLabel;

/**
 *  图片消息容器
 */
@property (nonatomic, strong) UIImageView *messageImageView;

@end

@implementation ZMessageViewCell {
  
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 40, 40)];
        _imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
}

/**
 *  文本消息容器
 *
 *  @return UILabel
 */
- (UILabel *)messageLabel {
    
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, 10, 200, self.height - 20)];
        _messageLabel.backgroundColor = [UIColor redColor];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [ZMessageStyle sharedManager].messageFont;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_messageLabel];
    }
    
    return _messageLabel;
}


/**
 *  图片消息内容
 *
 *  @return
 */
- (UIImageView *)messageImageView {
    if (!_messageImageView) {
        
        _messageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, 10, 200, self.height - 20)];
        [self addSubview:_messageImageView];
    }
    
    return _messageImageView;
}

- (void)setMessageModel:(ZMessageModel *)messageModel {
    _messageModel = messageModel;
    
    [_imageView sd_setImageWithURL:_messageModel.faceUrl];

    
    // 文本消息
    if ([messageModel.messages isKindOfClass:[NSString class]]) {
        self.messageLabel.height = messageModel.height;
        self.messageLabel.text = (NSString *)_messageModel.messages;
    }
    
    // 图片消息
    if ([messageModel.messages isKindOfClass:[NSURL class]]) {
//        self.messageImageView.height = messageModel.height;
        [self.messageImageView sd_setImageWithURL:(NSURL *)_messageModel.messages];
    }
    
    
    if (_messageModel.mySelf) {
        _imageView.left = self.width - _imageView.width;
        _messageLabel.right = _imageView.right - _imageView.width - 5;
    } else {
        _imageView.left = 0;
        _messageLabel.left = CGRectGetMaxX(_imageView.frame) + 5;
    }
    
}


@end
