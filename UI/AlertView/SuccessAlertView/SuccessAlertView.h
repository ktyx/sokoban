//
//  TipAlertView.h
//
//  Created by daxin on 4/5/12.
//  Copyright daxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSAlertView.h"

#define  TipType_Login_Fail	1011


@protocol SuccessAlertViewDelegate;
@interface SuccessAlertView : CSAlertView
{

}

+ (void)showConfirm:(NSString*)tipText withDelegate:(id<SuccessAlertViewDelegate>)aDelegate;

- (IBAction)confirm:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)next:(id)sender;

@property (nonatomic, retain) IBOutlet UILabel*   tipLabel;
@property (nonatomic, assign)	int			tipType;
@property (nonatomic, assign) id<SuccessAlertViewDelegate> delegate;

@property (nonatomic, retain) IBOutlet UIButton* nextButton;
@property (nonatomic, retain) IBOutlet UILabel* textLabel;
@end


@protocol SuccessAlertViewDelegate <NSObject>
- (void) successAlertViewYesPressed:(SuccessAlertView*)alertview;
- (void) successAlertViewCancelPressed:(SuccessAlertView*)alertview;
@end