//
//  CalendarExporter.m
//  ScheduleLookup
//
//  Created by CSSE Department on 5/1/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CalendarExporter.h"
#import <EventKit/EventKit.h>


@implementation CalendarExporter

- (void) initiateExportWithSchedule:(Schedule *)schedule
{
    for (ClassSchedule *sched in schedule.schedule)
    {
        [self exportSingleClassToCalendar:sched];
    }
}

- (void) exportSingleClassToCalendar:(ClassSchedule *)schedule
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    
    [event setTitle:schedule.Course];
    [event setLocation:schedule.description];
    [event setStartDate:[NSDate date]];
    [event setEndDate:[NSDate date]];
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
    
    NSLog(@"Exported event: %@", schedule.Course);
    
    
}

@end
