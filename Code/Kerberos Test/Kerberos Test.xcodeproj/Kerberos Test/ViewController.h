//
//  ViewController.h
//  Kerberos Test
//
//  Created by Mark Vitale on 1/8/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
- (IBAction)someMethod:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end
