//
//  BoxMap.h
//  Pushbox
//
//  Created by daxin on 13-10-1.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AStarNode.h"

#define CELL_NUM       210
#define BOX_NUM        48
//#define TOTAL_LEVEL_NUM 200

typedef enum {
    MAPCELL_NONE = 0,
    MAPCELL_WALL,
    MAPCELL_FLOOR,
    MAPCELL_TARGET,
    MAPCELL_BOX,
}MapCellType;

@interface BoxMap : NSObject
{
    int       map[CELL_NUM];
    int       boxOrigin[BOX_NUM];
    int       boxPos[BOX_NUM];
}
- (id) initWithLevel:(int)alevel;
- (void) updateLevelData:(int)alevel;
- (void)setMap:(int[])amap withLen:(int)alen;
- (MapCellType)typeForCellAtIndex:(int)aindex;
- (NSArray*)pathFromOriginX:(int)sx originY:(int)sy
                    toDestx:(int)dx desty:(int)dy;

- (void)setBox:(int[])abox withLen:(int)alen;
- (CGSize) positionForBox:(int)aindex;
- (CGSize) originalPositionForBox:(int)aindex;
- (BOOL)boxExistAtIndex:(int)aindex;
- (void)setBoxAtIndex:(int)aindex toPositionX:(int)ax Y:(int)ay;
- (int) leastStepNum;

- (BOOL)isFinished;

@property (nonatomic, retain) NSArray*  cellArray;     //地图
@property (nonatomic, retain) NSArray*  answerArray;  //答案
@property (nonatomic, assign) CGSize    personStartPosition;    //人起始位置
@property (nonatomic, assign) int       level;
@property (nonatomic, assign) int       row;
@property (nonatomic, assign) int       column;
@property (nonatomic, assign) int       boxNum;
@property (nonatomic, assign) int       cellNum;
@end
