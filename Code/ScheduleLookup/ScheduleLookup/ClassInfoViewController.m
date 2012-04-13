//
//  ClassInfoViewController.m
//  ScheduleLookup
//
//  Created by Nix on 4/12/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "ClassInfoViewController.h"

@interface ClassInfoViewController ()

@end

@implementation ClassInfoViewController

@synthesize course, infoList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated
{
    [[self tableView] reloadData];
    self.title = self.course.Course;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.infoList = [NSMutableArray arrayWithCapacity:9];
    int count = 6;
    
    //[infoList addObject:self.course.Description];
    [infoList addObject:self.course.Instructor];
    [infoList addObject:self.course.Credit];
    [infoList addObject:self.course.ENRL];
    [infoList addObject:self.course.CAP];
    [infoList addObject:self.course.CRN];
    
    
    
    if (![self.course.Comments isEqualToString:@""]){
        [infoList addObject:self.course.Comments];
        count++;
    }
    if (![self.course.Final_Schedule isEqualToString:@""]){
        [infoList addObject:self.course.Final_Schedule];
        count++;
    }   
    
    if (section == 0) {
        return count;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = [infoList objectAtIndex:indexPath.row];
        
    } else {
        cell.textLabel.text = @"View Roster";
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return self.course.Description;
    else
        return @"Actions";
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
