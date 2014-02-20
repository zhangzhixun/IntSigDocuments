//
//  MyTest.m
//  iOSFramework
//
//  Created by 张志勋 on 14-1-2.
//  Copyright (c) 2014年 IntSig. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MyTest : XCTestCase

@end

@implementation MyTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
