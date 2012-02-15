//
//  Schedule.h
//  ScheduleLookup
//
//  Created by Brandon Knight on 2/13/2012
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Schedule : NSObject
{
    NSMutableArray *schedule;

}

- (Schedule *) initScheduleWithClassArray:(NSMutableArray *) aSchedule;
@property(strong, nonatomic) NSMutableArray *schedule;
@end
