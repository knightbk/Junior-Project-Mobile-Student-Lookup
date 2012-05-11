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

@synthesize startDatePicker, endDatePicker;

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
    
    
    cell.textLabel.text = [courseList objectAtIndex:indexPath.section];
    
    
    if(indexPath.section == [courseList count] - 3)
    {
        cell.textLabel.text = [self formatDate:startDate];
    }
    else if(indexPath.section == [courseList count] - 2)
    {
        cell.textLabel.text = [self formatDate:endDate];
    }
    cell.textAlignment = UITextAlignmentCenter;
    
    
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
            [self displayStartDatePicker:[tableView cellForRowAtIndexPath:indexPath]];
            break;
        case 4:
            
            NSLog(@"Select end date");
            [self displayEndDatePicker:[tableView cellForRowAtIndexPath:indexPath]];
            
            break;
        case 5:
            if([endDate timeIntervalSinceDate:startDate] > 0)
            {
                [exporter initiateExportWithSchedule:schedule OnDate:startDate Until:endDate];
                [[[UIAlertView alloc] initWithTitle:@"Courses exported successfully!" message:@"Press OK to continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
            else
            {
                [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Start date must be before end date!" delegate:nil cancelButtonTitle:@"Sorry." otherButtonTitles:nil] show];
            }
            break;
    }
}

- (IBAction)displayStartDatePicker:(id)sender
{
    startDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Select start date" datePickerMode:UIDatePickerModeDate selectedDate:startDate target:self action:@selector(startDateWasSelected:element:) origin:sender];
    self.startDatePicker.hideCancel = YES;
    
    [self.startDatePicker showActionSheetPicker];
}

- (void) startDateWasSelected:(NSDate*)date element:(id)element {
    startDate = date;
    
    NSLog(@"Date changed to %@", date);
    [[self tableView] reloadData];
    
}

- (IBAction)displayEndDatePicker:(id)sender
{
    endDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Select end date" datePickerMode:UIDatePickerModeDate selectedDate:endDate target:self action:@selector(endDateWasSelected:element:) origin:sender];
    self.endDatePicker.hideCancel = YES;
    
    [self.endDatePicker showActionSheetPicker];
}

- (void) endDateWasSelected:(NSDate *)date element:(id)element
{
    endDate = date;
    
    NSLog(@"End date changed to %@", date);
    
    [[self tableView] reloadData];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    [[self navigationController] popViewControllerAnimated:YES];
}


@end
