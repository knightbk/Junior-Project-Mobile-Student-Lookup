//
//  Schedule.m
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//



#import "Schedule.h"
@implementation Schedule

@synthesize schedule;



- (Schedule *) initScheduleWithClassArray:(NSMutableArray *) aSchedule;
{
    self.schedule = aSchedule;
    
    return self;
}

@end