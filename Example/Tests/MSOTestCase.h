//
//  iMRTestCase.h
//  iMobileRep
//
//  Created by John Setting on 2/8/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SMXMLDocument/SMXMLDocument.h>
#import "MSOSDK.h"

// Test suite 1 == Chinese Laundry
// Test suite 2 == Volume Distributer
// Test suite 3 == Logiciel
#define test 2

@interface MSOTestCase : XCTestCase

@property (nonatomic, assign) NSTimeInterval networkTimeout;

- (void)waitForExpectationsWithLongTimeout;
- (void)waitForExpectationsWithLongTimeoutUsingHandler:(XCWaitCompletionHandler)handler;
- (void)waitForExpectationsWithCommonTimeout;
- (void)waitForExpectationsWithCommonTimeoutUsingHandler:(XCWaitCompletionHandler)handler;

@end
