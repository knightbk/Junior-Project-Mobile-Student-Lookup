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
#import "RosterFactory.h"

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
    NSString *classHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"CSSE404-01" ofType:@"html"];
    NSString *classHTML = [[NSString alloc] initWithContentsOfFile:classHTMLPath encoding:NSUTF8StringEncoding error:nil];
    ClassSchedule *classSchedule = [[ScheduleFactory scheduleFromSchedulePage:classHTML].schedule objectAtIndex:0];
    STAssertEqualObjects(@"CSSE404-01", classSchedule.Course, @"");
    STAssertEqualObjects(@"3264", classSchedule.CRN, @"");
    STAssertEqualObjects(@"4", classSchedule.Credit, @"");
    STAssertEqualObjects(@"&nbsp", classSchedule.Comments, @"");
    STAssertEqualObjects(@"25", classSchedule.CAP, @"");
    STAssertEqualObjects(@"anderson", classSchedule.Instructor, @"");
    STAssertEqualObjects(@"Compiler Construction", classSchedule.Description, @"");
    STAssertEqualObjects(@"9", classSchedule.ENRL, @"");
    STAssertEqualObjects(@"&nbsp", classSchedule.Final_Schedule, @"");
    STAssertEqualObjects(@"MTR/7/O267:W/6/O267", classSchedule.Term_Schedule, @"");
}

- (void)testGetCourseRosterIsCorrectSize
{
    NSString *classHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"CSSE404-01" ofType:@"html"];
    NSString *classHTML = [[NSString alloc] initWithContentsOfFile:classHTMLPath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *rosterDict = [RosterFactory rosterFromCoursePage:classHTML];
    
    STAssertEquals(9, (int) [rosterDict count], @"");
}

- (void)testGetCourseRosterContainsCorrectKeysAndValues
{
    NSString *classHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"CSSE404-01" ofType:@"html"];
    NSString *classHTML = [[NSString alloc] initWithContentsOfFile:classHTMLPath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *rosterDict = [RosterFactory rosterFromCoursePage:classHTML];
    
    STAssertEqualObjects(@"mooreja1", [rosterDict valueForKey:@"James Andrew Moore"], @"");
}


@end