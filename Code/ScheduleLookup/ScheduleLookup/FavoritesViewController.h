//
//  SecondViewController.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 12/14/11.
//  Modified by Brandon Knight on 2/13/2012
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkScraper.h"

@interface FavoritesViewController : UITableViewController <NetworkScraperDelegate>{

NSMutableDictionary *userFavoritesDictionary;

}

@property (nonatomic, strong) NSMutableDictionary *userFavoritesDictionary;
@property (strong, nonatomic) NetworkScraper *networkScraper;

- (void) updateFavorites;

@end