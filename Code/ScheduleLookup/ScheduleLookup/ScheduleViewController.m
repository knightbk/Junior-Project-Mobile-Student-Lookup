//
//  ScheduleViewController.m
//  ScheduleLookup
//
//  Created by Mark Vitale on 3/20/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#define Y_VALUE 50

#import "ScheduleViewController.h"
#import "SingleDayScheduleViewController.h"
#import "Schedule.h"
#import "ClassSchedule.h"

@implementation ScheduleViewController

@synthesize scrollView,pageControl;
@synthesize viewControllers;
@synthesize schedule;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= 5)
        return;
    
    // replace the placeholder if necessary
    UITableViewController *controller = [viewControllers objectAtIndex:page];
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = Y_VALUE;
        frame.size.height -= Y_VALUE;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
}

-(IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width*page;
    frame.origin.y = Y_VALUE;
    frame.size.height -= Y_VALUE;
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlUsed = YES;
        
    [self loadScrollViewWithPage:page-1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page+1];
    
    [scrollView addSubview:[[self.viewControllers objectAtIndex:page] view]];


}
#pragma mark - UIScrollViewDelegate Methods


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (pageControlUsed) 
    {
        return;
    } 
    else 
    {
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControl.currentPage = page;
        [self loadScrollViewWithPage:page-1];
        [self loadScrollViewWithPage:page];
        [self loadScrollViewWithPage:page+1];

    }

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;

}

#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Schedule";
    
    self.viewControllers = [[NSMutableArray alloc] initWithCapacity:5];
    
    //create viewcontrollers
    SingleDayScheduleViewController *mondayTableViewController = [[SingleDayScheduleViewController alloc] init];
    SingleDayScheduleViewController *tuesdayTableViewController = [[SingleDayScheduleViewController alloc] init];
    SingleDayScheduleViewController *wednesdayTableViewController = [[SingleDayScheduleViewController alloc] init];
    SingleDayScheduleViewController *thursdayTableViewController = [[SingleDayScheduleViewController alloc] init];
    SingleDayScheduleViewController *fridayTableViewController = [[SingleDayScheduleViewController alloc] init];

    //set the properties
    mondayTableViewController.dayString = @"Monday";
    tuesdayTableViewController.dayString = @"Tuesday";
    wednesdayTableViewController.dayString = @"Wednesday";
    thursdayTableViewController.dayString = @"Thursday";
    fridayTableViewController.dayString = @"Friday";

    mondayTableViewController.classArray = [schedule getScheduleForDay:MONDAY];
    tuesdayTableViewController.classArray = [schedule getScheduleForDay:TUESDAY];
    wednesdayTableViewController.classArray = [schedule getScheduleForDay:WEDNESDAY];
    thursdayTableViewController.classArray = [schedule getScheduleForDay:THURSDAY];
    fridayTableViewController.classArray = [schedule getScheduleForDay:FRIDAY];
    
    //add them to the viewcontrollers array
    [self.viewControllers addObject:mondayTableViewController];
    [self.viewControllers addObject:tuesdayTableViewController];  
    [self.viewControllers addObject:wednesdayTableViewController];
    [self.viewControllers addObject:thursdayTableViewController];
    [self.viewControllers addObject:fridayTableViewController];

    self.pageControl.numberOfPages = 5;
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*5,scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;

    
    NSInteger weekday = [self getWeekday];
    
    if (weekday == 1 || weekday == 7) 
    {
        self.pageControl.currentPage = 0;
    }
    else
    {
        self.pageControl.currentPage = weekday - 2;
    }
    [self changePage:nil];
    
}

-(NSInteger) getWeekday
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* components = [cal components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    return [components weekday];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
