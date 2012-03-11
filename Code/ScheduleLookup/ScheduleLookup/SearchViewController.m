//
//  FirstViewController.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 12/14/11.
//  Modified by Brandon Knight on 2/13/2012
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "SearchViewController.h"
#import "Student.h"
#import "Factory.h"
#import "KeychainItemWrapper.h"
#import "SettingsViewController.h"
#import "GCCalendarPortraitView.h"
#import "StudentFactory.h"
#import "Schedule.h"
#import "ScheduleFactory.h"
#import "ClassSchedule.h"
#import "ClassFactory.h"
#import "SearchUserViewController.h"
@implementation SearchViewController

@synthesize schedule = _schedule;


- (void)calendarViewAddButtonPressed:(GCCalendarView *)view {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)calendarTileTouchedInView:(GCCalendarView *)view withEvent:(GCCalendarEvent *)event {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (int) getPeriod:(NSString *) period
{
    
    return 0;
}
- (BOOL) isSlash:(char) character
{
    if (character == '/')
        return true;
    else
        return false;
}

+ (NSMutableArray *) parseThis:(ClassSchedule *) withClass
{
    SearchViewController *thing = [[SearchViewController alloc] init];
    NSMutableArray *things = [[NSMutableArray alloc] initWithObjects:[withClass Course], [withClass CRN], [withClass Description],[withClass Instructor], [withClass Credit], [withClass ENRL], [withClass CAP], [withClass Term_Schedule], [withClass Comments], [withClass Final_Schedule], nil];
    NSMutableArray *newString = [[NSMutableArray alloc] init];
    NSString *tempString = @"";
    NSString *checkMe =[things objectAtIndex:7];
    for(int i = 0; i < [checkMe length]; i++){
        if ([thing isSlash:[checkMe characterAtIndex:i]]) {
            i++;
            while( ! [thing isSlash:[checkMe characterAtIndex:i]])
            {
                tempString = [tempString stringByAppendingString:[checkMe substringWithRange:NSMakeRange(i, 1)]];
                
                i++;
                
            }
            [newString addObject:tempString];
            tempString = [tempString stringByAppendingString:@":"];
        }
    }
    NSLog(@"%@", tempString);
    for(NSObject *match in newString){
        NSLog(@"%@", match);
        
    }
    
    
    return newString;
}

- (void)viewDidLoad
{
    
    self.dataSource = self;
    self.delegate = self;
    [self loadView];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
<<<<<<< HEAD
    
}
- (NSArray *)calendarEventsForDate:(NSDate *)date{
	NSMutableArray *events = [NSMutableArray array];
	
    SearchUserViewController *obj = (SearchUserViewController *)[[(UINavigationController *)[[[self tabBarController] viewControllers] objectAtIndex:0] viewControllers] objectAtIndex:0];
    
	NSDateComponents *components = [[NSCalendar currentCalendar] components:
									(NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit)
																   fromDate:date];
	[components setSecond:0];

    
	// create 5 calendar events that aren't all day events
    
   
    for(ClassSchedule *c in obj.schedule.schedule){
        GCCalendarEvent *event = [[GCCalendarEvent alloc] init];
        event.color = [[GCCalendar colors] objectAtIndex:1];
        event.allDayEvent = NO;
        NSLog(@"first");
        event.eventName = c.Course;
        event.eventDescription = c.Description;

        NSMutableArray *array = [SearchViewController parseThis:c];
        if(c != nil){
            for(NSString *match in array){
                
                if([match length] == 1){
                    if([match characterAtIndex:0] == '1'){
                        [components setHour:8];
                        [components setMinute:5];
                        event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [components setMinute:50];
                        
                        event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [events addObject:event];
                    }
                    if([match characterAtIndex:0] == '2'){
                        [components setHour:9];
                        [components setMinute:0];  
                        event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [components setMinute:50];
                        
                        event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [events addObject:event];
                    }
                    if([match characterAtIndex:0] == '3'){
                        [components setHour:9];
                        [components setMinute:55];
                        event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [components setHour:10];
                        [components setMinute:45];
                        event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [events addObject:event];
                    }
                    if([match characterAtIndex:0] == '4'){
                        [components setHour:10];
                        [components setMinute:50];
                        event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [components setHour:11];
                        [components setMinute:40];
                        
                        event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [events addObject:event];
                    }
                    if([match characterAtIndex:0] == '5'){
                        [components setHour:11];
                        [components setMinute:45];
                        event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [components setHour:12];
                        [components setMinute:35];
                        
                        event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [events addObject:event];
                    }
                    if([match characterAtIndex:0] == '6'){
                        [components setHour:12];
                        [components setMinute:40];
                        event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [components setHour:13];
                        [components setMinute:30];
                        
                        event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [events addObject:event];
                        
                    }
                    if([match characterAtIndex:0] == '7'){
                        [components setHour:13];
                        [components setMinute:35];
                        event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        [components setHour:14];
                        [components setMinute:25];
                        
                        event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [events addObject:event];
                    }
                    if([match characterAtIndex:0] == '8'){
                        [components setHour:14];
                        [components setMinute:30];
                        event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        [components setHour:15];
                        [components setMinute:20];
                        
                        event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [events addObject:event];
                    }
                    if([match characterAtIndex:0] == '9'){
                        [components setHour:15];
                        [components setMinute:25];
                        event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [components setHour:16];
                        [components setMinute:15];
                        
                        event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
                        
                        [events addObject:event];
                    }
                    
                }
            }
        }
	}
	
    
	
	return events;
=======
    [self hideLabels:(true)];
>>>>>>> parent of 6caa24b... Add placeholder text.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self today];
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
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - SearchUserDelegate methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController * popoverNavigationController = segue.destinationViewController;
    SearchUserViewController * targetController = [[popoverNavigationController viewControllers] objectAtIndex:0];
   targetController.delegate = self;
}

- (void)controller:(SearchUserViewController *)controller withSchedule:(Schedule *)personSchedule{
    self.schedule = personSchedule;
}

@end
