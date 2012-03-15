//
//  SecondViewController.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 12/14/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "FavoritesViewController.h"
#import "Faculty.h"
#import "Factory.h"
#import "FacultyFactory.h"

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

- (void)viewWillAppear:(BOOL)animated
{
    [self updateFavorites];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserFavorites" ofType:@"plist"];
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
    //NSString * username = [userFavoritesDictionary objectForKey:([[userFavoritesDictionary allKeys] objectAtIndex:indexPath.row])];
    
    //NSLog(@"Viewing %@'s profile", username);
}

@end
