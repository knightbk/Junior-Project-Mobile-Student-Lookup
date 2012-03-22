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
    //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserFavorites" ofType:@"plist"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"UserFavorites"]];
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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"UserFavorites.plist"];
    
    NSMutableDictionary *newDict;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        newDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    }
    else
    {
        [[NSFileManager defaultManager] createFileAtPath:plistPath contents:nil attributes:nil];
        newDict = [[NSMutableDictionary alloc] init];
    }
    
    NSLog(@"%@",newDict);
    [newDict setObject:[self name] forKey:[self alias]];
    BOOL suc = [newDict writeToFile:plistPath atomically:YES];
    NSLog(@"%@ %@", (suc ? @"Yes": @"No"), newDict);
}

- (void) removeFromFavorites
{
    NSLog(@"Removing %@ from favorites.", alias);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"UserFavorites"]]; 
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    [newDict removeObjectForKey:alias];
    [newDict writeToFile:plistPath atomically:YES];
}


@end
