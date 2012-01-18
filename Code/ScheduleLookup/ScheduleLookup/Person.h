//
//  Person.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 1/18/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString *name;
    NSString *cmNumber;
    NSString *alias; //essentially the email without @rose-hulman.edu
}

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *cmNumber;
@property(strong, nonatomic) NSString *alias;

- (Person *) initPersonWithAlias:(NSString *)newAlias;
- (NSString *) getEmailAddress;
@end
