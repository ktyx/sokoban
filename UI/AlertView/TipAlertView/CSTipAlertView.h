//
//  TipAlertView.h
//  sokoban
//
//  Created by Huang Daxin on 4/5/12.
//  Copyright 2012 daxin. All rights reserved.
//
//  not support for autorotate

#import <UIKit/UIKit.h>
#import "CSAlertView.h"

#define  TipType_Login_Fail	1011


@interface CSTipAlertView : CSAlertView
{

}

+ (void)showTip:(NSString*)tipText withTitle:(NSString*)titleText;
+ (void)showTip:(NSString*)tipText withType:(int)aTipType;

+ (void)showTip:(NSString*)tipText atView:(UIView*)aview;

@property (nonatomic, retain) IBOutlet UILabel*   tipLabel;
@property (nonatomic, assign)	int			tipType;
@property (nonatomic, retain) IBOutlet UIButton*  okButton;
@property (nonatomic, retain) IBOutlet UILabel*    titleLabel;
@end

