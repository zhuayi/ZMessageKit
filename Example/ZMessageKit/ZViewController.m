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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [messageView insertMessage:10];
    });
    
    
}

#pragma mark - ZMessageDelegate

- (NSInteger)numberOfItemsInMessageKit {
    
    return 100;
}


- (ZMessageModel *)messageModelOfItems:(NSIndexPath *)indexPath messageModel:(ZMessageModel *)messageModel {
    
    NSLog(@"indexPath.row is %ld", indexPath.row);
    if ((indexPath.row % 2)) {
        messageModel.mySelf = YES;
    } else {


        messageModel.mySelf = NO;
    }
    
    messageModel.messages = [NSString stringWithFormat:@"UICollectionView is :%ld", indexPath.row];
    
    return messageModel;
}
@end
