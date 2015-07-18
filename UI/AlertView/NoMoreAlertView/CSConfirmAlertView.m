//
//  TipAlertView.m
//  DrawSomeThing
//
//  Created by »Æ ´ïöÎ on 4/5/12.
//  Copyright 2012 The9. All rights reserved.
//

#import "CSConfirmAlertView.h"

@implementation CSConfirmAlertView
@synthesize tipType;
@synthesize tipLabel;
@synthesize delegate;

/*
+ (void)showTip:(NSString*)tipText withTitle:(NSString*)titleText
{
	CSConfirmAlertView* alertView = [[[CSConfirmAlertView alloc] init] autorelease];
	[alertView.tipLabel setText:tipText];
	NSArray* viewArray = [[[UIApplication sharedApplication] keyWindow] subviews];
	int viewCount = [viewArray count];
	if (viewCount < 1) return;
	UIView* last2View = [viewArray objectAtIndex:viewCount - 1];
	[last2View addSubview:alertView];
}

+ (void)showTip:(NSString*)tipText withType:(int)aTipType
{
	CSConfirmAlertView* alertView = [[[CSConfirmAlertView alloc] init] autorelease];
	[alertView.tipLabel setText:tipText];
	[alertView setTipType:aTipType];
	NSArray* viewArray = [[[UIApplication sharedApplication] keyWindow] subviews];
	int viewCount = [viewArray count];
	if (viewCount < 1) return;
	UIView* last2View = [viewArray objectAtIndex:viewCount - 1];
	[last2View addSubview:alertView];
}
 */

+ (void)showConfirm:(NSString*)tipText withDelegate:(id<CSConfirmAlertViewDelegate>)aDelegate
{
	CSConfirmAlertView* tipView = [[[CSConfirmAlertView alloc] init] autorelease];
	[tipView.tipLabel setText:tipText];
	[tipView setDelegate:aDelegate];
//	NSArray* viewArray = [[[UIApplication sharedApplication] keyWindow] subviews];
//	int viewCount = [viewArray count];
//	if (viewCount < 1) return;
//	UIView* last2View = [viewArray objectAtIndex:viewCount - 1];
//	[last2View addSubview:tipView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:tipView];
}

+ (void)showConfirm:(NSString*)tipText withDelegate:(id<CSConfirmAlertViewDelegate>)aDelegate atView:(UIView*)aview
{
    CSConfirmAlertView* tipView = [[[CSConfirmAlertView alloc] init] autorelease];
    [tipView.tipLabel setText:tipText];
    [tipView setDelegate:aDelegate];
    [aview addSubview:tipView];
}

+ (void)showConfirm:(NSString*)tipText withDelegate:(id<CSConfirmAlertViewDelegate>)aDelegate atView:(UIView*)aview withTag:(int)atag
{
    CSConfirmAlertView* tipView = [[[CSConfirmAlertView alloc] init] autorelease];
    [tipView.tipLabel setText:tipText];
    [tipView setDelegate:aDelegate];
    [tipView setTag:atag];
    [aview addSubview:tipView];
}

//+ (void)showTipOnHomeView:(NSString*)tipText
//{
//	TipAlertView* alertView = [[[TipAlertView alloc] init] autorelease];
//	[alertView.tipLabel setText:tipText];
//	[[[GameEngine GetInstance] m_pKITHomeView] addSubview:alertView];
//}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithNibName:@"CSConfirmAlertView"];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)close:(id)sender
{
	[super close:sender];
//	if (tipType == TipType_Login_Fail) 
//	{
//		NSLog(@"tip type login password worng");
//		[LoginAlertView show];
//	}
	if (delegate)
	{
		if ([delegate respondsToSelector:@selector(confirmAlertViewCancelPressed:)])
		{
			[delegate confirmAlertViewCancelPressed:self];
		}
	}
}

- (IBAction)confirm:(id)sender
{
    [super close:sender];
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(confirmAlertViewYesPressed:)])
        {
            [delegate confirmAlertViewYesPressed:self];
        }
    }
}

- (IBAction)cancel:(id)sender
{
    [super close:sender];
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(confirmAlertViewCancelPressed:)])
        {
            [delegate confirmAlertViewCancelPressed:self];
        }
    }
}

@end
