//
//  ClassInfoViewController.h
//  ScheduleLookup
//
//  Created by Nick Crawford on 4/12/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClassSchedule.h"
#import "NetworkScraper.h"

@protocol ClassInfoViewControllerDelegate

@end

@interface ClassInfoViewController : UITableViewController <NetworkScraperDelegate, UIActionSheetDelegate> {
    
}

@property (strong, nonatomic) NSString *termCode;
@property (strong, nonatomic) ClassSchedule *course;
@property (strong, nonatomic) NSMutableArray *infoList;
@property (strong, nonatomic) NSNumber *buttonPressed;
@end
