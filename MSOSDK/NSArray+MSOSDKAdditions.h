//
//  NSArray+MSOSDKAdditions.h
//  iMobileRep
//
//  Created by John Setting on 3/8/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 An extension of `NSArray` to ensure the application does not crash
 */
@interface NSArray (MSOSDKAdditions)

/**
 Safely returns the object in the array at a specified index. If the index is not within the bounds of the array, Apple's `objectAtIndex:` method will crash the application. This method will return null

 @param index The index of the object in the array
 @return A nullable value
 */
- (nullable id)mso_safeObjectAtIndex:(NSUInteger)index;

@end
