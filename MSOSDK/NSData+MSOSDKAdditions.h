//
//  NSData+MSOSDKAdditions.h
//  Pods
//
//  Created by John Setting on 4/6/17.
//
//

#import <Foundation/Foundation.h>

#import "MSOSDKConstants.h"
#import "NSString+MSOSDKAdditions.h"
#import "NSMutableString+MSOSDKAdditions.h"

@interface NSData (MSOSDKAdditions)

- (nullable NSString *)sanatizeDataForWebServiceResponse;
- (nullable NSString *)sanatizeDataForNetserverResponse;

@end
