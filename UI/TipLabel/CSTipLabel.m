//
//  WOTipLabel.m
//  CustomSomeUI
//
//  Created by Huang Daxin on 13-1-14.
//  Copyright (c) 2013 Cute Screen Studio . All rights reserved.
//

#import "CSTipLabel.h"
#import <QuartzCore/QuartzCore.h>
#import "CSColor.h"

@interface CSTipLabel()
+ (CSTipLabel*)tipLabelWithText:(NSString*)text;
- (void)fadeIn;
- (void)fadeOut;
@end

@implementation CSTipLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setTextColor:[UIColor whiteColor]];
        [self setFont:[UIFont boldSystemFontOfSize:[[self font] pointSize]]];
        [self setBackgroundColor:[CSColor bgPurlpleColor]];
        [self setTextAlignment:NSTextAlignmentCenter];
        [self.layer setCornerRadius:5];
        [self setNumberOfLines:0];
    }
    return self;
}

+ (void) showText:(NSString*)text
{
    [CSTipLabel showText:text atView:nil];
}

+ (void) showText:(NSString*)text atView:(UIView*)view
{
    CSTipLabel* label = [CSTipLabel tipLabelWithText:text];
    if (view == nil)
    {
        [[[UIApplication sharedApplication] keyWindow] addSubview:label];
    }else
    {
        [view addSubview:label];
    }
    [label fadeIn];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:label selector:@selector(fadeOut) userInfo:nil repeats:NO];
}

+ (void) showTextUponKeyboard:(NSString*)text atView:(UIView*)view
{
    CSTipLabel* label = [CSTipLabel tipLabelWithText:text];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenRect.size.height = screenRect.size.height / 2;
    int midx = CGRectGetMidX(screenRect);
    int midy = CGRectGetMidY(screenRect);
    CGPoint centerPoint = CGPointMake(midx, midy);
    [label setCenter:centerPoint];
    [view addSubview:label];
    [label fadeIn];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:label selector:@selector(fadeOut) userInfo:nil repeats:NO];
}


#pragma mark -
#pragma mark WOTipLabel()

+ (CSTipLabel*)tipLabelWithText:(NSString*)text
{
    UIFont* textFont = [UIFont systemFontOfSize:14];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGSize labelSize = CGSizeMake(WOTIPLABEL_WIDTH_LIMIT, WOTIPLABEL_HEIGHT_LIMIT);
    CGSize textSize = [text sizeWithFont:textFont
                       constrainedToSize:labelSize lineBreakMode:NSLineBreakByWordWrapping];
    int labelWidth = textSize.width + WOTIPLABEL_EDGE_WIDTH;
    int labelHeight = textSize.height + WOTIPLABEL_EDGE_HEIGHT;
    CGRect labelRect = CGRectMake( (screenRect.size.width - labelWidth)/2,
                                  (screenRect.size.height - labelHeight)/2,
                                  labelWidth, labelHeight);
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft
        || orientation == UIInterfaceOrientationLandscapeRight)
    {
        labelRect = CGRectMake( (screenRect.size.height - labelWidth ) / 2.0 ,
                                (screenRect.size.width - labelHeight) / 2.0,
                               labelWidth, labelHeight);
    }
    
    
    CSTipLabel* tipLabel = [[CSTipLabel alloc] initWithFrame:labelRect];
    [tipLabel setText:text];
    return [tipLabel autorelease];
}

- (void)fadeIn
{
    [self setAlpha:0];
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:0.5];
    [self setAlpha:1];
    [UIView commitAnimations];
}

- (void)fadeOut
{
    [UIView beginAnimations:@"fade out" context:nil];
    [UIView setAnimationDuration:0.8];
    [self setAlpha:0];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    [UIView commitAnimations];
}
@end
