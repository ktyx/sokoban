//
//  LevelManager.h
//  Pushbox
//
//  Created by daxin on 13-11-16.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelItem.h"

#define LEVEL_FILE_NAME    @"LEVEL_FILE_1_0.plist"
#define TOTAL_LEVEL_NUM    60//112

@interface LevelManager : NSObject
{
    NSMutableArray*      levelArray;
}

+ (LevelManager*) sharedInstance;
- (NSString*) filePath;
- (void) saveToDocument;
- (LevelItem*) levelItemAtIndex:(int)aindex;
- (void)initialize;
- (void)unlockLevel:(int)alevel;
- (BOOL)isUnlock:(int)alevel;

@property (nonatomic, assign) int   totalLevel;
@property (nonatomic, assign) int   currentLevel;
@end
