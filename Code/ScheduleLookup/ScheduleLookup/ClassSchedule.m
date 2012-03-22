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
        if(!([meeting rangeOfString:dayCode].location==NSNotFound))
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
            NSLog(@"FIX: evening class");
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

- (NSNumber *) numberFromString:(NSString *)numberString
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    return [f numberFromString:numberString];
}

@end