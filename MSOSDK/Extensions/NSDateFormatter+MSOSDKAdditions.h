//
//  NSDateFormatter+MSOSDKAdditions.h
//  Pods
//
//  Created by John Setting on 3/24/17.
//
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (MSOSDKAdditions)

+ (nonnull instancetype)mso_longDateFormatter;
+ (nonnull instancetype)mso_mediumDateFormatter;

@end
