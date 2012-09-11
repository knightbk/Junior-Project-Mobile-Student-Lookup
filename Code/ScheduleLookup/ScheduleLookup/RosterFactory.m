//
//  RosterFactory.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 4/12/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "RosterFactory.h"

@implementation RosterFactory


+ (NSDictionary *) rosterFromCoursePage:(NSString *) html
{
    NSDictionary *roster = [self matchesInStrings:@"<TR><TD><.*>([^<]+)</A></TD><TD>([^<]+)</TD><TD>.*</TD><TD>.*</TD><TD>.*</TD><TD><.*>.*</A></TD><TD><.*>.*</A></TD></TR>" WithStringData:html];
    
    return roster;
}

+ (NSDictionary *) matchesInStrings:(NSString *)expression WithStringData:(NSString *)sdata
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSMutableDictionary *roster = [NSMutableDictionary dictionary];

    NSArray *matches = [regex matchesInString:sdata options:0 range:NSMakeRange(0, [sdata length])];
    
    for (NSTextCheckingResult *match in matches) {
        [roster setObject:[sdata substringWithRange:[match rangeAtIndex:1]] forKey:[sdata substringWithRange:[match rangeAtIndex:2]]];
        
    }
    return roster;
}

@end
