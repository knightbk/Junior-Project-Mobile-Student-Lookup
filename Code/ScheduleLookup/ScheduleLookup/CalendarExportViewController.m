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
#define SECTION_TYPES 4
#import "CalendarExportViewController.h"



@implementation CalendarExportViewController
@synthesize schedule;

@synthesize courseList;
@synthesize pickerPicker;

- (id)initWithSchedule:(Schedule*) sched
{
    [self initWithStyle:UITableViewStyleGrouped].schedule = sched;
    courseList = [[NSMutableArray alloc] init];
    pickerPicker = [[NSMutableArray alloc] init];
    for (ClassSchedule* classSched in sched.schedule)
    {
        [courseList addObject:classSched.Course];
        [courseList addObject:[classSched getLocation]];
        [courseList addObject:[classSched getClassDays]];
        [courseList addObject:[classSched getClassHours]];
        
        [pickerPicker addObject:[NSString stringWithFormat:@"%d",TEXT]];
        [pickerPicker addObject:[NSString stringWithFormat:@"%d",TEXT]];
        [pickerPicker addObject:[NSString stringWithFormat:@"%d",DAYS]];
        [pickerPicker addObject:[NSString stringWithFormat:@"%d",HOUR]];        
    }
    
    [courseList addObject:@"Enter Start Date"];
    [courseList addObject:@"Enter End Date"];
    
    [pickerPicker addObject:[NSString stringWithFormat:@"%d",DATE]];
    [pickerPicker addObject:[NSString stringWithFormat:@"%d",DATE]];
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    // Return YES for supported orientations
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
            return @"Location";
        }
        if(section % SECTION_TYPES == 2)
        {
            return [NSString stringWithFormat:@"Meets: %@", [courseList objectAtIndex:section]];
        }
        if(section % SECTION_TYPES == 3)
        {
            return [NSString stringWithFormat:@"Hour(s): %@", [courseList objectAtIndex:section]];
        }
    }
    else if(section < [schedule.schedule count] * SECTION_TYPES + 1)
    {
        return @"Calendar Start date";
    }
    else
    {
        return @"Calendar End date";
    }
    return @"";
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section < ([schedule.schedule count] * SECTION_TYPES) && section % SECTION_TYPES == 3)
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

        cell.textLabel.text = [courseList objectAtIndex:indexPath.section];
        if([[pickerPicker objectAtIndex:indexPath.section] isEqualToString:[NSString stringWithFormat:@"%d",DAYS]])
        {
            cell.userInteractionEnabled = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        default:
            break;
    }
}

@end
