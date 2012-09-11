//
//  IntegrationTests.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 5/10/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NetworkScraper.h"

@interface IntegrationTests : SenTestCase <NetworkScraperDelegate>
{
}
@property (strong, nonatomic) NSString *sHtml;
@property (strong, nonatomic) NSNumber *canContinue;

@end
