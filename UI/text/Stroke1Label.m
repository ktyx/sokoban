//
//  Stroke1Label.m
//  Pushbox
//
//  Created by daxin on 14-1-6.
//  Copyright (c) 2014年 daxin. All rights reserved.
//

#import "Stroke1Label.h"

@implementation Stroke1Label

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect
{
    float fontSize = [self.font  pointSize];
    int pinkLineWidth = fontSize * 0.14;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, pinkLineWidth);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    
    CGContextSetTextDrawingMode(ctx, kCGTextStroke);
    UIColor* brownColor = [UIColor colorWithRed:58/255.0 green:35/255.0 blue:10/255.0 alpha:1];
    [self setTextColor:brownColor];
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(ctx, kCGTextFill);
    self.textColor = [UIColor whiteColor];
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
}

@end
