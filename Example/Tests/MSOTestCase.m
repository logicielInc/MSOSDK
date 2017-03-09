//
//  MSOTestCase.m
//  iMobileRep
//
//  Created by John Setting on 2/8/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOTestCase.h"

@implementation MSOTestCase

- (void)setUp {
    [super setUp];
    
    self.networkTimeout = 30.0;
}

- (void)tearDown {

    [super tearDown];
}

#pragma mark -

- (void)waitForExpectationsWithLongTimeout {
    [self waitForExpectationsWithLongTimeoutUsingHandler:nil];
}

- (void)waitForExpectationsWithLongTimeoutUsingHandler:(XCWaitCompletionHandler)handler {
    self.networkTimeout = 600.0;
    [self waitForExpectationsWithTimeout:self.networkTimeout handler:handler];
}

- (void)waitForExpectationsWithCommonTimeout {
    [self waitForExpectationsWithCommonTimeoutUsingHandler:nil];
}

- (void)waitForExpectationsWithCommonTimeoutUsingHandler:(XCWaitCompletionHandler)handler {
    [self waitForExpectationsWithTimeout:self.networkTimeout handler:handler];
}

@end
