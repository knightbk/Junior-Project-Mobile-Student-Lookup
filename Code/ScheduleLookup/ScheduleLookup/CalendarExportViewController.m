//
//  CalendarExportViewController.m
//  ScheduleLookup
//
//  Created by CSSE Department on 5/2/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//


#define TEXT 1
#define DAYS 2
#define START_DATE 3
#define END_DATE 4
#define SUBMIT 5
#define SECTION_TYPES 4
#import "CalendarExportViewController.h"
#import "CalendarExporter.h"


@implementation CalendarExportViewController
@synthesize schedule;

@synthesize courseList;
@synthesize pickerPicker;
//@synthesize datePicker;
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (id)initWithSchedule:(Schedule*) sched
{
    startDate = [NSDate date];
    endDate = [[NSDate alloc] initWithTimeInterval:(60*60*24) sinceDate:startDate];
    
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
        [pickerPicker addObject:[NSString stringWithFormat:@"%d",TEXT]];        
    }
    
    [courseList addObject:[NSString stringWithFormat:@"%@",[self formatDate:startDate]]];
    [courseList addObject:[NSString stringWithFormat:@"%@",[self formatDate:endDate]]];
    [courseList addObject:@"Submit"];
    
    [pickerPicker addObject:[NSString stringWithFormat:@"%d",START_DATE]];
    [pickerPicker addObject:[NSString stringWithFormat:@"%d",END_DATE]];
    [pickerPicker addObject:[NSString stringWithFormat:@"%d",SUBMIT]];
    return self;
}

- (NSString*) formatDate:(NSDate*) date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd yyyy"];
    
    return [formatter stringFromDate:date];
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
    if(indexPath.section > [courseList count] - 4)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textAlignment = UITextAlignmentCenter;
    cell.textLabel.text = [courseList objectAtIndex:indexPath.section];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CalendarExporter *exporter = [[CalendarExporter alloc] init];
    
    switch ([[pickerPicker objectAtIndex:indexPath.section] intValue]) {
        case 1:

            break;
        case 2:

            break;
        case 3:
           
            NSLog(@"Select start date");
            [self displayStartDatePicker];
            break;
        case 4:
            //Bring up date picker and allow them to pick start/end date
            NSLog(@"Select end date");
            
            
            break;
        case 5:
            [exporter initiateExportWithSchedule:schedule OnDate:[NSDate date] Until:[NSDate dateWithTimeInterval:(24*60*60) sinceDate:[NSDate date]]];
            [[[UIAlertView alloc] initWithTitle:@"Courses exported successfully!" message:@"Press OK to continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            break;
    }
}

- (void) displayStartDatePicker
{
    
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Clicked button.");
}
-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Clicked cancel button.");
}

-(void) actionSheetCancel:(UIActionSheet *)actionSheet
{
    NSLog(@"Cancelling.");
}

@end
