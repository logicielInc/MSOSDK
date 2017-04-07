//
//  NSMutableString+MSOSDKAdditions.h
//  Pods
//
//  Created by John Setting on 4/6/17.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableString (MSOSDKAdditions)

- (nullable NSMutableString *)mso_string_escape;
- (nullable NSMutableString *)mso_string_unescape;

@end
