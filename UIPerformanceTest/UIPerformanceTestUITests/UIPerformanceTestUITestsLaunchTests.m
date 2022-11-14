//
//  UIPerformanceTestUITestsLaunchTests.m
//  UIPerformanceTestUITests
//
//  Created by Jack-Sparrow on 2022/11/11.
//

#import <XCTest/XCTest.h>

@interface UIPerformanceTestUITestsLaunchTests : XCTestCase

@end

@implementation UIPerformanceTestUITestsLaunchTests

+ (BOOL)runsForEachTargetApplicationUIConfiguration {
    return YES;
}

- (void)setUp {
    self.continueAfterFailure = NO;
}

- (void)testLaunch {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // Insert steps here to perform after app launch but before taking a screenshot,
    // such as logging into a test account or navigating somewhere in the app

    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:XCUIScreen.mainScreen.screenshot];
    attachment.name = @"Launch Screen";
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    [self addAttachment:attachment];
}

@end
