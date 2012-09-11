//
//  ScheduleFactory.h
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/2012
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Schedule.h"

@interface ScheduleFactory: NSObject
+ (Schedule *) matchesInStrings:(NSString *)expression WithStringData:(NSString *)sdata;
+ (Schedule *) scheduleFromSchedulePage:(NSString *)html;



@end
