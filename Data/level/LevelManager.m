//
//  LevelManager.m
//  Pushbox
//
//  Created by daxin on 13-11-16.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "LevelManager.h"

static LevelManager* levelMgrInstance = nil;

@implementation LevelManager
@synthesize totalLevel;
@synthesize currentLevel;

+ (LevelManager*) sharedInstance
{
    if (levelMgrInstance == nil)
    {
        levelMgrInstance = [[LevelManager alloc] init];
    }
    return levelMgrInstance;
}

- (void)initialize
{
    
}

- (void)unlockLevel:(int)alevel
{
    LevelItem* item = [levelArray objectAtIndex:alevel];
    [item setIsLocked:NO];
    currentLevel = [item level];
}

- (BOOL)isUnlock:(int)alevel
{
    LevelItem* item = [levelArray objectAtIndex:alevel];
    return ![item isLocked];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        levelArray = [[NSMutableArray alloc] init];
        
        NSString* filePath = [self filePath];
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        if (isExist)
        {
            NSDictionary* fileDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
            if (fileDict)
            {
                NSArray* levels = [fileDict objectForKey:@"levels"];
                NSNumber* totalNum = [fileDict objectForKey:@"total"];
                NSNumber* current = [fileDict objectForKey:@"current"];
                if (levels)
                {
                    for (NSDictionary* dict in levels)
                    {
                        LevelItem* item = [[LevelItem alloc] initWithDictionary:dict];
                        [levelArray addObject:item];
                        [item release];
                    }
                }
                if (totalNum)
                {
                    totalLevel = (int)[totalNum integerValue];
                }
                if (current)
                {
                    currentLevel = (int)[current integerValue];
                }
            }
        }else
        {
            totalLevel = TOTAL_LEVEL_NUM;
            currentLevel = 1;
            for (int i = 1; i <= TOTAL_LEVEL_NUM ; i++)
            {
                LevelItem* item = [[LevelItem alloc] initWithLevel:i];
                [item setIsLocked:YES];
                [levelArray addObject:item];
                [item release];
            }
            LevelItem* item1 = [levelArray objectAtIndex:0];
            [item1 setIsLocked:NO];
            [self saveToDocument];
        }
    }
    return self;
}

- (NSString*) filePath
{
    NSArray* folders = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* path = [[folders objectAtIndex:0] stringByAppendingPathComponent:LEVEL_FILE_NAME];
    return path;
}

- (void) saveToDocument
{
    NSMutableArray* lArray = [[NSMutableArray alloc] init];
    for (LevelItem* it in levelArray)
    {
        [lArray addObject:[it dictionary]];
    }
    NSDictionary* fileDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              lArray,@"levels",
                              [NSNumber numberWithInteger:TOTAL_LEVEL_NUM],@"total",
                              [NSNumber numberWithInteger:currentLevel],@"current",
                              nil];
    [lArray release];
    BOOL issuc = [fileDict writeToFile:[self filePath] atomically:YES];
    issuc ? NSLog(@"SAVE SUCCESS ") : NSLog(@"SAVE FAILED ");
}

- (LevelItem*) levelItemAtIndex:(int)aindex
{
    if (aindex < [levelArray count])
    {
        LevelItem* item = [levelArray objectAtIndex:aindex];
        return item;
    }
    return nil;
}


@end
