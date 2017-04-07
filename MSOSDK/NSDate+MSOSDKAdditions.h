//
//  NSDate+MSOSDKAdditions.h
//  Pods
//
//  Created by John Setting on 4/6/17.
//
//

#import <Foundation/Foundation.h>

#import "NSDateFormatter+MSOSDKAdditions.h"

@interface NSDate (MSOSDKAdditions)

- (nullable NSString *)mso_stringFromDate;

@end
