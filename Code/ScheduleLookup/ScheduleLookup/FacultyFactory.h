//
//  Factory.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 1/26/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Faculty.h"
#import "Factory.h"

@interface FacultyFactory : Factory

+ (Faculty *) FacultyFromSchedulePage:(NSString *)html;

+ (NSString *) departmentFromStringData:(NSString *)sdata;



@end
