//
//  CourseRosterViewController.m
//  ScheduleLookup
//
//  Created by Nick Crawford on 4/12/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CourseRosterViewController.h"
#import "Faculty.h"
#import "FacultyFactory.h"
#import "UserInfoViewController.h"

@interface CourseRosterViewController ()

@end

@implementation CourseRosterViewController

@synthesize userDictionary;
@synthesize networkScraper;
@synthesize termCode;

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
    self.title = @"Roster";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) viewWillAppear
{
    self.title = @"Roster";
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [userDictionary count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[userDictionary allKeys] objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (networkScraper == nil) {
        networkScraper = [[NetworkScraper alloc] init];
        networkScraper.delegate = self;
    }
    NSString *alias = [[userDictionary allValues] objectAtIndex:indexPath.row];
    [networkScraper initiatePersonInfoSearchWithUsername:alias termcode:termCode];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void) networkScraperDidReceiveData:(NSString *)sdata
{
    Faculty *person = [FacultyFactory FacultyFromSchedulePage:sdata];
    UserInfoViewController *userInfoPage = [[UserInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
    userInfoPage.termCode = termCode;
    userInfoPage.person = person;
    [self.navigationController pushViewController:userInfoPage animated:YES];
}

@end
