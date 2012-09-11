//
//  FavoritesViewController.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 12/14/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "FavoritesViewController.h"
#import "Faculty.h"
#import "PersonFactory.h"
#import "FacultyFactory.h"
#import "UserInfoViewController.h"

@implementation FavoritesViewController

@synthesize userFavoritesDictionary;
@synthesize networkScraper;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateFavorites];
    [self.tableView reloadData];

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) updateFavorites
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", @"UserFavorites"]];
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    userFavoritesDictionary = newDict;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [userFavoritesDictionary count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[userFavoritesDictionary allValues] objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (networkScraper == nil) {
        networkScraper = [[NetworkScraper alloc] init];
        networkScraper.delegate = self;
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *alias = [[userFavoritesDictionary allKeys] objectAtIndex:indexPath.row];
    [networkScraper initiatePersonInfoSearchWithUsername:alias termcode:[self getSavedTermCode]];
}
     
- (void) networkScraperDidReceiveData:(NSString *)sdata
{
    Faculty *person = [FacultyFactory FacultyFromSchedulePage:sdata];
    UserInfoViewController *userInfoPage = [[UserInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
    userInfoPage.termCode = [self getSavedTermCode];
    userInfoPage.person = person;
    [self.navigationController pushViewController:userInfoPage animated:YES];
}

- (NSString *)getSavedTermCode
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", @"SearchSelectionFavorites"]];
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSString *term = [newDict valueForKey:@"TermCode"];
    NSString *year = [newDict valueForKey:@"Year"];
    NSString *catString = [[NSString alloc] initWithFormat:@"%@%@", year, term];
    
    return catString;
}


@end
