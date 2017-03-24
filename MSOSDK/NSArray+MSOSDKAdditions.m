//
//  NSArray+MSOSDKAdditions.m
//  iMobileRep
//
//  Created by John Setting on 3/8/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "NSArray+MSOSDKAdditions.h"

@implementation NSArray (MSOSDKAdditions)

- (id)mso_safeObjectAtIndex:(NSUInteger)index {
    if (index >= [self count] || index < 0) {
        NSLog(@"%s : Attemping to access a key beyond the bounds of the array", __PRETTY_FUNCTION__);
        return nil;
    }
    id object = [self objectAtIndex:index];
    return object;
}

@end
