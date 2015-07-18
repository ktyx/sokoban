//
//  TipAlertView.m
//  sokoban
//
//  Created by daxin on 4/5/12.
//  Copyright 2012 daxin. All rights reserved.
//

#import "SuccessAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "CSDevice.h"

@implementation SuccessAlertView
@synthesize tipType;
@synthesize tipLabel;
@synthesize delegate;

@synthesize textLabel;
@synthesize nextButton;

+ (void)showConfirm:(NSString*)tipText withDelegate:(id<SuccessAlertViewDelegate>)aDelegate
{
	SuccessAlertView* tipView = [[[SuccessAlertView alloc] init] autorelease];
	[tipView.tipLabel setText:tipText];
	[tipView setDelegate:aDelegate];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft
        || orientation == UIInterfaceOrientationLandscapeRight)
    {
        [tipView setTransform: CGAffineTransformMakeRotation(- M_PI_2)];
        CGRect appRect = [[UIScreen mainScreen] applicationFrame];
        [tipView setFrame:appRect];
    }
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:tipView];
    
    if ([CSDevice currentDeviceType] == CSDevice_iPad)
    {
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            [tipView setTransform: CGAffineTransformMakeRotation(- M_PI_2)];
        }else if(orientation == UIInterfaceOrientationLandscapeRight)
        {
            tipView.transform = CGAffineTransformMakeRotation(M_PI/2.0);
        }
    }
    
    
    CAKeyframeAnimation *scaleAnimation;
	scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	scaleAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	scaleAnimation.duration = 1.0;
	scaleAnimation.removedOnCompletion = YES;
	scaleAnimation.fillMode = kCAFillModeForwards;
	scaleAnimation.autoreverses = NO;
	scaleAnimation.repeatCount = 1e100;
	
	NSMutableArray * values = [NSMutableArray array];
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.98, 0.98, 0.98)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.05)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.98, 0.98, 0.98)]];
	scaleAnimation.values = values;
	scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];;
    
    [CATransaction begin];
	[tipView.textLabel.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
	[CATransaction commit];
    
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithNibName:@"SuccessAlertView"];
    if (self) {
        // Initialization code.
        [textLabel setText:CSLOCAL(@"RIGHT_ANSWER")];
        [nextButton setTitle:CSLOCAL(@"NEXT") forState:UIControlStateNormal];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)close:(id)sender
{
	[super close:sender];
	if (delegate)
	{
		if ([delegate respondsToSelector:@selector(successAlertViewCancelPressed:)])
		{
			[delegate successAlertViewCancelPressed:self];
		}
	}
}

- (IBAction)confirm:(id)sender
{
    [super close:sender];
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(successAlertViewYesPressed:)])
        {
            [delegate successAlertViewYesPressed:self];
        }
    }
}

- (IBAction)cancel:(id)sender
{
    [super close:sender];
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(successAlertViewCancelPressed:)])
        {
            [delegate successAlertViewCancelPressed:self];
        }
    }
}


- (IBAction)next:(id)sender
{
    [super close:sender];
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(successAlertViewYesPressed:)])
        {
            [delegate successAlertViewYesPressed:self];
        }
    }
}


#pragma mark -
- (void) alertViewZoomIn
{
	[alertView setTransform:CGAffineTransformScale(CGAffineTransformIdentity,0.1f,0.1f)];
	[UIView beginAnimations:@"alert view zoom in" context:nil];
    //[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.25];
    //[UIView setAnimationDidStopSelector:@selector(alertViewZoomInBounds1)];
	//[alertView setTransform:CGAffineTransformScale(CGAffineTransformIdentity,1.1f,1.1f)];
    [alertView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f)];
	[UIView commitAnimations];
}

- (void) alertViewZoomOut
{
	[UIView beginAnimations:@"alert view zoom out" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.2];
	[alertView setTransform:CGAffineTransformScale(CGAffineTransformIdentity,0.1f,0.1f)];
    alertView.alpha = 0.1f;
	[UIView setAnimationDelegate:self];
	[UIView commitAnimations];
}

@end
