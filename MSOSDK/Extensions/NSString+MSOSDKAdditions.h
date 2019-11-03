//
//  NSString+MSOSDKAdditions.h
//  iMobileRep
//
//  Created by John Setting on 3/2/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

#import "MSOSDKConstants.h"
#import "NSMutableString+MSOSDKAdditions.h"
#import "NSDateFormatter+MSOSDKAdditions.h"

@interface NSString (MSOSDKAdditions)

/**
 Used to interact with Netserver. This function builds a string between `MSOSDK_begin_command` and `MSOSDK_end_command` whose parameters are seperated using `^`

 @param parameters The fields to send to Netserver
 @return A formatted `NSString` object used to send to Netserver
 */
- (nonnull instancetype)mso_build_command:(nullable NSArray *)parameters;

/**
 Given a string, the method finds a substring between the starting string and ending string. If no string is found, nil is returned.

 @param start The string to start finding the specified substring
 @param end The string to end finding the specified substring
 @return The substring between the start and end string. If end or start is nil, nothing is returned
 */
- (nullable instancetype)mso_stringBetweenString:(nullable NSString *)start andString:(nullable NSString *)end;


/**
 An XML escaped string formatted to send to the Webserver (FTP) or Netserver 
 
 @return An XML escaped `NSString` object
 */
- (nullable NSString *)mso_escape;

/**
 An XML unescaped string formatted to be read into
 
 @return An XML unescaped `NSString` object
 */
- (nullable NSString *)mso_unescape;

/**
 Converts a `kMSOProductSearchType` enum to a string value

 @param type A `kMSOProductSearchType` enum
 @return A formatted `NSString` value
 */
+ (nonnull NSString *)mso_product_search_type_formatted:(kMSOProductSearchType)type;

- (nullable NSDate *)mso_dateFromString;

@end
