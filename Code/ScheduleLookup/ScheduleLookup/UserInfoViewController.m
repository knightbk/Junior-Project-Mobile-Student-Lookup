//
//  UserInfoViewController.m
//  ScheduleLookup
//
//  Created by Nick Crawford on 3/11/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "UserInfoViewController.h"
#import "ScheduleViewController.h"
#import "Schedule.h"
#import "ScheduleFactory.h"
#import "NetworkScraper.h"


@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

@synthesize person, infoList;

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
    self.title = self.person.alias;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    self.infoList = [NSMutableArray arrayWithCapacity:5];
    int count = 1;
    [infoList addObject:[self.person getEmailAddress]];
    if (![[self.person phoneNumber] isEqualToString:@""]){
        [infoList addObject:[self.person phoneNumber]];
        count++;
    }
    if (![[self.person cmNumber] isEqualToString:@""]){
        [infoList addObject:[self.person cmNumber]];
        count++;
    }
    if (![[self.person officeNumber] isEqualToString:@""]){
        [infoList addObject:[self.person officeNumber]];
        count++;
    }
    if (![[self.person department] isEqualToString:@"&nbsp"]){
        [infoList addObject:[self.person department]];
        count++;
    }
    
    
    if (section == 0) {
        return count;
    }
    else
    {
        return 2;
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
        
        if(indexPath.row == 1 && [[self.person phoneNumber] isEqualToString:@""])
        {
            cell.userInteractionEnabled = NO;
        }
        else if(indexPath.row > 1)
        {
            cell.userInteractionEnabled = NO;
            
        }
    } else {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"View Schedule";
                break;
            case 1:
                if (person.inFavorites)
                {
                    cell.textLabel.text = @"Remove from Favorites";
                }
                else if(!person.inFavorites)
                {
                    cell.textLabel.text = @"Add to Favorites";
                }
                
                break;
            default:
                break;
        }
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return [self.person name];
    else
        return @"Actions";
}

- (UITableViewCellAccessoryType) tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0)
    {
        return UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    if (indexPath.row == 1 && indexPath.section == 0 && ![[self.person phoneNumber] isEqualToString:@""])
    {
        return UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    return UITableViewCellAccessoryNone;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            //Sends e-mail to user.
            NSString * email = [NSString stringWithFormat:@"mailto:%@",person.getEmailAddress];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
            
        }
        else if(indexPath.row == 1 && indexPath.section == 0 && ![[self.person phoneNumber] isEqualToString:@""])
        {
            //Calls user.
            NSString * phone = [NSString stringWithFormat:@"tel://%@",person.getPhoneNumberWithAreaCode];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
        }
        
    }
    else
    {
        switch(indexPath.row)
        {

            case 0:
            {
                //Displays the schedule of the user.
                NetworkScraper *networkScraper = [[NetworkScraper alloc] init];
                networkScraper.delegate = self;
                [networkScraper initiatePersonScheduleSearchWithUsername:person.alias termcode:@"201230"];                
                break;
            }
                
            case 1:
            {
                //Adds or removes the user from favorites.
                if(person.inFavorites)
                {
                    [person removeFromFavorites];                    
                }
                else if(!person.inFavorites)
                {
                    [person addToFavorites];
                }
                [[self tableView] reloadData]; 
                break;
            }
                
        }
    }
}
#pragma mark NetworkScraperDelegate methods
    
- (void) networkScraperDidReceiveData:(NSString *)sdata
{
    ScheduleViewController *scheduleViewController = [[ScheduleViewController alloc] initWithNibName:@"ScheduleViewController" bundle:[NSBundle mainBundle]];
    scheduleViewController.schedule = [ScheduleFactory scheduleFromSchedulePage:sdata];;

    [self.navigationController pushViewController:scheduleViewController animated:YES];

}


@end
