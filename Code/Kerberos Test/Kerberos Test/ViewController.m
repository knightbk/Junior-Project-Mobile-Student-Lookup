//
//  ViewController.m
//  Kerberos Test
//
//  Created by Mark Vitale on 1/8/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize usernameTextField,passwordTextField;

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (IBAction)someMethod:(id)sender
{
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://prodweb.rose-hulman.edu/regweb-cgi/reg-sched.pl"]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

}

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
        [[challenge sender]  useCredential:[NSURLCredential credentialWithUser:[self.usernameTextField text] password:[self.passwordTextField text] persistence:NSURLCredentialPersistenceForSession] forAuthenticationChallenge:challenge];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Valid Credentials" message:@"Those credentials just got you access to the schedule lookup page" delegate:nil cancelButtonTitle:@"Hooray!" otherButtonTitles:nil];
    [alert show];
    [connection cancel];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    NSString *sdata = [[NSString alloc ]initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"The data is: %@",sdata); 
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

@end
