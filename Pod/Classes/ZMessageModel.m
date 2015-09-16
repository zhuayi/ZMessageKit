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

@implementation ZMessageModel


- (void)setMessages:(NSObject *)messages {
    
    _messages = messages;
 
    // 获取文本内容的高度;
    if ([messages isKindOfClass:[NSString class]]) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        NSDictionary *fontDict = @{
                                   NSFontAttributeName:[ZMessageStyle sharedManager].messageFont,
                                   NSParagraphStyleAttributeName: paragraphStyle
                                   };
        

        _messageSize = [(NSString *)messages boundingRectWithSize:CGSizeMake(180, CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      attributes:fontDict
                                                         context:nil].size;
   
        _messageSize.height += 20;
        _messageSize.width += 20;
    }
    
    // 设置图片高度
    if ([messages isKindOfClass:[NSURL class]]) {
        
        _messageSize = CGSizeMake(220, 220);
    }
}


@end
