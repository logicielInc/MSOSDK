//
//  NSURLRequest+MSOSDKAdditions.m
//  iMobileRep
//
//  Created by John Setting on 3/8/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "NSURLRequest+MSOSDKAdditions.h"

@implementation NSURLRequest (MSOSDKAdditions)

- (void)printRequestWithBenchmark:(NSDate *)date headerMessage:(NSString *)headerMessage {
    NSError *error = nil;
    if (self.HTTPBody) {
        NSString *json = [NSJSONSerialization JSONObjectWithData:self.HTTPBody
                                                  options:NSJSONReadingMutableContainers
                                                    error:&error];
        
        if (!json || [json isKindOfClass:[NSNull class]] || [json isEqual:[NSNull null]]) {
            json = [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding];
        }
        
        if (date) {
            NSLog(@"Debug: \n\nCallie = %@\nURL = %@\nURL = %@ (DECODED)\nMETHOD = %@\nHEADERS = %@\nBODY = \n%@\n\n",
                       headerMessage, self.URL, [[self.URL absoluteString] stringByRemovingPercentEncoding], self.HTTPMethod, self.allHTTPHeaderFields, json);
        } else {
            NSLog(@"Debug: \n\nCallie = %@\nURL = %@\nURL = %@ (DECODED)\nMETHOD = %@\nHEADERS = %@\nBODY = \n%@\nTime Executed = %f\n\n",
                       headerMessage, self.URL, [[self.URL absoluteString] stringByRemovingPercentEncoding], self.HTTPMethod, self.allHTTPHeaderFields, json, [[NSDate date] timeIntervalSinceDate:date]);
        }
    } else {
        if (date) {
            NSLog(@"Debug: \n\nCallie = %@\nURL = %@\nURL = %@ (DECODED)\nMETHOD = %@\nHEADERS = %@\nTime Executed = %f\n\n",
                       headerMessage, self.URL, [[self.URL absoluteString] stringByRemovingPercentEncoding], self.HTTPMethod, self.allHTTPHeaderFields, [[NSDate date] timeIntervalSinceDate:date]);
        } else {
            NSLog(@"Debug: \n\nCallie = %@\nURL = %@\nURL = %@ (DECODED)\nMETHOD = %@\nHEADERS = %@\n\n",
                       headerMessage, self.URL, [[self.URL absoluteString] stringByRemovingPercentEncoding], self.HTTPMethod, self.allHTTPHeaderFields);
        }
    }
}

@end
