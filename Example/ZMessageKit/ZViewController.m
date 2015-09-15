//
//  ZViewController.m
//  ZMessageKit
//
//  Created by zhuayi on 09/14/2015.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZViewController.h"


@implementation ZViewController {
    
    ZMessageKit *_messageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    
    _messageView = [[ZMessageKit alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -  64)];
    _messageView.delegate = self;
    _messageView.style.messageFont = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:_messageView];

    self.rightButton.title = @"新增数据";
}

- (void)rightButtonAction {
    
    [_messageView insertMessage:(arc4random() % 10) + 1];
}

#pragma mark - ZMessageDelegate

- (NSInteger)numberOfItemsInMessageKit {
    
    return 5;
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
