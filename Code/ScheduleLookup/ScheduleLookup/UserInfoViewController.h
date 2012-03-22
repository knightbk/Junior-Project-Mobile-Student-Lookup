//
//  UserInfoViewController.h
//  ScheduleLookup
//
//  Created by Nick Crawford on 3/11/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Faculty.h"
#import "NetworkScraper.h"

@protocol UserInfoViewControllerDelegate 

@end

@interface UserInfoViewController : UITableViewController <NetworkScraperDelegate, UIActionSheetDelegate> {

}


@property (strong, nonatomic) Faculty *person;
@property (strong, nonatomic) NSMutableArray *infoList;

- (void) networkScraperDidReceiveData:(NSString *)sdata;

@end
