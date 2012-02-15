//
//  Schedule.m
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//



#import "Schedule.h"
#import "ClassSchedule.h"
@implementation Schedule

@synthesize schedule;



- (Schedule *) initScheduleWithClassArray:(NSMutableArray *) aSchedule;
{
    self.schedule = aSchedule;
    
    return self;
}

- (NSString *) scheduleInformationString
{
    NSMutableString *result = [NSMutableString stringWithString:@"----------\n"];
    for (ClassSchedule *class in self.schedule) {
        [result appendString:[class classInformationString]];
        [result appendString:@"----------\n"];
    }
    return result;
}

@end