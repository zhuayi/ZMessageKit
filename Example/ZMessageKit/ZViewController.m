//
//  ZViewController.m
//  ZMessageKit
//
//  Created by zhuayi on 09/14/2015.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZViewController.h"


@implementation ZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    
    ZMessageKit *messageView = [[ZMessageKit alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -  64)];
    messageView.messageDelegate = self;
    messageView.style.messageFont = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:messageView];
}

#pragma mark - ZMessageDelegate

- (NSInteger)numberOfItemsInMessageKit {
    
    return 100;
}


- (ZMessageModel *)messageModelOfItems:(NSIndexPath *)indexPath messageModel:(ZMessageModel *)messageModel {
    
    if ((indexPath.row % 2)) {
        messageModel.mySelf = YES;
    } else {


        messageModel.mySelf = NO;
    }
    
//    messageModel.height = 200;
    messageModel.messages = @"UICollectionView";
    
    return messageModel;
}
@end
