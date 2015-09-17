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
 *  图片消息容器
 */
@property (nonatomic, strong) UIImageView *messageImageView;

@end


@implementation ZMessageViewCell {
  
    UIImageView *_faceView;
    
    UIButton *_backview;
    
    UIImage *_messageBackImage;
    UIImage *_messageBackHighImage;
    
    UIImageView *_imageViewMask;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        _faceView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 40, 40)];
        [self addSubview:_faceView];
        
        _messageBackImage = [ZMessageStyle sharedManager].messageLeftPaopaoImage;
        _messageBackHighImage = [ZMessageStyle sharedManager].messageRightPaopaoImage;
        
        // 设置消息背景
        _backview = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backview setBackgroundImage:[ZMessageStyle sharedManager].messageLeftPaopaoImage forState:UIControlStateNormal];
        [_backview setBackgroundImage:[ZMessageStyle sharedManager].messageRightPaopaoImage forState:UIControlStateSelected];
        _backview.titleLabel.numberOfLines = 0;
        _backview.titleLabel.textAlignment = NSTextAlignmentLeft;
        _backview.titleLabel.font = [ZMessageStyle sharedManager].messageFont;
        _backview.userInteractionEnabled = NO;
        [_backview setTitleColor:[ZMessageStyle sharedManager].messageColor forState:UIControlStateNormal];
        [_backview addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_backview];
        
        _imageViewMask = [[UIImageView alloc] init];
    }
    return self;
}

/**
 *  图片消息内容
 *
 *  @return
 */
- (UIImageView *)messageImageView {
    if (!_messageImageView) {
        
        _messageImageView = [[UIImageView alloc] init];
        _messageImageView.layer.cornerRadius = 5;
        _messageImageView.layer.masksToBounds  = YES;
        _messageImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_backview addSubview:_messageImageView];
    }
    
    return _messageImageView;
}

- (void)setMessageModel:(ZMessageModel *)messageModel {
    _messageModel = messageModel;
    
    [_faceView sd_setImageWithURL:_messageModel.faceUrl];

    [_backview setTitle:@"" forState:UIControlStateNormal];
    
    self.messageImageView.hidden = YES;
    _backview.userInteractionEnabled = NO;
    _backview.size = _messageModel.messageSize;
    
    // 文本消息
    if (messageModel.messageOptions == ZMessageTextMessage) {
        [_backview setTitle:(NSString *)_messageModel.messages forState:UIControlStateNormal];
    }
    
    // 远程图片消息
    if (messageModel.messageOptions == ZMessageImageUrlMessage || messageModel.messageOptions == ZMessageImageMessage) {
        
        if (messageModel.messageOptions == ZMessageImageUrlMessage) {
            [self.messageImageView sd_setImageWithURL:(NSURL *)_messageModel.messages];
        } else if (messageModel.messageOptions == ZMessageImageMessage) {
            self.messageImageView.image = (UIImage *)_messageModel.messages;
        }
        
        self.messageImageView.hidden = NO;
        self.messageImageView.size = _messageModel.messageSize;
        if (_messageModel.mySelf) {
            
            _imageViewMask.image = _messageBackImage;
        } else {            
            _imageViewMask.image = _messageBackHighImage;
        }
        _imageViewMask.frame = CGRectInset(_messageImageView.frame, 0.0f, 0.0f);
        _messageImageView.layer.mask = _imageViewMask.layer;
        _backview.userInteractionEnabled = YES;
    }

    
    // 设置气泡类型, 左右
    if (_messageModel.mySelf) {
        _faceView.left = self.width - _faceView.width;
        _backview.right = _faceView.right - _faceView.width - 5;
        _backview.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 15);
    } else {
        _faceView.left = 0;
        _backview.left = CGRectGetMaxX(_faceView.frame) + 5;
        _backview.contentEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 5);
    }
    
    _backview.selected = !_messageModel.mySelf;
}


- (void)didClickButton {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidClickCellButton object:@[_messageModel, @(_indexPath.row)]];
}

@end

