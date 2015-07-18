//
//  CSDevice.h
//  BrandGuess
//
//  Created by daxin on 13-6-18.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CSDevice_iPhone5 = 0,
    CSDevice_iPhone4,
    CSDevice_iPad,
    CSDevice_Unknown,
}CSDeviceType;

@interface CSDevice : NSObject
+ (CSDeviceType) currentDeviceType;
+ (BOOL) isPad;
+ (BOOL) isPhone4;
+ (BOOL) isPhone5;

+ (NSString*)univesal_xib:(NSString*)xibname;

+ (CGRect) backgroundRect;
+ (int)    screenWidth;
+ (int)    screenHeight;

+ (BOOL)   isSystemVersionLaterThan:(float)aver;
@end
