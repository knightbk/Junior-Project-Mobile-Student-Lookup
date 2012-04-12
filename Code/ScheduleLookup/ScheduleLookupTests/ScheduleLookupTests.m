//
//  ScheduleLookupTests.m
//  ScheduleLookupTests
//
//  Created by Mark Vitale on 12/14/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "ScheduleLookupTests.h"

#import "ScheduleFactory.h"
#import "ClassSchedule.h"

@implementation ScheduleLookupTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

//Test get course info from https://prodweb.rose-hulman.edu/regweb-cgi/reg-sched.pl?type=Roster&termcode=TERM_ID&view=tgrid&id=COURSE_ID
- (void)testViewCourseInformationFromCoursePage
{
    //@synthesize Course, CRN, Credit, Comments, CAP, Instructor, Description, ENRL, Final_Schedule, Term_Schedule;
    NSString *classHTMLPath = [[NSBundle mainBundle] pathForResource:@"CSSE404-01" ofType:@"html"];
    NSString *classHTML = [[NSString alloc] initWithContentsOfFile:classHTMLPath encoding:NSUTF8StringEncoding error:nil];
    ClassSchedule *classSchedule = [[ScheduleFactory scheduleFromSchedulePage:classHTML].schedule objectAtIndex:0];
    STAssertEqualObjects(@"", classSchedule.Course, @"asdf");
    STFail(@"aaaa");
}

@end