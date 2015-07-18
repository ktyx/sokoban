//
//  CSAnimation.h
//  mnazc
//
//  Created by daxin on 13-10-25.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSAnimation : NSObject
+ (CAAnimation *) scaleAnimation:(int)scalesize;
+ (CAAnimation*) scaleFromLarge:(int)largeSize toSmall:(int)smallSize time:(float)t;
+ (CAAnimation*) zoomingWithRatio:(float)ratio;
+ (CAAnimation*) pulse;

+ (CAAnimation*) rotateAppear;
+ (CAAnimation*)  rotateDisappear;
+ (CAAnimation*)  rotate;
+ (CAAnimation*)  goUpAndFade;

+ (CAAnimation*) wiggle:(int)x;
+ (CAAnimation*) moveWithPath;

+ (CAAnimation*) popup;


//TRANSITION   参考 CAShowcase项目
//参考CATransition文档
+ (CAAnimation*) transitionAnimation;

+ (CAAnimation*) brighten;
+ (CAAnimation*) darken;

//最好修改成扩展方式，需要layer位置时，就不用传参数
@end
