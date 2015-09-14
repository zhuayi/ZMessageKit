//
//  ZMessageStyle.m
//  ZMessageKit
//
//  Created by zhuayi on 9/15/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZMessageStyle.h"

@implementation ZMessageStyle


static ZMessageStyle *sharedAccountManagerInstance = nil;


+ (ZMessageStyle *)sharedManager {
    
    @synchronized (self)
    {
        if (sharedAccountManagerInstance == nil)
        {
            sharedAccountManagerInstance = [[self alloc] init];
        }
    }
    return sharedAccountManagerInstance;
}


+ (void)dellocInstance {
    sharedAccountManagerInstance = nil;
}


@end
