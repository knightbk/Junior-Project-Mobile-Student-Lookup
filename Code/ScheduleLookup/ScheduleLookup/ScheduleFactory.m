//
//  ScheduleFactory.m
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/2012
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "ScheduleFactory.h"
#import "Schedule.h"


@implementation ScheduleFactory

+ (Schedule *) scheduleFromSchedulePage:(NSString *) html
{
    return [[Schedule alloc] initScheduleWithAlias:nil
                                           WithCRN:nil
                                        WithCredit:nil
                                      WithComments:nil 
                                           WithCAP:nil
                                    WithInstructor:nil
                                   WithDescription:nil
                                          WithENRL:nil
                                WithFinal_Schedule:nil
                                 WithTerm_Schedule:nil
                                         WithOther:nil];
}


+ (NSString *) firstMatchStringWithRegex:(NSString *)expression WithStringData:(NSString *)sdata
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSArray *matches = [regex matchesInString:sdata options:0 range:NSMakeRange(0, [sdata length])];
    NSLog(@"---------------------");

    //each of these matches should have 10 fields
    //Currently only logging the values and returning an empty string to keep from throwing errors.
    for (NSTextCheckingResult *match in matches) {
        for (int i=1; i < [match numberOfRanges]; i++) {
            NSString *temp = [sdata substringWithRange:[match rangeAtIndex:i]];
            NSLog(@"%@", temp);
        }
        NSLog(@"---------------------");
    }
    return @"";
}

@end
