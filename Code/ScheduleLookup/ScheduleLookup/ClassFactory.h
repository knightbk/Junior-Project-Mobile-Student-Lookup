//
//  ScheduleFactory.h
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/2012
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassSchedule.h"

@interface ClassFactory: NSObject
+ (ClassSchedule *) matchesInStringsForClass:(NSString *)expression WithStringData:(NSString *)sdata;
+ (ClassSchedule *) classScheduleFromSchedulePage:(NSString *)html;
+ (ClassSchedule *) getClass:(NSString *) sdata withRange:(NSTextCheckingResult *) match;


@end
