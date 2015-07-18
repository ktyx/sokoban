//
//  BoxMap.m
//  Pushbox
//
//  Created by daxin on 13-10-1.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "BoxMap.h"


@implementation BoxMap
@synthesize cellArray;
@synthesize answerArray;
@synthesize personStartPosition;
@synthesize level;
@synthesize row;
@synthesize column;
@synthesize boxNum;
@synthesize cellNum;

- (id) initWithLevel:(int)alevel
{
    self = [super init];
    if (self)
    {
        [self updateLevelData:alevel];
    }
    return self;
}

- (void) updateLevelData:(int)alevel
{
    level = alevel;
    switch (level)
    {
        case 1:
        {
            [self setPersonStartPosition:CGSizeMake(2, 3)];
            int map1array[] = {1,1,1,1,1,1,1,1,
                1,2,2,2,2,2,2,1,
                1,2,2,2,2,2,2,1,
                1,2,2,2,2,3,2,1,
                1,2,2,2,2,2,2,1,
                1,2,2,2,2,2,2,1,
                1,1,1,1,1,1,1,1};
            [self setMap:map1array withLen:56];
            int box1Array[] = {3,3};
            [self setBox:box1Array withLen:2];
            [self setRow:7];
            [self setColumn:8];
            [self setBoxNum:1];
        }
            break;
            
        case 2:
        {
            [self setPersonStartPosition:CGSizeMake(5, 2)];
            int map1array[] = {1,1,1,1,1,1,1,1,
                1,2,2,2,2,2,2,1,
                1,3,2,2,2,2,2,1,
                1,2,2,2,2,2,2,1,
                1,1,1,1,2,2,2,1,
                0,0,0,1,2,3,2,1,
                0,0,0,1,1,1,1,1};
            [self setMap:map1array withLen:56];
            int box1Array[] = {3,2,5,3};
            [self setBox:box1Array withLen:4];
            [self setRow:7];
            [self setColumn:8];
            [self setBoxNum:2];
        }
            break;
            
        case 3:
        {
            [self setPersonStartPosition:CGSizeMake(3, 3)];
            int map1array[] = {1,1,1,1,1,1,1,1,
                1,2,2,2,2,2,2,1,
                1,2,3,2,2,3,2,1,
                1,2,2,2,2,2,2,1,
                1,2,2,2,2,1,1,1,
                1,2,3,2,2,1,0,0,
                1,2,2,2,2,1,0,0,
                1,1,1,1,1,1,0,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {2,3,5,3,3,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 4:
        {
            [self setRow:7];
            [self setColumn:6];
            [self setBoxNum:2];
            [self setPersonStartPosition:CGSizeMake(2, 3)];
            int mapArray[] =
            {
                1,1,1,1,0,0,
                1,2,3,1,0,0,
                1,2,2,1,1,1,
                1,3,2,2,2,1,
                1,2,2,2,2,1,
                1,2,2,1,1,1,
                1,1,1,1,0,0,
            };
            [self setMap:mapArray withLen:42];
            int boxArray[] = {1,3,3,4};
            [self setBox:boxArray withLen:4];
        }
            break;
            
        case 5:
        {
            [self setRow:9];
            [self setColumn:9];
            [self setBoxNum:3];
            [self setPersonStartPosition:CGSizeMake(1, 1)];
            int mapArray[] =
            {
                1,1,1,1,1,0,0,0,0,
                1,2,2,2,1,0,0,0,0,
                1,2,2,2,1,0,1,1,1,
                1,2,2,2,1,0,1,3,1,
                1,1,1,2,1,1,1,3,1,
                0,1,1,2,2,2,2,3,1,
                0,1,2,2,2,1,2,2,1,
                0,1,2,2,2,1,1,1,1,
                0,1,1,1,1,1,0,0,0,
            };
            [self setMap:mapArray withLen:81];
            int boxArray[] = {2,2,3,2,2,3};
            [self setBox:boxArray withLen:6];
        }
            break;
            
        case 6:
        {
            [self setPersonStartPosition:CGSizeMake(4, 4)];
            int map1array[] = {0,0,1,1,1,0,0,0,
                0,0,1,3,1,0,0,0,
                0,0,1,2,1,1,1,1,
                1,1,1,2,2,2,3,1,
                1,3,2,2,2,1,1,1,
                1,1,1,1,2,1,0,0,
                0,0,0,1,3,1,0,0,
                0,0,0,1,1,1,0,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {3,3,5,3,3,4,4,5};
            [self setBox:box1Array withLen:8];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:4];
        }
            break;
            
        case 7:
        {
            [self setPersonStartPosition:CGSizeMake(4, 1)];
            int map1array[] = {0,0,0,1,1,1,1,1,
                1,1,1,1,2,2,2,1,
                1,2,2,2,3,3,2,1,
                1,2,2,2,2,2,2,1,
                1,2,2,1,1,1,1,1,
                1,1,1,1,0,0,0,0};
            [self setMap:map1array withLen:48];
            int box1Array[] = {3,2,4,2};
            [self setBox:box1Array withLen:4];
            [self setRow:6];
            [self setColumn:8];
            [self setBoxNum:2];
        }
            break;
            
        case 8:
        {
            [self setPersonStartPosition:CGSizeMake(6, 4)];
            int map1array[] = {1,1,1,1,1,1,1,1,
                1,2,2,1,2,2,2,1,
                1,2,2,2,3,3,2,1,
                1,2,3,2,2,3,2,1,
                1,2,3,3,2,2,2,1,
                1,2,2,2,1,2,2,1,
                1,1,1,1,1,1,1,1};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,2,3,2,4,2,3,4,4,4,5,4};
            [self setBox:box1Array withLen:12];
            [self setRow:7];
            [self setColumn:8];
            [self setBoxNum:6];
        }
            break;
            
        case 9:
        {
            [self setPersonStartPosition:CGSizeMake(4, 1)];
            int map1array[] = {1,1,1,1,1,1,1,1,1,
                1,2,2,2,2,2,2,2,1,
                1,3,2,2,3,2,2,3,1,
                1,2,3,3,2,3,3,2,1,
                1,2,2,2,1,2,2,2,1,
                1,1,1,1,1,1,1,1,1};
            [self setMap:map1array withLen:54];
            int box1Array[] = {1,3,2,2,3,2,4,3,5,2,6,2,7,3};
            [self setBox:box1Array withLen:14];
            [self setRow:6];
            [self setColumn:9];
            [self setBoxNum:7];
        }
            break;
            
        case 10:
        {
            [self setPersonStartPosition:CGSizeMake(2, 1)];
            int map1array[] = {0,1,1,1,1,0,0,0,
                0,1,2,2,1,1,1,0,
                0,1,2,2,2,2,1,0,
                1,1,1,2,1,2,1,1,
                1,3,1,2,1,2,2,1,
                1,3,2,2,2,1,2,1,
                1,3,2,2,2,2,2,1,
                1,1,1,1,1,1,1,1};
            [self setMap:map1array withLen:64];
            int box1Array[] = {3,2,2,5,5,6};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 11:
        {
            [self setPersonStartPosition:CGSizeMake(6, 4)];
            int map1array[] = {0,0,1,1,1,1,0,0,0,
                1,1,1,2,2,1,1,1,1,
                1,2,2,2,2,2,2,2,1,
                1,2,1,2,2,1,2,2,1,
                1,2,3,2,3,1,2,2,1,
                1,1,1,1,1,1,1,1,1};
            [self setMap:map1array withLen:54];
            int box1Array[] = {6,2,6,3};
            [self setBox:box1Array withLen:4];
            [self setRow:6];
            [self setColumn:9];
            [self setBoxNum:2];
        }
            break;
            
        case 12:
        {
            [self setPersonStartPosition:CGSizeMake(4, 2)];
            int map1array[] =
            {1,1,1,1,1,1,
             1,2,2,2,2,1,
             1,3,2,2,2,1,
             1,3,2,1,2,1,
             1,1,2,2,3,1,
             0,1,2,1,2,1,
             0,1,2,2,2,1,
             0,1,1,1,1,1};
            [self setMap:map1array withLen:48];
            int box1Array[] = {2,2,3,4,4,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:6];
            [self setBoxNum:3];
        }
            break;
            
        case 13:
        {
            [self setPersonStartPosition:CGSizeMake(3, 6)];
            int map1array[] =
               {0,1,1,1,1,1,
                1,1,2,2,2,1,
                1,2,2,2,2,1,
                1,2,2,1,3,1,
                1,1,2,2,2,1,
                0,1,2,2,3,1,
                0,1,1,2,3,1,
                0,0,1,1,1,1};
            [self setMap:map1array withLen:48];
            int box1Array[] = {3,4,3,5,4,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:6];
            [self setBoxNum:3];
        }
            break;
            
        case 14:
        {
            [self setPersonStartPosition:CGSizeMake(3, 6)];
            int map1array[] =
               {0,1,1,1,1,0,
                0,1,2,2,1,0,
                1,1,3,2,1,0,
                1,2,3,2,1,1,
                1,2,2,2,2,1,
                1,1,2,2,2,1,
                0,1,3,2,2,1,
                0,1,1,1,1,1};
            [self setMap:map1array withLen:48];
            int box1Array[] = {2,5,3,3,3,4};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:6];
            [self setBoxNum:3];
        }
            break;
            
        case 15:
        {
            [self setPersonStartPosition:CGSizeMake(4, 6)];
            int map1array[] =
               {0,1,1,1,1,0,
                0,1,2,2,1,1,
                1,1,3,2,2,1,
                1,3,2,2,3,1,
                1,2,2,2,2,1,
                1,1,1,2,2,1,
                0,0,1,2,2,1,
                0,0,1,1,1,1};
            [self setMap:map1array withLen:48];
            int box1Array[] = {3,4,3,5,4,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:6];
            [self setBoxNum:3];
        }
            break;
            
        case 16:
        {
            [self setPersonStartPosition:CGSizeMake(1, 3)];
            int map1array[] =
               {1,1,1,1,1,1,1,
                1,2,3,2,3,2,1,
                1,2,2,1,2,2,1,
                1,2,2,3,2,2,1,
                1,1,2,2,2,1,1,
                0,1,2,2,2,1,0,
                0,1,1,1,1,1,0};
            [self setMap:map1array withLen:49];
            int box1Array[] = {4,1,2,3,3,3};
            [self setBox:box1Array withLen:6];
            [self setRow:7];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 17:
        {
            [self setPersonStartPosition:CGSizeMake(3, 5)];
            int map1array[] =
               {0,1,1,1,1,1,1,
                1,1,2,2,3,2,1,
                1,2,3,2,1,2,1,
                1,2,3,2,2,2,1,
                1,2,2,1,2,1,1,
                1,1,2,2,2,1,0,
                0,1,1,1,1,1,0};
            [self setMap:map1array withLen:49];
            int box1Array[] = {2,2,3,3,4,4};
            [self setBox:box1Array withLen:6];
            [self setRow:7];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 18:
        {
            [self setPersonStartPosition:CGSizeMake(4, 1)];
            int map1array[] =
               {1,1,1,1,1,1,1,
                1,2,2,3,2,2,1,
                1,2,1,3,1,2,1,
                1,2,2,2,2,2,1,
                1,3,2,2,2,1,1,
                1,2,2,1,1,1,0,
                1,1,1,1,0,0,0};
            [self setMap:map1array withLen:49];
            int box1Array[] = {2,4,3,4,4,3};
            [self setBox:box1Array withLen:6];
            [self setRow:7];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 19:
        {
            [self setPersonStartPosition:CGSizeMake(4, 3)];
            int map1array[] =
               {1,1,1,1,1,0,0,
                1,3,2,3,1,1,1,
                1,3,1,2,2,2,1,
                1,2,2,2,2,2,1,
                1,2,2,1,2,2,1,
                1,1,2,2,2,1,1,
                0,1,1,1,1,1,0};
            [self setMap:map1array withLen:49];
            int box1Array[] = {3,2,4,2,2,4};
            [self setBox:box1Array withLen:6];
            [self setRow:7];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 20:
        {
            [self setPersonStartPosition:CGSizeMake(3, 5)];
            int map1array[] =
               {1,1,1,1,1,0,0,
                1,3,2,2,1,0,0,
                1,2,1,2,1,1,1,
                1,2,3,2,2,2,1,
                1,2,2,2,3,2,1,
                1,2,2,2,1,1,1,
                1,1,1,1,1,0,0};
            [self setMap:map1array withLen:49];
            int box1Array[] = {2,3,3,3,3,4};
            [self setBox:box1Array withLen:6];
            [self setRow:7];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
        
        case 21:
        {
            [self setPersonStartPosition:CGSizeMake(1, 4)];
            int map1array[] =
               {0,0,1,1,1,1,1,
                0,0,1,2,2,2,1,
                0,0,1,2,1,3,1,
                1,1,1,2,2,3,1,
                1,2,2,2,2,2,1,
                1,2,2,3,2,2,1,
                1,1,1,1,1,1,1};
            [self setMap:map1array withLen:49];
            int box1Array[] = {3,4,4,4,4,5};
            [self setBox:box1Array withLen:6];
            [self setRow:7];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
        
        case 22:
        {
            [self setPersonStartPosition:CGSizeMake(4, 1)];
            int map1array[] =
               {1,1,1,1,1,1,0,
                1,2,2,2,2,1,1,
                1,2,2,1,2,2,1,
                1,3,2,2,2,2,1,
                1,2,2,2,1,3,1,
                1,1,1,2,2,3,1,
                0,0,1,1,1,1,1};
            [self setMap:map1array withLen:49];
            int box1Array[] = {2,4,3,4,4,3};
            [self setBox:box1Array withLen:6];
            [self setRow:7];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 23:
        {
            [self setPersonStartPosition:CGSizeMake(5, 3)];
            int map1array[] =
               {1,1,1,1,1,1,1,
                1,2,2,2,2,2,1,
                1,3,1,1,2,3,1,
                1,3,2,2,2,2,1,
                1,2,2,1,2,2,1,
                1,2,2,1,2,2,1,
                1,1,1,1,1,1,1};
            [self setMap:map1array withLen:49];
            int box1Array[] = {1,3,4,3,4,4};
            [self setBox:box1Array withLen:6];
            [self setRow:7];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 24:
        {
            [self setPersonStartPosition:CGSizeMake(5, 3)];
            int map1array[] =
               {0,0,1,1,1,1,1,
                1,1,1,2,2,2,1,
                1,2,3,3,2,2,1,
                1,2,1,3,1,2,1,
                1,2,1,2,2,2,1,
                1,2,2,2,2,1,1,
                1,1,2,2,2,1,0,
                0,1,1,1,1,1,0};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,5,3,4,4,4};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 25:
        {
            [self setPersonStartPosition:CGSizeMake(1, 4)];
            int map1array[] =
               {1,1,1,1,1,1,0,
                1,3,2,2,2,1,0,
                1,2,2,1,2,1,0,
                1,2,2,2,2,1,1,
                1,2,1,2,2,2,1,
                1,3,2,3,1,2,1,
                1,1,1,2,2,2,1,
                0,0,1,1,1,1,1};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,3,3,4,4,4};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 26:
        {
            [self setPersonStartPosition:CGSizeMake(3, 6)];
            int map1array[] =
               {1,1,1,1,1,0,0,
                1,3,2,2,1,0,0,
                1,2,1,2,1,0,0,
                1,2,2,2,1,0,0,
                1,2,1,2,1,1,1,
                1,3,2,2,2,2,1,
                1,2,2,3,2,2,1,
                1,1,1,1,1,1,1};
            [self setMap:map1array withLen:56];
            int box1Array[] = {3,2,3,5,4,6};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
        
        case 27:
        {
            [self setPersonStartPosition:CGSizeMake(1, 3)];
            int map1array[] =
               {0,0,1,1,1,0,0,
                1,1,1,3,1,1,1,
                1,2,2,2,2,2,1,
                1,2,3,2,1,2,1,
                1,2,2,3,2,2,1,
                1,1,2,2,1,1,1,
                0,1,2,2,1,0,0,
                0,1,1,1,1,0,0};
            [self setMap:map1array withLen:56];
            int box1Array[] = {4,2,3,3,3,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 28:
        {
            [self setPersonStartPosition:CGSizeMake(4,1)];
            int map1array[] =
               {0,1,1,1,1,1,0,
                1,1,3,2,2,1,0,
                1,2,3,1,2,1,0,
                1,2,2,2,2,1,0,
                1,1,2,2,1,1,1,
                0,1,2,2,2,2,1,
                0,1,3,2,2,2,1,
                0,1,1,1,1,1,1};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,3,3,3,3,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 29:
        {
            [self setPersonStartPosition:CGSizeMake(2, 5)];
            int map1array[] =
               {1,1,1,1,1,0,0,
                1,2,2,2,1,0,0,
                1,2,1,2,1,1,1,
                1,2,2,3,2,2,1,
                1,1,3,2,2,2,1,
                0,1,2,2,2,2,1,
                0,1,1,2,2,3,1,
                0,0,1,1,1,1,1};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,4,3,3,4,3};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 30:
        {
            [self setPersonStartPosition:CGSizeMake(3, 4)];
            int map1array[] =
               {1,1,1,1,1,0,0,
                1,2,2,2,1,1,1,
                1,2,1,2,2,2,1,
                1,2,2,2,1,2,1,
                1,2,2,2,3,2,1,
                1,2,2,1,2,2,1,
                1,2,2,3,2,3,1,
                1,1,1,1,1,1,1};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,3,3,2,4,2};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 31:
        {
            [self setPersonStartPosition:CGSizeMake(1, 5)];
            int map1array[] =
               {1,1,1,1,1,1,0,0,
                1,2,2,3,2,1,0,0,
                1,2,2,2,2,1,1,1,
                1,2,1,2,2,3,2,1,
                1,3,2,2,1,1,2,1,
                1,2,2,2,1,1,2,1,
                1,1,1,2,2,2,2,1,
                0,0,1,1,1,1,1,1};
            [self setMap:map1array withLen:64];
            int box1Array[] = {2,5,3,3,4,3};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 32:
        {
            [self setPersonStartPosition:CGSizeMake(5,3)];
            int map1array[] =
               {0,0,1,1,1,1,0,
                1,1,1,2,2,1,1,
                1,2,2,2,2,2,1,
                1,2,1,3,1,2,1,
                1,2,1,2,2,3,1,
                1,2,2,3,2,2,1,
                1,1,2,2,2,1,1,
                0,1,1,1,1,1,0};
            [self setMap:map1array withLen:56];
            int box1Array[] = {4,2,3,4,4,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 33:
        {
            [self setPersonStartPosition:CGSizeMake(5, 3)];
            int map1array[] =
               {0,1,1,1,1,1,1,
                0,1,2,2,2,2,1,
                1,1,2,2,1,2,1,
                1,2,2,3,1,2,1,
                1,2,1,2,3,2,1,
                1,2,2,3,2,1,1,
                1,1,1,2,2,1,0,
                0,0,1,1,1,1,0};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,2,3,2,3,4};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 34:
        {
            [self setPersonStartPosition:CGSizeMake(5, 1)];
            int map1array[] =
               {0,1,1,1,1,1,1,0,
                0,1,2,2,3,2,1,1,
                0,1,2,2,2,2,3,1,
                0,1,1,1,3,1,2,1,
                1,1,2,2,2,2,2,1,
                1,2,2,2,2,2,1,1,
                1,2,2,2,1,1,1,0,
                1,1,1,1,1,0,0,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {5,2,4,3,3,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 35:
        {
            [self setPersonStartPosition:CGSizeMake(2, 5)];
            int map1array[] =
               {1,1,1,1,1,0,0,
                1,3,2,2,1,1,1,
                1,2,1,2,2,2,1,
                1,2,3,2,1,2,1,
                1,2,2,3,2,2,1,
                1,1,2,2,1,1,1,
                0,1,2,2,1,0,0,
                0,1,1,1,1,0,0};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,4,3,4,4,4};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 36:
        {
            [self setPersonStartPosition:CGSizeMake(4,6)];
            int map1array[] =
               {1,1,1,1,0,0,0,0,
                1,2,2,1,0,0,0,0,
                1,2,2,1,1,1,1,1,
                1,2,3,3,2,2,2,1,
                1,1,2,2,2,2,2,1,
                0,1,2,1,2,1,1,1,
                0,1,3,2,2,1,0,0,
                0,1,1,1,1,1,0,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {3,3,2,4,4,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 37:
        {
            [self setPersonStartPosition:CGSizeMake(4,3)];
            int map1array[] =
               {0,1,1,1,1,1,0,
                1,1,2,2,2,1,0,
                1,2,2,1,2,1,0,
                1,2,3,2,2,1,1,
                1,2,3,2,2,2,1,
                1,1,2,1,2,2,1,
                0,1,3,2,2,1,1,
                0,1,1,1,1,1,0};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,2,2,4,4,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 38:
        {
            [self setPersonStartPosition:CGSizeMake(2,1)];
            int map1array[] =
               {0,1,1,1,1,0,0,0,
                0,1,2,2,1,0,0,0,
                0,1,2,2,1,0,0,0,
                1,1,3,2,1,1,1,1,
                1,2,2,2,3,2,3,1,
                1,2,2,2,2,1,1,1,
                1,1,1,2,2,1,0,0,
                0,0,1,1,1,1,0,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {2,4,3,4,3,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 39:
        {
            [self setPersonStartPosition:CGSizeMake(4,1)];
            int map1array[] =
               {1,1,1,1,1,1,0,0,
                1,2,2,2,2,1,0,0,
                1,2,2,1,2,1,1,1,
                1,2,3,2,2,2,2,1,
                1,2,2,2,1,1,2,1,
                1,1,3,2,2,3,2,1,
                0,1,1,2,2,2,1,1,
                0,0,1,1,1,1,1,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {2,2,2,3,4,3};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 40:
        {
            [self setPersonStartPosition:CGSizeMake(2,1)];
            int map1array[] =
               {0,1,1,1,1,1,1,0,
                1,1,2,3,2,2,1,0,
                1,2,2,2,3,2,1,0,
                1,2,2,1,2,2,1,1,
                1,2,2,1,2,2,3,1,
                1,1,1,1,2,1,2,1,
                0,0,0,1,2,2,2,1,
                0,0,0,1,1,1,1,1};
            [self setMap:map1array withLen:64];
            int box1Array[] = {2,2,3,2,4,2};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 41:
        {
            [self setPersonStartPosition:CGSizeMake(5,6)];
            int map1array[] =
               {0,0,0,0,1,1,1,1,
                0,0,0,0,1,2,2,1,
                0,0,1,1,1,2,3,1,
                0,0,1,2,2,3,2,1,
                1,1,1,2,2,1,3,1,
                1,2,2,2,2,2,2,1,
                1,2,2,2,1,2,2,1,
                1,1,1,1,1,1,1,1};
            [self setMap:map1array withLen:64];
            int box1Array[] = {5,2,2,5,5,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 42:
        {
            [self setPersonStartPosition:CGSizeMake(6,5)];
            int map1array[] =
               {1,1,1,1,1,0,0,0,
                1,2,2,3,1,1,1,0,
                1,2,2,3,3,2,1,0,
                1,2,2,1,1,2,1,1,
                1,1,2,2,1,2,2,1,
                0,1,2,2,2,2,2,1,
                0,1,2,2,1,1,1,1,
                0,1,1,1,1,0,0,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {2,2,2,5,5,3};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 43:
        {
            [self setPersonStartPosition:CGSizeMake(5,6)];
            int map1array[] =
               {0,0,1,1,1,1,0,0,
                0,0,1,2,2,1,0,0,
                0,0,1,2,2,1,1,1,
                1,1,1,2,3,3,2,1,
                1,2,2,2,1,2,2,1,
                1,2,2,3,2,2,2,1,
                1,1,1,1,2,2,2,1,
                0,0,0,1,1,1,1,1};
            [self setMap:map1array withLen:64];
            int box1Array[] = {3,4,4,5,5,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 44:
        {
            [self setPersonStartPosition:CGSizeMake(3,2)];
            int map1array[] =
               {0,0,1,1,1,1,1,1,
                1,1,1,2,3,2,2,1,
                1,2,2,2,1,3,2,1,
                1,2,2,2,1,2,1,1,
                1,2,2,3,2,2,1,0,
                1,1,2,2,1,2,1,0,
                0,1,1,2,2,2,1,0,
                0,0,1,1,1,1,1,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {2,2,3,3,3,4};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 45:
        {
            [self setPersonStartPosition:CGSizeMake(1,2)];
            int map1array[] =
               {0,1,1,1,1,1,1,
                1,1,3,2,2,2,1,
                1,2,2,2,3,2,1,
                1,2,1,2,1,1,1,
                1,2,2,2,2,1,0,
                1,2,2,3,2,1,0,
                1,2,2,1,1,1,0,
                1,1,1,1,0,0,0};
            [self setMap:map1array withLen:56];
            int box1Array[] = {3,2,3,3,3,4};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 46:
        {
            [self setPersonStartPosition:CGSizeMake(3,3)];
            int map1array[] =
               {1,1,1,1,1,1,1,1,
                1,2,2,2,2,2,2,1,
                1,2,1,2,1,1,3,1,
                1,2,1,2,2,2,2,1,
                1,3,2,2,3,2,2,1,
                1,1,1,1,1,2,2,1,
                0,0,0,0,1,2,2,1,
                0,0,0,0,1,1,1,1};
            [self setMap:map1array withLen:64];
            int box1Array[] = {2,4,5,3,6,2};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 47:
        {
            [self setPersonStartPosition:CGSizeMake(2,1)];
            int map1array[] =
               {0,1,1,1,1,1,1,0,
                0,1,2,2,2,2,1,1,
                0,1,1,2,2,2,2,1,
                1,1,1,2,3,2,2,1,
                1,2,2,2,1,2,1,1,
                1,2,3,2,2,3,1,0,
                1,1,1,1,2,2,1,0,
                0,0,0,1,1,1,1,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {3,2,2,4,5,4};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 48:
        {
            [self setPersonStartPosition:CGSizeMake(2,4)];
            int map1array[] =
               {1,1,1,1,1,0,0,
                1,2,2,2,1,1,1,
                1,2,2,2,2,2,1,
                1,1,2,2,2,3,1,
                0,1,2,2,3,2,1,
                0,1,1,2,1,2,1,
                0,0,1,2,2,3,1,
                0,0,1,1,1,1,1};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,3,3,2,3,3};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
        
        case 49:
        {
            [self setPersonStartPosition:CGSizeMake(2,6)];
            int map1array[] =
               {1,1,1,1,1,0,0,0,
                1,2,2,2,1,1,1,1,
                1,2,2,2,2,2,2,1,
                1,2,3,1,3,2,2,1,
                1,2,2,1,1,2,1,1,
                1,2,2,1,1,2,1,0,
                1,2,2,2,2,3,1,0,
                1,1,1,1,1,1,1,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {2,2,3,2,5,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 50:
        {
            [self setPersonStartPosition:CGSizeMake(3, 2)];
            int map1array[] =
               {1,1,1,1,1,1,
                1,2,2,2,2,1,
                1,3,3,2,2,1,
                1,2,1,2,3,1,
                1,2,2,2,2,1,
                1,1,1,2,2,1,
                0,0,1,2,2,1,
                0,0,1,1,1,1};
            [self setMap:map1array withLen:48];
            int box1Array[] = {3,3,3,4,4,2};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:6];
            [self setBoxNum:3];
        }
            break;
            
        case 51:
        {
            [self setPersonStartPosition:CGSizeMake(2,1)];
            int map1array[] =
               {1,1,1,1,1,1,1,1,
                1,2,2,3,1,2,2,1,
                1,2,3,2,2,3,2,1,
                1,2,2,1,2,2,2,1,
                1,2,2,2,2,2,1,1,
                1,1,1,2,2,1,1,0,
                0,0,1,2,2,1,0,0,
                0,0,1,1,1,1,0,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {3,2,3,4,4,3};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 52:
        {
            [self setPersonStartPosition:CGSizeMake(6,2)];
            int map1array[] =
               {0,1,1,1,1,1,1,1,
                1,1,2,2,2,3,2,1,
                1,2,2,2,2,2,2,1,
                1,3,2,3,1,1,1,1,
                1,2,2,1,1,0,0,0,
                1,2,2,1,0,0,0,0,
                1,2,2,1,0,0,0,0,
                1,1,1,1,0,0,0,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {2,2,2,3,5,2};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 53:
        {
            [self setPersonStartPosition:CGSizeMake(4,2)];
            int map1array[] =
               {1,1,1,1,1,1,0,
                1,2,3,2,2,1,0,
                1,2,2,1,2,1,0,
                1,2,2,2,2,1,1,
                1,1,2,1,2,2,1,
                1,2,2,2,1,2,1,
                1,3,2,3,2,2,1,
                1,1,1,1,1,1,1};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,4,3,3,3,6};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 54:
        {
            [self setPersonStartPosition:CGSizeMake(2,3)];
            int map1array[] =
               {0,1,1,1,1,1,1,
                0,1,2,2,2,2,1,
                0,1,3,2,1,2,1,
                1,1,2,2,2,2,1,
                1,2,2,1,2,1,1,
                1,3,3,2,2,1,0,
                1,2,2,2,2,1,0,
                1,1,1,1,1,1,0};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,2,3,2,4,5};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
            
        case 55:
        {
            [self setPersonStartPosition:CGSizeMake(1,5)];
            int map1array[] =
               {0,0,1,1,1,1,0,
                0,0,1,2,2,1,0,
                0,0,1,2,2,1,1,
                0,0,1,2,2,2,1,
                1,1,1,2,3,3,1,
                1,2,2,2,2,2,1,
                1,2,3,2,2,2,1,
                1,1,1,1,1,1,1};
            [self setMap:map1array withLen:56];
            int box1Array[] = {3,2,3,4,3,6};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
        
        case 56:
        {
            [self setPersonStartPosition:CGSizeMake(6,5)];
            int map1array[] =
               {1,1,1,1,1,1,1,1,
                1,2,2,2,1,2,2,1,
                1,2,1,3,2,2,2,1,
                1,2,2,2,2,2,2,1,
                1,1,1,1,1,3,2,1,
                0,0,1,2,2,2,2,1,
                0,0,1,2,2,2,3,1,
                0,0,1,1,1,1,1,1};
            [self setMap:map1array withLen:64];
            int box1Array[] = {4,2,4,3,6,2};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
        
        case 57:
        {
            [self setPersonStartPosition:CGSizeMake(4,1)];
            int map1array[] =
               {0,0,0,1,1,1,1,0,
                0,0,1,1,2,2,1,1,
                0,1,1,2,2,3,3,1,
                1,1,2,2,1,2,1,1,
                1,2,2,2,2,3,2,1,
                1,2,2,1,2,2,2,1,
                1,2,2,2,2,1,1,1,
                1,1,1,1,1,1,0,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {3,3,4,4,5,3};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
        
        case 58:
        {
            [self setPersonStartPosition:CGSizeMake(4,1)];
            int map1array[] =
               {1,1,1,1,1,1,0,0,
                1,2,2,2,2,1,0,0,
                1,2,2,2,1,1,1,1,
                1,2,2,2,3,2,2,1,
                1,1,2,1,3,1,2,1,
                1,3,2,2,2,1,2,1,
                1,2,2,2,2,2,2,1,
                1,1,1,1,1,1,1,1};
            [self setMap:map1array withLen:64];
            int box1Array[] = {2,2,2,3,3,2};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
        
        case 59:
        {
            [self setPersonStartPosition:CGSizeMake(2,3)];
            int map1array[] =
               {0,0,0,1,1,1,1,0,
                0,0,0,1,2,2,1,0,
                1,1,1,1,2,2,1,1,
                1,2,2,2,3,2,2,1,
                1,2,1,1,2,2,2,1,
                1,2,2,2,1,1,2,1,
                1,2,2,2,3,2,3,1,
                1,1,1,1,1,1,1,1};
            [self setMap:map1array withLen:64];
            int box1Array[] = {3,3,4,6,5,2};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
            
        case 60:
        {
            [self setPersonStartPosition:CGSizeMake(5,1)];
            int map1array[] =
               {0,0,0,1,1,1,1,1,
                0,0,0,1,2,2,2,1,
                0,1,1,1,2,2,2,1,
                0,1,2,2,2,2,1,1,
                1,1,2,2,2,2,1,0,
                1,3,2,2,1,2,1,0,
                1,3,3,2,2,2,1,0,
                1,1,1,1,1,1,1,0};
            [self setMap:map1array withLen:64];
            int box1Array[] = {3,3,3,4,5,3};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:8];
            [self setBoxNum:3];
        }
            break;
        
        case 61:
        {
            [self setPersonStartPosition:CGSizeMake(1,5)];
            int map1array[] =
               {0,1,1,1,1,1,0,
                0,1,2,2,2,1,0,
                0,1,2,1,2,1,0,
                1,1,3,2,2,1,1,
                1,3,2,2,2,2,1,
                1,2,2,1,2,2,1,
                1,2,2,1,3,2,1,
                1,1,1,1,1,1,1};
            [self setMap:map1array withLen:56];
            int box1Array[] = {2,4,4,2,4,4};
            [self setBox:box1Array withLen:6];
            [self setRow:8];
            [self setColumn:7];
            [self setBoxNum:3];
        }
            break;
        default:
            break;
            
    }
    
    NSString* answerFileName = [NSString stringWithFormat:@"answer%d",level];
    NSString* path = [[NSBundle mainBundle] pathForResource:answerFileName ofType:nil];
    if (answerArray && [answerArray count] > 0)
    {
        [answerArray release];
        answerArray = nil;
    }
    answerArray = [[NSArray alloc] initWithContentsOfFile:path];
}

- (void)setMap:(int[])amap withLen:(int)alen
{
    cellNum = alen;
    for (int i = 0; i < alen; i++)
    {
        map[i] = amap[i];
    }
}

- (void)setBox:(int[])abox withLen:(int)alen
{
    for (int i = 0; i < alen; i++)
    {
        boxOrigin[i] = abox[i];
        boxPos[i] = abox[i];
    }
}

- (MapCellType)typeForCellAtIndex:(int)aindex
{
    return map[aindex];
}

- (CGSize) positionForBox:(int)aindex
{
    int px = boxPos[aindex*2];
    int py = boxPos[aindex*2+1];
    CGSize pos = CGSizeMake(px, py);
    return pos;
}

- (CGSize) originalPositionForBox:(int)aindex
{
    int px = boxOrigin[aindex*2];
    int py = boxOrigin[aindex*2+1];
    CGSize pos = CGSizeMake(px, py);
    return pos;
}

- (BOOL)boxExistAtIndex:(int)aindex
{
    int ix = aindex % column;
    int iy = aindex / column;
    for (int i = 0; i < boxNum*2; i+=2)
    {
        if (boxPos[i] == ix && boxPos[i+1] == iy )
        {
            return YES;
        }
    }
    return NO;
}

- (void)setBoxAtIndex:(int)aindex toPositionX:(int)ax Y:(int)ay
{
    boxPos[aindex*2] = ax;
    boxPos[aindex*2+1]= ay;
}

- (int) leastStepNum
{
    int i = 0;
    for (NSArray* paths in answerArray)
    {
        i += [paths count];
        i --;
    }
    return i;
}

- (NSArray*)pathFromOriginX:(int)sx originY:(int)sy
                    toDestx:(int)dx desty:(int)dy
{
    if ( sx < 0 || sx >= column
        || sy < 0 || sy >= row
        || dx < 0 || dx >= column
        || dy < 0 || dy >= row )
    {
        NSLog(@"坐标不在地图内");
        return nil;
    }
    
    if (sx == dx && sy == dy)
    {
        NSLog(@"起点终点一样");
        return nil;
    }
    
    NSMutableArray* nodeArray = [[[NSMutableArray alloc] init] autorelease];
    for (int i = 0; i < row*column; i++)
    {
        AStarNode* node = [[AStarNode alloc] init];
        [node setRow:i/column];
        [node setColumn:i%column];
        [node setType:map[i]];
        if (map[i] == MAPCELL_NONE || map[i] == MAPCELL_WALL ||
            [self boxExistAtIndex:i])
        {
            [node setBlocked:YES];
        }
        if ([node row] == dy && [node column] == dx && [self boxExistAtIndex:i])
        {
            [node setBlocked:NO];
        }
        [nodeArray addObject: node];
        [node release];
    }
    
    AStarNode* node1 = [nodeArray objectAtIndex:sy*column+sx];
    NSMutableArray* openArray = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray* closeArray = [[[NSMutableArray alloc] init] autorelease];
    [openArray addObject:node1];
    
    while ([openArray count] != 0)
    {
        //获取数组中f值最小的节点
        [openArray sortUsingComparator:^(AStarNode* obj1, AStarNode* obj2)
         {
             if ([obj1 f] < [obj2 f])
             {
                 return NSOrderedAscending;
             }else if([obj1 f] > [obj2 f])
             {
                 return NSOrderedDescending;
             }
             return NSOrderedSame;
         }];
        
        AStarNode* bestNode = [openArray objectAtIndex:0];
        int bestValue = [bestNode f];
        
        if ( ( [bestNode row] == dy )
            && ([bestNode column] == dx) )
        {
            //NSLog(@"到达终点:%d %d",[bestNode column], [bestNode row]);
            break;
        }
        
        NSMutableArray* subNodeArray = [NSMutableArray array];
        if ([bestNode row] - 1 >= 0)
        {
            int uprow = [bestNode row] - 1;
            int upcolumn = [bestNode column];
            AStarNode* upNode = [nodeArray objectAtIndex:uprow*column + upcolumn];
            [subNodeArray addObject:upNode];
        }
        
        if ([bestNode row] + 1 < row)
        {
            int downrow = [bestNode row] + 1;
            int downcolumn = [bestNode column];
            AStarNode* downNode = [nodeArray objectAtIndex:downrow*column+downcolumn];
            [subNodeArray addObject:downNode];
        }

        if ([bestNode column] - 1 >= 0)
        {
            int leftrow = [bestNode row];
            int leftcolumn = [bestNode column] - 1;
            AStarNode* leftNode = [nodeArray objectAtIndex:leftrow*column+leftcolumn];
            [subNodeArray addObject:leftNode];
        }
        
        if ([bestNode column] + 1 < column)
        {
            int rightrow = [bestNode row];
            int rightcolumn = [bestNode column] + 1;
            AStarNode* rightNode = [nodeArray objectAtIndex:rightrow*column+rightcolumn];
            [subNodeArray addObject:rightNode];
        }
        
        for (AStarNode* subNode in subNodeArray)
        {
            //NSLog(@"sub node:%d %d",[subNode column],[subNode row]);
            //父节点到自己的代价
            if ([subNode row] == sy && [subNode column] == sx
                && [subNode fatherNode] == nil )
            {
                [subNode setG:0];
                [subNode setH:0];
                [subNode setF:0];
            }else
            {
                int g_sub = [bestNode g] + 1;
                int h_sub = abs([subNode row] - dy) + abs([subNode column] - dx);
                int f_sub = g_sub + h_sub;
                [subNode setG:g_sub];
                [subNode setH:h_sub];
                [subNode setF:f_sub];
            }
            //NSLog(@"ghf:%d %d %d",[subNode g],[subNode h],[subNode f]);
            
            if ([openArray containsObject:subNode])
            {
                //NSLog(@"sub node %d %d 在open set中",[subNode column],[subNode row]);
                if ([subNode f] < bestValue)
                {
                    //NSLog(@"估值小于fathernode，更新估价");
                    [subNode setFatherNode:bestNode];
                    bestValue = [subNode f];
                }
            }
            
            if ([closeArray containsObject:subNode])
            {
                //NSLog(@"sub node %d %d 在close set中",[subNode column], [subNode row]);
                continue;
            }
            
            if (![openArray containsObject:subNode]
                && ![closeArray containsObject:subNode] && ![subNode blocked])
            {
                
                 [subNode setFatherNode:bestNode];
                 //NSLog(@"oepn add :%d %d",[subNode row],[subNode column]);
                 [openArray addObject:subNode];
            }
        }
        
        [openArray removeObject:bestNode];
        [closeArray addObject:bestNode];
        
    }
    
    int destIndex = dy * column + dx;
    AStarNode* nd = [nodeArray objectAtIndex:destIndex];
    if ([nd fatherNode] != nil)
    {
        NSMutableArray* nodes = [[[NSMutableArray alloc] init] autorelease];
        [nodes addObject:nd];
        NSLog(@"====路径搜寻%d %d结果====",sx,sy);
        NSLog(@"node %d,%d",[nd column], [nd row]);
        do {
            nd = [nd fatherNode];
            //NSLog(@"node %d,%d",[nd column], [nd row]);
            if (([nd row] == sy)
                && ([nd column] == sx))
            {
                [nodes addObject:nd];
                break;
            }else
            {
                [nodes addObject:nd];
            }
        } while (1);
        
        //判断路径是否有效
        return nodes;
    }else
    {
        NSLog(@"====没有找到路径====");
    }
    return nil;
}

- (BOOL)isFinished
{
    BOOL finish = YES;
    for (int i = 0; i < boxNum; i ++)
    {
        int bx = boxPos[i*2];
        int by = boxPos[i*2+1];
        int index = by * column + bx;
        MapCellType type = [self typeForCellAtIndex:index];
        if (type != MAPCELL_TARGET)
        {
            finish =  NO;
            break;
        }
    }
    return finish;
}

- (void)dealloc
{
    [answerArray release];
    answerArray = nil;
    [super dealloc];
}
@end


