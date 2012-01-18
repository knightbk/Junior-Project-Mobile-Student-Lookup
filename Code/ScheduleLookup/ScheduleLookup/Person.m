//
//  Person.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 1/18/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "Person.h"

#define EMAIL_SUFFIX @"@rose-hulman.edu"
@implementation Person

@synthesize name, cmNumber, alias;

- (Person *) initPersonWithAlias:(NSString *)newAlias WithCmNumber:(NSString *)newCmNumber  WithName:(NSString *)newName
{
    self.alias = newAlias;
    self.name = newName;
    self.cmNumber = newCmNumber;
    
    return self;
}

- (NSString *) getEmailAddress
{
    return [NSString stringWithFormat:@"%@%@", self.alias, EMAIL_SUFFIX];
}

@end