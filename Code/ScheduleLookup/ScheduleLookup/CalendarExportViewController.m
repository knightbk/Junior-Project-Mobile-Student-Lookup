//
//  CalendarExportViewController.m
//  ScheduleLookup
//
//  Created by CSSE Department on 5/2/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CalendarExportViewController.h"


@implementation CalendarExportViewController
@synthesize schedule;

@synthesize courseList;

- (id)initWithSchedule:(Schedule*) sched
{
    [self initWithStyle:UITableViewStyleGrouped].schedule = sched;
    courseList = [[NSMutableArray alloc] init];
    for (ClassSchedule* classSched in sched.schedule)
    {
        [courseList addObject:classSched.Course];
        [courseList addObject:[classSched getLocation]];
        [courseList addObject:[classSched getClassDays]];
        [courseList addObject:[classSched getClassHours]];
    }
    
    [courseList addObject:@"Enter Start Date"];
    [courseList addObject:@"Enter End Date"];
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

    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section < ([schedule.schedule count] * 4))
    {
        if(section % 4 == 0)
        {
            return @"Course";
        }
        if(section % 4 == 1)
        {
            return @"Location";
        }
        if(section % 4 == 2)
        {
            return @"Meets";
        }
        if(section % 4 == 3)
        {
            return @"Hour";
        }
    }
    else if(section < [schedule.schedule count] * 4 + 1)
    {
        return @"Calendar Start date";
    }
    else
    {
        return @"Calendar End date";
    }
    return @"";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

        cell.textLabel.text = [courseList objectAtIndex:indexPath.section];
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
