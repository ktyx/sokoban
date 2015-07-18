//
//  PushBoxController.m
//  Pushbox
//
//  Created by daxin on 13-10-1.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "PushBoxController.h"
#import "BoxMap.h"
#import "AStarNode.h"
#import "BoxCell.h"
#import "LevelManager.h"
#import "CSAnimation.h"

@interface PushBoxController ()
- (void)responseToButtonAction:(id)sender;
- (BoxMapCell*)boxCellAtX:(int)ax y:(int)ay;

- (void)changeToReadyState;

- (CSAnimationItem*)movePersonToX:(int)ax y:(int)ay addStep:(BOOL)isadd;
- (CSAnimationItem*)moveBox:(int)aid toX:(int)ax toY:(int)ay;
- (void)popWinTip;
- (void)dismissLevelView;
- (void)updateStepLabel;
- (void)updateGoBackButton;

- (void)playActionsFromBackward:(NSArray*)actions;
- (void)playActionBackWard:(NSString*)act;
- (void)playActions:(NSArray*)actions;

- (void)updatePlayButton;
- (void)updateBoxState:(BoxCell*)acell;

- (void)refreshMap;

- (void)showDarkView;
- (void)hideDarkView;

- (void)updateButtonPanelPosition;
@end

@implementation PushBoxController
@synthesize bgImageView;
@synthesize levelLabel;
@synthesize stepLabel;
@synthesize gameView;
@synthesize goBackButton;
@synthesize playAnswerView;
@synthesize playAnswerButton;
@synthesize answerPanel;
@synthesize darkView;
@synthesize fingerView;

@synthesize levelView;
@synthesize starView1;
@synthesize starView2;
@synthesize starView3;
@synthesize stepNumLabel;
@synthesize leastNumLabel;
@synthesize leastStepLabel;

