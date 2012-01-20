//
//  Student.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 1/20/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Student : Person
{
    NSString *major;
    NSString *year;
}

@property(strong, nonatomic) NSString *major;
@property(strong, nonatomic) NSString *year;

- (Student *) initStudentWithAlias:(NSString *)newAlias 
                      WithCmNumber:(NSString *)newCmNumber  
                          WithName:(NSString *)newName 
                         WithMajor:(NSString *)newMajor 
                          WithYear:(NSString *)newYear;

@end
