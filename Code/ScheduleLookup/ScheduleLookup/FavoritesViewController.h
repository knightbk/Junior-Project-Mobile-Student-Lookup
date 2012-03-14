//
//  SecondViewController.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 12/14/11.
//  Modified by Brandon Knight on 2/13/2012
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UIViewController {

NSDictionary *userFavoritesDictionary;

}

@property (nonatomic, strong) NSDictionary *userFavoritesDictionary;
@property (nonatomic, retain) IBOutlet UITableView *favoritesTable;

- (void) updateFavorites;

@end