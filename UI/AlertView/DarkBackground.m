//
//  DarkBackground.m
//
//  Created by Huang Daxin 4/1/12.
//  Copyright 2012 daxin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DarkBackground.h"
#import "CSDevice.h"


static UIView*  darkBackgroundInstance = nil;

@implementation DarkBackground
@synthesize shownViewArray;

+ (id)sharedInstance
{
	if (darkBackgroundInstance == nil) 
	{
        CGRect bgRect = [CSDevice backgroundRect];
		darkBackgroundInstance = [[DarkBackground alloc] initWithFrame:bgRect];
	}
	return darkBackgroundInstance;
}

- (id)initWithFrame:(CGRect)frame 
{    
    self = [super initWithFrame:frame];
    if (self) 
	{
		[self setBackgroundColor:[UIColor blackColor]];
		self.shownViewArray = [NSMutableArray arrayWithCapacity:2];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateLayout) name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void) backgroundDarken
{
	[UIView beginAnimations:@"background fade in" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDuration:0.2];
	[[DarkBackground sharedInstance] setAlpha:0.6];
	[UIView commitAnimations];
}

- (void) backgroundBrighten
{
	[UIView beginAnimations:@"background fade out" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDuration:0.2];
	[[DarkBackground sharedInstance] setAlpha:0];
	[UIView setAnimationDelegate:self];
	[UIView commitAnimations];
}


#pragma mark -
#pragma mark AnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //NSLog(@"showArray:%@",shownViewArray);
	[[DarkBackground sharedInstance] removeFromSuperview];
	DarkBackground* darkView = [DarkBackground sharedInstance];
	if ([darkView.shownViewArray count] > 0)
	{
		UIView* shownView = [darkView.shownViewArray lastObject];
		//NSLog(@"shown view subview:%@",[shownView subviews]);
		NSArray* shownSubviewArray = [shownView subviews];
		UIView* lastAlertView = [shownSubviewArray lastObject];
		if (lastAlertView)
		{
			[shownView insertSubview:darkView belowSubview:lastAlertView];
			[darkView backgroundDarken];
		}
	}
}

+ (void) darken
{
	DarkBackground* darkView = [DarkBackground sharedInstance];
//	NSArray* viewArray = [[[UIApplication sharedApplication] keyWindow] subviews];
//	int viewCount = [viewArray count];
//	if (viewCount < 1 ) return;
//	UIView* last2View = [viewArray objectAtIndex:viewCount - 1];
//	[last2View addSubview:darkView];
    UIView* fatherView = [[UIApplication sharedApplication] keyWindow];
    [fatherView addSubview:darkView];
	[darkView backgroundDarken];
	[darkView.shownViewArray addObject:fatherView];
}

+ (void) brighten
{
	DarkBackground* darkView = [DarkBackground sharedInstance];
	[darkView backgroundBrighten];
	[darkView.shownViewArray removeLastObject];
}

+ (void) darkenAtView:(UIView*) aview
{
    DarkBackground* darkView = [DarkBackground sharedInstance];
    [aview addSubview:darkView];
    [darkView backgroundDarken];
    [darkView.shownViewArray addObject:aview];
}

+ (void) brightenAtView:(UIView*)aview
{
    
}

- (void) updateLayout
{
    CGRect rect = [CSDevice backgroundRect];
    [darkBackgroundInstance setFrame:rect];
}


- (void)dealloc 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[shownViewArray release];
    [super dealloc];
}

@end
