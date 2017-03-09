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
    if (index >= [self count]) {
        return nil;
    }
    id object = [self objectAtIndex:index];
    return object;
}

@end
