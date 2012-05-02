//
//  Faculty.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 1/20/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
@interface Faculty : Person
{
    NSString *department;
    NSString *officeNumber;
    NSString *phoneNumber;
}


@property(strong, nonatomic) NSString *department;
@property(strong, nonatomic) NSString *officeNumber;
@property(strong, nonatomic) NSString *phoneNumber;

- (Faculty *) initFacultyWithAlias:(NSString *)newAlias 
                      WithCmNumber:(NSString *)newCmNumber  
                          WithName:(NSString *)newName 
                    WithDepartment:(NSString *)newDepartment
                  WithOfficeNumber:(NSString *)newOfficeNumber
                   WithPhoneNumber:(NSString *)newPhoneNumber;

- (NSString *) asText;
- (NSString *) getPhoneNumberWithAreaCode;
- (BOOL) isCurrentUser;
- (BOOL) inFavorites;
- (void) addToFavorites;
- (void) removeFromFavorites;
@end