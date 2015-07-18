//
//  BoxMapView.h
//  Pushbox
//
//  Created by daxin on 13-10-1.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxMap.h"
#import "BoxMapCell.h"
#import "CSAnimationSequence.h"
#import "CSBrownLabel.h"

@interface BoxMapView : UIView<CSAnimationSequenceDelegate>
{
    BoxMap*         map;
    
    NSMutableArray*  mapCellArray;
    NSMutableArray*  boxCellArray;
    BoxMapCell*      personCell;
    
    int              cellWidth;
    
    int              steps;
    UILabel*         stepLabel;
    
    NSMutableArray*  actionHistory;
    NSMutableArray*  oneAction;
    NSArray*         answerArray;
    
    
    CSAnimationSequence*  gameAnimation;
    
    
    BOOL             isPlayingAnswer;
    UIView*          answerView;
    UIButton*         playButton;
    
    UIButton*         goBackButton;
    CSBrownLabel*          levelLabel;
}

- (id)initWithMap:(BoxMap*)amap;


- (void)goback;
- (BOOL)canGoBack;

- (void)playAnswer;
- (void)pauseAnswer;

- (void)stopAllAnimations;

@end
