//
//  ScheduleFactory.m
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/2012
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "ScheduleFactory.h"
#import "Schedule.h"
#import "ClassSchedule.h"
#import "ClassFactory.h"

@implementation ScheduleFactory

+ (Schedule *) scheduleFromSchedulePage:(NSString *) html
{
   Schedule *aSchedule = [self matchesInStrings:@"<TR>.*>([A-Z-]{2,4}[0-9]{3}R?L?-[0-9]{2}|[0]{2}[A-Z-]{2,5}-[0-9]{2})<.*?<TD>([0-9]{4})</TD><TD>([^<]+)</TD>.*?>([a-zA-Z0-9]+)<.*?<TD>([0-9]+)\n?</TD><TD>([0-9]+)</TD><TD>([0-9]+)</TD>.*?\n*.*<TD>([MTWRF]+/[^<]+|TBA|TBA/TBA/TBA)</TD><TD>([^<]*)</TD><TD>([^<]*)</TD></TR>" WithStringData:html];

    return aSchedule;
    
    
}
//this would indicate that a whole sched could only have 1 course...
//this "schedule" seem slike a course, and a schedule will take an array of courses.

+ (Schedule *) matchesInStrings:(NSString *)expression WithStringData:(NSString *)sdata
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSArray *matches = [regex matchesInString:sdata options:0 range:NSMakeRange(0, [sdata length])];
    NSMutableArray *schedule = [NSMutableArray array];
    ClassSchedule *class = nil;
    //each of these matches should have 10 fields
    //Currently only logging the values and returning an empty string to keep from throwing errors. 
    for (NSTextCheckingResult *match in matches) {
        class = [ClassFactory getClass:sdata withRange:match];
        [schedule addObject:class];
        
    }
    return [[Schedule alloc] initScheduleWithClassArray:schedule];
}

@end
