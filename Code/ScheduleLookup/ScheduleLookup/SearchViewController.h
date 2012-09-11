//
//  SearchViewController.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 12/14/11.
//  Modified by Brandon Knight on 2/13/2012
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoViewController.h"
#import "NetworkScraper.h"

@interface SearchViewController : UIViewController <UISearchBarDelegate, NetworkScraperDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    IBOutlet NSMutableArray *searchValues;
    IBOutlet NSMutableArray *termValues;
    IBOutlet NSMutableArray *yearValues;
    IBOutlet UIPickerView *pickerView;
    IBOutlet NSString *selectedYear;
    int currentYear;
}

-(NSString *) getSelectedTerm;
- (void) setUpPicker;
- (void) saveContentsOfPicker;
- (void) toggleBottomSearchBarButtonClickability;

@property (strong, nonatomic) NetworkScraper *networkScraper;
@property (strong, nonatomic) IBOutlet UISearchBar *scheduleSearchBar;
@property (strong, nonatomic) IBOutlet UIButton *bottomSearchButton;

@end
