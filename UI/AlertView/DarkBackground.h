//
//  DarkBackground.h
//
//  Created by Huang Daxin on 4/1/12.
//  Copyright 2012 daxin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DarkBackground : UIView 
{
//	int					darkenCount;
	NSMutableArray*		shownViewArray;
}

+ (id)sharedInstance;
+ (void) darken;
+ (void) brighten;

+ (void) darkenAtView:(UIView*) aview;
+ (void) brightenAtView:(UIView*)aview;
- (void) updateLayout;

//@property (nonatomic, assign) BOOL	isDarken;
//@property (nonatomic, assign) int	darkenCount;
@property (nonatomic, retain) NSMutableArray*	shownViewArray;
@end
