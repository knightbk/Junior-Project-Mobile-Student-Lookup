//
//  CourseRosterViewController.h
//  ScheduleLookup
//
//  Created by Nick Crawford on 4/12/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkScraper.h"

@interface CourseRosterViewController : UITableViewController <NetworkScraperDelegate> {

    NSDictionary *userDictionary;
    
}

@property (nonatomic, strong) NSDictionary *userDictionary;
@property (strong, nonatomic) NetworkScraper *networkScraper;
@property (strong, nonatomic) NSString *termCode;


@end