//
//  ScheduleFactory.m
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/2012
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "ClassFactory.h"
#import "ClassSchedule.h"


@implementation ClassFactory

//this would indicate that a whole sched could only have 1 course...
//this "schedule" seem slike a course, and a schedule will take an array of courses.

+ (ClassSchedule *) getClass:(NSString *) sdata withRange:(NSTextCheckingResult *) match
{
    return [[ClassSchedule alloc] initClassScheduleWithAlias:[sdata substringWithRange:[match rangeAtIndex:1]]
                                                     WithCRN:[sdata substringWithRange:[match rangeAtIndex:2]]
                                             WithDescription:[sdata substringWithRange:[match rangeAtIndex:3]]
                                              WithInstructor:[sdata substringWithRange:[match rangeAtIndex:4]]
                                                  WithCredit:[sdata substringWithRange:[match rangeAtIndex:5]]
                                                    WithENRL:[sdata substringWithRange:[match rangeAtIndex:6]]
                                                     WithCAP:[sdata substringWithRange:[match rangeAtIndex:7]]
                                           WithTerm_Schedule:[sdata substringWithRange:[match rangeAtIndex:8]]
                                                WithComments:[sdata substringWithRange:[match rangeAtIndex:9]]
                                          WithFinal_Schedule:[sdata substringWithRange:[match rangeAtIndex:10]]];
}

@end
