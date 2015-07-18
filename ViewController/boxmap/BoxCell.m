//
//  BoxCell.m
//  Pushbox
//
//  Created by daxin on 13-11-16.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "BoxCell.h"

@implementation BoxCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setType:MAPCELL_BOX];
        UIImage* tickImg = [UIImage imageNamed:@"box_correct.png"];
        CGSize tickSize = CGSizeMake(tickImg.size.width/2.0, tickImg.size.height/2.0);
        CGRect tickRect = CGRectMake((self.bounds.size.width - tickSize.width)/2.0,
                                     (self.bounds.size.height - tickSize.height)/2.0,
                                     tickSize.width, tickSize.height);
        tickView = [[UIImageView alloc] initWithFrame:tickRect];
        [tickView setFrame:tickRect];
        [tickView setImage:tickImg];
        [tickView setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:tickView];
        [tickView setHidden:YES];
    }
    return self;
}

- (void)setBoxPushIntoTarget:(BOOL)isin
{
    if (isin)
    {
        [tickView setHidden:NO];
    }else
    {
        [tickView setHidden:YES];
    }
}

- (void)dealloc
{
    [tickView release];
    [super dealloc];
}

@end
