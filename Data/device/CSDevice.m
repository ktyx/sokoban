//
//  CSDevice.m
//  BrandGuess
//
//  Created by daxin on 13-6-18.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "CSDevice.h"

@implementation CSDevice
+ (CSDeviceType) currentDeviceType
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (screenRect.size.height == 480)
    {
        return CSDevice_iPhone4;
    }else if(screenRect.size.height == 1024)
    {
        return CSDevice_iPad;
    }
    return CSDevice_iPhone5;
}


+ (BOOL) isPad
{
    return  ([CSDevice currentDeviceType] == CSDevice_iPad);
}

+ (BOOL) isPhone4
{
    return  ([CSDevice currentDeviceType] == CSDevice_iPhone4);
}

+ (BOOL) isPhone5
{
    return  ([CSDevice currentDeviceType] == CSDevice_iPhone5);
}

+ (NSString*)univesal_xib:(NSString*)xibname
{
    CSDeviceType curType = [CSDevice currentDeviceType];
    if (!xibname || [xibname length] == 0)
    {
        return nil;
    }
    NSString* res = nil;
    switch (curType)
    {
        /*
        case CSDevice_iPad:
        {
            res = [NSString stringWithFormat:@"%@_pad",xibname];
        }
            break;
         */
            
        case CSDevice_iPhone5:
        {
            res = xibname;
        }
            break;
        
        case CSDevice_iPhone4:
        {
            res = [NSString stringWithFormat:@"%@_4",xibname];
        }
            break;
            
        default:
            res = xibname;
            break;
    }
    return res;
}


+ (CGRect)backgroundRect
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    float width = 0, height = 0;
    if ((orientation == UIInterfaceOrientationLandscapeLeft)
        || (orientation == UIInterfaceOrientationLandscapeRight))
    {
        width = (screenBounds.size.width > screenBounds.size.height) ? screenBounds.size.width : screenBounds.size.height;
        height = (screenBounds.size.width > screenBounds.size.height) ? screenBounds.size.height : screenBounds.size.width;
    }else
    {
        width = (screenBounds.size.width > screenBounds.size.height) ? screenBounds.size.height : screenBounds.size.width;
        height = (screenBounds.size.width > screenBounds.size.height) ? screenBounds.size.width : screenBounds.size.height;
    }
    
    CGRect bgRect = CGRectMake(0, 0, width, height);
    return bgRect;
}

+ (int)    screenWidth
{
    CGRect srect = [CSDevice backgroundRect];
    return srect.size.width;
}

+ (int)    screenHeight
{
    CGRect srect = [CSDevice backgroundRect];
    return srect.size.height;
}

+ (BOOL)   isSystemVersionLaterThan:(float)aver
{
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= aver)
    {
        return YES;
    }
    return NO;
}
@end
