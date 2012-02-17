//
//  SearchUserDelegate.h
//  ScheduleLookup
//
//  Created by Home on 2/16/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Schedule.h"

@class SearchUserViewController;

@protocol SearchUserDelegate <NSObject>

- (void)controller:(SearchUserViewController *)controller withSchedule:(Schedule *)personSchedule;

@end
