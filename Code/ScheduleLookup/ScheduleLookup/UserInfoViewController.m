//
//  UserInfoViewController.m
//  ScheduleLookup
//
//  Created by Nick Crawford on 3/11/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "UserInfoViewController.h"

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
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
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    if (indexPath.section == 0) {
        
        cell.textLabel.text = [infoList objectAtIndex:indexPath.row];
        /*switch (indexPath.row) {
            case 0:
                cell.textLabel.text = [self.person getEmailAddress];
                break;
            case 1:
                cell.textLabel.text = [self.person phoneNumber];
                break;
            case 2:
                cell.textLabel.text = [self.person cmNumber];
                break;
            case 3:
                cell.textLabel.text = [self.person officeNumber];
                break;
            case 4:
                cell.textLabel.text = [self.person department];
                break;
            default:
                break;
        }*/
    } else {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"View Schedule";
                break;
            case 1:
//                if ([person inFavorites]) {
//                    cell.textLabel.text = @"Remove from Favorites";
//                }
                cell.textLabel.text = @"Add to Favorites";
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
            if(indexPath.section == 0)
            {
                if(indexPath.row == 0)
                {
                    NSLog(@"Send Email");
                }
                else if(indexPath.row == 1)
                {
                    NSLog(@"Make phone call");
                    
                    NSString * phone = [NSString stringWithFormat:@"tel://%@",person.getPhoneNumberWithAreaCode];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
                    
                }
                
            }
            else
            {
                
            }

        
}

@end
