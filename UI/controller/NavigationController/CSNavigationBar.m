//
//  CSNavigationBar.m
//  CuteScreenUI
//
//  Created by daxin on 13-4-29.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "CSNavigationBar.h"
#import <QuartzCore/QuartzCore.h>
#import "CSDevice.h"

@implementation CSNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage* navBarBgImage = nil;
        if ([CSDevice isPad])
        {
            navBarBgImage = [UIImage imageNamed:@"navbar-pad.png"];
        }else
        {
            navBarBgImage = [UIImage imageNamed:@"navbar.png"];
        }
        [self setBackgroundImage:navBarBgImage forBarMetrics:UIBarMetricsDefault];
        //[self.layer setContentsScale:0.5];
        
        // 图片缩放不对
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        //UIImage* navBarBgImage = [UIImage imageNamed:@"navbar.png"];
        UIImage* navBarBgImage = nil;
        if ([CSDevice isPad])
        {
            navBarBgImage = [UIImage imageNamed:@"navbar-pad.png"];
        }else
        {
            navBarBgImage = [UIImage imageNamed:@"navbar.png"];
        }
        [self setBackgroundImage:navBarBgImage forBarMetrics:UIBarMetricsDefault];
        //[self.layer setContentsScale:0.5];
    }
    return self;
}

@end
