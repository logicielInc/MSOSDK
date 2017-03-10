//
//  NSArray+MSOSDKAdditions.h
//  iMobileRep
//
//  Created by John Setting on 3/8/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MSOSDKAdditions)

- (nullable id)mso_safeObjectAtIndex:(NSUInteger)index;

@end
