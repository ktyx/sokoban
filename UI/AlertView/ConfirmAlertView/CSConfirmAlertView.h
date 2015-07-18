//
//  TipAlertView.h
//  BrandGuess
//
//  Created by Huang Daxin on 4/5/12.
//  Copyright 2012 Cute Screen Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSAlertView.h"

#define  TipType_Login_Fail	1011


@protocol CSConfirmAlertViewDelegate;
@interface CSConfirmAlertView : CSAlertView
{

}

+ (void)showConfirm:(NSString*)tipText withDelegate:(id<CSConfirmAlertViewDelegate>)aDelegate;
+ (void)showConfirm:(NSString*)tipText withDelegate:(id<CSConfirmAlertViewDelegate>)aDelegate atView:(UIView*)aview withTag:(int)atag;
+ (void)showConfirm:(NSString *)tipText withDelegate:(id<CSConfirmAlertViewDelegate>)aDelegate atView:(UIView *)aview withTag:(int)atag withTitle:(NSString*)atitle;

- (IBAction)confirm:(id)sender;
- (IBAction)cancel:(id)sender;

@property (nonatomic, retain) IBOutlet UILabel*   tipLabel;
@property (nonatomic, assign)	int			tipType;
@property (nonatomic, assign) id<CSConfirmAlertViewDelegate> delegate;
@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet UIButton* okButton;
@property (nonatomic, retain) IBOutlet UIButton* cancelButton;
@end


@protocol CSConfirmAlertViewDelegate <NSObject>
- (void) confirmAlertViewYesPressed:(CSConfirmAlertView*)alertview;
- (void) confirmAlertViewCancelPressed:(CSConfirmAlertView*)alertview;
@end