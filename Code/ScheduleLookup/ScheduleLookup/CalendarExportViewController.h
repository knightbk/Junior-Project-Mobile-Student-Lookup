//
//  CalendarExportViewController.h
//  ScheduleLookup
//
//  Created by CSSE Department on 5/2/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Schedule.h"
#import "ClassSchedule.h"
@interface CalendarExportViewController : UITableViewController

@property (nonatomic, retain) Schedule* schedule;
@property (nonatomic, retain) NSMutableArray* courseList;

- (id)initWithSchedule:(Schedule*) sched;

@end


