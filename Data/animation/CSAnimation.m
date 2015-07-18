//
//  CSAnimation.m
//  mnazc
//
//  Created by daxin on 13-10-25.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "CSAnimation.h"

@implementation CSAnimation
+ (CAAnimation *) scaleAnimation:(int)scalesize
{
    if (scalesize <= 0 || scalesize > 50)
    {
        return nil;
    }
    CAKeyframeAnimation *scaleAnimation;
	scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	scaleAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	scaleAnimation.duration = 0.8;
	scaleAnimation.removedOnCompletion = YES;
	scaleAnimation.fillMode = kCAFillModeForwards;
	scaleAnimation.autoreverses = NO;
	scaleAnimation.repeatCount = 1;
	
	NSMutableArray * values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(scalesize, scalesize, scalesize)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 0.7)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
	scaleAnimation.values = values;
	scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	
	return scaleAnimation;
}

+ (CAAnimation*) scaleFromLarge:(int)largeSize toSmall:(int)smallSize time:(float)t
{
    if (largeSize < smallSize || smallSize < 0)
    {
        return nil;
    }
    CAKeyframeAnimation *scaleAnimation;
	scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	scaleAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	scaleAnimation.duration = t;
	scaleAnimation.removedOnCompletion = YES;
	scaleAnimation.fillMode = kCAFillModeForwards;
	scaleAnimation.autoreverses = NO;
	scaleAnimation.repeatCount = 1;
	
	NSMutableArray * values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(largeSize, largeSize, largeSize)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(smallSize*0.7, smallSize*0.7, smallSize*0.7)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(smallSize, smallSize, smallSize)]];
	scaleAnimation.values = values;
	scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	
	return scaleAnimation;
}

+ (CAAnimation*) zoomingWithRatio:(float)ratio
{
    CAKeyframeAnimation *scaleAnimation;
	scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	scaleAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	scaleAnimation.duration = 0.5;
	scaleAnimation.removedOnCompletion = YES;
	scaleAnimation.fillMode = kCAFillModeForwards;
	scaleAnimation.autoreverses = NO;
	scaleAnimation.repeatCount = 1;
	
	NSMutableArray * values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(ratio, ratio, ratio)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
	scaleAnimation.values = values;
	scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	
	return scaleAnimation;
}

+ (CAAnimation*)  pulse
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.10, 1.10, 1)];
	animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	animation.autoreverses = YES;
	animation.duration = 0.3;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.repeatCount = HUGE_VALF;
    return animation;
}

+ (CAAnimation*) rotateAppear
{
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 3];
	rotationAnimation.duration = 1.9f;
	rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
	scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
	scaleAnimation.duration = 2.0f;
	scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.duration = 2.0f;
	//animationGroup.autoreverses = YES;
	//animationGroup.repeatCount = HUGE_VALF;
	[animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil]];
    return animationGroup;
}

+ (CAAnimation*)  rotateDisappear
{
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.toValue = [NSNumber numberWithFloat:(- 2 * M_PI) * 3];
	rotationAnimation.duration = 1.9f;
	rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
	scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
	scaleAnimation.duration = 2.0f;
	scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.duration = 2.0f;
	//animationGroup.autoreverses = YES;
	//animationGroup.repeatCount = HUGE_VALF;
	[animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil]];
    return animationGroup;
}

+ (CAAnimation*)  rotate
{
    // rotate animation
    CATransform3D rotationTransform  = CATransform3DMakeRotation(M_PI, 1.0, 0, 0.0);
    
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue        = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration        = 0.5;
    animation.autoreverses    = NO;
    animation.cumulative    = YES;
    animation.repeatCount    = FLT_MAX;  //"forever"
    //设置开始时间，能够连续播放多组动画
    animation.beginTime        = 0.5;
    //设置动画代理
    //animation.delegate        = self;
    
    return animation;
}

+ (CAAnimation*)  goUpAndFade
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.duration                = 2.3;
    animation.autoreverses            = NO;
    animation.removedOnCompletion    = NO;
    animation.repeatCount            = 0;//FLT_MAX;  //"forever"
    animation.fromValue                = [NSNumber numberWithInt: 0];
    animation.toValue                = [NSNumber numberWithInt: 170];
    
    CABasicAnimation * opacityAni;
    opacityAni= [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAni.duration=2.4;
    opacityAni.fromValue=[NSNumber numberWithFloat:1.0];
    opacityAni.toValue=[NSNumber numberWithFloat:0.0];
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    [group setAnimations:[NSArray arrayWithObjects:animation,opacityAni,nil]];
    [group setDuration:2.4];
    return group;
    
}

