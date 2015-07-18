//
//  CSBarButtonItem.m
//  CuteScreenUI
//
//  Created by daxin on 13-4-29.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "CSBarButtonItem.h"
#import "CSColor.h"

@implementation CSBarButtonItem
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
      //  codes commented is used for setting background image for Navbar button
      //  UIImage* buttonBgImage = [UIImage imageNamed:@"navbar_button_bg.png"];
      //  [self setBackgroundImage:buttonBgImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        //[self setStyle:UIBarButtonItemStyleDone];
        [self setTintColor:[CSColor bgPurlpleColor]];
        
        
    }
    return self;
}
@end
