//
//  NetworkScraper.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 3/13/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "NetworkScraper.h"
#import "KeychainItemWrapper.h"

@implementation NetworkScraper
@synthesize passwordItem;
@synthesize delegate;
@synthesize sdata;

#pragma mark - NSURLConnectionDelegate Methods


- (void) initiatePersonInfoSearchWithUsername:(NSString *)uname termcode:(NSString *) termcode
{
    self.sdata = @"";
    NSString *url = [NSString stringWithFormat:@"https://prodweb.rose-hulman.edu/regweb-cgi/reg-sched.pl?type=Instructor&termcode=%@&view=tgrid&id=%@", termcode, uname];
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void) initiatePersonScheduleSearchWithUsername:(NSString *)uname termcode:(NSString *) termcode
{
    self.sdata = @"";
    
    NSString *url = [NSString stringWithFormat:@"https://prodweb.rose-hulman.edu/regweb-cgi/reg-sched.pl?type=Username&termcode=%@&view=tgrid&id=%@", termcode, uname];
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}



- (void) initiateClassInfoSearchWithCourse:(NSString *)course termcode:(NSString *) termcode
{
    self.sdata = @"";
    
    NSString *url = [NSString stringWithFormat:@"https://prodweb.rose-hulman.edu/regweb-cgi/reg-sched.pl?type=Roster&termcode=%@&view=tgrid&id=%@", termcode, course];
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void) initiateRoomSearchWithRoom:(NSString *)room termcode: (NSString *) termcode
{
    self.sdata = @"";
    
    NSString *url = [NSString stringWithFormat:@"https://prodweb.rose-hulman.edu/regweb-cgi/reg-sched.pl?type=Room&termcode=%@&view=tgrid&id=%@", termcode, room];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}



- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] > 0)
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Invalid Credentials" message:@"The credentials you input for your account are invalid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [[challenge sender]  useCredential:[NSURLCredential credentialWithUser:[self getUserName]
                                                                      password:[self getPassword]
                                                                   persistence:NSURLCredentialPersistenceNone] 
                forAuthenticationChallenge:challenge];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{ 
    [self.delegate networkScraperDidReceiveData:sdata];
    [connection cancel];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    self.sdata = [NSString stringWithFormat:@"%@%@",self.sdata,[[NSString alloc ]initWithData:data encoding:NSASCIIStringEncoding]];
}

- (NSString *) getUserName
{
    [self loadPasswordItem];
    
    return [passwordItem objectForKey:(__bridge id)kSecAttrAccount];
}

- (NSString *) getPassword
{
    [self loadPasswordItem];
    
    return [passwordItem objectForKey:(__bridge id)kSecValueData];
}

- (void) setUserName:(NSString *)username
{
    [self loadPasswordItem];
    
    [passwordItem setObject:username forKey:(__bridge id)kSecAttrAccount];
}

- (void) setPassword:(NSString *)password
{
    [self loadPasswordItem];
    
    [passwordItem setObject:password forKey:(__bridge id)kSecValueData];
}

- (void) loadPasswordItem
{
    if(passwordItem == nil)
    {
        passwordItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:@"422ME6PATL.edu.rose-hulman.ScheduleLookup"];
    }
}

@end
