//
//  SingleDayScheduleViewController.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 3/21/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "SingleDayScheduleViewController.h"
#import "ClassSchedule.h"
#import "ScheduleFactory.h"

@implementation SingleDayScheduleViewController

@synthesize dayString, classArray;
@synthesize networkScraper;
@synthesize termCode;
@synthesize delegate;

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 10)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"E     %@", [classArray objectAtIndex:indexPath.row]];
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%d     %@", indexPath.row + 1, [classArray objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return dayString;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (networkScraper == nil) {
        networkScraper = [[NetworkScraper alloc] init];
        networkScraper.delegate = self;
    }
    
    if (![@"" isEqualToString:[classArray objectAtIndex:indexPath.row]]) {
        [networkScraper initiateClassInfoSearchWithCourse:[classArray objectAtIndex:indexPath.row] termcode:termCode];
    }
}

- (void) networkScraperDidReceiveData:(NSString *)sdata
{
    NSLog(@"here?");

    ClassSchedule *schedule = [[ScheduleFactory scheduleFromSchedulePage:sdata].schedule objectAtIndex:0];
    ClassInfoViewController *classInfoPage = [[ClassInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
    classInfoPage.course = schedule;
    //TODO: Needs to be unhardcoded
    classInfoPage.termCode = termCode;
    [delegate pushViewController:classInfoPage];
}


@end
