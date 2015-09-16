//
//  ZMessageKit.m
//  ZMessageKit
//
//  Created by zhuayi on 9/14/15.
//  Copyright (c) 2015 renxin. All rights reserved.
//

#import "ZMessageKit.h"
#import "ZMessageViewCell.h"
#import "ZMacro.h"
#import "UIView+Util.h"
#import "MBProgressHUD+BWMExtension.h"

@implementation ZMessageKit {
    
    // 数据对象字典
    NSMutableDictionary *_messageModelDict;
}

static NSString *CellIdentifier = @"GradientCell";
static NSString *kfooterIdentifier =  @"kfooterIdentifier";

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        _messageModelDict = [NSMutableDictionary new];
        
        _sendView = [[ZMessageSendView alloc] initWithFrame:CGRectMake(0, frame.size.height - 39, SCREEN_WIDTH, 39)];
        [self addSubview:_sendView];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - _sendView.height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ZMessageViewCell class] forCellWithReuseIdentifier:CellIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        
        [self bringSubviewToFront:_sendView];
        
    }
    return self;
}

- (void)setDelegate:(id<ZMessageDelegate>)delegate {
    _delegate = delegate;
    _sendView.delegate = delegate;
}
- (ZMessageStyle *)style {
    return [ZMessageStyle sharedManager];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollToBottom:NO];
    });
}


/**
 *  滚动到底部
 */
- (void)scrollToBottom:(BOOL)animated {
    
    NSInteger lastItemIndex = _messageModelDict.count - 1;
    if (lastItemIndex > 0) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:lastItemIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:animated];
    }
}


- (void)insertMessageWithArray:(NSArray *)messageArray {
    
    NSInteger weakDictCount = _messageModelDict.count;
    __weak NSMutableDictionary *__messageModelDict = _messageModelDict;
    __weak ZMessageKit *weakSelf = self;
    __weak UICollectionView *weakCollectionView = _collectionView;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        NSMutableArray *array = [NSMutableArray new];
        NSInteger messageModelDictCount = _messageModelDict.count;
        for (NSInteger index = _messageModelDict.count; index < (messageModelDictCount + messageArray.count); index++) {
            [array addObject:[NSIndexPath indexPathForRow:index inSection:0]];
            
            ZMessageModel *model = messageArray[index - messageModelDictCount];
            
            [model resetMessageSize];
            [__messageModelDict setObject:model forKey:@(index)];
        }
     
        

        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 初次赋值数据 weakDictCount 为0, 则不需要performBatchUpdates更新 view
            if (weakDictCount == 0) {
                [_collectionView reloadData];
                [weakSelf scrollToBottom:NO];
            } else {
                
                __weak UICollectionView *weakCollectionView2 = _collectionView;
                [weakCollectionView performBatchUpdates:^{
                    [weakCollectionView2 insertItemsAtIndexPaths:array];
                } completion:^(BOOL finished) {
                    [weakSelf scrollToBottom:YES];
                    [MBProgressHUD hideAllHUDsForView:self animated:YES];
                }];
            }
           

        });
       
        
        NSLog(@"resetMessageSize over");
    });
    
}

#pragma mark -- UICollectionViewDataSource

/**
 *  定义展示的UICollectionViewCell的个数
 *
 *  @param collectionView
 *  @param section
 *
 *  @return
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _messageModelDict.count;
}

/**
 *  定义展示的Section的个数
 *
 *  @param collectionView
 *
 *  @return
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


/**
 *  每个UICollectionView展示的内容
 *
 *  @param collectionView
 *  @param indexPath
 *
 *  @return
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZMessageViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.messageModel = _messageModelDict[@(indexPath.row)];
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout

/**
 *  定义每个UICollectionView 的大小
 *
 *  @param collectionView
 *  @param collectionViewLayout
 *  @param indexPath
 *
 *  @return
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZMessageModel *messageModel = _messageModelDict[@(indexPath.row)];
    
    NSLog(@"indexPath %f", messageModel.messageSize.height);
    
    return CGSizeMake(self.frame.size.width - 20, messageModel.messageSize.height);
}


/**
 *  定义每个UICollectionView 的 margin
 *
 *  @param collectionView
 *  @param collectionViewLayout
 *  @param section
 *
 *  @return
 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 20, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

#pragma mark - textFieldDelegate

/**
 *  获取手势, 触摸列表后隐藏键盘
 *
 *  @param touches
 *  @param event
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_sendView.textField resignFirstResponder];
}

/**
 *  键盘即将显示时,重置坐标
 *
 *  @param notification
 */
- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    _sendView.top = self.height - keyboardRect.size.height - _sendView.height;
    
    _collectionView.height = _sendView.top;
    _collectionView.userInteractionEnabled = NO;
    
    [self scrollToBottom:NO];
    
}

/**
 *  键盘隐藏时,重置坐标
 *
 *  @param notification
 */
- (void)keyboardWillHide:(NSNotification*)notification {
    
    _sendView.top = self.height - _sendView.height;
    _collectionView.height = _sendView.top;
    _collectionView.userInteractionEnabled = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_messageModelDict removeAllObjects];
    _messageModelDict = nil;
    NSLog(@"%s",  __func__);
}
@end