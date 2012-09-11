//
//  ViewController.h
//  Kerberos Test
//
//  Created by Mark Vitale on 1/8/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
KeychainItemWrapper *keychain;
@interface ViewController : UIViewController
- (IBAction) someMethod:(id)sender;
- (IBAction) savePassword:(id)sender;
- (IBAction)recoverPassword:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (weak, nonatomic) IBOutlet UIButton *recoverButton;

@end
