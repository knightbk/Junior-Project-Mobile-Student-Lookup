//
//  FirstViewController.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 12/14/11.
//  Modified by Brandon Knight on 2/13/2012
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "SearchViewController.h"
#import "Faculty.h"
#import "Factory.h"
#import "KeychainItemWrapper.h"
#import "SettingsViewController.h"
#import "FacultyFactory.h"
#import "Schedule.h"
#import "ScheduleFactory.h"
#import "UserInfoViewController.h"


@implementation SearchViewController

@synthesize nameLabel, usernameLabel, advisorLabel, scheduleTextView;
@synthesize networkScraper;



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
- (void)hideLabels:(BOOL)val
{
    if(val){
    [nameLabel setHidden:TRUE];
    [usernameLabel setHidden:TRUE];
    [advisorLabel setHidden:TRUE];
    }
    else{
        [nameLabel setHidden:false];
        [usernameLabel setHidden:false];
        [advisorLabel setHidden:false];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self hideLabels:(true)];
    scheduleTextView.text = @"";
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
//recognizes cancel touches on screen
UIGestureRecognizer* cancelGesture;

- (IBAction)backgroundTouched:(id)sender 
{
    [self.view endEditing:YES];
}

#pragma mark - UISearchBarDelegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    if (networkScraper == nil) {
        networkScraper = [[NetworkScraper alloc] init];
        networkScraper.delegate = self;
    }
    [networkScraper initiatePersonInfoSearchWithUsername:searchBar.text termcode:@"201230"];
}

//will place cancelGesture methods only when searchBar is being edited.
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    cancelGesture = [UITapGestureRecognizer new];
    [cancelGesture addTarget:self action:@selector(backgroundTouched:)];
    [self.view addGestureRecognizer:cancelGesture];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if (cancelGesture) {
        [self.view removeGestureRecognizer:cancelGesture];
        cancelGesture = nil;
    }
}

#pragma mark NetworkScraperDelegate methods

- (void) networkScraperDidReceiveData:(NSString *)sdata
{
    Faculty *person = [FacultyFactory FacultyFromSchedulePage:sdata];
    //Schedule *schedule = [ScheduleFactory scheduleFromSchedulePage:sdata];
    [nameLabel setText:person.name];
    //scheduleTextView.text = [schedule scheduleInformationString];
    
    [advisorLabel setText:@"derp"];
    
    [usernameLabel setText:person.alias];
    [self hideLabels:(false)];
    
    /*
    if (self.settingsPage == nil) {
        SettingsViewController *newSettingsPage = [[SettingsViewController alloc] init];
        self.settingsPage = newSettingsPage;
    }
     */
    UserInfoViewController *userInfoPage = [[UserInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    userInfoPage.person = person;
    
    [self.navigationController pushViewController:userInfoPage animated:YES];
    
}



@end
