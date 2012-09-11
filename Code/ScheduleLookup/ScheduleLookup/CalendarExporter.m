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

- (void) initiateExportWithSchedule: (Schedule*) schedule OnDate:(NSDate*) start Until:(NSDate*) end
{
    for (ClassSchedule *sched in schedule.schedule)
    {
        [self exportSingleClassToCalendar:sched From:start Until:end];
    }
}

- (void) exportSingleClassToCalendar:(ClassSchedule *)schedule From:(NSDate*) startDate Until:(NSDate*) endDate
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    NSMutableArray* daysOfWeek = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [schedule getClassDays].length; i++)
    {
        NSString* dayCode = [NSString stringWithFormat:@"%C",[[schedule getClassDays] characterAtIndex:i]];
        if([dayCode isEqualToString:@"M"])
        {
            [daysOfWeek addObject:[EKRecurrenceDayOfWeek dayOfWeek:2]];
        }
        else if([dayCode isEqualToString:@"T"])
        {
            [daysOfWeek addObject:[EKRecurrenceDayOfWeek dayOfWeek:3]];
        }
        else if([dayCode isEqualToString:@"W"])
        {
            [daysOfWeek addObject:[EKRecurrenceDayOfWeek dayOfWeek:4]];
        }
        else if([dayCode isEqualToString:@"R"])
        {
            [daysOfWeek addObject:[EKRecurrenceDayOfWeek dayOfWeek:5]];
        }
        else if([dayCode isEqualToString:@"F"])
        {
            [daysOfWeek addObject:[EKRecurrenceDayOfWeek dayOfWeek:6]];
        }
    }
    
    endDate = [self createNewDateWithTime:[[schedule getRangeOfDates] objectAtIndex:1] OnDate:endDate];
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    EKRecurrenceEnd *recurrenceEnd = [EKRecurrenceEnd recurrenceEndWithEndDate:endDate];
    EKRecurrenceRule *recurrenceRule = [[EKRecurrenceRule alloc]
                                        initRecurrenceWithFrequency:EKRecurrenceFrequencyWeekly
                                        interval:1
                                        daysOfTheWeek:daysOfWeek
                                        daysOfTheMonth:nil
                                        monthsOfTheYear:nil
                                        weeksOfTheYear:nil
                                        daysOfTheYear:nil
                                        setPositions:nil 
                                        end:recurrenceEnd];
    NSDate* startTime = [[NSDate alloc] init];
    NSDate* endTime = [[NSDate alloc] init];
    startTime = [self createNewDateWithTime:[[schedule getRangeOfDates] objectAtIndex:0] OnDate:startDate];
    endTime = [self createNewDateWithTime:[[schedule getRangeOfDates] objectAtIndex:1] OnDate:startDate];
    [event setTitle:schedule.Course];
    [event setLocation:schedule.getLocation];
    [event setStartDate:startTime];
    [event setEndDate:endTime];
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    [event setRecurrenceRules:[NSArray arrayWithObject:recurrenceRule]];
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
    
    
    
    
}
- (NSDate*) createNewDateWithTime:(NSDate*) time OnDate:(NSDate*) start{
    
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents* timeComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:time];
    NSDateComponents* startComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:start];
    
    NSDateComponents* result = [[NSDateComponents alloc] init];
    [result setHour:timeComponents.hour];
    [result setMinute:timeComponents.minute];
    [result setDay:startComponents.day];
    [result setMonth:startComponents.month];
    [result setYear:startComponents.year];
    [result setTimeZone:[[NSCalendar currentCalendar] timeZone]];
    return [[NSCalendar currentCalendar] dateFromComponents:result];
    
}

@end
