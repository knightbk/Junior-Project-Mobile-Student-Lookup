//
//  SettingsViewController.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 2/1/12.
//  Modified by Brandon Knight on 2/13/2012
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "AppDelegate.h"
@interface SettingsViewController : UIViewController <UITextFieldDelegate>


-(IBAction)textFieldDidEndEditing:(UITextField *)textField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end
