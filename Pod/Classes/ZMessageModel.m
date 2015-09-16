//
//  ZMessageModel.m
//  ZMessageKit
//
//  Created by zhuayi on 9/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZMessageModel.h"
#import "UIImageView+WebCache.h"
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

- (void)resetMessageSize {
    
    // 获取文本内容的高度;
    if ([_messages isKindOfClass:[NSString class]]) {

        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        NSDictionary *fontDict = @{
                                   NSFontAttributeName:[ZMessageStyle sharedManager].messageFont,
                                   NSParagraphStyleAttributeName: paragraphStyle
                                   };


        _messageSize = [(NSString *)_messages boundingRectWithSize:CGSizeMake(180, CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      attributes:fontDict
                                                         context:nil].size;

        _messageSize.height += 20;
        _messageSize.width += 20;
    }

    // 设置图片高度
    if ([_messages isKindOfClass:[NSURL class]]) {

        SDWebImageManager *manger = [SDWebImageManager sharedManager];
        UIImage *image = [manger.imageCache imageFromDiskCacheForKey:[manger cacheKeyForURL:(NSURL *)_messages]];
        if (image) {
            
            _messageSize = image.size;
            if (_messageSize.width > 180) {
                CGFloat originalWidth = _messageSize.width;
                _messageSize.width = 180;
                _messageSize.height /= (originalWidth / 180);
            }
        } else  {
         
            [manger downloadImageWithURL:(NSURL *)_messages options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
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

    }

    
}

@end
