//
//  Factory.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 1/26/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//


#import "StudentFactory.h"
#import "PersonFactory.h"

@implementation StudentFactory

+ (Student *) studentFromStudentSchedulePage:(NSString *) html
{
    return [[Student alloc] initStudentWithAlias:[self usernameFromStringData:html] 
                                    WithCmNumber:nil 
                                        WithName:[super nameFromStringData:html] 
                                       WithMajor:nil 
                                        WithYear:nil 
                                     WithAdvisor:[self advisorFromStringData:html]];
}



+ (NSString *) advisorFromStringData:(NSString *)sdata
{
    return [self firstMatchStringWithRegex:@"> Advisor: ([a-zA-Z ]+)<" WithStringData:sdata];
}





@end
