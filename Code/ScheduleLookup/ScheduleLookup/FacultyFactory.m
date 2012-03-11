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
                                    WithCmNumber:nil 
                                        WithName:[super nameFromStringData:html] 
                                       WithDepartment:[self departmentFromStringData:html] 
                                        WithOfficeNumber:nil 
                                     WithPhoneNumber:nil];
}



+ (NSString *) departmentFromStringData:(NSString *)sdata
{
    return [super firstMatchStringWithRegex:@"> Dept: ([a-zA-Z ]+)<" WithStringData:sdata];
}





@end
