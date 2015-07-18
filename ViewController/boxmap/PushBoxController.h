//
//  PushBoxController.h
//  Pushbox
//
//  Created by daxin on 13-10-1.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSViewController.h"
#import "BoxMap.h"
#import "BoxMapCell.h"
#import "CSAnimationSequence.h"
#import "CSBrownLabel.h"

#import "BoxManCell.h"

#import "CSConfirmAlertView.h"

#import "CSGlobal.h"
#import "CSDevice.h"
#import "CSSound.h"


#define PH_CELLSIZE_MAX  42
#define PAD_CELLSIZE_MAX 56

#define PER_MOVE_TIME_MAX   (0.24)
#define MOVE_PERIOD_MAX (1.5)
#define PER_MOVE_TIME_ANSWER (0.4)

@interface PushBoxController : CSViewController<CSAnimationSequenceDelegate, CSConfirmAlertViewDelegate>
{
    BoxMap*         map;
    
    NSMutableArray*  mapCellArray;
    NSMutableArray*  boxCellArray;
    
    BoxManCell*      personCell;
    
    int              cellWidth;
    float            cellStartX;
    int              cellStartY;
    
    int              steps;
    
    NSMutableArray*  actionHistory;
    NSMutableArray*  oneAction;
    NSArray*         answerArray;
    
    
    CSAnimationSequence*  gameAnimation;
    
    
    BOOL             isPlayingAnswer;
    UIButton*         playButton;
    float            animationIntelval;
    
    int              mGameViewWidth;
    int              mGameViewHeight;
    int              mGameViewStartY;
    int              mButtonPanelHeight;
}


- (id) initWithLevel:(int)alevel;
- (IBAction) onBack:(id)sender;
- (IBAction) cancel_a_step:(id)sender;
- (IBAction) onReplay:(id)sender;


- (void) stopAllAnimations;

@property (nonatomic, retain) IBOutlet UIImageView*  bgImageView;
@property (nonatomic, retain) IBOutlet CSBrownLabel*  levelLabel;
@property (nonatomic, retain) IBOutlet UILabel*         stepLabel;
@property (nonatomic, retain) IBOutlet UIView*        gameView;
@property (nonatomic, retain) IBOutlet UIButton*      goBackButton;

//PLAY ANSWER
@property (nonatomic, retain) IBOutlet UIView*        playAnswerView;
@property (nonatomic, retain) IBOutlet UIButton*      playAnswerButton;
@property (nonatomic, retain) IBOutlet UIImageView*   fingerView;
@property (nonatomic, retain) IBOutlet UIView*        answerPanel;
@property (nonatomic, retain) IBOutlet UIView*        darkView;
- (IBAction)onShowAnswerPanel:(id)sender;
- (IBAction)onPlayAnswer:(id)sender;
- (IBAction)onStopPlayAnswer:(id)sender;

//update button position
@property (nonatomic, retain) IBOutlet UIView*       buttonPanel;


@property (nonatomic, retain) IBOutlet UILabel*       leastStepLabel;

//LEVEL CLEAR
@property (nonatomic, retain) IBOutlet UIView*      levelView;
@property (nonatomic, retain) IBOutlet UIImageView*  starView1;
@property (nonatomic, retain) IBOutlet UIImageView*  starView2;
@property (nonatomic, retain) IBOutlet UIImageView*  starView3;
@property (nonatomic, retain) IBOutlet UILabel*      stepNumLabel;
@property (nonatomic, retain) IBOutlet UILabel*      leastNumLabel;
- (IBAction)goToMenuPage:(id)sender;
- (IBAction)replayThisLevel:(id)sender;
- (IBAction)goToNextLevel:(id)sender;

@end
