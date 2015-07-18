//
//  KITAlertView.h
//  sokoban
//
//  Created by Huang Daxin on 3/31/12.
//  Copyright 2012 daxin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CSAlertView : UIView
{
	UIView*		alertView;
	CGRect		displayRect;
}
@property (nonatomic, retain,readonly) UIView* alertView;


- (id)initWithNibName:(NSString*)nibName;
- (IBAction)close:(id)sender;
- (void)close;
- (void)closeWithoutAnimation;

- (void)moveForEdit:(UITextField*)textField;
- (void)moveForEdit2:(UITextField*)textField;

- (void)moveBackToOriginal;
- (void)startAnimating;

- (void) alertViewZoomIn;
- (void) alertViewZoomOut;
@end


