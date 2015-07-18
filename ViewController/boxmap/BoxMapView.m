//
//  BoxMapView.m
//  Pushbox
//
//  Created by daxin on 13-10-1.
//  Copyright (c) 2013年 daxin. All rights reserved.
//
//  算法描述: 当点击箱子，用A*算法计算是否有路径到达箱子位置，有则前往，到达箱子前一位，查询是否可以移动，有则移动，无则停止所有操作
//  箱子被选中，纪录箱子编号   地板被选中  
//

#import "BoxMapView.h"
#import "AStarNode.h"

@interface BoxMapView()
- (void)responseToButtonAction:(id)sender;
- (BoxMapCell*)boxCellAtX:(int)ax y:(int)ay;

- (void)initPersonAndBoxPosition;

- (CSAnimationItem*)movePersonToX:(int)ax y:(int)ay;
- (CSAnimationItem*)moveBox:(BoxMapCell*)abox toX:(int)ax y:(int)ay;
- (CSAnimationItem*)moveBox:(int)aid toX:(int)ax toY:(int)ay;
- (void)popWinView;
- (void)updateStepLabel;

//- (BOOL)isFinished;
- (void)playActionsFromBackward:(NSArray*)actions;
- (void)playActionBackWard:(NSString*)act;
- (void)playActions:(NSArray*)actions;
- (void)playAction:(NSString*)act;

- (void)onExitAnswerView;
- (void)updatePlayButton;
- (void)onPlayButton;
@end

