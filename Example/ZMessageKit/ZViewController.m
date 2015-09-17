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
    [self.view addSubview:_messageView];

    // 样式哦
    _messageView.style.messageFont = [UIFont systemFontOfSize:14.0];
    _messageView.style.messageColor = [UIColor blackColor];
    
    
    self.rightButton.title = @"新增数据";

    _dataArray = [NSMutableArray new];
    for (int i = 0 ; i < 20; i++) {
        ZMessageModel *messageModel = [[ZMessageModel alloc] init];
        
        if (i %2) {
            messageModel.mySelf = YES;
            messageModel.faceUrl = [NSURL URLWithString:@"http://tp4.sinaimg.cn/1753070263/50/5703349473/1"];
            [messageModel setMessages:@"http://ww4.sinaimg.cn/bmiddle/a716fd45jw1ew3j8kszwuj20q20iu0yh.jpg" messageOptions:ZMessageImageUrlMessage];
            
        } else {
            messageModel.faceUrl = [NSURL URLWithString:@"http://tp2.sinaimg.cn/1243861097/50/5679886030/1"];
            [messageModel setMessages:@"http://ww4.sinaimg.cn/bmiddle/834d87e8jw1ew572lg9j5j20ku0v9go3.jpg" messageOptions:ZMessageImageUrlMessage];
        }
        
        [_dataArray addObject:messageModel];
        
    }
    
    [_messageView insertMessageWithArray:_dataArray];
    
}

- (void)rightButtonAction {
    
    ZMessageModel *messageModel = [[ZMessageModel alloc] init];
    [messageModel setMessages:@"面的东西是编写自定义的表情键盘,话不多说,开门见山吧!下面主要用到的知识有MVC" messageOptions:ZMessageTextMessage];
    messageModel.faceUrl = [NSURL URLWithString:@"http://tp2.sinaimg.cn/1243861097/50/5679886030/1"];
    
    [_messageView insertMessageWithArray:@[messageModel]];
}

#pragma mark - ZMessageDelegate

- (void)didCameraUnavailable {
    
    //如果没有提示用户
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tip" message:@"Your device don't have camera" delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
    [alert show];
}

- (void)didPhotoLibraryUnavailable {
    
}

- (void)didfinishSendMessage:(NSArray *)messageModelArray{
    
    for (ZMessageModel *messageModel in messageModelArray) {
        messageModel.faceUrl = [NSURL URLWithString:@"http://tp4.sinaimg.cn/1753070263/50/5703349473/1"];
    }
    
    NSLog(@"message : is %@",  messageModelArray);
}

@end
