//
//  Schedule.h
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/2012
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassSchedule : NSObject
{
    NSString *Course;
    NSString *CRN;
    NSString *Description;
    NSString *Instructor;
    NSString *Credit;
    NSString *ENRL;
    NSString *CAP;
    NSString *Term_Schedule;
    NSString *Comments;
    NSString *Final_Schedule;
    
    

}

@property(strong, nonatomic) NSString *Course;
@property(strong, nonatomic) NSString *CRN;
@property(strong, nonatomic) NSString *Description;
@property(strong, nonatomic) NSString *Instructor;
@property(strong, nonatomic) NSString *Credit;
@property(strong, nonatomic) NSString *ENRL;
@property(strong, nonatomic) NSString *CAP;
@property(strong, nonatomic) NSString *Term_Schedule;
@property(strong, nonatomic) NSString *Comments;
@property(strong, nonatomic) NSString *Final_Schedule;

- (ClassSchedule *) initClassScheduleWithAlias:(NSString *)newAlias 
                                       WithCRN:(NSString *)newCRN  
                               WithDescription:(NSString *)newDescription
                                WithInstructor:(NSString *)newInstructor  
                                    WithCredit:(NSString *)newCredit
                                      WithENRL:(NSString *)newENRL
                                       WithCAP:(NSString *)newCAP
                             WithTerm_Schedule:(NSString *)newTerm_Schedule
                                  WithComments:(NSString *)newComments
                            WithFinal_Schedule:(NSString *)newFinal_Schedule;

- (NSString *) classInformationString;
- (NSMutableArray *) classMeetingsForDay:(int)day;
- (NSNumber *) numberFromString:(NSString *)numberString;
- (NSMutableArray *) getRangeOfHours:(NSString *)term_schedule;
- (NSString *) getLocation;
- (NSString *) getClassDays;
- (NSString *) getClassHours;
@end
