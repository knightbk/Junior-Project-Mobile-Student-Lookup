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

#pragma mark Course Roster Tests
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

- (void)testGetCourseRosterIsEmptyForInvalidCourse
{
    NSString *classHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"CSSE555-01" ofType:@"html"];
    NSString *classHTML = [[NSString alloc] initWithContentsOfFile:classHTMLPath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *rosterDict = [RosterFactory rosterFromCoursePage:classHTML];
    
    STAssertEquals(0, (int) [rosterDict count], @"");
}

- (void)testGetCourseRosterContainsCorrectKeysAndValues
{
    NSString *classHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"CSSE404-01" ofType:@"html"];
    NSString *classHTML = [[NSString alloc] initWithContentsOfFile:classHTMLPath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *rosterDict = [RosterFactory rosterFromCoursePage:classHTML];
    
    STAssertEqualObjects(@"mooreja1", [rosterDict valueForKey:@"James Andrew Moore"], @"");
}

- (void)testGetCourseRosterFromPipedCourses
{
    NSString *classHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"CSSE491-06CSSE290-09" ofType:@"html"];
    NSString *classHTML = [[NSString alloc] initWithContentsOfFile:classHTMLPath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *rosterDict = [RosterFactory rosterFromCoursePage:classHTML];
    
    STAssertEquals(2, (int) [rosterDict count], @"");
    STAssertEqualObjects(@"agnerrl", [rosterDict valueForKey:@"Rachel Lynn Agner"], @"");
    STAssertEqualObjects(@"theisje", [rosterDict valueForKey:@"James Edward Theis"], @"");
}

#pragma mark Room Roster Tests
- (void)testGetRoomScheduleIsCorrectSize
{
    NSString *roomHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"G220" ofType:@"html"];
    NSString *roomHTML = [[NSString alloc] initWithContentsOfFile:roomHTMLPath encoding:NSUTF8StringEncoding error:nil];
    Schedule *roomSchedule = [ScheduleFactory scheduleFromSchedulePage:roomHTML];
    
    STAssertEquals(9, (int) [roomSchedule.schedule count], @"");
}

- (void)testGetRoomSchedulsHasGivenCoursesOnDifferentDays
{
    NSString *roomHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"G220" ofType:@"html"];
    NSString *roomHTML = [[NSString alloc] initWithContentsOfFile:roomHTMLPath encoding:NSUTF8StringEncoding error:nil];
    Schedule *roomSchedule = [ScheduleFactory scheduleFromSchedulePage:roomHTML];
    
    STAssertEqualObjects(@"MA460-01", [[roomSchedule getScheduleForDay:1] objectAtIndex:8], @"");
    STAssertEqualObjects(@"MA450-01", [[roomSchedule getScheduleForDay:3] objectAtIndex:3], @"");
}

- (void)testRoomScheduleDoesNotContainClassAtTime
{
    NSString *roomHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"O159" ofType:@"html"];
    NSString *roomHTML = [[NSString alloc] initWithContentsOfFile:roomHTMLPath encoding:NSUTF8StringEncoding error:nil];
    Schedule *roomSchedule = [ScheduleFactory scheduleFromSchedulePage:roomHTML];
    
    STAssertEqualObjects(@"", [[roomSchedule getScheduleForDay:3] objectAtIndex:6], @"");
}

- (void)testRoomScheduleIsEmptyForInvalidRoom
{
    NSString *roomHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"F333" ofType:@"html"];
    NSString *roomHTML = [[NSString alloc] initWithContentsOfFile:roomHTMLPath encoding:NSUTF8StringEncoding error:nil];
    Schedule *roomSchedule = [ScheduleFactory scheduleFromSchedulePage:roomHTML];
    
    STAssertEquals(0, (int) [roomSchedule.schedule count], @"");
}

@end