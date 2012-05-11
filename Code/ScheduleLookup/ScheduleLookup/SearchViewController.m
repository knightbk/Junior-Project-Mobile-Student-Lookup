//
//  SearchViewController.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 12/14/11.
//  Modified by Brandon Knight on 2/13/2012
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "SearchViewController.h"
#import "Faculty.h"
#import "PersonFactory.h"
#import "KeychainItemWrapper.h"
#import "SettingsViewController.h"
#import "FacultyFactory.h"
#import "Schedule.h"
#import "ScheduleFactory.h"
#import "UserInfoViewController.h"
#import "ClassInfoViewController.h"
#import "ScheduleViewController.h"
#import "PartialMatchCourseViewController.h"
#import "PartialMatchUserViewController.h"

#define COURSE_SEARCH 0
#define ROOM_SEARCH 1
#define USER_SEARCH 2

#define YEAR 2013


@implementation SearchViewController

@synthesize scheduleSearchBar;
@synthesize bottomSearchButton;
@synthesize networkScraper;



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpPicker];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void) setUpPicker
{
    searchValues = [[NSMutableArray alloc] init];
    [searchValues addObject:@"Course"];
    [searchValues addObject:@"Room"];
    [searchValues addObject:@"Username"];
    termValues = [[NSMutableArray alloc] init];
    [termValues addObject:@"Fall"];
    [termValues addObject:@"Winter"];
    [termValues addObject:@"Spring"];
    [termValues addObject:@"Summer"];
    yearValues = [[NSMutableArray alloc] init];
    for (int i = YEAR; i >= 2000; i--) {
        [yearValues addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", @"SearchSelectionFavorites"]];
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSString *searchType = [newDict valueForKey:@"Type"];
    NSString *term = [newDict valueForKey:@"Term"];
    int year = [[newDict valueForKey:@"Year"] intValue];
    
    NSLog(@"%@", newDict);
    NSLog(@"%@, %@, %d", searchType, term, year);
    
    pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
    [pickerView selectRow:[searchValues indexOfObject:searchType] inComponent:0 animated:YES];
    [pickerView selectRow:[searchValues indexOfObject:term] inComponent:1 animated:YES];
    [pickerView selectRow:YEAR - year inComponent:2 animated:YES];
    CGRect frame = pickerView.frame;
    frame.origin.y = 45;
    pickerView.frame = frame;
}

- (void) saveContentsOfPicker
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"SearchSelectionFavorites.plist"];
    
    NSMutableDictionary *newDict;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        newDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    }
    else
    {
        [[NSFileManager defaultManager] createFileAtPath:plistPath contents:nil attributes:nil];
        newDict = [[NSMutableDictionary alloc] init];
    }
    
    [newDict setObject:[searchValues objectAtIndex:[pickerView selectedRowInComponent:0]] forKey:@"Type"];
    [newDict setObject:[termValues objectAtIndex:[pickerView selectedRowInComponent:1]] forKey:@"Term"];
    [newDict setObject:[yearValues objectAtIndex:[pickerView selectedRowInComponent:2]] forKey:@"Year"];
    [newDict writeToFile:plistPath atomically:YES];
}

- (NSString *)picker:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [searchValues objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 3;
}
/*
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            scheduleTextView.text = [searchValues objectAtIndex:row];
            break;
        case 1:
            scheduleTextView.text = [termValues objectAtIndex:row];
            break;
        case 2:
            scheduleTextView.text = [yearValues objectAtIndex:row];
            break;
        default:
            break;
    }
}
 */

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    switch (component) {
        case 0:
            return [searchValues count];
        case 1:
            return [termValues count];
        case 2:
            return [yearValues count];
            
        default:
            break;
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    switch (component) {
        case 0:
            return [searchValues objectAtIndex:row];
        case 1:
            return [termValues objectAtIndex:row];
        case 2:
            return [yearValues objectAtIndex:row];
        default:
            break;
    }
    return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch(component) {
            case 0: return 120;
            case 1: return 100;
            case 2: return 100;
        default: return 100;
    }
    return 100;
}

- (NSString *) getSelectedTerm
{
    switch([pickerView selectedRowInComponent:1])
    {
        case 0:
            return @"10";
        case 1:
            return @"20";
        case 2:
            return @"30";
        case 3:
            return @"40";
    }
    return @"10";
    
}

- (void) toggleBottomSearchBarButtonClickability
{
    if ([self.scheduleSearchBar.text isEqualToString:@""]){
        self.bottomSearchButton.enabled = NO;
        self.bottomSearchButton.alpha = 0.5;
    }
    else
    {
        self.bottomSearchButton.enabled = YES;
        self.bottomSearchButton.alpha = 1.0;
    }
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
    [self toggleBottomSearchBarButtonClickability];
}


- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [self saveContentsOfPicker];
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

- (IBAction) bottomSearchButtonPressed:(id)sender
{
    [self searchBarSearchButtonClicked:self.scheduleSearchBar];
}

