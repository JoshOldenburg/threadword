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

@end
