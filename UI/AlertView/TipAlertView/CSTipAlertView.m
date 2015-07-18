//
//  TipAlertView.m
//  sokoban
//
//  Created by daxin on 4/5/12.
//  Copyright 2012 daxin. All rights reserved.
//

#import "CSTipAlertView.h"

@implementation CSTipAlertView
@synthesize tipType;
@synthesize tipLabel;
@synthesize okButton;
@synthesize titleLabel;

+ (void)showTip:(NSString*)tipText withTitle:(NSString*)titleText
{
	CSTipAlertView* alertView = [[[CSTipAlertView alloc] init] autorelease];
	[alertView.tipLabel setText:tipText];
    [alertView.titleLabel setText:titleText];
    /*
	NSArray* viewArray = [[[UIApplication sharedApplication] keyWindow] subviews];
	int viewCount = [viewArray count];
	if (viewCount < 1) return;
	UIView* last2View = [viewArray objectAtIndex:viewCount - 1];
	[last2View addSubview:alertView];
     */
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft
        || orientation == UIInterfaceOrientationLandscapeRight)
    {
        [alertView setTransform: CGAffineTransformMakeRotation(M_PI_2)];
        CGRect appRect = [[UIScreen mainScreen] applicationFrame];
        [alertView setFrame:appRect];
    }
    [[[UIApplication sharedApplication] keyWindow] addSubview:alertView];
}

+ (void)showTip:(NSString*)tipText withType:(int)aTipType
{
	CSTipAlertView* alertView = [[[CSTipAlertView alloc] init] autorelease];
	[alertView.tipLabel setText:tipText];
	[alertView setTipType:aTipType];
	NSArray* viewArray = [[[UIApplication sharedApplication] keyWindow] subviews];
	int viewCount = (int)[viewArray count];
	if (viewCount < 1) return;
	UIView* last2View = [viewArray objectAtIndex:viewCount - 1];
	[last2View addSubview:alertView];
}


+ (void)showTip:(NSString*)tipText atView:(UIView*)aview
{
    if (aview)
    {
        CSTipAlertView* tipView = [[[CSTipAlertView alloc] init] autorelease];
        [tipView.tipLabel setText:tipText];
        [aview addSubview:tipView];
    }
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithNibName:@"CSTipAlertView"];
    if (self) {
        [titleLabel setText:CSLOCAL(@"TIP_TITLE")];
        [okButton setTitle:CSLOCAL(@"OK") forState:UIControlStateNormal];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)close:(id)sender
{
	[super close:sender];
}

@end
