//
//  SettingsViewController.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 2/1/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"

KeychainItemWrapper *keychain;

@interface SettingsViewController : UIViewController <UITextFieldDelegate>
+ (NSString *)giveUsername;
+ (NSString *)givePass;
- (IBAction) savePassword:(id)sender;
- (IBAction) recoverPassword:(id)sender;
-(IBAction)textFieldDidEndEditing:(UITextField *)textField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end
