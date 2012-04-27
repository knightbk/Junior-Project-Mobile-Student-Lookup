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
    userList = [FacultyFactory AllFacultyFromPartialMatchPage:@"<link REL=stylesheet HREF=/regweb/rhit_menu.css TYPE=text/css><title>Person Match: Usernames that match loa*</title><TABLE WIDTH=100% COLS=2><TR><TD ALIGN=LEFT CLASS=wr100>Person Match: Usernames that match loa*</TD><TD ALIGN=RIGHT CLASS=wr90>Rose-Hulman Institute of Technology</TD></TR><TR><TD ALIGN=RIGHT CLASS=bw70 COLSPAN=2>Updated Fri Apr 27 09:00:28 2012<br><A HREF=\"/regweb-cgi/reg-sched.pl\">Reset Schedule Lookup Page</A><BR><BR><A HREF=\"http://rose-hulmanbooks.collegestoreonline.com/ePOS?this_category=1&store=505&level1_category=1&form=shared3%2ftextbooks%2fmain%2ehtml&design=505\" target=\"_blank\">Rose-Hulman Bookstore Textbook Search</A></TD></TR></TABLE><p><TABLE BORDER=1 CELLSPACING=0 CELLPADDING=3><TR><TH>USERNAME</TH><TH>DESCRIPTION</TH><TH>NAME</TH><TH>CAMPUS MAIL</TH><TH>MAJOR</TH><TH>CLASS</TH><TH>ADVISOR</TH></TR>                <TR><TD><A HREF=\"/regweb-cgi/reg-sched.pl?type=Instructor&termcode=201230&view=tgrid&id=loaj\">loaj</A></TD><TD>faculty</TD><TD>Alexander J Lo</TD><TD>CM 4043</TD></TR>                </TABLE>"];
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

-(void) testFactoryCorrectlyDeterminesPartialMatch
{
    
    
    userHTMLPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"loa" ofType:@"html"];
    NSLog(@"%@", userHTMLPath);
    userHTML = [[NSString alloc] initWithContentsOfFile:userHTMLPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"JSDLASJDLASKDJALSKDJASLGHFSKLDASFBHSLK%@",userHTML);
    
    
    userList = [FacultyFactory AllFacultyFromPartialMatchPage:userHTML];
 
    STAssertEquals(true,[Factory userSearchIsPartialMatch:userHTML], @"");
}

- (void) testPartialMatchShowsCorrectNumberOfUsers
{
    [self setUpUserTestWithUser:@"loa"];
    
    STAssertEquals(1, [userList count]  , @"");
}

- (void) testPartialMatchShowNoUsersIfThereAreNoResults
{
    [self setUpUserTestWithUser:@"loaa"];
    
    STAssertEquals(0, [userList count], @"");
}

-(void) testPartialMatchOnCourseShowsCorrectNumberOfCourses
{
    [self setUpCourseTestWithCourse:@"csse375"];
    
    STAssertEquals(0, (int) [courseList.schedule count], @"");
}


@end