//
//  LevelItem.h
//  Pushbox
//
//  Created by daxin on 13-11-16.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelItem : NSObject
@property (nonatomic, assign) int   level;
@property (nonatomic, assign) int   score;
@property (nonatomic, assign) BOOL  isLocked;

- (id)initWithLevel:(int)alevel;
- (id)initWithDictionary:(NSDictionary*)adict;
- (NSDictionary*)dictionary;
@end
