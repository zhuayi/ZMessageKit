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
    
    NSMutableArray *_dataArray;
    
    int _newMessageCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    self.automaticallyAdjustsScrollViewInsets = NO; 
    _messageView = [[ZMessageKit alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -  64)];
    _messageView.delegate = self;
    _messageView.style.messageFont = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:_messageView];

    self.rightButton.title = @"新增数据";

    _dataArray = [NSMutableArray new];
    for (int i = 0 ; i < 20; i++) {
        ZMessageModel *messageModel = [[ZMessageModel alloc] init];
        
        if (i %2) {
            messageModel.mySelf = YES;
            messageModel.faceUrl = [NSURL URLWithString:@"http://tp4.sinaimg.cn/1753070263/50/5703349473/1"];
            [messageModel setMessages:@"http://ww4.sinaimg.cn/bmiddle/a716fd45jw1ew3j8kszwuj20q20iu0yh.jpg" messageOptions:ZMessageImageMessage];
            
        } else {
            messageModel.faceUrl = [NSURL URLWithString:@"http://tp2.sinaimg.cn/1243861097/50/5679886030/1"];
            [messageModel setMessages:@"http://ww2.sinaimg.cn/thumbnail/c0320848jw1ew428x1exyj20u01hcn7f.jpg" messageOptions:ZMessageImageMessage];
        }
        
        [_dataArray addObject:messageModel];
        
    }
    
    [_messageView insertMessageWithArray:_dataArray];
    
}

- (void)rightButtonAction {
    
    ZMessageModel *messageModel = [[ZMessageModel alloc] init];
    [messageModel setMessages:@"http://avatar.csdn.net/4/8/6/1_doubleuto.jpg" messageOptions:ZMessageImageMessage];
    messageModel.faceUrl = [NSURL URLWithString:@"http://tp2.sinaimg.cn/1243861097/50/5679886030/1"];
    
    [_messageView insertMessageWithArray:@[messageModel]];
}

#pragma mark - ZMessageDelegate

- (void)didSendMessage:(NSObject*)message {
    
    ZMessageModel *messageModel = [[ZMessageModel alloc] init];
    [messageModel setMessages:message messageOptions:ZMessageTextMessage];
    messageModel.mySelf = YES;
    messageModel.faceUrl = [NSURL URLWithString:@"http://tp4.sinaimg.cn/1753070263/50/5703349473/1"];
    [_messageView insertMessageWithArray:@[messageModel]];
}
@end
