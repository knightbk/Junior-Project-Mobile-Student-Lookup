//
//  ScheduleViewController.h
//  ScheduleLookup
//
//  Created by Mark Vitale on 3/20/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Schedule.h"


@interface ScheduleViewController : UIViewController <UIScrollViewDelegate> {
    NSMutableArray *viewControllers;
    
    BOOL pageControlUsed;
}
@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) Schedule *schedule;

@property (weak,nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak,nonatomic) IBOutlet UIPageControl *pageControl;

-(NSInteger) getWeekday;

@end
