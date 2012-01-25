//
//  FirstViewController.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 12/14/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "FirstViewController.h"
#import "Student.h"
@implementation FirstViewController

@synthesize nameLabel, usernameLabel, advisorLabel, credentialsAlertView;




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [nameLabel setHidden:TRUE];
    [usernameLabel setHidden:TRUE];
    [advisorLabel setHidden:TRUE];
    credentialsAlertView = [[UIAlertView alloc] initWithTitle:@"Credentials" 
                                                    message:@"Enter RHIT Credentials" 
                                                   delegate:nil 
                                          cancelButtonTitle:@"Done" 
                                          otherButtonTitles:nil];
    
    credentialsAlertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [credentialsAlertView show];
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

- (void) backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - UISearchBarDelegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    NSString *url = [NSString stringWithFormat:@"https://prodweb.rose-hulman.edu/regweb-cgi/reg-sched.pl?type=Username&termcode=201220&view=tgrid&id=%@", searchBar.text];

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
        
    if ([challenge previousFailureCount] > 1)
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Invalid Credentials" message:@"The credentials you input for your account are invalid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [[challenge sender]  useCredential:[NSURLCredential credentialWithUser:[[credentialsAlertView textFieldAtIndex:0] text] 
                                                                      password:[[credentialsAlertView textFieldAtIndex:1] text]
                                                                   persistence:NSURLCredentialPersistenceForSession] 
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
    Student *person = [[Student alloc] initStudentWithAlias:[self usernameFromStringData:sdata] 
                                               WithCmNumber:nil 
                                                   WithName:[self nameFromStringData:sdata] 
                                                  WithMajor:nil 
                                                   WithYear:nil 
                                                WithAdvisor:[self advisorFromStringData:sdata]];
    
    [nameLabel setText:person.name];
    [advisorLabel setText:person.advisor];
    [usernameLabel setText:person.alias];
    [nameLabel setHidden:false];
    [usernameLabel setHidden:false];
    [advisorLabel setHidden:false];
    [connection cancel];
}

- (NSString *) nameFromStringData:(NSString *)sdata
{
    return [self firstMatchStringWithRegex:@">Name: ([a-zA-Z ]+)<" WithStringData:sdata];
}

- (NSString *) advisorFromStringData:(NSString *)sdata
{
    return [self firstMatchStringWithRegex:@"> Advisor: ([a-zA-Z ]+)<" WithStringData:sdata];
}

- (NSString *) usernameFromStringData:(NSString *)sdata
{
    return [self firstMatchStringWithRegex:@">Username: ([a-zA-Z ]+)<" WithStringData:sdata];
}

- (NSString *) firstMatchStringWithRegex:(NSString *)expression WithStringData:(NSString *)sdata
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSTextCheckingResult *rangeOfFirstMatch = [regex firstMatchInString:sdata options:0 range:NSMakeRange(0, [sdata length])];
    
    NSString *name = @"";
    if (!NSEqualRanges([rangeOfFirstMatch rangeAtIndex:0], NSMakeRange(NSNotFound, 0))) {
        name = [sdata substringWithRange:[rangeOfFirstMatch rangeAtIndex:1]];
    }
    return name;
}


@end
