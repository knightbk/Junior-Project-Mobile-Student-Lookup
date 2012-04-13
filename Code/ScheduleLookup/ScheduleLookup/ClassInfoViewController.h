//
//  ClassInfoViewController.h
//  ScheduleLookup
//
//  Created by Nix on 4/12/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClassSchedule.h"

@interface ClassInfoViewController : UITableViewController {
    
}

@property (strong, nonatomic) ClassSchedule *course;
@property (strong, nonatomic) NSMutableArray *infoList;

@end
