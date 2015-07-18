//
//  TipAlertView.h
//  DrawSomeThing
//
//  Created by »Æ ´ïöÎ on 4/5/12.
//  Copyright 2012 The9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSAlertView.h"

#define  TipType_Login_Fail	1011


@protocol CSConfirmAlertViewDelegate;
@interface CSConfirmAlertView : CSAlertView
{

}

//+ (void)showTip:(NSString*)tipText withTitle:(NSString*)titleText;
//+ (void)showTip:(NSString*)tipText withType:(int)aTipType;
//+ (void)showTipOnHomeView:(NSString*)tipText;
+ (void)showConfirm:(NSString*)tipText withDelegate:(id<CSConfirmAlertViewDelegate>)aDelegate;
+ (void)showConfirm:(NSString*)tipText withDelegate:(id<CSConfirmAlertViewDelegate>)aDelegate atView:(UIView*)aview;
+ (void)showConfirm:(NSString*)tipText withDelegate:(id<CSConfirmAlertViewDelegate>)aDelegate atView:(UIView*)aview withTag:(int)atag;

- (IBAction)confirm:(id)sender;
- (IBAction)cancel:(id)sender;

@property (nonatomic, retain) IBOutlet UILabel*   tipLabel;
@property (nonatomic, assign)	int			tipType;
@property (nonatomic, assign) id<CSConfirmAlertViewDelegate> delegate;
@end


@protocol CSConfirmAlertViewDelegate <NSObject>
- (void) confirmAlertViewYesPressed:(CSConfirmAlertView*)alertview;
- (void) confirmAlertViewCancelPressed:(CSConfirmAlertView*)alertview;
@end