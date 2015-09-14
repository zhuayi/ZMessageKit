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
    
    if ([messages isKindOfClass:[NSString class]]) {
        
        NSDictionary *fontDict = @{
                                   NSFontAttributeName:[ZMessageStyle sharedManager].messageFont,
                                   };
        CGRect size = [(NSString *)messages boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      attributes:fontDict
                                                         context:nil];
        _height = size.size.height;
    }
    _messages = messages;
}
@end
