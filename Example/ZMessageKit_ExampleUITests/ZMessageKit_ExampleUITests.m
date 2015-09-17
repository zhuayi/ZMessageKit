//
//  ZMessageKit_ExampleUITests.m
//  ZMessageKit_ExampleUITests
//
//  Created by zhuayi on 15/9/17.
//  Copyright © 2015年 zhuayi. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ZMessageKit_ExampleUITests : XCTestCase

@end

@implementation ZMessageKit_ExampleUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
//    XCUIElement *button = app.navigationBars[@"ZView"].buttons[@"\U4e0a\U4f20\Uff082/9\Uff09\U5f20"];
//    [button tap];
    
    XCUIElement *element = [[[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"ZView"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element;
//    [[[element childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:2] tap];
//    [app.buttons[@"\U4e0a\U4f20\Uff082/9\Uff09\U5f20"] tap];
//    [app.alerts[@"\U201cZMessageKit_Example\U201d Would Like to Access Your Photos"].collectionViews.buttons[@"OK"] tap];
    
    XCUIElementQuery *collectionViewsQuery = app.collectionViews;
    [[[collectionViewsQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:4].buttons[@"CameraSelect"] tap];
    [[[collectionViewsQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:2].buttons[@"CameraSelect"] tap];
//    [app.buttons[@"\U4e0a\U4f20\Uff082/9\Uff09\U5f20"] tap];
    
    XCUIElement *textView = [element childrenMatchingType:XCUIElementTypeTextView].element;
    [textView tap];
    [textView typeText:@"Sfh\n"];
//    [button tap];
    self.continueAfterFailure = YES;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
