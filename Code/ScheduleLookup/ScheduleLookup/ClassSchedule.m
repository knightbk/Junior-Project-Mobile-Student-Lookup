//
//  Schedule.m
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//



#import "ClassSchedule.h"
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

@end