@synthesize buttonPanel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString* xibStr = [CSDevice univesal_xib:@"PushBoxController"];
    self = [super initWithNibName:xibStr bundle:nibBundleOrNil];
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithLevel:(int)alevel
{
    self = [super init];
    if (self)
    {
        map = [[BoxMap alloc] initWithLevel:alevel];
        
        mapCellArray = [[NSMutableArray alloc] init];
        boxCellArray = [[NSMutableArray alloc] init];
        actionHistory = [[NSMutableArray alloc] init];
        oneAction = nil;
        
        gameAnimation = [[CSAnimationSequence alloc] init];
        [gameAnimation setDelegate:self];
        animationIntelval = PER_MOVE_TIME_MAX;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int stepFontSize = [[stepLabel font] pointSize];
    UIFont* stepFont = [UIFont fontWithName:@"CarterOne" size:stepFontSize];
    [stepLabel setFont:stepFont];

    mGameViewWidth = [gameView frame].size.width;
    mGameViewHeight = [gameView frame].size.height;
    mGameViewStartY = [gameView frame].origin.y;
    mButtonPanelHeight = [buttonPanel frame].size.height;
    [self refreshMap];

    CGRect playAnswerRect = CGRectMake(0, 0,
                                       playAnswerView.frame.size.width,playAnswerView.frame.size.height);
    [playAnswerView setFrame:playAnswerRect];
    [self.view addSubview:playAnswerView];
    [playAnswerView setHidden:YES];
    
    [self.view addSubview:levelView];
    [levelView setHidden:YES];
    
    [self hideDarkView];
     
    [self updateButtonPanelPosition];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [gameAnimation clear];
    [gameAnimation stop];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [map release];
    
    [gameAnimation release];
    [actionHistory release];
    [boxCellArray release];
    [mapCellArray release];
    [super dealloc];
}

- (IBAction)onBack:(id)sender
{
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshMap
{
    for (BoxMapCell* mc in mapCellArray)
    {
        [mc removeFromSuperview];
    }
    [mapCellArray removeAllObjects];
    for (BoxCell* mc in boxCellArray)
    {
        [mc removeFromSuperview];
    }
    [boxCellArray removeAllObjects];
    [actionHistory removeAllObjects];
    [personCell removeFromSuperview];
    [self updateGoBackButton];
    [gameAnimation clear];
    
    //CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    NSString* levelText = [NSString stringWithFormat:CSLOCAL(@"LEVEL %d"),[map level]];
    [levelLabel setText:levelText];
    
    float rawHeight = mGameViewHeight / [map row];
    float rawWidth = mGameViewWidth / [map column];
    cellWidth = (rawHeight > rawWidth) ? rawWidth : rawHeight;
    if (cellWidth > PH_CELLSIZE_MAX)
    {
        cellWidth = PH_CELLSIZE_MAX;
    }
    cellStartX = (mGameViewWidth - cellWidth*[map column])/2.0;
    cellStartY = (mGameViewHeight - cellWidth*[map row] - mButtonPanelHeight)/2.0;
    
    CGRect newGameRect = CGRectMake(cellStartX, mGameViewStartY + cellStartY, cellWidth*[map column], cellWidth*[map row]);
    [gameView setFrame:newGameRect];
        
    int mapSize = [map cellNum];
    for (int i = 0; i < mapSize; i++)
    {
        BoxMapCell* mapCell = [BoxMapCell buttonWithType:UIButtonTypeCustom];
        [mapCell setTag:i];
        int curColumn = i % [map column];
        int curRow = i / [map column];
        CGRect btnRect = CGRectMake(curColumn*cellWidth,curRow*cellWidth, cellWidth, cellWidth);
        [mapCell setFrame:btnRect];
        [mapCell addTarget:self action:@selector(responseToButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        MapCellType cellType = [map typeForCellAtIndex:i];
        [mapCell setRow:curRow];
        [mapCell setColumn:curColumn];
        [mapCell setType:cellType];
        [mapCellArray addObject:mapCell];
        [gameView addSubview:mapCell];
    }
        
    int boxNum = [map boxNum];
    for (int i = 0; i < boxNum; i++)
    {
        CGSize boxPos = [map positionForBox:i];
        CGRect boxRect = CGRectMake(boxPos.width *cellWidth,boxPos.height * cellWidth,
                                    cellWidth, cellWidth);
        BoxCell* boxCell = [[BoxCell alloc] initWithFrame:boxRect];
        [boxCell addTarget:self action:@selector(responseToButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];

        [boxCell setFrame:boxRect];
        [boxCell setRow:boxPos.height];
        [boxCell setColumn:boxPos.width];
        [boxCell setTag:i];
        [self updateBoxState:boxCell];
        [boxCellArray addObject:boxCell];
        [gameView addSubview:boxCell];
    }
    
    CGSize personPos = [map personStartPosition];
    CGRect personRect = CGRectMake(personPos.width*cellWidth,
                                   personPos.height*cellWidth,
                                   cellWidth, cellWidth);
    personCell = [[BoxManCell alloc] initWithFrame:personRect];
    [gameView addSubview:personCell];
    [personCell setColumn:personPos.width];
    [personCell setRow:personPos.height];
        
    steps = 0;
    [self updateStepLabel];
    
    NSString* leastStr = [NSString stringWithFormat:@"%d",[map leastStepNum]];
    [leastStepLabel setText:leastStr];
}

- (void)showDarkView
{
    [darkView setAlpha:0];
    [darkView setHidden:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [darkView setAlpha:1];
    }completion:^(BOOL isfinished)
    {
        [gameView setUserInteractionEnabled:NO];
    }];
}

- (void)hideDarkView
{
    [UIView animateWithDuration:0.2 animations:^{
        [darkView setAlpha:0];
    }completion:^(BOOL isfinished){
        [darkView setHidden:YES];
        [gameView setUserInteractionEnabled:YES];
    }];
}

- (void)updateButtonPanelPosition
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect gameRect = gameView.frame;
    int blankStartY = gameRect.origin.y + gameRect.size.height;
    /*
    if ( [CSDevice isPhone4])
    {
        blankStartY = gameRect.origin.y + gameRect.size.height;
    }else
    {
        blankStartY = screenRect.size.height - blankStartY - 50;
        //blankStartY = gameRect.origin.y + gameRect.size.height - 50;
    }
     */
    if (![CSDevice isPhone4])
    {
        //blankStartY -= 50;
    }
    int blankHeight = screenRect.size.height - blankStartY;
    CGRect panelRect = buttonPanel.bounds;
    int newPanelStartY = blankStartY + (blankHeight - panelRect.size.height - 36)/2.0;
    CGRect newPanelRect = CGRectMake((screenRect.size.width - panelRect.size.width)/2.0,
                                     newPanelStartY, panelRect.size.width, panelRect.size.height);
    [buttonPanel setFrame:newPanelRect];
}

- (IBAction)cancel_a_step:(id)sender
{
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    
    if ([actionHistory count] > 0)
    {
        NSArray* action = [actionHistory lastObject];
        [self playActionsFromBackward:action];
        [actionHistory removeLastObject];
        [self updateGoBackButton];
        
        int num = (int)[action count] - 1;
        steps -= num;
        if (steps < 0)
        {
            steps = 0;
        }
        [self updateStepLabel];
    }
}

- (IBAction)onShowAnswerPanel:(id)sender
{
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [playAnswerView setHidden:NO];
    [self.view bringSubviewToFront:playAnswerView];
    
    [self showDarkView];
    [answerPanel.layer addAnimation:[CSAnimation popup] forKey:@"pop up ani"];
    
    //归位
    isPlayingAnswer = NO;
    [self updatePlayButton];
    [self changeToReadyState];
    [gameAnimation clear];
}

- (IBAction)onReplay:(id)sender
{
    //[CSConfirmAlertView showConfirm:@"Restart?" withDelegate:self];
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    [CSConfirmAlertView showConfirm:CSLOCAL(@"restart?") withDelegate:self];
}

- (IBAction)onPlayAnswer:(id)sender
{
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    
    isPlayingAnswer = !isPlayingAnswer;
    animationIntelval = PER_MOVE_TIME_ANSWER;
    [self updatePlayButton];
    
    if (!isPlayingAnswer)
    {
        [gameAnimation stop];
        //[self showDarkView];
    }else
    {
        if ([[gameAnimation groups] count] <= 0)
        {
            [self changeToReadyState];
            
            [fingerView setHidden:YES];
            
            for (NSArray* actions in [map answerArray])
            {
                //add finger touch animation
                [fingerView setHidden:NO];
           
                
                int target_x = 0, target_y = 0;
                NSString* posStr = [actions lastObject];
                NSArray* strs = [posStr componentsSeparatedByString:@","];
                if ([strs count] >= 3)
                {
                    NSString* s1 = [strs objectAtIndex:0];
                    if ([s1 isEqualToString:@"p"])
                    {
                        NSString* sx = [strs objectAtIndex:1];
                        NSString* sy = [strs objectAtIndex:2];
                        target_x = (int)[sx integerValue];
                        target_y = (int)[sy integerValue];
                    }
                    else if([s1 isEqualToString:@"bp"])
                    {
                        NSString* spx1 = [strs objectAtIndex:4];
                        NSString* spy1 = [strs objectAtIndex:5];
                        target_x = (int)[spx1 integerValue];
                        target_y = (int)[spy1 integerValue];
                    }
                }
                
                int targetCellID = target_y * [map column] + target_x;
                BoxMapCell* cell = [mapCellArray objectAtIndex:targetCellID];
                
                CGRect fingerRect = CGRectMake(gameView.frame.origin.x + (target_x + 0.5) * cellWidth,
                                               gameView.frame.origin.y + (target_y + 0.5) * cellWidth,
                                               cellWidth, cellWidth);
                
                CSAnimationItem* posChangeAniItem = [CSAnimationItem itemWithDuration:0 delay:0
                                                                              options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                                                                  //[personCell pauseAnimation];
                                                                                  [fingerView setFrame:fingerRect];
                                                                                  [fingerView setHidden:NO];
                                                                              }];
                
                CSAnimationItem* fAnim1 =
                [CSAnimationItem itemWithDuration:0.6  delay:0
                                            options:UIViewAnimationOptionCurveEaseInOut
                                         animations:^{
                                             [cell setSelected:YES];
                                             CGRect rect1 = CGRectInset(fingerRect,
                                                                        fingerRect.size.width*0.05,
                                                                        fingerRect.size.height*0.05);
                                             [fingerView setFrame:rect1];
                                         }];
                CSAnimationItem* fAnim2 =
                [CSAnimationItem itemWithDuration:0.6  delay:0
                                          options:UIViewAnimationOptionCurveEaseInOut
                                       animations:^{
                                           [cell setSelected:YES];
                                           CGRect rect1 = CGRectInset(fingerRect,
                                                                      -fingerRect.size.width*0.05,
                                                                      -fingerRect.size.height*0.05);
                                           [fingerView setFrame:rect1];
                                       }];
                CSAnimationItem* fAnim3 =
                [CSAnimationItem itemWithDuration:0.6  delay:0
                                          options:UIViewAnimationOptionCurveEaseInOut
                                       animations:^{
                                           [cell setSelected:YES];
                                           CGRect rect1 = CGRectInset(fingerRect,
                                                                      -fingerRect.size.width*0.05,
                                                                      -fingerRect.size.height*0.05);
                                                                      [fingerView setFrame:rect1];
                                       }];
                CSAnimationItem* removeFingerAniItem =
                [CSAnimationItem itemWithDuration:1.5 delay:0
                                          options:UIViewAnimationOptionCurveEaseInOut
                                       animations:^{
                                           [cell setSelected:NO];
                                           [fingerView setHidden:YES];
                                       }];
                CSAnimationGroup* group1 = [CSAnimationGroup groupWithItems:[NSArray arrayWithObjects:posChangeAniItem,nil]];
                [gameAnimation addAnimationGroup:group1];
                
                CSAnimationGroup* group2 = [CSAnimationGroup groupWithItems:[NSArray arrayWithObjects:fAnim1, nil]];
                [gameAnimation addAnimationGroup:group2];
                
                CSAnimationGroup* group3 = [CSAnimationGroup groupWithItems:[NSArray arrayWithObjects:fAnim2, nil]];
                [gameAnimation addAnimationGroup:group3];
                
                CSAnimationGroup* group4 = [CSAnimationGroup groupWithItems:[NSArray arrayWithObjects:fAnim3, nil]];
                [gameAnimation addAnimationGroup:group4];
                
                CSAnimationGroup* group5 = [CSAnimationGroup groupWithItems:[NSArray arrayWithObjects:removeFingerAniItem, nil]];
                [gameAnimation addAnimationGroup:group5];
                
                [self playActions:actions];
            }
        }
        [gameAnimation start];
    }
}

- (IBAction)onStopPlayAnswer:(id)sender
{
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    isPlayingAnswer = NO;
    animationIntelval = PER_MOVE_TIME_MAX;
    [playAnswerView setHidden:YES];
    [self changeToReadyState];
    
    [self hideDarkView];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)stopAllAnimations
{
    [gameAnimation clear];
    [gameAnimation stop];
}


#pragma mark -
#pragma mark UIButton Action
- (void)responseToButtonAction:(id)sender
{
    BoxMapCell* cell = (BoxMapCell*)sender;
    
    int boxIndex = 0;
    for (boxIndex = 0; boxIndex < [boxCellArray count]; boxIndex++)
    {
        BoxCell* c = [boxCellArray objectAtIndex:boxIndex];
        if ([c isEqual:cell])
        {
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
        
        int stepnum = (int)[nodes count] - 1;
        float moveTime = 0;
        if (stepnum > 0)
        {
            moveTime = MOVE_PERIOD_MAX / stepnum;
            if (moveTime > PER_MOVE_TIME_MAX)
            {
                animationIntelval = PER_MOVE_TIME_MAX;
            }else
            {
                animationIntelval = moveTime;
            }
        }
        //NSLog(@" step num:%d aniint:%.2f",stepnum,moveTime);
        
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
                
                // if there's no box at next position
                if (boxCellAtBoxNext == nil)
                {
                    if ([mapCellForBoxNext type] == MAPCELL_FLOOR ||
                        [mapCellForBoxNext type] == MAPCELL_TARGET )
                    {
                        if (oneAction != nil)
                        {
                            [oneAction addObject:[NSString stringWithFormat:@"bp,%d,%d,%d,%d,%d,%d,%d",boxIndex,
                                                  bx,by,[nextNode column],[nextNode row],[last2Node column],[last2Node row]]];
                        }
                        CSAnimationItem* boxAni = [self moveBox:boxIndex toX:bx toY:by];

                        CSAnimationItem* perAni = [self movePersonToX:[nextNode column] y:[nextNode row] addStep:YES];
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
                CSAnimationItem* perAni = [self movePersonToX:[nextNode column] y:[nextNode row] addStep:YES];
                CSAnimationGroup* group = [CSAnimationGroup groupWithItem:perAni];
                [gameAnimation addAnimationGroup:group];
            }
            if (i == 0)
            {
                if (oneAction != nil)
                {
                    [actionHistory addObject:oneAction];
                    [self updateGoBackButton];
                    [oneAction release];
                    oneAction = nil;
                }
            }
        }
        
        [gameAnimation start];
        [nodes release];
    }
}

- (CSAnimationItem*)movePersonToX:(int)ax y:(int)ay addStep:(BOOL)isadd
{
    CGRect newRect = CGRectMake(ax*cellWidth,
                                ay*cellWidth,
                                cellWidth, cellWidth);
    
    CGPoint cp = CGPointMake(newRect.origin.x + newRect.size.width / 2.0,
                             newRect.origin.y + newRect.size.width/2.0);
    
    CSAnimationItem* moveItem = [CSAnimationItem itemWithDuration:animationIntelval  delay:0
                                                          options:UIViewAnimationOptionCurveLinear
                                                       animations:^{
                                                           int x_dis = [personCell column] - ax;
                                                           int y_dis = [personCell row] - ay;
                                                           BoxManOrientation ori = BoxManOrientationNone;
                                                           if (x_dis > 0)
                                                           {
                                                               ori = BoxManOrientationLeft;
                                                           }else if(x_dis < 0)
                                                           {
                                                               ori = BoxManOrientationRight;
                                                           }else
                                                           {
                                                               if (y_dis > 0)
                                                               {
                                                                   ori = BoxManOrientationUp;
                                                               }else
                                                               {
                                                                   ori = BoxManOrientationDown;
                                                               }
                                                           }
                                                              [personCell setCenter:cp];
                                                              [personCell setColumn:ax];
                                                              [personCell setRow:ay];
                                                              [personCell updateOrientation:ori];
                                                           
                                                              if (isadd)
                                                              {
                                                                  steps ++;
                                                                  [self updateStepLabel];
                                                              }
                                                          }];
    return moveItem;
}

- (CSAnimationItem*)moveBox:(int)boxID toX:(int)ax toY:(int)ay;
{
    if (boxID >= [map boxNum])
    {
        NSLog(@"moveBox:toX:toY aid参数过大");
        return nil;
    }
    
    BoxCell* boxCell = [boxCellArray objectAtIndex:boxID];
    
    CGRect boxRect = CGRectMake(ax * cellWidth,
                                ay * cellWidth,
                                cellWidth, cellWidth);
    CGPoint cp = CGPointMake(boxRect.origin.x + boxRect.size.width/2.0, boxRect.origin.y + boxRect.size.height/2.0);
    
    CSAnimationItem* moveItem = [CSAnimationItem itemWithDuration:animationIntelval delay:0
                                                          options:UIViewAnimationOptionCurveLinear
                                                       animations:
                                 ^{
                                     [map setBoxAtIndex:boxID toPositionX:ax Y:ay];
                                     [boxCell setCenter:cp];
                                     [boxCell setColumn:ax];
                                     [boxCell setRow:ay];
                                     [self updateBoxState:boxCell];
                                     
                                     if ([map isFinished])
                                     {
                                         NSArray* folders = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                                         NSString* filename = [NSString stringWithFormat:@"action%d",[map level]];
                                         NSString* actionPath = [[folders objectAtIndex:0] stringByAppendingPathComponent:filename];
                                         //NSLog(@"action path:%@",actionPath);
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
                                             [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
                                                                            selector:@selector(popWinTip)
                                                                            userInfo:nil repeats:NO];
                                         }
                                     }
                                 }];
    return moveItem;
}


- (void)popWinTip
{
    [levelView setHidden:NO];
    
    //calc level star
    int starLevel = 0;
    int leastStep = [map leastStepNum];
    if (steps <= leastStep)
    {
        starLevel = 3;
    }else if(steps <= leastStep * 1.2)
    {
        starLevel = 2;
    }else
    {
        starLevel = 1;
    }
    if (starLevel > 0)
    {
        [starView1 setHidden:NO];
    }
    if (starLevel > 1)
    {
        [starView2 setHidden:NO];
    }
    if (starLevel > 2)
    {
        [starView3 setHidden:NO];
    }
    
    NSString* stepStr = [NSString stringWithFormat:@"%d",steps];
    [stepNumLabel setText:stepStr];
    NSString* leastStepStr = [NSString stringWithFormat:@"%d",[map leastStepNum]];
    [leastNumLabel setText:leastStepStr];
    
    int currentLevel = [map level] - 1;
    LevelItem* li = [[LevelManager sharedInstance] levelItemAtIndex:currentLevel];
    if ([li score] < starLevel)
    {
        [li setScore:starLevel];
    }

    if (([map level] < TOTAL_LEVEL_NUM) &&
        ![[LevelManager sharedInstance] isUnlock:[map level]])
    {
        [[LevelManager sharedInstance] unlockLevel:[map level]];
    }
    [[LevelManager sharedInstance] saveToDocument];
}

- (void)dismissLevelView
{
    [levelView setHidden:YES];
    [starView1 setHidden:YES];
    [starView2 setHidden:YES];
    [starView3 setHidden:YES];
}

- (void)updateStepLabel
{
    NSString* str = [NSString stringWithFormat:@"%d",steps];
    [stepLabel setText:str];
}

- (void)updateGoBackButton
{
    if ([actionHistory count] == 0)
    {
        [goBackButton setHidden:YES];
    }else if ([actionHistory count] > 0)
    {
        [goBackButton setHidden:NO];
    }
}

- (BoxMapCell*)boxCellAtX:(int)ax y:(int)ay
{
    BoxMapCell* res = nil;
    for (BoxCell* cell in boxCellArray)
    {
        if (([cell column] == ax) && ([cell row] == ay))
        {
            res = cell;
            break;
        }
    }
    return res;
}

- (void)changeToReadyState
{
    //两个参数都被改了，需要增加参数
    int boxNum = [map boxNum];
    for (int i = 0; i < boxNum; i++)
    {
        BoxCell* boxCell = [boxCellArray objectAtIndex:i];
        CGSize boxPos = [map originalPositionForBox:i];
        CGRect boxRect = CGRectMake(boxPos.width *cellWidth,
                                    boxPos.height * cellWidth,
                                    cellWidth, cellWidth);
        [boxCell setFrame:boxRect];
        [boxCell setRow:boxPos.height];
        [boxCell setColumn:boxPos.width];
        [map setBoxAtIndex:i toPositionX:boxPos.width Y:boxPos.height];
        [self updateBoxState:boxCell];
    }
    
    CGSize personPos = [map personStartPosition];
    CGRect personRect = CGRectMake(personPos.width*cellWidth,
                                 personPos.height*cellWidth,
                                   cellWidth, cellWidth);
    [personCell setFrame:personRect];
    [personCell setColumn:personPos.width];
    [personCell setRow:personPos.height];
    [self.view setNeedsDisplay];
    
    //step label 清零
    steps = 0;
    [self updateStepLabel];
    
    //操作纪录清零
    [actionHistory removeAllObjects];
    [self updateGoBackButton];
    [gameAnimation clear];
}


- (void)playActionsFromBackward:(NSArray*)actions
{
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
            CSAnimationItem* perAni = [self movePersonToX:px y:py addStep:NO];
            CSAnimationGroup* group = [CSAnimationGroup groupWithItem:perAni];
            [gameAnimation addAnimationGroup:group];
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
            
            CSAnimationItem* boxAni = [self moveBox:boxID toX:px1 toY:py1];
            CSAnimationItem* personAni = [self movePersonToX:px2 y:py2 addStep:NO];
            CSAnimationGroup* group = [CSAnimationGroup groupWithItems:[NSArray arrayWithObjects:personAni,boxAni, nil]];
            [gameAnimation addAnimationGroup:group];
        }
    }
}