+ (CAAnimation*)wiggle:(int)x
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [rotationAnimation setRepeatCount:MAXFLOAT];
    [rotationAnimation setDuration:0.1];
    [rotationAnimation setAutoreverses:YES];
    
    [rotationAnimation setFromValue:[NSNumber numberWithFloat:(float) (M_PI/100.0)]];
    [rotationAnimation setToValue:[NSNumber numberWithFloat:(float) (-M_PI/100.0)]];
    
    CABasicAnimation *translationXAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    [translationXAnimation setRepeatCount:MAXFLOAT];
    [translationXAnimation setDuration:0.2];
    
    [translationXAnimation setAutoreverses:YES];
    [translationXAnimation setFromValue:[NSNumber numberWithFloat: 0 + 2.0]];
    [translationXAnimation setToValue:[NSNumber numberWithFloat: 0 - 2.0]];
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    [group setAnimations:[NSArray arrayWithObjects:rotationAnimation,translationXAnimation,nil]];
    [group setDuration:0.2];
    [group setRepeatCount:MAXFLOAT];
    return group;
}

//JUST SAMPLE CODE
+ (CAAnimation*) moveWithPath
{
    CGMutablePathRef tPath = CGPathCreateMutable();
    CGPathMoveToPoint(tPath, NULL, 15.0, 15.0);
    CGPathAddLineToPoint(tPath, NULL, 100, 100);
    CGPathAddArc(tPath, NULL, 100, 100, 75, 0, M_PI, 1);
    CGPathAddLineToPoint(tPath, NULL, 200, 150);
    CGPathAddCurveToPoint(tPath, NULL, 150, 150, 50, 350, 300, 300);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setPath:tPath]; // here is the magic!
    [animation setDuration:2.5];
    
    [animation setCalculationMode:kCAAnimationCubic];
    [animation setRotationMode:kCAAnimationRotateAuto];
    CGPathRelease(tPath);
    return animation;
}

+ (CAAnimation*) popup
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
	CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
	CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
	CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
	CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
	NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    
	[animation setValues:frameValues];
    
	NSArray *frameTimes = [NSArray arrayWithObjects:
	                       [NSNumber numberWithFloat:0.0],
	                       [NSNumber numberWithFloat:0.5],
	                       [NSNumber numberWithFloat:0.9],
	                       [NSNumber numberWithFloat:1.0],
	                       nil];
	[animation setKeyTimes:frameTimes];
    
	animation.fillMode = kCAFillModeForwards;
	animation.duration = .25;
    
	return animation;
}

//http://iphonedevwiki.net/index.php/CATransition
//type 类型: kCATransitionFade  kCATransitionMoveIn kCATransitionPush kCATransitionReveal
//Private:  cameraIris cameraIrisHollowOpen cameraIrisHollowClose cube alignedCube flip alignedFlip
// oglFlip rotate pageCurl pageUnCurl rippleEffect suckEffect
//subtype类型: kCATransitionFromRight 等
+ (CAAnimation*) transitionAnimation
{
    CATransition *t = [CATransition animation];
    //t.type = kCATransitionReveal;
    //t.subtype = kCATransitionFromTop;
    
    t.type = kCATransitionFade;
	//t.subtype = kCATransitionFromRight;
    [t setDuration:0.8];
    return t;
}

+ (CAAnimation*) brighten
{
    CABasicAnimation * opacityAni;
    opacityAni= [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAni.duration= 0.2;
    opacityAni.fromValue=[NSNumber numberWithFloat:0.6];
    opacityAni.toValue=[NSNumber numberWithFloat:0];
    return opacityAni;
}

+ (CAAnimation*) darken
{
    CABasicAnimation * opacityAni;
    opacityAni= [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAni.duration= 0.2;
    opacityAni.fromValue=[NSNumber numberWithFloat:0.0];
    opacityAni.toValue=[NSNumber numberWithFloat:0.6];
    return opacityAni;
}
@end
