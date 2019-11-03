//
//  NSDate+MSOSDKAdditions.m
//  Pods
//
//  Created by John Setting on 4/6/17.
//
//

#import "NSDate+MSOSDKAdditions.h"

@implementation NSDate (MSOSDKAdditions)

- (NSString *)mso_stringFromDate {
    NSString *string = [[NSDateFormatter mso_longDateFormatter] stringFromDate:self];
    return string;
}

@end
