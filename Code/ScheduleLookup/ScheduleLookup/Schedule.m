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

- (NSMutableArray *)getScheduleForDay:(int) day
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (int x = 0; x < 10; x++)
    {
        [result addObject:@""];
    }
    
    for (ClassSchedule *class in schedule)
    {
        for (NSNumber *number in [class classMeetingsForDay:day])
        {
            [result replaceObjectAtIndex:[number intValue]-1 withObject:class.Course];
        }
    }
    return result;
}

@end