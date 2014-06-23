//
//  JOUtil.h
//  threadword
//
//  Created by Joshua Oldenburg on 6/18/14.
//  Copyright (c) 2014 Joshua Oldenburg. All rights reserved.
//

@import Foundation;
@import CoreServices;

@interface JOUtil : NSObject

+ (BOOL)isWord:(NSString *)word;
+ (NSUInteger)binarySearchArray:(NSArray *)array forObject:(id)object;
+ (BOOL)isFound:(NSUInteger)idx; // != NSNotFound

@end
