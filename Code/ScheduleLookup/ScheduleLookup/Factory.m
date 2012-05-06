//
//  Factory.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 1/26/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "Factory.h"



@implementation Factory

+ (NSString *) nameFromStringData:(NSString *)sdata
{
    return [self firstMatchStringWithRegex:@">Name: ([^<]+)<" WithStringData:sdata];
}

+ (NSString *) usernameFromStringData:(NSString *)sdata
{
    return [self firstMatchStringWithRegex:@">Username: ([a-zA-Z0-9 ]+)<" WithStringData:sdata];
}

+ (BOOL) userSearchIsPartialMatch:(NSString *)sdata
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@">Instructor Match:"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:sdata options:NSRegularExpressionCaseInsensitive range:NSMakeRange(0, [sdata length])];
    
    return (int) numberOfMatches > 0;
}

+ (NSString *) firstMatchStringWithRegex:(NSString *)expression WithStringData:(NSString *)sdata
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSTextCheckingResult *rangeOfFirstMatch = [regex firstMatchInString:sdata options:0 range:NSMakeRange(0, [sdata length])];
    
    NSString *name = @"";
    if (!NSEqualRanges([rangeOfFirstMatch rangeAtIndex:0], NSMakeRange(NSNotFound, 0))) {
        name = [sdata substringWithRange:[rangeOfFirstMatch rangeAtIndex:1]];
    }
    return name;
}

@end
