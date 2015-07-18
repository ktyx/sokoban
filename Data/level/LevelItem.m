//
//  LevelItem.m
//  Pushbox
//
//  Created by daxin on 13-11-16.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "LevelItem.h"

@implementation LevelItem
@synthesize level;
@synthesize score;
@synthesize isLocked;

- (id)initWithLevel:(int)alevel
{
    self = [super init];
    if (self)
    {
        level = alevel;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary*)adict
{
    self = [super init];
    if (self)
    {
        NSNumber* levelNum = [adict objectForKey:@"level"];
        NSNumber* scoreNum = [adict objectForKey:@"score"];
        NSNumber* lockNum = [adict objectForKey:@"islocked"];
        if (levelNum)
        {
            level = (int)[levelNum integerValue];
        }
        if (scoreNum)
        {
            score = (int)[scoreNum integerValue];
        }
        if (lockNum)
        {
            isLocked = [lockNum boolValue];
        }
    }
    return self;
}

- (NSDictionary*)dictionary
{
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInteger:level],@"level",
                          [NSNumber numberWithInteger:score],@"score",
                          [NSNumber numberWithBool:isLocked],@"islocked",nil];
    return dict;
}

@end
