//
//  iMRTestCase.h
//  iMobileRep
//
//  Created by John Setting on 2/8/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MSOTestCase : XCTestCase

@property (nonatomic, assign) NSTimeInterval networkTimeout;

- (void)waitForExpectationsWithLongTimeout;
- (void)waitForExpectationsWithLongTimeoutUsingHandler:(XCWaitCompletionHandler)handler;
- (void)waitForExpectationsWithCommonTimeout;
- (void)waitForExpectationsWithCommonTimeoutUsingHandler:(XCWaitCompletionHandler)handler;

@end
