//
//  ScheduleLookupTests.m
//  ScheduleLookupTests
//
//  Created by Mark Vitale on 12/14/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "ScheduleLookupTests.h"



@implementation ScheduleLookupTests

@synthesize classHTMLPath;
@synthesize classHTML;
@synthesize classSchedule;
@synthesize rosterDict;
@synthesize roomHTMLPath;
@synthesize roomHTML;
@synthesize roomSchedule;
@synthesize userHTML;
@synthesize userList;
@synthesize userHTMLPath;
@synthesize courseList;
@synthesize faculty;

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

-(void) setUpCourseTestWithCourse : (NSString*) course
{
    classHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:course ofType:@"html"];
    classHTML = [[NSString alloc] initWithContentsOfFile:classHTMLPath encoding:NSUTF8StringEncoding error:nil];
    classSchedule = [[ScheduleFactory scheduleFromSchedulePage:classHTML].schedule objectAtIndex:0];
    courseList = [ScheduleFactory scheduleFromSchedulePage:classHTML];
    rosterDict = [RosterFactory rosterFromCoursePage:classHTML];

}

-(void) setUpRoomTestWithRoom : (NSString*) room
{
    roomHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:room ofType:@"html"];
    roomHTML = [[NSString alloc] initWithContentsOfFile:roomHTMLPath encoding:NSUTF8StringEncoding error:nil];
    roomSchedule = [ScheduleFactory scheduleFromSchedulePage:roomHTML];
    
}

-(void) setUpUserTestWithUser : (NSString*) user
{
    userHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:user ofType:@"html"];
    userHTML = [[NSString alloc] initWithContentsOfFile:userHTMLPath encoding:NSUTF8StringEncoding error:nil];
    userList = [FacultyFactory AllFacultyFromPartialMatchPage:userHTML];
}

- (void) setupTestWithExactMatchUser: (NSString *) user
{
    userHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:user ofType:@"html"];
    userHTML = [[NSString alloc] initWithContentsOfFile:userHTMLPath encoding:NSUTF8StringEncoding error:nil];
    faculty = [FacultyFactory FacultyFromSchedulePage:userHTML];
}

#pragma mark User Parsing Tests
- (void) testUserIsParsedCorrectly
{
    [self setupTestWithExactMatchUser:@"crawfonw"];
    STAssertEqualObjects(@"Nicholas William Crawford", faculty.name, @"");
    STAssertEqualObjects(@"crawfonw", faculty.alias, @"");
    STAssertEqualObjects(@"CM 1043", faculty.cmNumber, @"");
    STAssertEqualObjects(@"&nbsp", faculty.department, @"");
    STAssertEqualObjects(@"Apartment Room WEST 209A", faculty.officeNumber, @"");
    STAssertEqualObjects(@"872-6796", faculty.phoneNumber, @"");
}

- (void) testUserWithNumberInUsernameIsParsedCorrectly
{
    [self setupTestWithExactMatchUser:@"casey1"];
    STAssertEqualObjects(@"Nicholas William Crawford", faculty.name, @"");
    STAssertEqualObjects(@"crawfonw", faculty.alias, @"");
    STAssertEqualObjects(@"CM 1043", faculty.cmNumber, @"");
    STAssertEqualObjects(@"&nbsp", faculty.department, @"");
    STAssertEqualObjects(@"Apartment Room WEST 209A", faculty.officeNumber, @"");
    STAssertEqualObjects(@"872-6796", faculty.phoneNumber, @"");
}

#pragma mark Course Roster Tests
//Test get course info from https://prodweb.rose-hulman.edu/regweb-cgi/reg-sched.pl?type=Roster&termcode=TERM_ID&view=tgrid&id=COURSE_ID
- (void)testViewCourseInformationFromCoursePage
{
    [self setUpCourseTestWithCourse:@"CSSE404-01"];
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
    [self setUpCourseTestWithCourse:@"CSSE404-01"];
    
    STAssertEquals(9, (int) [rosterDict count], @"");
}


- (void)testGetCourseRosterContainsCorrectKeysAndValues
{
    [self setUpCourseTestWithCourse:@"CSSE404-01"];
    
    STAssertEqualObjects(@"mooreja1", [rosterDict valueForKey:@"James Andrew Moore"], @"");
}

- (void)testGetCourseRosterFromPipedCourses
{
    [self setUpCourseTestWithCourse:@"CSSE491-06CSSE290-09"];
    
    STAssertEquals(2, (int) [rosterDict count], @"");
    STAssertEqualObjects(@"agnerrl", [rosterDict valueForKey:@"Rachel Lynn Agner"], @"");
    STAssertEqualObjects(@"theisje", [rosterDict valueForKey:@"James Edward Theis"], @"");
}

#pragma mark Room Roster Tests
- (void)testGetRoomScheduleIsCorrectSize
{
    [self setUpRoomTestWithRoom:@"G220"];
    
    STAssertEquals(9, (int) [roomSchedule.schedule count], @"");
}

- (void)testGetRoomSchedulsHasGivenCoursesOnDifferentDays
{
    [self setUpRoomTestWithRoom:@"G220"];    
    STAssertEqualObjects(@"MA460-01", [[roomSchedule getScheduleForDay:1] objectAtIndex:8], @"");
    STAssertEqualObjects(@"MA450-01", [[roomSchedule getScheduleForDay:3] objectAtIndex:3], @"");
}

- (void)testRoomScheduleDoesNotContainClassAtTime
{
    [self setUpRoomTestWithRoom:@"O159"];
    
    STAssertEqualObjects(@"", [[roomSchedule getScheduleForDay:3] objectAtIndex:6], @"");
}

- (void)testRoomScheduleIsEmptyForInvalidRoom
{
    [self setUpRoomTestWithRoom:@"F333"];
    
    STAssertEquals(0, (int) [roomSchedule.schedule count], @"");
}
/*
-(void) testFactoryCorrectlyDeterminesPartialMatch
{
    

    userHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"loa" ofType:@"html"];
    userHTML = [[NSString alloc] initWithContentsOfFile:userHTMLPath encoding:NSUTF8StringEncoding error:nil];
    userList = [FacultyFactory AllFacultyFromPartialMatchPage:userHTML];

    
    STAssertEquals(YES, [Factory userSearchIsPartialMatch:userHTML], @"");
}

- (void) testPartialMatchShowsCorrectNumberOfUsers
{
    [self setUpUserTestWithUser:@"loa"];
    
    STAssertEquals(1, [userList count]  , @"");
}

- (void) testPartialMatchShowNoUsersIfThereAreNoResults
{
    [self setUpUserTestWithUser:@"djkdaajkad"];
    
    STAssertEquals(0, [userList count], @"");
}

-(void) testPartialMatchOnCourseShowsCorrectNumberOfCourses
{
    [self setUpCourseTestWithCourse:@"csse375"];
    
    STAssertEquals(2, (int) [courseList.schedule count], @"");
}
*/

@end