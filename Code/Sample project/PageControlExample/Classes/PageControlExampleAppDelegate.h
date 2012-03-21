//
//  PageControlExampleAppDelegate.h
//  PageControlExample
//
//  Created by Chakra on 26/02/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageControlExampleAppDelegate : NSObject <UIApplicationDelegate , UIScrollViewDelegate> {
    UIWindow *window;
	IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    BOOL pageControlUsed;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;

- (IBAction)changePage:(id)sender;

@end

