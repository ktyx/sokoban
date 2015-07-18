//
//  BoxMenuButton.m
//  Pushbox
//
//  Created by daxin on 13-11-16.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "BoxLevelButton.h"
#import "CSBrownLabel.h"

@implementation BoxLevelButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect labelRect = CGRectMake(0, LEVEL_LABEL_ORIGIN_Y, BOX_MENU_BUTTON_WIDTH, LEVEL_LABEL_HEIGHT);
        levelLabel = [[CSBrownLabel alloc] initWithFrame:labelRect];
        [levelLabel setBackgroundColor:[UIColor clearColor]];
        [levelLabel setTextAlignment:NSTextAlignmentCenter];
        UIFont* levelFont = [UIFont boldSystemFontOfSize:LEVEL_LABEL_FONT_SIZE];
        [levelLabel setFont:levelFont];
        [self addSubview:levelLabel];
        [levelLabel release];
        
        UIImage* starImg = [UIImage imageNamed:@"menu_star_1.png"];
        int x = 12;
        CGRect starRect1 = CGRectMake(x, LEVEL_LABEL_ORIGIN_Y + LEVEL_LABEL_HEIGHT,
                                      MENU_STAR_SIZE, MENU_STAR_SIZE);
        starView1 = [[UIImageView alloc] initWithFrame:starRect1];
        [starView1 setImage:starImg];
        [self addSubview:starView1];
        [starView1 release];
        [starView1 setHidden:YES];
        
        x += (MENU_STAR_SIZE - 1) ;
        CGRect starRect2 = CGRectMake(x, LEVEL_LABEL_ORIGIN_Y + LEVEL_LABEL_HEIGHT,
                                      MENU_STAR_SIZE, MENU_STAR_SIZE);
        starView2 = [[UIImageView alloc] initWithFrame:starRect2];
        [starView2 setImage:starImg];
        [self addSubview:starView2];
        [starView2 release];
        [starView2 setHidden:YES];
        
        x += ( MENU_STAR_SIZE - 1) ;
        CGRect starRect3 = CGRectMake(x, LEVEL_LABEL_ORIGIN_Y + LEVEL_LABEL_HEIGHT,
                                      MENU_STAR_SIZE, MENU_STAR_SIZE);
        starView3 = [[UIImageView alloc] initWithFrame:starRect3];
        [starView3 setImage:starImg];
        [self addSubview:starView3];
        [starView3 release];
        [starView3 setHidden:YES];
    }
    return self;
}

- (void)updateWithLevelItem:(LevelItem*)aitem
{
    NSString* levelStr = [NSString stringWithFormat:@"%d",[aitem level]];
    [levelLabel setText:levelStr];
    
    if ([aitem score] > 0)
    {
        [starView1 setHidden:NO];
    }
    if ([aitem score] > 1)
    {
        [starView2 setHidden:NO];
    }
    if ([aitem score] > 2)
    {
        [starView3 setHidden:NO];
    }
    if ([aitem isLocked])
    {
        UIImage* lockImg = [UIImage imageNamed:@"menu_locked.png"];
        [self setImage:lockImg forState:UIControlStateNormal];
        [self setUserInteractionEnabled:NO];
    }else
    {
        UIImage* unlockImg = [UIImage imageNamed:@"menu_unlocked.png"];
        [self setImage:unlockImg forState:UIControlStateNormal];
        [self setUserInteractionEnabled:YES];
    }
}

@end
