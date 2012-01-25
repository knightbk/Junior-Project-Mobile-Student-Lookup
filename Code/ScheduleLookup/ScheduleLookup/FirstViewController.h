//
//  FirstViewController.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 12/14/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UISearchBarDelegate, NSURLConnectionDelegate>

@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property(weak, nonatomic) IBOutlet UILabel *advisorLabel;
@property(strong, nonatomic) UIAlertView *credentialsAlertView;

- (NSString *) nameFromStringData:(NSString *)sdata;
- (NSString *) firstMatchStringWithRegex:(NSString *)regex WithStringData:(NSString *)sdata;
- (NSString *) advisorFromStringData:(NSString *)sdata;
- (NSString *) usernameFromStringData:(NSString *)sdata;

@end
