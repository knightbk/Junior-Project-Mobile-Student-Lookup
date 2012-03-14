//
//  FirstViewController.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 12/14/11.
//  Modified by Brandon Knight on 2/13/2012
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoViewController.h"
#import "NetworkScraper.h"

@interface SearchViewController : UIViewController <UISearchBarDelegate, NetworkScraperDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *advisorLabel;
@property (weak, nonatomic) IBOutlet UITextView *scheduleTextView;
@property (strong, nonatomic) NetworkScraper *networkScraper;


@end
