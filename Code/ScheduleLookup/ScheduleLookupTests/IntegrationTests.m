//
//  IntegrationTests.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 5/10/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "IntegrationTests.h"
#import "SearchViewController.h"
#import "FacultyFactory.h"

@implementation IntegrationTests

@synthesize sHtml, canContinue;

- (void)setUp
{
    [super setUp];
    sHtml = @"";
}

- (void)tearDown
{
    [super tearDown];
}

- (void) testUserIsParsedCorrectly
{
    
    NetworkScraper *ns = [[NetworkScraper alloc] init];
    ns.delegate = self;
    [ns initiatePersonInfoSearchWithUsername:@"crawfonw" termcode:@"201230"];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10.0]];
    
    Faculty *faculty = [FacultyFactory FacultyFromSchedulePage:sHtml];
    
    STAssertEqualObjects(@"Nicholas William Crawford", faculty.name, @"");
    STAssertEqualObjects(@"crawfonw", faculty.alias, @"");
    STAssertEqualObjects(@"CM 1043", faculty.cmNumber, @"");
    STAssertEqualObjects(@"&nbsp", faculty.department, @"");
    STAssertEqualObjects(@"Apartment Room WEST 209A", faculty.officeNumber, @"");
    STAssertEqualObjects(@"872-6796", faculty.phoneNumber, @"");
    STAssertEqualObjects(@"crawfonw@rose-hulman.edu", [faculty getEmailAddress], @"");
    
}

- (void) networkScraperDidReceiveData:(NSString *) sdata
{
    sHtml = sdata;
}


@end
