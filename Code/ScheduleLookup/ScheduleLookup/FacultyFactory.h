//
//  Factory.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 1/26/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Faculty.h"
#import "PersonFactory.h"

@interface FacultyFactory : PersonFactory

+ (Faculty *) FacultyFromSchedulePage:(NSString *)html;
+ (NSArray *) AllFacultyFromPartialMatchPage:(NSString *)html;

+ (NSString *) departmentFromStringData:(NSString *)sdata;
+ (NSString *) cmNumberFromStringData:(NSString *)sdata;
+ (NSString *) officeNumberFromStringData:(NSString *)sdata;
+ (NSString *) phoneNumberFromStringData:(NSString *)sdata;



@end
