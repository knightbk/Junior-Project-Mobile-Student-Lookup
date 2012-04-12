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
#import "Factory.h"
#import "KeychainItemWrapper.h"
#import "SettingsViewController.h"
#import "FacultyFactory.h"
#import "Schedule.h"
#import "ScheduleFactory.h"
#import "UserInfoViewController.h"


@implementation SearchViewController

@synthesize scheduleTextView;
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
    
    searchValues = [[NSMutableArray alloc] init];
    [searchValues addObject:@"Username"];
    [searchValues addObject:@"Room"];
    [searchValues addObject:@"Course"];
    termValues = [[NSMutableArray alloc] init];
    [termValues addObject:@"Fall"];
    [termValues addObject:@"Winter"];
    [termValues addObject:@"Spring"];
    [termValues addObject:@"Summer"];
    yearValues = [[NSMutableArray alloc] init];
    for (int i = 2000; i < 2012; i++) {
        [yearValues addObject:[NSString stringWithFormat:@"%d", i]];
    }
    pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
    [pickerView selectRow:1 inComponent:0 animated:YES];
	// Do any additional setup after loading the view, typically from a nib.
    scheduleTextView.text = [searchValues objectAtIndex:[pickerView selectedRowInComponent:0]];
}

- (NSString *)picker:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [searchValues objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    scheduleTextView.text= [searchValues objectAtIndex:row];
}

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

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch(component) {
            case 0: return 120;
            case 1: return 100;
            case 2: return 100;
        default: return 22;
    }
    
    //NOT REACHED
    return 22;
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
    //scheduleTextView.text = [schedule scheduleInformationString];
    
    
    UserInfoViewController *userInfoPage = [[UserInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    userInfoPage.person = person;
    
    [self.navigationController pushViewController:userInfoPage animated:YES];
    
}



@end
