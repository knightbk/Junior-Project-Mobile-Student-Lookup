//
//  FirstViewController.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 12/14/11.
//  Modified by Brandon Knight on 2/13/2012
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCCalendar.h"
#import "ClassSchedule.h"
#import "SearchUserDelegate.h"
@interface SearchViewController : GCCalendarPortraitView <UISearchBarDelegate, NSURLConnectionDelegate, GCCalendarDataSource, GCCalendarDelegate, SearchUserDelegate>
{
}

@property (strong) Schedule *schedule;
+ (NSMutableArray *) parseThis:(ClassSchedule *) withClass;

@end
