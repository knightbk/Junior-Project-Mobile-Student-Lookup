//
//  Factory.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 1/26/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//


#import "FacultyFactory.h"
#import "Factory.h"

@implementation FacultyFactory

+ (Faculty *) FacultyFromSchedulePage:(NSString *) html
{
    return [[Faculty alloc] initFacultyWithAlias:[self usernameFromStringData:html] 
                                    WithCmNumber:[self cmNumberFromStringData:html]
                                        WithName:[super nameFromStringData:html] 
                                       WithDepartment:[self departmentFromStringData:html] 
                                        WithOfficeNumber:[self officeNumberFromStringData:html] 
                                     WithPhoneNumber:[self phoneNumberFromStringData:html]];
}



+ (NSString *) departmentFromStringData:(NSString *)sdata
{
    return [super firstMatchStringWithRegex:@">Dept: ([^<]+)<" WithStringData:sdata];
}

+ (NSString *) cmNumberFromStringData:(NSString *)sdata
{
    return [super firstMatchStringWithRegex:@">Campus Mail: (CM [0-9]+)<" WithStringData:sdata];
}

+ (NSString *) officeNumberFromStringData:(NSString *)sdata
{
    return [super firstMatchStringWithRegex:@">Room: ([a-zA-Z0-9 ]+)<" WithStringData:sdata];
}

+ (NSString *) phoneNumberFromStringData:(NSString *)sdata
{
    return [super firstMatchStringWithRegex:@">Phone: ([0-9]{3}-[0-9]{4})<" WithStringData:sdata];
}




@end
