//
//  NSString+MSOSDKAdditions.m
//  iMobileRep
//
//  Created by John Setting on 3/2/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "NSString+MSOSDKAdditions.h"

@implementation NSString (MSOSDKAdditions)

- (instancetype)mso_build_command:(NSArray *)parameters {

    NSString *params = [self copy];
    if (parameters && [parameters count] > 0) {
        NSString *additions = [NSString stringWithFormat:@"^%@", [parameters componentsJoinedByString:@"^"]];
        params = [params stringByAppendingString:additions];
    }
    
    NSString *formatted = [NSString _mso_build_command:params];
    NSString *escaped = [formatted mso_escape];
    return escaped;
}

- (NSString *)mso_escape {
//    NSString *escaped = [self gtm_stringByEscapingForHTML];
    NSString *escaped = [[[self mutableCopy] mso_string_escape] copy];
    return escaped;
}

- (NSString *)mso_unescape {
//    NSString *unescaped = [self gtm_stringByUnescapingFromHTML];
    NSString *unescaped = [[[self mutableCopy] mso_string_unescape] copy];
    return unescaped;
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

+ (NSString *)mso_product_search_type_formatted:(kMSOProductSearchType)type {
    if (type < 0 || type > 5) return @"1";
    return [NSString stringWithFormat:@"%li", (long)type];
}


- (NSDate *)mso_dateFromString {
    NSDate *string = [[NSDateFormatter mso_mediumDateFormatter] dateFromString:self];
    return string;
}


@end
