//
//  NSDateFormatter+MSOSDKAdditions.m
//  Pods
//
//  Created by John Setting on 3/24/17.
//
//

#import "NSDateFormatter+MSOSDKAdditions.h"

@implementation NSDateFormatter (MSOSDKAdditions)

+ (instancetype)mso_longDateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        NSLocale* enUS = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [formatter setLocale: enUS];
        [formatter setLenient: YES];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    });
    return formatter;
}

+ (instancetype)mso_mediumDateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        //    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        //    [dateFormatter setLocale:enUSPOSIXLocale];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    return dateFormatter;
}

@end
