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
                   WithPhoneNumber:(NSString *)newPhoneNumber
{
    if (self = [super initPersonWithAlias:newAlias WithCmNumber:newCmNumber  WithName:newName])
    {
        self.department = newDepartment;
        self.officeNumber = newOfficeNumber;
        self.phoneNumber = newPhoneNumber;
        //self.phoneNumber = [NSString stringWithFormat:@"812-%@", newPhoneNumber];
    }
    
    return self;
}

- (NSString *) asText
{
    return [NSString stringWithFormat:@"Alias: %@\nCM: %@\nName: %@\nDept: %@\nRoom: %@\nPhone: %@\n",[self alias], [self cmNumber], [self name], [self department], [self officeNumber], [self phoneNumber]];
}

- (NSString *) getPhoneNumberWithAreaCode
{
    return [NSString stringWithFormat:@"812-%@", self.phoneNumber];
}

- (BOOL) inFavorites
{
    BOOL isFavorited = NO;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserFavorites" ofType:@"plist"];
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *aliases = [newDict allKeys];
    for(int i = 0; i < [newDict count]; i++)
    {
        if([[self alias] isEqualToString:[aliases objectAtIndex:i]])
        {
            isFavorited = YES;
            i+= [newDict count];
        }
    }
    
    return isFavorited;
}

- (void) addToFavorites
{
    NSLog(@"Adding %@ to favorites.", alias);
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserFavorites" ofType:@"plist"];
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSMutableArray *nameToAdd = [[NSMutableArray alloc] init];
    [nameToAdd addObject:[self name]];
    NSMutableArray *aliasToAdd = [[NSMutableArray alloc] init];
    [aliasToAdd addObject:[self alias]];
    [newDict addEntriesFromDictionary:[[NSMutableDictionary alloc] initWithObjects:nameToAdd forKeys:aliasToAdd]];
    NSLog(@"%@",newDict);
    [newDict writeToFile:plistPath atomically:YES];
    
}
- (void) removeFromFavorites
{
    NSLog(@"Removing %@ from favorites.", alias);
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserFavorites" ofType:@"plist"];
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    [newDict removeObjectForKey:alias];
    [newDict writeToFile:plistPath atomically:YES];
}


@end
