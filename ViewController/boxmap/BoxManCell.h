//
//  BoxManCell.h
//  Pushbox
//
//  Created by daxin on 13-11-22.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "BoxMapCell.h"

typedef enum
{
    BoxManOrientationUp = 0,
    BoxManOrientationDown,
    BoxManOrientationLeft,
    BoxManOrientationRight,
    BoxManOrientationNone,
}BoxManOrientation;

@interface BoxManCell : BoxMapCell
{
    UIImageView*         animateImgView;
    NSMutableArray*     downImgArray;
    NSMutableArray*     upImgArray;
    NSMutableArray*     leftImgArray;
    NSMutableArray*     rightImgArray;
    
    BoxManOrientation   orientation;
    UIImage*            downImgDefault;
    UIImage*            upImgDefault;
    UIImage*            leftImgDefault;
    UIImage*            rightImgDefault;
}

- (void)startAnimation;
- (void)stopAnimation;
- (void)pauseAnimation;
- (void)updateOrientation:(BoxManOrientation) aorientation;
@end
