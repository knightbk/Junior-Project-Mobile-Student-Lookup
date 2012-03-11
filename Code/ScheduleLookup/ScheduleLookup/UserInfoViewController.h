//
//  UserInfoViewController.h
//  ScheduleLookup
//
//  Created by Nick Crawford on 3/11/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserInfoViewControllerDelegate

@end

@interface UserInfoViewController : UITableViewController {

id __unsafe_unretained delegate;

}

@property (nonatomic, unsafe_unretained) id<UserInfoViewControllerDelegate> delegate;

@end
