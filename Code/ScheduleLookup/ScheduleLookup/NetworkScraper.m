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

#pragma mark - NSURLConnectionDelegate Methods


- (void) initiatePersonInfoSearchWithUsername:(NSString *)uname termcode:(NSString *) termcode
{
    NSString *url = [NSString stringWithFormat:@"https://prodweb.rose-hulman.edu/regweb-cgi/reg-sched.pl?type=Instructor&termcode=%@&view=tgrid&id=%@", termcode, uname];
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}



- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if(passwordItem == nil)
    {
        passwordItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:@"$(TeamIdentifierPrefix)edu.rose-hulman.ScheduleLookup"];
    }
    
    if ([challenge previousFailureCount] > 0)
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Invalid Credentials" message:@"The credentials you input for your account are invalid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [[challenge sender]  useCredential:[NSURLCredential credentialWithUser:[passwordItem objectForKey:(__bridge_transfer id)kSecAttrAccount]
                                                                      password:[passwordItem objectForKey:(__bridge_transfer id)kSecValueData]
                                                                   persistence:NSURLCredentialPersistenceNone] 
                forAuthenticationChallenge:challenge];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{ 
    [connection cancel];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    NSString *sdata = [[NSString alloc ]initWithData:data encoding:NSASCIIStringEncoding];
    [self.delegate networkScraperDidReceiveData:sdata];
}

@end
