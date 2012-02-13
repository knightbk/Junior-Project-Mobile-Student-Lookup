//
//  ScheduleFactory.m
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/2012
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "ScheduleFactory.h"



@implementation ScheduleFactory

+ (NSString *) scheduleFromStringData:(NSString *)sdata
{
    return [self firstMatchStringWithRegex:@">Name: ([a-zA-Z ]+)<" WithStringData:sdata];
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
