//
//  Schedule.h
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/2012
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#define MONDAY 1
#define TUESDAY 2
#define WEDNESDAY 3
#define THURSDAY 4
#define FRIDAY 5

#import <Foundation/Foundation.h>

@interface Schedule : NSObject
{
    NSMutableArray *schedule;

}

- (Schedule *) initScheduleWithClassArray:(NSMutableArray *) aSchedule;

- (NSString *) scheduleInformationString;
- (NSMutableArray *)getScheduleForDay:(int) day;

@property(strong, nonatomic) NSMutableArray *schedule;
@end
