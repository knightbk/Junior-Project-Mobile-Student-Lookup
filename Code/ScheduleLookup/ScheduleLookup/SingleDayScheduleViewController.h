//
//  SingleDayScheduleViewController.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 3/21/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkScraper.h"
#import "ClassInfoViewController.h"

@protocol SingleDayScheduleDelegate

- (void) pushViewController:(ClassInfoViewController *) viewController;

@end



@interface SingleDayScheduleViewController : UITableViewController<NetworkScraperDelegate>


@property (strong, nonatomic) NSString *dayString;
@property (strong, nonatomic) NSArray *classArray;
@property (strong, nonatomic) NSString *termCode;

@property (strong, nonatomic) NetworkScraper *networkScraper;

@property (unsafe_unretained, nonatomic) id <SingleDayScheduleDelegate> delegate;

@end
