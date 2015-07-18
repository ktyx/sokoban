//
//  CSGlobal.m
//  BrandGuess
//
//  Created by daxin on 13-6-18.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "CSGlobal.h"

@implementation CSGlobal
+ (NSString*) globalAppAddressWithAppID:(NSString*)appid
{
    if (appid && [appid length] > 0)
    {
        return [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@",appid];
    }
    return nil;
}

+ (NSString*)localTableName
{
    NSString* sysLaunage = [CSGlobal systemLaunage];
    if([sysLaunage isEqualToString:@"zh-Hans"]
       || [sysLaunage isEqualToString:@"zh-Hant"])
    {
        return @"cn_brands";
    }else if([sysLaunage isEqualToString:@"en"]
             || [sysLaunage isEqualToString:@"en-GB"])
    {
        return @"us_brands";
    }else if([sysLaunage isEqualToString:@"ja"])
    {
        return @"ja_brands";
    }else if([sysLaunage isEqualToString:@"it"])
    {
        return @"it_brands";
    }else if([sysLaunage isEqualToString:@"de"])
    {
        return @"de_brands";
    }else if([sysLaunage isEqualToString:@"fr"])
    {
        return @"fr_brands";
    }else if([sysLaunage isEqualToString:@"uk"])
    {
        return @"uk_brands";
    }
    return @"us_brands";
}

+ (NSString*) localLanguage
{
    NSString* sysLaunage = [CSGlobal systemLaunage];
    if([sysLaunage isEqualToString:@"zh-Hans"]
       || [sysLaunage isEqualToString:@"zh-Hant"])
    {
        return @"zh";
    }else if([sysLaunage isEqualToString:@"en"]
             || [sysLaunage isEqualToString:@"en-GB"])
    {
        return @"en";
    }else if([sysLaunage isEqualToString:@"ja"])
    {
        return @"ja";
    }else if([sysLaunage isEqualToString:@"it"])
    {
        return @"it";
    }else if([sysLaunage isEqualToString:@"de"])
    {
        return @"de";
    }else if([sysLaunage isEqualToString:@"fr"])
    {
        return @"fr";
    }else if([sysLaunage isEqualToString:@"uk"])
    {
        return @"uk";
    }
    return @"en";
}

+ (NSString*) systemLaunage
{
    NSArray* languageArray = [NSLocale preferredLanguages];
    NSString* language = nil;
    if ([languageArray count] > 0)
    {
        language = [languageArray objectAtIndex:0];
    }

    return language;
}
@end
