//
//  CSGlobal.h
//  BrandGuess
//
//  Created by daxin on 13-6-18.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAppID          @"709552885"
#define KAppAddress     @"http://itunes.apple.com/app/id709552885"

@interface CSGlobal : NSObject
+ (NSString*) globalAppAddressWithAppID:(NSString*)appid;
+ (NSString*)localTableName;
+ (NSString*) localLanguage;
+ (NSString*)  systemLaunage;
@end
