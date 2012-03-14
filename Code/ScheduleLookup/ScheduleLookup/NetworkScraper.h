//
//  NetworkScraper.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 3/13/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"

@protocol NetworkScraperDelegate

- (void) networkScraperDidReceiveData:(NSString *) sdata;

@end

@interface NetworkScraper : NSObject <NSURLConnectionDelegate>

@property (strong, nonatomic) KeychainItemWrapper *passwordItem;
@property (unsafe_unretained, nonatomic) id <NetworkScraperDelegate> delegate;
@property (strong, nonatomic) NSString *sdata;

- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data; 
- (void) connectionDidFinishLoading:(NSURLConnection *)connection; 

- (void) initiatePersonInfoSearchWithUsername:(NSString *)uname termcode:(NSString *) termcode;
- (NSString *) getUserName;
- (NSString *) getPassword;
- (void) setUserName:(NSString *)username;
- (void) setPassword:(NSString *)password;
- (void) loadPasswordItem;

@end
