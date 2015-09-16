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

    
    _messageView = [[ZMessageKit alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -  64)];
    _messageView.delegate = self;
    _messageView.style.messageFont = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:_messageView];

    self.rightButton.title = @"新增数据";

    _dataArray = [NSMutableArray new];
    for (int i = 0 ; i < 500; i++) {
        ZMessageModel *messageModel = [[ZMessageModel alloc] init];
        messageModel.messages = [NSURL URLWithString:@"http://tp2.sinaimg.cn/1243861097/50/5679886030/1"];
        if (i %2) {
            messageModel.mySelf = YES;
            messageModel.faceUrl = [NSURL URLWithString:@"http://tp4.sinaimg.cn/1753070263/50/5703349473/1"];
        } else {
            messageModel.faceUrl = [NSURL URLWithString:@"http://tp2.sinaimg.cn/1243861097/50/5679886030/1"];
        }
        
        [_dataArray addObject:messageModel];
    }
    
    
    NSLog(@"_dataArray is %@", _dataArray);
}

- (void)rightButtonAction {
    
    ZMessageModel *messageModel = [[ZMessageModel alloc] init];
    messageModel.messages = @"我是新增的测试的";
    messageModel.faceUrl = [NSURL URLWithString:@"http://tp2.sinaimg.cn/1243861097/50/5679886030/1"];
    [_dataArray addObject:messageModel];
    
    [_messageView insertMessage:1];
}

#pragma mark - ZMessageDelegate

- (NSInteger)numberOfItemsInMessageKit {
    
    return _dataArray.count;
}


- (ZMessageModel *)messageModelOfItems:(NSIndexPath *)indexPath {
    
    return _dataArray[indexPath.row];
}


- (void)didSendMessage:(NSObject*)message {
    
    ZMessageModel *messageModel = [[ZMessageModel alloc] init];
    messageModel.messages = message;
    messageModel.mySelf = YES;
    messageModel.faceUrl = [NSURL URLWithString:@"http://tp4.sinaimg.cn/1753070263/50/5703349473/1"];
    [_dataArray addObject:messageModel];
    [_messageView insertMessage:1];
}
@end
