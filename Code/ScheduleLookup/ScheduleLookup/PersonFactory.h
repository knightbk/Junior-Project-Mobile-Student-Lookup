//
//  Factory.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 1/26/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface PersonFactory : NSObject
+ (NSString *) firstMatchStringWithRegex:(NSString *)expression WithStringData:(NSString *)sdata;
+ (NSString *) usernameFromStringData:(NSString *)sdata;
+ (NSString *) nameFromStringData:(NSString *)sdata;
+ (BOOL) userSearchIsPartialMatch:(NSString *)sdata;


@end