- (void)playActions:(NSArray*)actions
{
    int i = 0;
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
                BOOL isadd = YES;
                if (i == 0)
                {
                    isadd = NO;
                }
                CSAnimationItem* perAni = [self movePersonToX:px y:py addStep:isadd];
                CSAnimationGroup* group = [CSAnimationGroup groupWithItem:perAni];
                [gameAnimation addAnimationGroup:group];
            }
            else if([s1 isEqualToString:@"bp"])
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
                
                BOOL isadd = YES;
                if (i == 0)
                {
                    isadd = NO;
                }
                CSAnimationItem* bAni = [self moveBox:boxID toX:bx2 toY:by2];
                CSAnimationItem* pAni = [self movePersonToX:px1 y:py1 addStep:isadd];
                CSAnimationGroup* group = [CSAnimationGroup groupWithItems:[NSArray arrayWithObjects:pAni,bAni, nil]];
                [gameAnimation addAnimationGroup:group];
            }
            
        }
        i++;
    }
}

- (void)updatePlayButton
{
    if (!isPlayingAnswer)
    {
        UIImage* playImg = [UIImage imageNamed:@"button_play.png"];
        [playAnswerButton setImage:playImg forState:UIControlStateNormal];
        [playAnswerButton.layer addAnimation:[CSAnimation pulse] forKey:@"pulse"];
    }else
    {
        UIImage* pauseImg = [UIImage imageNamed:@"button_pause.png"];
        [playAnswerButton setImage:pauseImg forState:UIControlStateNormal];
        [playAnswerButton.layer removeAllAnimations];
    }
}

