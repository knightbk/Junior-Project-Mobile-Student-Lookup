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
#import "ActionSheetPicker.h"

@interface CalendarExportViewController : UITableViewController <UIAlertViewDelegate, UIActionSheetDelegate>
{
    NSDate* startDate;
    NSDate* endDate;
}
@property (nonatomic, retain) Schedule* schedule;
@property (nonatomic, retain) NSMutableArray* courseList;
@property (nonatomic, retain) NSMutableArray* pickerPicker;

@property (nonatomic, retain) ActionSheetDatePicker* startDatePicker;
@property (nonatomic, retain) ActionSheetDatePicker* endDatePicker;

- (id)initWithSchedule:(Schedule*) sched;
- (NSString*) formatDate: (NSDate*) date;
- (IBAction)displayStartDatePicker:(id)sender;
- (IBAction)displayEndDatePicker:(id)sender;
- (void) startDateWasSelected:(NSDate*)date element:(id)element;
- (void) endDateWasSelected:(NSDate*)date element:(id)element;
@end


