//
//  CalendarExportViewController.m
//  ScheduleLookup
//
//  Created by CSSE Department on 5/2/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//


#define TEXT 1
#define DAYS 2
#define HOUR 3
#define DATE 4
#define SUBMIT 5
#define SECTION_TYPES 4
#import "CalendarExportViewController.h"
#import "CalendarExporter.h"


@implementation CalendarExportViewController
@synthesize schedule;

@synthesize courseList;
@synthesize pickerPicker;

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (id)initWithSchedule:(Schedule*) sched
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    [self initWithStyle:UITableViewStyleGrouped].schedule = sched;
    
    courseList = [[NSMutableArray alloc] init];
    pickerPicker = [[NSMutableArray alloc] init];
    for (ClassSchedule* classSched in sched.schedule)
    {
        NSMutableArray* classHours = [classSched getRangeOfDates];
        NSString* hours = [NSString stringWithFormat:@"%@ - %@", [dateFormatter stringFromDate:[classHours objectAtIndex:0]], [dateFormatter stringFromDate:[classHours objectAtIndex:1]]];
        [courseList addObject:classSched.Description];
        [courseList addObject:[classSched getLocation]];
        [courseList addObject:[classSched getClassDays]];
        [courseList addObject:hours];
        
        [pickerPicker addObject:[NSString stringWithFormat:@"%d",TEXT]];
        [pickerPicker addObject:[NSString stringWithFormat:@"%d",TEXT]];
        [pickerPicker addObject:[NSString stringWithFormat:@"%d",DAYS]];
        [pickerPicker addObject:[NSString stringWithFormat:@"%d",HOUR]];        
    }
    
    [courseList addObject:@"Enter Start Date"];
    [courseList addObject:@"Enter End Date"];
    [courseList addObject:@"Submit"];
    
    [pickerPicker addObject:[NSString stringWithFormat:@"%d",DATE]];
    [pickerPicker addObject:[NSString stringWithFormat:@"%d",DATE]];
    [pickerPicker addObject:[NSString stringWithFormat:@"%d",SUBMIT]];
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    
    }
    return self;
}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [courseList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if(section < ([schedule.schedule count] * SECTION_TYPES))
    {   
        if(section % SECTION_TYPES == 1)
        {
            return 0;
        }
        if(section % SECTION_TYPES == 2)
        {
            return 0;
        }
        if(section % SECTION_TYPES == 3)
        {
            return 0;
        }
    }
    return 1;
}





- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if(section < ([schedule.schedule count] * SECTION_TYPES))
    {
        if(section % SECTION_TYPES == 0)
        {
            return @"Course";
        }
        if(section % SECTION_TYPES == 1)
        {
            return [NSString stringWithFormat:@"Location: %@", [courseList objectAtIndex:section]];
        }
        if(section % SECTION_TYPES == 2)
        {
            return [NSString stringWithFormat:@"Days: %@", [courseList objectAtIndex:section]];
        }
        if(section % SECTION_TYPES == 3)
        {
            return [NSString stringWithFormat:@"Time: %@", [courseList objectAtIndex:section]];
        }
    }
    else if(section < [schedule.schedule count] * SECTION_TYPES + 1)
    {
        return @"Calendar Start date";
    }
    else if(section < [schedule.schedule count] * SECTION_TYPES + 2)
    {
        return @"Calendar End date";
    }
    return @"";
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if((section < ([schedule.schedule count] * SECTION_TYPES) && section % SECTION_TYPES == 3) || section == [courseList count] - 2)
    {
        return 40;
    }
    else
    {
        return 10;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textAlignment = UITextAlignmentCenter;
    cell.textLabel.text = [courseList objectAtIndex:indexPath.section];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarExporter *exporter = [[CalendarExporter alloc] init];
    
    switch ([[pickerPicker objectAtIndex:indexPath.section] intValue]) {
        case 1:
            //Bring up keyboard and allow editing of [courseList objectAtIndex:indexPath.section]
            //Modifies course title or location.
            NSLog(@"Edit text");
            break;
        case 2:
            //Bring up picker with days and allow them to verify the correct days with check list
            //Maybe we shouldn't let them change this. It's definitely right..
            NSLog(@"Select days");
            break;
        case 3:
            //Bring up picker with hours and allow them to verify correct hour
            //Maybe we shouldn't let them change this. It's definitely right.
            NSLog(@"Select hour");
            break;
        case 4:
            //Bring up date picker and allow them to pick start/end date
            NSLog(@"Select date");
            
            break;
        case 5:
            [exporter initiateExportWithSchedule:schedule OnDate:[NSDate date] Until:[NSDate dateWithTimeInterval:(24*60*60) sinceDate:[NSDate date]]];
            break;
    }
}



@end
