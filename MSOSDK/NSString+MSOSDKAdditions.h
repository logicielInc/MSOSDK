//
//  NSString+MSOSDKAdditions.h
//  iMobileRep
//
//  Created by John Setting on 3/2/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

@interface NSString (MSOSDKAdditions)

- (nonnull instancetype)mso_build_command:(nullable NSArray *)parameters;
- (nullable instancetype)mso_stringBetweenString:(nullable NSString *)start andString:(nullable NSString *)end;
- (nullable NSString *)mso_escape;
- (nullable NSString *)mso_unescape;

@end
