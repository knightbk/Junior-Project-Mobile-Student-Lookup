//
//  ClassInfoViewController.m
//  ScheduleLookup
//
//  Created by Nick Crawford on 4/12/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "ClassInfoViewController.h"
#import "NetworkScraper.h"
#import "ScheduleFactory.h"
#import "CourseRosterViewController.h"
#import "UserInfoViewController.h"
#import "RosterFactory.h"
#import "Faculty.h"
#import "FacultyFactory.h"

#define PROFESSOR 0
#define ROSTER 1

@interface ClassInfoViewController ()

@end

@implementation ClassInfoViewController

@synthesize course, infoList, termCode;
@synthesize buttonPressed;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated
{
    [[self tableView] reloadData];
    self.title = self.course.Course;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.infoList = [NSMutableArray arrayWithCapacity:7];
    int count = 5;
    
    //[infoList addObject:self.course.Description];
    [infoList addObject:self.course.Instructor];
    [infoList addObject:[@"Credit Hours: " stringByAppendingString:self.course.Credit]];
    [infoList addObject:[@"Enrolled: " stringByAppendingString:self.course.ENRL]];
    [infoList addObject:[@"Cap: " stringByAppendingString:self.course.CAP]];
    [infoList addObject:[@"CRN: " stringByAppendingString:self.course.CRN]];
    
    
    
    if (![self.course.Comments isEqualToString:@"&nbsp"]){
        [infoList addObject:[@"Comments: " stringByAppendingString:self.course.Comments]];
        count++;
    }
    if (![self.course.Final_Schedule isEqualToString:@"&nbsp"]){
        [infoList addObject:[@"Final Schedule: " stringByAppendingString:self.course.Final_Schedule]];
        count++;
    }   
    
    if (section == 0) {
        return count;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [infoList objectAtIndex:indexPath.row];
        if (indexPath.row != 0) {
            cell.userInteractionEnabled = NO;
        }
    } else {
        cell.textLabel.text = @"View Roster";
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return self.course.Description;
    else
        return @"Actions";
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            //View instructor profile
            NetworkScraper *networkScraper = [[NetworkScraper alloc] init];
            networkScraper.delegate = self;
            [networkScraper initiatePersonScheduleSearchWithUsername:self.course.Instructor termcode:termCode];
            buttonPressed = [NSNumber numberWithInt:PROFESSOR];
        }
    }
    else
    {
        //Displays the roster of a course.
        NetworkScraper *networkScraper = [[NetworkScraper alloc] init];
        networkScraper.delegate = self;
        [networkScraper initiateClassInfoSearchWithCourse:self.course.Course termcode:termCode];
        buttonPressed = [NSNumber numberWithInt:ROSTER];
    }           
}

#pragma mark NetworkScraperDelegate methods
- (void) networkScraperDidReceiveData:(NSString *)sdata
{
    if ([buttonPressed intValue] == PROFESSOR) 
    {
        Faculty *person = [FacultyFactory FacultyFromSchedulePage:sdata];
        UserInfoViewController *userInfoPage = [[UserInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
        userInfoPage.person = person;
        userInfoPage.termCode = termCode;
        [self.navigationController pushViewController:userInfoPage animated:YES];
    } 
    else 
    {
        CourseRosterViewController *classViewController = [[CourseRosterViewController alloc] init];
        classViewController.userDictionary = [RosterFactory rosterFromCoursePage:sdata];
        classViewController.termCode = termCode;
        [self.navigationController pushViewController:classViewController animated:YES];

    }
}
@end
