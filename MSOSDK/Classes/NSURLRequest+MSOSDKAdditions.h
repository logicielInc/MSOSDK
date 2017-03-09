//
//  NSURLRequest+MSOSDKAdditions.h
//  iMobileRep
//
//  Created by John Setting on 3/8/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (MSOSDKAdditions)

- (void)printRequestWithBenchmark:(nullable NSDate *)date headerMessage:(nullable NSString *)headerMessage;

@end
