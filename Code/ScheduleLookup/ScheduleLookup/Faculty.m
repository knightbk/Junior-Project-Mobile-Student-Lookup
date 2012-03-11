//
//  Faculty.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 1/20/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "Faculty.h"

@implementation Faculty

@synthesize department, officeNumber, phoneNumber;

- (Faculty *) initFacultyWithAlias:(NSString *)newAlias 
                      WithCmNumber:(NSString *)newCmNumber  
                          WithName:(NSString *)newName 
                    WithDepartment:(NSString *)newDepartment
                  WithOfficeNumber:(NSString *)newOfficeNumber
                   WithOfficeNumber:(NSString *)newPhoneNumber
{
    if (self = [super initPersonWithAlias:newAlias WithCmNumber:newCmNumber  WithName:newName])
    {
        self.department = newDepartment;
        self.officeNumber = newOfficeNumber;
        self.phoneNumber = newPhoneNumber;
    }
    
    return self;
}


@end
