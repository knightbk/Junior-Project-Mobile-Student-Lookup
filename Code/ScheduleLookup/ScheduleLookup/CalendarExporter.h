//
//  CalendarExporter.h
//  ScheduleLookup
//
//  Created by CSSE Department on 5/1/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "Schedule.h"
#import "ClassSchedule.h"

@interface CalendarExporter : NSObject

- (void) initiateExportWithSchedule: (Schedule*) schedule;
- (void) exportSingleClassToCalendar: (ClassSchedule*) schedule;



@end

