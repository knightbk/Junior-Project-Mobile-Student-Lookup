//
//  PartialMatchUserViewController.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 4/24/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "PartialMatchUserViewController.h"
#import "FacultyFactory.h"

@interface PartialMatchUserViewController ()

@end

@implementation PartialMatchUserViewController

@synthesize termCode, usernameArray;

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
    return [usernameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [usernameArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NetworkScraper *networkScraper = [[NetworkScraper alloc] init];
    networkScraper.delegate = self;
    [networkScraper initiatePersonInfoSearchWithUsername:[usernameArray objectAtIndex:indexPath.row] termcode:termCode];
}

#pragma mark NetworkScraperDelegate methods
- (void) networkScraperDidReceiveData:(NSString *)sdata
{
    NSLog(@"%@", sdata);
    UserInfoViewController *userInfoPage = [[UserInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
    userInfoPage.person = [FacultyFactory FacultyFromSchedulePage:sdata];
    userInfoPage.termCode = termCode;
    [self.navigationController pushViewController:userInfoPage animated:YES];
}

@end
