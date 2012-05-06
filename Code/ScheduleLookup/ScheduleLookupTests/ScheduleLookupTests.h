//
//  ScheduleLookupTests.h
//  ScheduleLookupTests
//
//  Created by Mark Vitale on 12/14/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "ScheduleFactory.h"
#import "ClassSchedule.h"
#import "RosterFactory.h"
#import "FacultyFactory.h"
#import "Factory.h"
@interface ScheduleLookupTests : SenTestCase


@property (nonatomic, retain) NSString *classHTMLPath;
@property (nonatomic, retain) NSString *classHTML;
@property (nonatomic, retain) ClassSchedule *classSchedule;
@property (nonatomic, retain) NSDictionary *rosterDict;
@property (nonatomic, retain) NSString *roomHTMLPath;
@property (nonatomic, retain) NSString *roomHTML;
@property (nonatomic, retain) Schedule *roomSchedule;
@property (nonatomic, retain) NSString *userHTML;
@property (nonatomic, retain) NSString *userHTMLPath;
@property (nonatomic, retain) NSArray *userList;
@property (nonatomic, retain) Schedule *courseList;
@property (nonatomic, retain) Faculty *faculty;

@end
