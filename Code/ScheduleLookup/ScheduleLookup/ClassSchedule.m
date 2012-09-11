//
//  Schedule.m
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//



#import "ClassSchedule.h"
#import "Schedule.h"

@implementation ClassSchedule

@synthesize Course, CRN, Credit, Comments, CAP, Instructor, Description, ENRL, Final_Schedule, Term_Schedule;

- (ClassSchedule *) initClassScheduleWithAlias:(NSString *)newAlias 
                                       WithCRN:(NSString *)newCRN  
                               WithDescription:(NSString *)newDescription
                                WithInstructor:(NSString *)newInstructor  
                                    WithCredit:(NSString *)newCredit
                                      WithENRL:(NSString *)newENRL
                                       WithCAP:(NSString *)newCAP
                             WithTerm_Schedule:(NSString *)newTerm_Schedule
                                  WithComments:(NSString *)newComments
                            WithFinal_Schedule:(NSString *)newFinal_Schedule
{
    self.Course = newAlias;
    self.CRN = newCRN;
    self.Credit = newCredit;
    self.Comments = newComments;
    self.CAP = newCAP;
    self.Instructor = newInstructor;
    self.Description = newDescription;
    self.ENRL = newENRL;
    self.Final_Schedule = newFinal_Schedule;
    self.Term_Schedule = newTerm_Schedule;
    
    return self;
}

- (NSString *) classInformationString
{
    return [NSString stringWithFormat:@"Course: %@\nCRN: %@\nDescription: %@\nInstructor: %@\nCredit: %@\nENRL: %@\nCAP: %@\nTerm Schedule: %@\nComments: %@\nFinal Schedule: %@\n",Course, CRN, Description, Instructor, Credit, ENRL, CAP, Term_Schedule, Comments, Final_Schedule];
}

- (NSMutableArray *) classMeetingsForDay:(int)day
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSString *dayCode;
    
    switch (day) {
        case MONDAY:
            dayCode = @"M";
            break;
        case TUESDAY:
            dayCode = @"T";
            break;
        case WEDNESDAY:
            dayCode = @"W";
            break;
        case THURSDAY:
            dayCode = @"R";
            break;
        case FRIDAY:
            dayCode = @"F";
            break;
        default:
            break;
    }
    
    NSArray *meetings = [Term_Schedule componentsSeparatedByString:@":"];
    
    for (NSString *meeting in meetings)
    {
        //extract the days only to avoid false positives from rooms with shorthand same as a dayCode
        //i.e. looking at the entire string W/7-9/F225 would return meeting times for Friday.
        NSString *meetingDays = [[meeting componentsSeparatedByString:@"/"] objectAtIndex:0];
        
        if(!([meetingDays rangeOfString:dayCode].location==NSNotFound) && ([meetingDays rangeOfString:@"TBA"].location==NSNotFound))
        {
            [result addObjectsFromArray:[self getRangeOfHours:meeting]];
        }
    }
    return result;
}

- (NSMutableArray *) getRangeOfHours:(NSString *)term_schedule
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *array = [term_schedule componentsSeparatedByString:@"/"];
    
    
    if([[array objectAtIndex:1] rangeOfString:@"-"].location==NSNotFound)
    {
        [result addObject:[self numberFromString:[array objectAtIndex:1]]];
    }
    else
    {
        NSArray *numbers = [[array objectAtIndex:1] componentsSeparatedByString:@"-"];
        NSNumber *first = [self numberFromString:[numbers objectAtIndex:0]];
        NSNumber *second = [self numberFromString:[numbers objectAtIndex:1]];

        if ([first intValue] > 10) 
        {
            [result addObject:[NSNumber numberWithInt:11]];
        }
        else
        {
            for (int x = [first intValue]; x <= [second intValue]; x++) 
            {
                [result addObject:[NSNumber numberWithInt:x]];
            }
        }
    }

    return result;
}

- (NSMutableArray *) getRangeOfDates
{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    NSMutableArray* hours = [self getRangeOfHours:[self Term_Schedule]];
    
    [result addObject:[self getStartTimeFromHourSlot:[hours objectAtIndex:0]]];
    [result addObject:[self getEndTimeFromHourSlot:[hours lastObject]]];
    
    return result;
}

- (NSDate *) getStartTimeFromHourSlot : (NSNumber*) hour
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    [dateComponents setTimeZone:[[NSCalendar currentCalendar] timeZone]];
    switch ([hour intValue]) {
        case 1:
            [dateComponents setHour:8];
            [dateComponents setMinute:05];
            break;
        case 2:
            [dateComponents setHour:9];
            [dateComponents setMinute:00];
            break;
        case 3:
            [dateComponents setHour:9];
            [dateComponents setMinute:55];
            break;
        case 4:
            [dateComponents setHour:10];
            [dateComponents setMinute:50];
            break;
        case 5:
            [dateComponents setHour:11];
            [dateComponents setMinute:45];
            break;
        case 6:
            [dateComponents setHour:12];
            [dateComponents setMinute:40];
            break;
        case 7:
            [dateComponents setHour:13];
            [dateComponents setMinute:35];
            break;
        case 8:
            [dateComponents setHour:14];
            [dateComponents setMinute:30];
            break;
        case 9:
            [dateComponents setHour:15];
            [dateComponents setMinute:25];
            break;
        case 10:
            [dateComponents setHour:16];
            [dateComponents setMinute:20];
            break;
        default:
            NSLog(@"FIX: Evening Classes");
            [dateComponents setHour:18];
            [dateComponents setMinute:0];
            break;
    }
    
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}
- (NSDate *) getEndTimeFromHourSlot : (NSNumber *) hour
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setTimeZone:[[NSCalendar currentCalendar] timeZone]];
    
    switch ([hour intValue]) {
        case 1:
            [dateComponents setHour:8];
            [dateComponents setMinute:55];
            break;
        case 2:
            [dateComponents setHour:9];
            [dateComponents setMinute:50];
            break;
        case 3:
            [dateComponents setHour:10];
            [dateComponents setMinute:45];
            break;
        case 4:
            [dateComponents setHour:11];
            [dateComponents setMinute:40];
            break;
        case 5:
            [dateComponents setHour:12];
            [dateComponents setMinute:35];
            break;
        case 6:
            [dateComponents setHour:13];
            [dateComponents setMinute:30];
            break;
        case 7:
            [dateComponents setHour:14];
            [dateComponents setMinute:25];
            break;
        case 8:
            [dateComponents setHour:15];
            [dateComponents setMinute:20];
            break;
        case 9:
            [dateComponents setHour:14];
            [dateComponents setMinute:15];
            break;
        case 10:
            [dateComponents setHour:17];
            [dateComponents setMinute:15];
            break;
        default:
            NSLog(@"FIX: Evening Classes");
            [dateComponents setHour:18];
            [dateComponents setMinute:0];
            break;
    }
    
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

- (NSString *) getLocation
{
    return [[[self Term_Schedule] componentsSeparatedByString:@"/"] lastObject];
}

- (NSString *) getClassDays
{
    return [[[self Term_Schedule] componentsSeparatedByString:@"/"] objectAtIndex:0];
}

- (NSString *) getClassHours
{
    return [[[self Term_Schedule] componentsSeparatedByString:@"/"] objectAtIndex:1];
}


- (NSNumber *) numberFromString:(NSString *)numberString
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    return [f numberFromString:numberString];
}

@end