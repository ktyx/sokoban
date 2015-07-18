//
//  WOTipLabel.h
//  CustomSomeUI
//
//  Created by Huang Daxin on 13-1-14.
//  Copyright (c) 2013 Cute Screen Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WOTIPLABEL_WIDTH_LIMIT  200
#define WOTIPLABEL_HEIGHT_LIMIT 100
#define WOTIPLABEL_EDGE_WIDTH   40
#define WOTIPLABEL_EDGE_HEIGHT  10

@interface CSTipLabel : UILabel
+ (void) showText:(NSString*)text;
+ (void) showText:(NSString*)text atView:(UIView*)view;
+ (void) showTextUponKeyboard:(NSString*)text atView:(UIView*)view;
@end
