//
//  ZMessageModel.m
//  ZMessageKit
//
//  Created by zhuayi on 9/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZMessageModel.h"
#import "ZMessageStyle.h"
#import "ZMacro.h"
#import "SDWebImageManager.h"

@implementation ZMessageModel {
    
    BOOL finishedDownImage;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        finishedDownImage = NO;
    }
    return self;
}

- (void)setMessages:(NSObject *)messages messageOptions:(ZMessageOptions)messageOptions {
    _messages = messages;
    _messageOptions = messageOptions;
}

- (void)resetMessageSize {
    
    // 获取文本内容的高度;
    if (_messageOptions == ZMessageTextMessage) {

//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setLineSpacing:10];
        NSDictionary *fontDict = @{
                                   NSFontAttributeName:[ZMessageStyle sharedManager].messageFont,
//                                   NSParagraphStyleAttributeName: paragraphStyle
                                   };


        _messageSize = [(NSString *)_messages boundingRectWithSize:CGSizeMake(180, CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:fontDict
                                                         context:nil].size;

        _messageSize.height += 20;
        _messageSize.width += 20;
    }

    // 设置图片高度
    if (_messageOptions == ZMessageImageUrlMessage) {

        SDWebImageManager *manger = [SDWebImageManager sharedManager];
        [manger downloadImageWithURL:[NSURL URLWithString:(NSString *)_messages] options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            if (image && finished) {
                _messageSize = image.size;
                if (_messageSize.width > 180) {
                    CGFloat originalWidth = _messageSize.width;
                    _messageSize.width = 180;
                    _messageSize.height /= (originalWidth / 180);
                }
                finishedDownImage = YES;
            }
        }];
        
        while (!finishedDownImage) {
            
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }
    
    
    // 设置图片高度
    if (_messageOptions == ZMessageImageMessage) {
        
        UIImage *image = (UIImage *)_messages;
        _messageSize = image.size;
        if (_messageSize.width > 180) {
            CGFloat originalWidth = _messageSize.width;
            _messageSize.width = 180;
            _messageSize.height /= (originalWidth / 180);
        }
        finishedDownImage = YES;
    }

}

@end
