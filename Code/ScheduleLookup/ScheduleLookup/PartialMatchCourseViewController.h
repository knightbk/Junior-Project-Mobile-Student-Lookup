//
//  PartialMatchCourseViewController.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 4/24/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartialMatchCourseViewController : UITableViewController {

    NSArray *courseArray;
    
}

@property (strong, nonatomic) NSArray *courseArray;
@property (strong, nonatomic) NSString *termCode;

@end