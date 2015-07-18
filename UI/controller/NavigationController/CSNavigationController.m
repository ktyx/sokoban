//
//  CSNavigationController.m
//  CuteScreenUI
//
//  Created by daxin on 13-4-29.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "CSNavigationController.h"
#import "CSButton.h"
#import "CSDevice.h"

@interface CSNavigationController ()

@end

@implementation CSNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage* navBarBgImage = nil;
        if ([CSDevice isPad])
        {
            navBarBgImage = [UIImage imageNamed:@"navbar-pad.png"];
        }else
        {
            navBarBgImage = [UIImage imageNamed:@"navbar.png"];
        }
        [self.navigationBar setBackgroundImage:navBarBgImage forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
        NSDictionary* textDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont fontWithName:@"TRENDS" size:24],UITextAttributeFont,
                                  [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],UITextAttributeTextShadowOffset,
                                  [UIColor whiteColor], UITextAttributeTextColor,nil];
        [self.navigationBar setTitleTextAttributes:textDict];
        if ([CSDevice isSystemVersionLaterThan:7.0])
        {
            [self.navigationBar setBackgroundColor:[UIColor blackColor]];
            [self.navigationBar setTranslucent:NO];
            [self.navigationBar setBarTintColor:[UIColor blackColor]];
        }
        
        [self.navigationBar.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [self.navigationBar.layer setShadowOffset:CGSizeMake(1, 1)];
        [self.navigationBar.layer setShadowOpacity:0.5];
        [self.navigationBar.layer setShadowRadius:2];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
    //[self.navigationBar setContentMode:UIViewContentModeScaleToFill];

    //[self.navigationBar setBackgroundColor:[UIColor colorWithPatternImage:navBarBgImage]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    [self.navigationItem setHidesBackButton:YES];
    if (([[self viewControllers] count] > 1)
        && (self.navigationItem.leftBarButtonItems == nil))
    {
        [self customBackButton];
    }
}

- (UIViewController*)popViewControllerAnimated:(BOOL)animated
{
    [super popViewControllerAnimated:animated];
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customBackButton
{
    UIImage* backgroundImage = [UIImage imageNamed:@"navbar_back.png"];
    int height = backgroundImage.size.height;
    if (backgroundImage.size.width != 0)
    {
        height = ( backgroundImage.size.height * NAVIGATION_BACKBUTTON_WIDTH ) / backgroundImage.size.width;
    }
    CGRect imageRect = CGRectMake(5, 5, NAVIGATION_BACKBUTTON_WIDTH, height);
    CSButton*  button = [CSButton buttonWithType:UIButtonTypeCustom];
    [button setImage:backgroundImage forState:UIControlStateNormal];
    [button setFrame:imageRect];
    [button addTarget:self action:@selector(responseToBackButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    //[self.navigationItem setLeftBarButtonItem:backButton];
    [self.navigationBar.topItem setLeftBarButtonItem:backButton];
    [backButton release];
}

- (void)responseToBackButton
{
    [self popViewControllerAnimated:YES];
}

@end
