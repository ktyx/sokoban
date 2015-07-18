//
//  KITAlertView.m
//  sokoban
//
//  Created by Huang Daxin on 3/31/12.
//  Copyright 2012 daxin. All rights reserved.
//

#import "CSAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "DarkBackground.h"
#import "CSDevice.h"


@interface CSAlertView (Private)
- (void) responseToOrientationRotate;
- (void) updateLayout;
@end


@implementation CSAlertView
@synthesize alertView;

- (id)initWithNibName:(NSString*)nibName
{
	if (nibName == nil)
	{
		NSLog(@"KITAlertView: nib name cannot be nil");
		return nil;
	}
    CGRect bgRect = [CSDevice backgroundRect];
    //NSLog(@"bg rect: w:%.2f h:%.2f x:%.2f y:%.2f",bgRect.size.width, bgRect.size.height, bgRect.origin.x, bgRect.origin.y);
    
	self = [super initWithFrame:bgRect];
	if (self == nil) return nil;
	//[DarkBackground darken];
    [DarkBackground darkenAtView:self];
	
	NSArray * viewsArray = [[NSBundle mainBundle] loadNibNamed:nibName 
														 owner:self 
													   options:nil];
	if ([viewsArray count] > 0) 
	{
		alertView = [viewsArray objectAtIndex:0];
		[alertView setBackgroundColor:[UIColor clearColor]];
		

//		displayRect = alertView.frame;
//		float startX = (self.frame.size.width - displayRect.size.width) / 2;
//		float startY = (self.frame.size.height - displayRect.size.height) / 2;
//		displayRect = CGRectOffset(displayRect, startX, startY);
//		//hideRect = CGRectInset(displayRect, displayRect.size.width/2, displayRect.size.height/2);
//		hideRect = CGRectInset(displayRect, displayRect.size.width*10.0/21, displayRect.size.height*10.0/21);
//
//		[alertView setFrame:hideRect];
        int midx = CGRectGetMidX(bgRect);
        int midY = CGRectGetMidY(bgRect);
        CGPoint centerPoint = CGPointMake(midx, midY);
		[alertView setCenter:centerPoint];
		displayRect = alertView.frame;
		[self addSubview:alertView];

		[self alertViewZoomIn];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(responseToOrientationRotate)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
	}
	return self;
}

- (IBAction)close:(id)sender
{
	[self close];
}

- (void)close
{
    //[MBProgressHUD hideHUDForView:self animated:YES];
	[DarkBackground brighten];
	[self alertViewZoomOut];
}

- (void)closeWithoutAnimation
{
    //[MBProgressHUD hideHUDForView:self animated:YES];
	[DarkBackground brighten];
	[self removeFromSuperview];
}

- (void)moveForEdit:(UITextField*)textField
{
	float moveDistance = self.frame.size.height/3 - (displayRect.origin.y + textField.frame.origin.y );
	[UIView beginAnimations:@"move for edit" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.2];
	[alertView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, moveDistance)];
	[UIView commitAnimations];
}

- (void)moveForEdit2:(UITextField*)textField
{
	float moveDistance = -15 + self.frame.size.height/3 - (displayRect.origin.y + textField.frame.origin.y );
	[UIView beginAnimations:@"move for edit" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.2];
	[alertView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, moveDistance)];
	[UIView commitAnimations];
}

- (void)moveBackToOriginal
{
	[UIView beginAnimations:@"move back to original" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.2];
	[alertView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0)];
	[UIView commitAnimations];
}

- (void)startAnimating
{
    //[MBProgressHUD showHUDAddedTo:self animated:YES];
}



#pragma mark -
#pragma mark AnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	[self removeFromSuperview];
}




#pragma mark -
#pragma mark KITAlertView(Private)

- (void) alertViewZoomIn
{
	[alertView setTransform:CGAffineTransformScale(CGAffineTransformIdentity,0.1f,0.1f)];
	[UIView beginAnimations:@"alert view zoom in" context:nil];
    [UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.2];
    [UIView setAnimationDidStopSelector:@selector(alertViewZoomInBounds1)];
	[alertView setTransform:CGAffineTransformScale(CGAffineTransformIdentity,1.1f,1.1f)];
	[UIView commitAnimations];
}

- (void)alertViewZoomInBounds1 {
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(alertViewZoomInBounds2)];
	[alertView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.9f, 0.9f)];
	[UIView commitAnimations];
}

- (void)alertViewZoomInBounds2 {
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
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

- (void) responseToOrientationRotate
{
    [self updateLayout];
}

- (void) updateLayout
{
    CGRect bgRect = [CSDevice backgroundRect];
    int midx = CGRectGetMidX(bgRect);
    int midY = CGRectGetMidY(bgRect);
    CGPoint centerPoint = CGPointMake(midx, midY);
    [alertView setCenter:centerPoint];
    displayRect = alertView.frame;
}

/*
#pragma mark -
#pragma mark UIView Delegate

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([self canBecomeFirstResponder]) 
	{
		[self becomeFirstResponder];
	}
}
*/

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end
