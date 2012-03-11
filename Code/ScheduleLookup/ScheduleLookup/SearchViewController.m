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
    NSString *url = [NSString stringWithFormat:@"https://prodweb.rose-hulman.edu/regweb-cgi/reg-sched.pl?type=Instructor&termcode=201230&view=tgrid&id=%@", searchBar.text];

    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

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




#pragma mark - NSURLConnectionDelegate Methods

- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
        
    if ([challenge previousFailureCount] > 0)
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Invalid Credentials" message:@"The credentials you input for your account are invalid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
        [[challenge sender]  useCredential:[NSURLCredential credentialWithUser:[passwordItem objectForKey:(__bridge_transfer id)kSecAttrAccount]
                                                                      password:[passwordItem objectForKey:(__bridge_transfer id)kSecValueData]
                                                                   persistence:NSURLCredentialPersistenceNone] 
                forAuthenticationChallenge:challenge];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{ 
    [connection cancel];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    NSString *sdata = [[NSString alloc ]initWithData:data encoding:NSASCIIStringEncoding];

    Faculty *person = [FacultyFactory FacultyFromSchedulePage:sdata];
    //Schedule *schedule = [ScheduleFactory scheduleFromSchedulePage:sdata];
    [nameLabel setText:person.name];
    //scheduleTextView.text = [schedule scheduleInformationString];
    
    [advisorLabel setText:@"derp"];
    
    [usernameLabel setText:person.alias];
    [self hideLabels:(false)];
    [connection cancel];
    
    NSLog(@"%@",[person asText]);
    
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
