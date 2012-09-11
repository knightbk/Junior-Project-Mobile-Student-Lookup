//
//  PartialMatchUserViewController.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 4/24/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoViewController.h"

@interface PartialMatchUserViewController : UITableViewController <NetworkScraperDelegate> {

    NSArray *usernameArray;
    
}

@property (strong, nonatomic) NSArray *usernameArray;
@property (strong, nonatomic) NSString *termCode;

@end
