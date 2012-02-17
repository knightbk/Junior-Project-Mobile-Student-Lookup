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
#import "Schedule.h"
#import "SearchUserDelegate.h"

@interface SearchUserViewController : UIViewController <UISearchBarDelegate, NSURLConnectionDelegate>
{
    Schedule *schedule;
    NSMutableArray *results;
    id<SearchUserDelegate> delegate;
}
@property ( strong, readwrite) Schedule *schedule;

@property (weak) id<SearchUserDelegate> delegate;
- (IBAction)done:(id)sender;




@end
