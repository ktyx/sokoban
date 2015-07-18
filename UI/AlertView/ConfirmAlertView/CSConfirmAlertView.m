//
//  TipAlertView.m
//  BrandGuess
//
//  Created by Huang Daxin on 4/5/12.
//  Copyright 2012 Cute Screen Studio. All rights reserved.
//

#import "CSConfirmAlertView.h"
#import "CSDevice.h"

@implementation CSConfirmAlertView
@synthesize tipType;
@synthesize tipLabel;
@synthesize delegate;
@synthesize titleLabel;
@synthesize okButton;
@synthesize cancelButton;


+ (void)showConfirm:(NSString*)tipText withDelegate:(id<CSConfirmAlertViewDelegate>)aDelegate
{
    [CSConfirmAlertView showConfirm:tipText withDelegate:aDelegate atView:nil withTag:0];
}

+ (void)showConfirm:(NSString*)tipText withDelegate:(id<CSConfirmAlertViewDelegate>)aDelegate atView:(UIView*)aview withTag:(int)atag
{
    [CSConfirmAlertView showConfirm:tipText withDelegate:aDelegate atView:aview withTag:atag
                          withTitle:@"提示"];
}

+ (void)showConfirm:(NSString *)tipText withDelegate:(id<CSConfirmAlertViewDelegate>)aDelegate atView:(UIView *)aview withTag:(int)atag withTitle:(NSString*)atitle
{
    CSConfirmAlertView* tipView = [[[CSConfirmAlertView alloc] init] autorelease];
    [tipView.tipLabel setText:tipText];
    [tipView setDelegate:aDelegate];
    [tipView setTag:atag];
    [tipView.titleLabel setText:atitle];
    if (aview == nil)
    {
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if ([CSDevice currentDeviceType] == CSDevice_iPad)
        {
            if (orientation == UIInterfaceOrientationLandscapeLeft)
            {
                CGAffineTransform  rotate = CGAffineTransformMakeRotation(-M_PI_2);
                CGAffineTransform   move = CGAffineTransformMakeTranslation(-128, 128);
                CGAffineTransform t = CGAffineTransformConcat(rotate, move);
                [tipView setTransform:t];
            }else if(orientation == UIInterfaceOrientationLandscapeRight)
            {
                CGAffineTransform  rotate = CGAffineTransformMakeRotation(M_PI_2);
                CGAffineTransform   move = CGAffineTransformMakeTranslation(-128, 128);
                CGAffineTransform t = CGAffineTransformConcat(rotate, move);
                [tipView setTransform:t];
            }
        }
        [[[UIApplication sharedApplication] keyWindow] addSubview:tipView];
    }else
    {
        NSLog(@"confirm not nil");
        [aview addSubview:tipView];
    }
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithNibName:@"CSConfirmAlertView"];
    if (self) {
        // Initialization code.
        [titleLabel setText:CSLOCAL(@"TIP_TITLE")];
        [okButton setTitle:CSLOCAL(@"OK") forState:UIControlStateNormal];
        [cancelButton setTitle:CSLOCAL(@"Cancel") forState:UIControlStateNormal];
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
