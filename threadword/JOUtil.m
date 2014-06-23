//
//  JOUtil.m
//  threadword
//
//  Created by Joshua Oldenburg on 6/18/14.
//  Copyright (c) 2014 Joshua Oldenburg. All rights reserved.
//

#import "JOUtil.h"

@implementation JOUtil

// CF is a pain in Swift
+ (BOOL)isWord:(NSString *)word {
	NSString *definition = (__bridge_transfer NSString *)DCSCopyTextDefinition(NULL, (__bridge CFStringRef)word, CFRangeMake(0, word.length));
	return !!definition;
}

+ (NSUInteger)binarySearchArray:(NSArray *)array forObject:(id)object {
	return [array indexOfObject:array inSortedRange:NSMakeRange(0, array.count) options:0 usingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [obj1 compare:obj2];
	}];
}

+ (BOOL)isFound:(NSUInteger)idx {
	return idx != NSNotFound;
}

@end
