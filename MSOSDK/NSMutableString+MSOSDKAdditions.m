//
//  NSMutableString+MSOSDKAdditions.m
//  Pods
//
//  Created by John Setting on 4/6/17.
//
//

#import "NSMutableString+MSOSDKAdditions.h"

@implementation NSMutableString (MSOSDKAdditions)

- (NSMutableString *)mso_string_escape {
    NSMutableString *string = [self mutableCopy];
    [string replaceOccurrencesOfString:@"&"  withString:@"&amp;"  options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"'"  withString:@"&apos;" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@">"  withString:@"&gt;"   options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"<"  withString:@"&lt;"   options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    return string;
}

- (NSMutableString *)mso_string_unescape {
    NSMutableString *string = [self mutableCopy];
    [string replaceOccurrencesOfString:@"&amp;"     withString:@"&"     options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&gt;"      withString:@">"     options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&lt;"      withString:@"<"     options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&apos"     withString:@"'"     options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&quot;"    withString:@"\""    options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    return string;
}

@end