#pragma mark - UISearchBarDelegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    if (networkScraper == nil) {
        networkScraper = [[NetworkScraper alloc] init];
        networkScraper.delegate = self;
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    switch ([pickerView selectedRowInComponent:0])
    {
        case COURSE_SEARCH:
            [networkScraper initiateClassInfoSearchWithCourse:searchBar.text termcode:[NSString stringWithFormat:@"%@%@",[yearValues objectAtIndex:[pickerView selectedRowInComponent:2]], [self getSelectedTerm]]];
            break;
        case ROOM_SEARCH:
            [networkScraper initiateRoomSearchWithRoom:searchBar.text termcode:[NSString stringWithFormat:@"%@%@",[yearValues objectAtIndex:[pickerView selectedRowInComponent:2]], [self getSelectedTerm]]];
            break;
        case USER_SEARCH:
            [networkScraper initiatePersonInfoSearchWithUsername:searchBar.text termcode:[NSString stringWithFormat:@"%@%@",[yearValues objectAtIndex:[pickerView selectedRowInComponent:2]], [self getSelectedTerm]]];
            break;
    }

}

//will place cancelGesture methods only when searchBar is being edited.
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    cancelGesture = [UITapGestureRecognizer new];
    [cancelGesture addTarget:self action:@selector(backgroundTouched:)];
    [self.view addGestureRecognizer:cancelGesture];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [self toggleBottomSearchBarButtonClickability];
    
    if (cancelGesture) {
        [self.view removeGestureRecognizer:cancelGesture];
        cancelGesture = nil;
    }
}

#pragma mark NetworkScraperDelegate methods

- (void) networkScraperDidReceiveData:(NSString *)sdata
{
    Faculty *person = nil;
    Schedule *schedules = nil;
    switch ([pickerView selectedRowInComponent:0])
    {
        case COURSE_SEARCH:
        {
            schedules = [ScheduleFactory scheduleFromSchedulePage:sdata];
            
            NSInteger numMatches = [schedules.schedule count];
            if (numMatches == 1)
            {
                ClassInfoViewController *classInfoPage = [[ClassInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
                classInfoPage.course = [schedules.schedule objectAtIndex:0];
                classInfoPage.termCode = [NSString stringWithFormat:@"%@%@",[yearValues objectAtIndex:[pickerView selectedRowInComponent:2]], [self getSelectedTerm]];
                [self.navigationController pushViewController:classInfoPage animated:YES];
            }
            else
            {
                PartialMatchCourseViewController *viewController = [[PartialMatchCourseViewController alloc] init];
                if (numMatches > 1)
                {
                    viewController.courseArray = schedules.schedule;
                    viewController.termCode = [NSString stringWithFormat:@"%@%@",[yearValues objectAtIndex:[pickerView selectedRowInComponent:2]], [self getSelectedTerm]];
                    viewController.title = @"Results";
                }
                else
                {
                    viewController.title = @"No Results";
                }
                [self.navigationController pushViewController:viewController animated:YES];
            }
            break;
        }
        case ROOM_SEARCH:
        {            
            ScheduleViewController *scheduleViewController = [[ScheduleViewController alloc] initWithNibName:@"ScheduleViewController" bundle:[NSBundle mainBundle]];
            scheduleViewController.schedule = [ScheduleFactory scheduleFromSchedulePage:sdata];;
            scheduleViewController.termCode = [NSString stringWithFormat:@"%@%@",[yearValues objectAtIndex:[pickerView selectedRowInComponent:2]], [self getSelectedTerm]];
            [self.navigationController pushViewController:scheduleViewController animated:YES];
            break;
        }
        case USER_SEARCH:
        {
            if ([PersonFactory userSearchIsPartialMatch:sdata])
            {
                PartialMatchUserViewController *viewController = [[PartialMatchUserViewController alloc] init];
                NSArray *matches = [FacultyFactory AllFacultyFromPartialMatchPage:sdata];
                if([matches count] > 0)
                {
                    viewController.usernameArray = matches;
                    viewController.termCode = [NSString stringWithFormat:@"%@%@", [yearValues objectAtIndex:[pickerView selectedRowInComponent:2]], [self getSelectedTerm]];
                    viewController.title = @"Results";
                }
                else
                {
                    viewController.title = @"No Results";
                }
                [self.navigationController pushViewController:viewController animated:YES];
            }
            else
            {
                person = [FacultyFactory FacultyFromSchedulePage:sdata];
                UserInfoViewController *userInfoPage = [[UserInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
                userInfoPage.person = person;
                userInfoPage.termCode = [NSString stringWithFormat:@"%@%@",[yearValues objectAtIndex:[pickerView selectedRowInComponent:2]], [self getSelectedTerm]];
                [self.navigationController pushViewController:userInfoPage animated:YES];
            }
            break;
        }
    }
}

@end
