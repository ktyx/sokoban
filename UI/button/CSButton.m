//
//  CSButton.m
//  BrandGuess
//
//  Created by daxin on 13-8-27.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "CSButton.h"
#import "CSSound.h"

@implementation CSButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

@end
