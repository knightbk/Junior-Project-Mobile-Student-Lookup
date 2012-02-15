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

+ (ClassSchedule *) classScheduleFromSchedulePage:(NSString *) html
{
   ClassSchedule *classSchedule = [self matchesInStringsForClass:@"<TR>.*>([A-Z-]{2,4}[0-9]{3}R?L?-[0-9]{2}|[0]{2}[A-Z-]{2,5}-[0-9]{2})<.*?<TD>([0-9]{4})</TD><TD>([^<]+)</TD>.*?>([a-zA-Z0-9]+)<.*?<TD>([0-9]+)\n?</TD><TD>([0-9]+)</TD><TD>([0-9]+)</TD>.*?\n*.*<TD>([MTWRF]+/[^<]+|TBA|TBA/TBA/TBA)</TD><TD>([^<]*)</TD><TD>([^<]*)</TD></TR>" WithStringData:html];
    return classSchedule;
    
}
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

//+ (ClassSchedule *) matchesInStringsForClass:(NSString *)expression WithStringData:(NSString *)sdata withRange:(NSTextCheckingResult *) place
//{
//    NSError *error = NULL;
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
//                                                                           options:NSRegularExpressionCaseInsensitive
//                                                                             error:&error];
//    
//    NSArray *matches = [regex matchesInString:sdata options:0 range:NSMakeRange(0, [sdata length])];
//    //each of these matches should have 10 fields
//    //Currently only logging the values and returning an empty string to keep from throwing errors. 
//    for (place in matches) {
//        return [self getClass:sdata withRange:place];
//    }
//}
@end
