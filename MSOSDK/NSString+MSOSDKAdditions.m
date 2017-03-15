//
//  NSString+MSOSDKAdditions.m
//  iMobileRep
//
//  Created by John Setting on 3/2/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "NSString+MSOSDKAdditions.h"

#import <GTMNSStringHTMLAdditions/GTMNSString+HTML.h>

static NSString * const MSOSDK_begin_command = @"<*!BEGIN!*><~~>";
static NSString * const MSOSDK_end_command = @"<*!END!*>";

@implementation NSString (MSOSDKAdditions)

- (instancetype)mso_build_command:(NSArray *)parameters {

    NSString *params = [self copy];
    if (parameters && [parameters count] > 0) {
        NSString *additions = [NSString stringWithFormat:@"^%@", [parameters componentsJoinedByString:@"^"]];
        params = [params stringByAppendingString:additions];
    }
    
    NSString *formatted = [NSString _mso_build_command:params];
//    NSString *escaped = formatted;
    NSString *escaped = [formatted mso_escape];
    
    return escaped;
}

- (NSString *)mso_escape {
    NSString *escaped = [self gtm_stringByEscapingForHTML];
    return escaped;
}

- (NSString *)mso_unescape {
//    NSString *unescaped = [self gtm_stringByUnescapingFromHTML];
    //NSString *unescaped = [self htmlEntityDecode];
    return [[self gtm_stringByUnescapingFromHTML] gtm_stringByUnescapingFromHTML];
}

+ (instancetype)_mso_build_command:(NSString *)internal {
    return [NSString stringWithFormat:@"%@%@%@", MSOSDK_begin_command, internal, MSOSDK_end_command];
}

- (instancetype)mso_stringBetweenString:(NSString *)start andString:(NSString *)end {
    if (![self containsString:end] || ![self containsString:start]) return nil;
    NSScanner* scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    [scanner scanUpToString:start intoString:NULL];
    if ([scanner scanString:start intoString:NULL]) {
        NSString* result = nil;
        if ([scanner scanUpToString:end intoString:&result]) {
            return result;
        }
    }
    return nil;
}


@end
