//
//  BoxMapCell.m
//  Pushbox
//
//  Created by daxin on 13-10-1.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "BoxMapCell.h"

@implementation BoxMapCell

@synthesize row;
@synthesize column;
@synthesize type;

@synthesize f;
@synthesize g;
@synthesize h;
@synthesize fatherCell;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)setType:(MapCellType)atype
{
    type = atype;
    switch (type)
    {
        case MAPCELL_NONE:
            [self setUserInteractionEnabled:NO];
            break;
            
        case MAPCELL_FLOOR:
        {
            UIImage* floorImg = [UIImage imageNamed:@"btn_floor.png"];
            [self setImage:floorImg forState:UIControlStateNormal];
        }
            break;
            
        case MAPCELL_TARGET:
        {
            UIImage* targetImg = [UIImage imageNamed:@"btn_target.png"];
            [self setImage:targetImg forState:UIControlStateNormal];
        }
            break;
            
        case MAPCELL_WALL:
        {
            UIImage* wallImg = [UIImage imageNamed:@"p_brick.png"];
            [self setImage:wallImg forState:UIControlStateNormal];
            [self setUserInteractionEnabled:NO];
        }
            break;
            
        case MAPCELL_BOX:
        {
            UIImage* boxBtnImg = [UIImage imageNamed:@"p_box.png"];
            [self setImage:boxBtnImg forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    [self setNeedsDisplay];
}

@end
