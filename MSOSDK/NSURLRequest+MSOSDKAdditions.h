//
//  NSURLRequest+MSOSDKAdditions.h
//  iMobileRep
//
//  Created by John Setting on 3/8/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (MSOSDKAdditions)

/**
 Used for debug purposes. Prints the entire `NSURLRequest` object, from its BODY to URL

 @param date The date to run against when the request has finished being generated
 @param headerMessage A custom message to print (e.g __PRETTY_FUNCTION)
 */
- (void)printRequestWithBenchmark:(nullable NSDate *)date
                    headerMessage:(nullable NSString *)headerMessage;

@end
