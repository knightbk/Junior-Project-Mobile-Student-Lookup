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
                          WithCredit:(NSString *)newCredit
                        WithComments:(NSString *)newComments
                             WithCAP:(NSString *)newCAP
                      WithInstructor:(NSString *)newInstructor  
                     WithDescription:(NSString *)newDescription
                            WithENRL:(NSString *)newENRL
                  WithFinal_Schedule:(NSString *)newFinal_Schedule
                   WithTerm_Schedule:(NSString *)newTerm_Schedule


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

@end