- (void)updateBoxState:(BoxCell*)acell
{
    int bx = [acell column];
    int by = [acell row];
    int bcIndex = by * [map column] + bx;
    MapCellType bcType = [map typeForCellAtIndex:bcIndex];
    if (bcType == MAPCELL_TARGET)
    {
        [acell setBoxPushIntoTarget:YES];
    }else
    {
        [acell setBoxPushIntoTarget:NO];
    }
}


#pragma mark -
#pragma mark CSAnimationSequenceDelegate
- (void)animationSequenceFinished
{
    isPlayingAnswer = NO;
    [self updatePlayButton];
    [gameAnimation clear];
    
    [personCell stopAnimation];
}

#pragma mark -
#pragma mark LEVEL CLEAR 
- (IBAction)goToMenuPage:(id)sender
{
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)replayThisLevel:(id)sender
{
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    [self dismissLevelView];
    [self changeToReadyState];
}

- (IBAction)goToNextLevel:(id)sender
{
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    int currentLevel = [map level];
    //此处应该判断是否有下一个LEVEL
    if (currentLevel + 1 <= TOTAL_LEVEL_NUM)
    {
        [map updateLevelData:currentLevel+1];
        [self refreshMap];
    }else
    {
        UIAlertView* successAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"No more levels, well done!!!"
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil, nil];
        [successAlert show];
        [successAlert release];
    }
    
    [self dismissLevelView];
}


#pragma mark -
#pragma mark CSConfirmAlertViewDelegate
- (void) confirmAlertViewYesPressed:(CSConfirmAlertView*)alertview
{
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    [self changeToReadyState];
}

- (void) confirmAlertViewCancelPressed:(CSConfirmAlertView*)alertview
{
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
}
@end