@implementation BoxMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)initWithMap:(BoxMap*)amap
{
    int mapwidth = 320;
    int controlBarHeight = 50;
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    int originY = 50;//(screenRect.size.height - mapwidth)/2.0;
    CGRect mapRect = CGRectMake(0, 0 , mapwidth, mapwidth+controlBarHeight);
    self = [super initWithFrame:mapRect];
    if (self)
    {
        map = amap;
        
        CGRect levelRect = CGRectMake(80, 0, 160, 50);
        levelLabel = [[CSBrownLabel alloc] initWithFrame:levelRect];
        [levelLabel setFont:[UIFont boldSystemFontOfSize:24]];
        NSString* levelText = [NSString stringWithFormat:CSLOCAL(@"LEVEL %d"),[map level]];
        [levelLabel setText:levelText];
        [self addSubview:levelLabel];
        [levelLabel release];
        
        mapCellArray = [[NSMutableArray alloc] init];
        boxCellArray = [[NSMutableArray alloc] init];
        actionHistory = [[NSMutableArray alloc] init];
        oneAction = nil;
        
        gameAnimation = [[CSAnimationSequence alloc] init];
        [gameAnimation setDelegate:self];
        
        cellWidth = screenRect.size.width / [map column];
        NSLog(@"cellwidth :%d",cellWidth);
        
        int mapSize = [map cellNum];
        for (int i = 0; i < mapSize; i++)
        {
            BoxMapCell* mapCell = [BoxMapCell buttonWithType:UIButtonTypeCustom];
            [mapCell setTag:i];
            int curColumn = i % [map column];
            int curRow = i / [map column];
            CGRect btnRect = CGRectMake(curColumn*cellWidth, originY + curRow*cellWidth, cellWidth, cellWidth);
            [mapCell setFrame:btnRect];
            [mapCell addTarget:self action:@selector(responseToButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            MapCellType cellType = [map typeForCellAtIndex:i];
            [mapCell setRow:curRow];
            [mapCell setColumn:curColumn];
            if (i == 52)
            {
                NSLog(@"52 cell is set to %d",cellType);
            }
            [mapCell setType:cellType];
            [mapCellArray addObject:mapCell];
            [self addSubview:mapCell];
        }
        
        int boxNum = [map boxNum];
        for (int i = 0; i < boxNum; i++)
        {
            BoxMapCell* boxCell = [BoxMapCell buttonWithType:UIButtonTypeCustom];
            UIImage* boxBtnImg = [UIImage imageNamed:@"p_box.png"];
            [boxCell setImage:boxBtnImg forState:UIControlStateNormal];
            [boxCell addTarget:self action:@selector(responseToButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
            CGSize boxPos = [map positionForBox:i];
            CGRect boxRect = CGRectMake(boxPos.width *cellWidth, boxPos.height * cellWidth,
                                        cellWidth, cellWidth);
            [boxCell setFrame:boxRect];
            [boxCell setRow:boxPos.height];
            [boxCell setColumn:boxPos.width];
            [boxCell setTag:i];
            [boxCellArray addObject:boxCell];
            [self addSubview:boxCell];
        }
        
        CGSize personPos = [map personStartPosition];
        personCell = [BoxMapCell buttonWithType:UIButtonTypeCustom];
        UIImage* personImg = [UIImage imageNamed:@"p_person.png"];
        [personCell setImage:personImg forState:UIControlStateNormal];
        CGRect personRect = CGRectMake(personPos.width*cellWidth, personPos.height*cellWidth,
                                       cellWidth, cellWidth);
        [personCell setFrame:personRect];
        [personCell setColumn:personPos.width];
        [personCell setRow:personPos.height];
        [self addSubview:personCell];
        
        goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* goBackImage = [UIImage imageNamed:@"button_goback.png"];
        //[goBackButton setTitle:@"GoBack" forState:UIControlStateNormal];
        [goBackButton setImage:goBackImage forState:UIControlStateNormal];
        [goBackButton addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
        CGRect goBackRect = CGRectMake(20, mapwidth , 49, 49);
        [goBackButton setFrame:goBackRect];
        [self addSubview:goBackButton];
        [goBackButton setHidden:YES];
        
        UIButton* answerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* answerImg = [UIImage imageNamed:@"button_help.png"];
        [answerButton setImage:answerImg forState:UIControlStateNormal];
        [answerButton addTarget:self action:@selector(playAnswer) forControlEvents:UIControlEventTouchUpInside];
        CGRect answerRect = CGRectMake(150, mapwidth , 49, 49);
        [answerButton setFrame:answerRect];
        [self addSubview:answerButton];
        
        CGRect stepRect = CGRectMake(150, mapwidth + 20, 100, 60);
        stepLabel = [[UILabel alloc] initWithFrame:stepRect];
        [stepLabel setTextColor:[UIColor redColor]];
        [stepLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:stepLabel];
        [stepLabel release];
        
        steps = 0;
        [self updateStepLabel];
        
        
        CGRect answerViewRect = self.bounds;
        answerView = [[UIView alloc] initWithFrame:answerViewRect];
        CGRect backButtonRect = CGRectMake(20, 0, 60, 60);
        UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:backButtonRect];
        [backButton setImage:[UIImage imageNamed:@"caige_button_pos.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(onExitAnswerView) forControlEvents:UIControlEventTouchDown];
        [answerView addSubview:backButton];
        
        
        CGRect playButtonRect = CGRectMake(120, 0, 60, 60);
        playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [playButton setFrame:playButtonRect];
        [playButton addTarget:self action:@selector(onPlayButton) forControlEvents:UIControlEventTouchDown];
        [answerView addSubview:playButton];
        [self updatePlayButton];
        
        }
    return self;
}

- (void)goback
{
    if ([actionHistory count] > 0)
    {
        NSArray* action = [actionHistory lastObject];
        NSLog(@"action:%@",action);
        [self playActionsFromBackward:action];
        [actionHistory removeLastObject];
        if ([actionHistory count] == 0)
        {
            [goBackButton setHidden:YES];
        }
    }
}

- (BOOL)canGoBack
{
    if ([actionHistory count] > 0)
    {
        return YES;
    }
    return NO;
}

- (void)playAnswer
{
    [self addSubview:answerView];
    
    //归位
    //isPlayingAnswer = NO;
    [self initPersonAndBoxPosition];
    [gameAnimation clear];
    
    
//    [gameAnimation clear];
//    for (NSArray* actions in [map answerArray])
//    {
//        [self playActions:actions];
//    }
//    [gameAnimation start];
}

- (void)pauseAnswer
{
    isPlayingAnswer = NO;
    [gameAnimation stop];
}

- (void)stopAllAnimations
{
    [gameAnimation clear];
    [gameAnimation stop];
}

- (void)dealloc
{
    [answerView release];
    [gameAnimation release];
    [actionHistory release];
    [boxCellArray release];
    [mapCellArray release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIButton Action
- (void)responseToButtonAction:(id)sender
{
    BoxMapCell* cell = (BoxMapCell*)sender;
    int tag = (int)[cell tag];
    NSLog(@"tag:%d",tag);
    
    int boxIndex = 0;
    //BOOL istouch = NO;
    for (boxIndex = 0; boxIndex < [boxCellArray count]; boxIndex++)
    {
        BoxMapCell* c = [boxCellArray objectAtIndex:boxIndex];
        if ([c isEqual:cell])
        {
            //istouch = YES;
            break;
        }
    }

    
    //判断人可否走到按下的位置
    NSArray* pathArray = [map pathFromOriginX:[personCell column] originY:[personCell row]
                                      toDestx:[cell column] desty:[cell row]];
    
    if (pathArray == nil || [pathArray count] < 2)
    {
        NSLog(@"路径出错:%d",(int)[pathArray count]);
    }else
    {
        [gameAnimation clear];
        
        //纪录操作
        if (oneAction != nil)
        {
            [oneAction release];
            oneAction = nil;
        }
        oneAction = [[NSMutableArray alloc] init];
        [oneAction addObject:[NSString stringWithFormat:@"p,%d,%d",[personCell column],[personCell row]]];
        
        NSMutableArray* nodes = [[NSMutableArray alloc] initWithArray:pathArray];
        
        
        for (int i = (int)[nodes count] - 2; i >= 0; i--)
        {
            AStarNode* nextNode = [nodes objectAtIndex:i];//[nodes lastObject];
            
            // Destination Node
            AStarNode* destNode = [nodes objectAtIndex:0];
            int destCellIndex = [destNode row]*[map column] + [destNode column];
            //arrive destination node
            
            if ( i == 0 && [map boxExistAtIndex:destCellIndex] )
            {
                AStarNode* last2Node = [nodes objectAtIndex:1];
                
                int bx = 0, by = 0;
                if ([nextNode row] == [last2Node row])
                {
                    by = [nextNode row];
                    bx = [nextNode column] + [nextNode column] - [last2Node column];
                }else
                {
                    bx = [nextNode column];
                    by = [nextNode row] + [nextNode row] - [last2Node row];
                }
                
                int perNext = by*[map column] + bx;
                BoxMapCell* mapCellForBoxNext = [mapCellArray objectAtIndex:perNext];
                BoxMapCell* boxCellAtBoxNext = [self boxCellAtX:bx y:by];
                //BoxMapCell*  curBoxCell = [self boxCellAtX:[nextNode column] y:[nextNode row]];
                
                // if there's no box at next position
                if (boxCellAtBoxNext == nil)
                {
                    if ([mapCellForBoxNext type] == MAPCELL_FLOOR ||
                        [mapCellForBoxNext type] == MAPCELL_TARGET )
                    {
                        if (oneAction != nil)
                        {
//                            [oneAction addObject:[NSString stringWithFormat:@"bp,%d,%d,%d,%d,%d",boxIndex,bx,by,
//                                                  [nextNode column],[nextNode row]]];
                            [oneAction addObject:[NSString stringWithFormat:@"bp,%d,%d,%d,%d,%d,%d,%d",boxIndex,
                                                      bx,by,[nextNode column],[nextNode row],[last2Node column],[last2Node row]]];
                        }
                        //CSAnimationItem* boxAni = [self moveBox:curBoxCell toX:bx y:by];
                        CSAnimationItem* boxAni = [self moveBox:boxIndex toX:bx toY:by];
                        CSAnimationItem* perAni = [self movePersonToX:[nextNode column] y:[nextNode row]];
                        CSAnimationGroup* group = [CSAnimationGroup groupWithItems:[NSArray arrayWithObjects:boxAni,perAni, nil]];
                        [gameAnimation addAnimationGroup:group];
                    }
                }else
                {
                    NSLog(@"can not move");
                }
                
            }else
            {
                if (oneAction != nil)
                {
                    NSLog(@"add one action");
                    [oneAction addObject:[NSString stringWithFormat:@"p,%d,%d",[nextNode column],[nextNode row]]];
                }
                CSAnimationItem* perAni = [self movePersonToX:[nextNode column] y:[nextNode row]];
                CSAnimationGroup* group = [CSAnimationGroup groupWithItem:perAni];
                [gameAnimation addAnimationGroup:group];
            }
            if (i == 0)
            {
                if (oneAction != nil)
                {
                    [actionHistory addObject:oneAction];
                    if ([actionHistory count] > 0)
                    {
                        [goBackButton setHidden:NO];
                    }
                    [oneAction release];
                    oneAction = nil;
                }
            }
        }
        
        [gameAnimation start];
        [nodes release];
    }
}

- (CSAnimationItem*)movePersonToX:(int)ax y:(int)ay
{
    NSLog(@"### per before move:%d,%d ###",[personCell column],[personCell row]);
    CGRect newRect = CGRectMake(ax*cellWidth, ay*cellWidth,
                                   cellWidth, cellWidth);
    
    CGPoint cp = CGPointMake(newRect.origin.x + newRect.size.width / 2.0,
                             newRect.origin.y + newRect.size.width/2.0);
    
    CSAnimationItem* moveItem = [CSAnimationItem itemWithDuration:0.25  delay:0
                                                          options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                                              //[personCell setFrame:newRect];
                                                              [personCell setCenter:cp];
                                                              [personCell setColumn:ax];
                                                              [personCell setRow:ay];
                                                              
                                                              steps ++;
                                                              [self updateStepLabel];
                                                          }];
    NSLog(@"### per after move:%d,%d ###",[personCell column],[personCell row]);
    return moveItem;
}

- (CSAnimationItem*)moveBox:(BoxMapCell*)abox toX:(int)ax y:(int)ay
{
    int currentBoxIndex = (int)[abox tag];
    [map setBoxAtIndex:currentBoxIndex toPositionX:ax Y:ay];
    
    //CGSize boxPos = [map positionForBox:currentBoxIndex];
    CGRect boxRect = CGRectMake(ax * cellWidth, ay * cellWidth,
                                cellWidth, cellWidth);
    CGPoint cp = CGPointMake(boxRect.origin.x + boxRect.size.width/2.0, boxRect.origin.y + boxRect.size.height/2.0);
    
    CSAnimationItem* moveItem = [CSAnimationItem itemWithDuration:0.25 delay:0
                                                          options:UIViewAnimationOptionCurveEaseInOut animations:
                                 ^{
                                    //[abox setFrame:boxRect];
                                    [abox setCenter:cp];
                                    [abox setColumn:ax];
                                    [abox setRow:ay];
                                     NSLog(@"箱子移动到%d,%d",[abox column],[abox row]);
                                     NSLog(@"======================");
                                     NSLog(@"box cell array:%d",(int)[boxCellArray count]);
                                     for (BoxMapCell* c in boxCellArray)
                                     {
                                         NSLog(@"cell:%d,%d",[c column],[c row]);
                                     }
                                     NSLog(@"=======================");
                                     
                                    if ([map isFinished])
                                    {
                                                                
                                        NSLog(@"收集完成");
                                        NSArray* folders = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                                        NSString* filename = [NSString stringWithFormat:@"action%d",[map level]];
                                        NSString* actionPath = [[folders objectAtIndex:0] stringByAppendingPathComponent:filename];
                                        NSLog(@"action path:%@",actionPath);
                                        BOOL res = [actionHistory writeToFile:actionPath atomically:YES];
                                        if (res)
                                        {
                                            NSLog(@"fil 存储成功");
                                        }else
                                        {
                                            NSLog(@"保存失败");
                                        }

                                        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
                                                                       selector:@selector(popWinTip)
                                                                      userInfo:nil repeats:NO];
                                    }
                                }];
    NSLog(@"xxxxxxxxxxxxxxxxxxxxxxxxxx");
    for (BoxMapCell* c in boxCellArray)
    {
        NSLog(@"boxcell:%d,%d",[c column],[c row]);
    }
    NSLog(@"xxxxxxxxxxxxxxxxxxxxxxxxxx");
    return moveItem;
}


- (CSAnimationItem*)moveBox:(int)boxID toX:(int)ax toY:(int)ay;
{
    if (boxID >= [map boxNum])
    {
        NSLog(@"moveBox:toX:toY aid参数过大");
        return nil;
    }
    
    BoxMapCell* boxCell = [boxCellArray objectAtIndex:boxID];
    
    //CGSize boxPos = [map positionForBox:boxID];
    CGRect boxRect = CGRectMake(ax * cellWidth, ay * cellWidth,
                                cellWidth, cellWidth);
    CGPoint cp = CGPointMake(boxRect.origin.x + boxRect.size.width/2.0, boxRect.origin.y + boxRect.size.height/2.0);
    
    CSAnimationItem* moveItem = [CSAnimationItem itemWithDuration:0.25 delay:0
                                                          options:UIViewAnimationOptionCurveEaseInOut animations:
                                 ^{
                                     //[abox setFrame:boxRect];
                                     [map setBoxAtIndex:boxID toPositionX:ax Y:ay];
                                     [boxCell setCenter:cp];
                                     [boxCell setColumn:ax];
                                     [boxCell setRow:ay];
                                     NSLog(@"箱子移动到%d,%d",[boxCell column],[boxCell row]);
                                     NSLog(@"======================");
                                     NSLog(@"box cell array:%d",(int)[boxCellArray count]);
                                     for (BoxMapCell* c in boxCellArray)
                                     {
                                         NSLog(@"cell:%d,%d",[c column],[c row]);
                                     }
                                     NSLog(@"=======================");
                                     
                                     if ([map isFinished])
                                     {
                                         
                                         NSLog(@"收集完成");
                                         NSArray* folders = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                                         NSString* filename = [NSString stringWithFormat:@"action%d",[map level]];
                                         NSString* actionPath = [[folders objectAtIndex:0] stringByAppendingPathComponent:filename];
                                         NSLog(@"action path:%@",actionPath);
                                         BOOL res = [actionHistory writeToFile:actionPath atomically:YES];
                                         if (res)
                                         {
                                             NSLog(@"fil 存储成功");
                                         }else
                                         {
                                             NSLog(@"保存失败");
                                         }
                                         
                                         if (!isPlayingAnswer)
                                         {
                                             [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
                                                                            selector:@selector(popWinTip)
                                                                            userInfo:nil repeats:NO];
                                         }
                                     }
                                 }];
    NSLog(@"xxxxxxxxxxxxxxxxxxxxxxxxxx");
    for (BoxMapCell* c in boxCellArray)
    {
        NSLog(@"boxcell:%d,%d",[c column],[c row]);
    }
    NSLog(@"xxxxxxxxxxxxxxxxxxxxxxxxxx");
    return moveItem;
}


- (void)popWinView
{
        UIAlertView* successAlert = [[UIAlertView alloc] initWithTitle:@"Win" message:nil
                                                              delegate:nil
                                                     cancelButtonTitle:@"ok"
                                                     otherButtonTitles:nil, nil];
        [successAlert show];
        [successAlert release];
}

- (void)updateStepLabel
{
    NSString* str = [NSString stringWithFormat:@"%d",steps];
    [stepLabel setText:str];
}


- (BoxMapCell*)boxCellAtX:(int)ax y:(int)ay
{
    NSLog(@"****get cell %d,%d****",ax,ay);
    BoxMapCell* res = nil;
    for (BoxMapCell* cell in boxCellArray)
    {
        NSLog(@"c %d,%d",[cell column],[cell row]);
        if (([cell column] == ax) && ([cell row] == ay))
        {
            res = cell;
            break;
        }
    }
    if (res)
    {
        NSLog(@"MMMMMMMM");
    }else
    {
        NSLog(@"88888888");
    }
    return res;
}

- (void)initPersonAndBoxPosition
{
    //两个参数都被改了，需要增加参数
    int boxNum = [map boxNum];
    for (int i = 0; i < boxNum; i++)
    {
        BoxMapCell* boxCell = [boxCellArray objectAtIndex:i];
        CGSize boxPos = [map originalPositionForBox:i];
        CGRect boxRect = CGRectMake(boxPos.width *cellWidth, boxPos.height * cellWidth,
                                    cellWidth, cellWidth);
        [boxCell setFrame:boxRect];
        [boxCell setRow:boxPos.height];
        [boxCell setColumn:boxPos.width];
        [map setBoxAtIndex:i toPositionX:boxPos.width Y:boxPos.height];
    }
    
    CGSize personPos = [map personStartPosition];
    CGRect personRect = CGRectMake(personPos.width*cellWidth, personPos.height*cellWidth,
                                   cellWidth, cellWidth);
    [personCell setFrame:personRect];
    [personCell setColumn:personPos.width];
    [personCell setRow:personPos.height];
    [self setNeedsDisplay];
}


- (void)playActionsFromBackward:(NSArray*)actions
{
    NSLog(@"play actions %d",(int)[actions count]);
    int last = (int)[actions count] - 1;
    [gameAnimation clear];
    for (int i = last; i >= 0; i--)
    {
        NSString* act = [actions objectAtIndex:i];
        [self playActionBackWard:act];
    }
    [gameAnimation start];
}

- (void)playActionBackWard:(NSString*)act
{
    //回退情况
    NSArray* strs = [act componentsSeparatedByString:@","];
    if ([strs count] >= 3)
    {
        
        NSString* s1 = [strs objectAtIndex:0];
        if ([s1 isEqualToString:@"p"])
        {
            NSString* sx = [strs objectAtIndex:1];
            NSString* sy = [strs objectAtIndex:2];
            int px = (int)[sx integerValue];
            int py = (int)[sy integerValue];
            CSAnimationItem* perAni = [self movePersonToX:px y:py];
            CSAnimationGroup* group = [CSAnimationGroup groupWithItem:perAni];
            [gameAnimation addAnimationGroup:group];
            NSLog(@"move p back %d,%d",px,py);
        }else if([s1 isEqualToString:@"b"])
        {
            NSString* sx1 = [strs objectAtIndex:1];
            NSString* sy1 = [strs objectAtIndex:2];
            NSString* sx2 = [strs objectAtIndex:3];
            NSString*  sy2 = [strs objectAtIndex:4];
            int x1 = (int)[sx1 integerValue];
            int y1 = (int)[sy1 integerValue];
            int x2 = (int)[sx2 integerValue];
            int y2 = (int)[sy2 integerValue];
            BoxMapCell* boxCell = [self boxCellAtX:x2 y:y2];
            CSAnimationItem* boxAni = [self moveBox:boxCell toX:x1 y:y1];
            CSAnimationGroup* group = [CSAnimationGroup groupWithItem:boxAni];
            [gameAnimation addAnimationGroup:group];
            NSLog(@"move b back:%d,%d",x1,y1);
        }else if([s1 isEqualToString:@"bp"])
        {
            NSString* sboxID = [strs objectAtIndex:1];
            NSString* spx1 = [strs objectAtIndex:4];
            NSString* spy1 = [strs objectAtIndex:5];
            NSString* spx2 = [strs objectAtIndex:6];
            NSString* spy2 = [strs objectAtIndex:7];
            int boxID = (int)[sboxID integerValue];
            int px1 = (int)[spx1 integerValue];
            int py1 = (int)[spy1 integerValue];
            int px2 = (int)[spx2 integerValue];
            int py2 = (int)[spy2 integerValue];
            
            //BoxMapCell* boxCell = [self boxCellAtX:bx2 y:by2];
            //CSAnimationItem* boxAni = [self moveBox:boxCell toX:bx1 y:by1];
            //CSAnimationItem* boxAni = [self moveBox:boxID toX:bx2 toY:by2];
            CSAnimationItem* boxAni = [self moveBox:boxID toX:px1 toY:py1];
            CSAnimationItem* personAni = [self movePersonToX:px2 y:py2];
            //CSAnimationItem* personAni = [self movePersonToX:px1 y:py1];
            CSAnimationGroup* group = [CSAnimationGroup groupWithItems:[NSArray arrayWithObjects:personAni,boxAni, nil]];
            [gameAnimation addAnimationGroup:group];
        }
    }
}

- (void)playActions:(NSArray*)actions
{
    for (NSString* act in actions)
    {
        NSArray* strs = [act componentsSeparatedByString:@","];
        if ([strs count] >= 3)
        {
            NSString* s1 = [strs objectAtIndex:0];
            if ([s1 isEqualToString:@"p"])
            {
                NSString* sx = [strs objectAtIndex:1];
                NSString* sy = [strs objectAtIndex:2];
                int px = (int)[sx integerValue];
                int py = (int)[sy integerValue];
                CSAnimationItem* perAni = [self movePersonToX:px y:py];
                CSAnimationGroup* group = [CSAnimationGroup groupWithItem:perAni];
                [gameAnimation addAnimationGroup:group];
                NSLog(@"move p back %d,%d",px,py);
            }else if([s1 isEqualToString:@"b"])
            {
                NSString* sx1 = [strs objectAtIndex:1];
                NSString* sy1 = [strs objectAtIndex:2];
                NSString* sx2 = [strs objectAtIndex:3];
                NSString*  sy2 = [strs objectAtIndex:4];
                int x1 = (int)[sx1 integerValue];
                int y1 = (int)[sy1 integerValue];
                int x2 = (int)[sx2 integerValue];
                int y2 = (int)[sy2 integerValue];
                BoxMapCell* boxCell = [self boxCellAtX:x2 y:y2];
                CSAnimationItem* boxAni = [self moveBox:boxCell toX:x1 y:y1];
                CSAnimationGroup* group = [CSAnimationGroup groupWithItem:boxAni];
                [gameAnimation addAnimationGroup:group];
            }else if([s1 isEqualToString:@"bp"])
            {
                NSString* sboxID = [strs objectAtIndex:1];
                NSString* sbx2 = [strs objectAtIndex:2];
                NSString* sby2 = [strs objectAtIndex:3];
                NSString* spx1 = [strs objectAtIndex:4];
                NSString* spy1 = [strs objectAtIndex:5];
                int boxID = (int)[sboxID integerValue];
                int bx2 = (int)[sbx2 integerValue];
                int by2 = (int)[sby2 integerValue];
                int px1 = (int)[spx1 integerValue];
                int py1 = (int)[spy1 integerValue];
                
                //BoxMapCell* boxCell = [self boxCellAtX:bx1 y:by1];
                //CSAnimationItem* bAni = [self moveBox:boxCell toX:bx2 y:by2];
                CSAnimationItem* bAni = [self moveBox:boxID toX:bx2 toY:by2];
                CSAnimationItem* pAni = [self movePersonToX:px1 y:py1];
                CSAnimationGroup* group = [CSAnimationGroup groupWithItems:[NSArray arrayWithObjects:pAni,bAni, nil]];
                [gameAnimation addAnimationGroup:group];
            }
            
        }
    }
    
    /*
    for (NSString* act in actions)
    {
        [self performSelectorOnMainThread:@selector(playAction:) withObject:act waitUntilDone:NO];
    }
     */
    
}

- (void)playAction:(NSString*)act
{
    NSArray* strs = [act componentsSeparatedByString:@","];
    if ([strs count] >= 3)
    {
        NSString* s1 = [strs objectAtIndex:0];
        if ([s1 isEqualToString:@"p"])
        {
            NSString* sx = [strs objectAtIndex:1];
            NSString* sy = [strs objectAtIndex:2];
            int px = (int)[sx integerValue];
            int py = (int)[sy integerValue];
            [self movePersonToX:px y:py];
            NSLog(@"move p back %d,%d",px,py);
        }else if([s1 isEqualToString:@"b"])
        {
            NSString* sx1 = [strs objectAtIndex:1];
            NSString* sy1 = [strs objectAtIndex:2];
            NSString* sx2 = [strs objectAtIndex:3];
            NSString*  sy2 = [strs objectAtIndex:4];
            int x1 = (int)[sx1 integerValue];
            int y1 = (int)[sy1 integerValue];
            int x2 = (int)[sx2 integerValue];
            int y2 = (int)[sy2 integerValue];
            BoxMapCell* boxCell = [self boxCellAtX:x1 y:y1];
            [self moveBox:boxCell toX:x2 y:y2];
        }
        
    }
}

- (void)onExitAnswerView
{
    [gameAnimation stop];
    [gameAnimation clear];
    isPlayingAnswer = NO;
    [answerView removeFromSuperview];
    [self initPersonAndBoxPosition];
}

- (void)updatePlayButton
{
    if (!isPlayingAnswer)
    {
        UIImage* playImg = [UIImage imageNamed:@"guess_button_play.png"];
        [playButton setImage:playImg forState:UIControlStateNormal];
    }else
    {
        UIImage* pauseImg = [UIImage imageNamed:@"guess_button_pause.png"];
        [playButton setImage:pauseImg forState:UIControlStateNormal];
    }
}

- (void)onPlayButton
{
    NSLog(@"on play button is pressed");
    isPlayingAnswer = !isPlayingAnswer;
    [self updatePlayButton];
    
    if (!isPlayingAnswer)
    {
        [gameAnimation stop];
    }else
    {
        //[gameAnimation clear];
        if ([[gameAnimation groups] count] <= 0)
        {
            NSLog(@"增加游戏动画");
            [self initPersonAndBoxPosition];
            for (NSArray* actions in [map answerArray])
            {
                [self playActions:actions];
            }
        }
        [gameAnimation start];
    }
}

#pragma mark -
#pragma mark CSAnimationSequenceDelegate
- (void)animationSequenceFinished
{
    NSLog(@"animation seq finished");
    isPlayingAnswer = NO;
    [self updatePlayButton];
    [gameAnimation clear];
}
@end
