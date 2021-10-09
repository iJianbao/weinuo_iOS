//
//  lanyaUITests.m
//  lanyaUITests
//
//  Created by apple on 2019/11/30.
//  Copyright © 2019 ronglian. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "lanyaUITests-Swift.h"

@interface lanyaUITests : XCTestCase

@end

@implementation lanyaUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [Snapshot setupSnapshot:app waitForAnimations:YES];
    [app launch];
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
}

- (void)testExample {
    // UI tests must launch the application that they test.
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
    
    [Snapshot snapshot:@"01LoginScreen" timeWaitingForIdle:10];
    XCUIElement *btnDisconnectedGoButton = app.buttons[@"btn disconnected go"];
    [btnDisconnectedGoButton tap];
//    [Snapshot snapshot:@"link" timeWaitingForIdle:10];
//    XCUIElementQuery *tablesQuery = app.tables;
//    [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:1].staticTexts[@"cBOX_1584006BD8"] tap];
//    [Snapshot snapshot:@"heale" timeWaitingForIdle:10];
//
//    [app.navigationBars[@"\u667a\u80fd\u5347\u964d\u684c"].buttons[@"btn set"] tap];
//    [Snapshot snapshot:@"setting" timeWaitingForIdle:10];
    
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)) {
        // This measures how long it takes to launch your application.
        [self measureWithMetrics:@[XCTOSSignpostMetric.applicationLaunchMetric] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
