//
//  SettingsViewController.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 2/1/12.
//  Modified by Brandon Knight on 2/13/2012
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "KeychainItemWrapper.h"
@implementation SettingsViewController
@synthesize  usernameTextField, passwordTextField;
@synthesize networkScraper;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(void)findAndResignFirstResponder{
	for (UIView *aView in [self.view subviews]){
		if ([aView isFirstResponder] ) {
			[aView resignFirstResponder];
		}
	}
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	for (UITouch *touch in touches){
		if (touch.view == self.view){
			[self findAndResignFirstResponder];
		}
	}
}

- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewWillAppear:(BOOL)animated
{
    if (networkScraper == nil) {
        networkScraper = [[NetworkScraper alloc] init];
    }
    
    [usernameTextField setText:[networkScraper getUserName]];
        
    [passwordTextField setText:[networkScraper getPassword]];
}
- (void)viewWillDisappear:(BOOL)animated
{
    // Store username to keychain 	
    if ([usernameTextField text])
    {
        [networkScraper setUserName:[usernameTextField text]];
    }
    
    // Store password to keychain
    if ([passwordTextField text])
    {
        [networkScraper setPassword:[passwordTextField text]];
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{

    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
