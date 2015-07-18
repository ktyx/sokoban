//
//  BoxManCell.m
//  Pushbox
//
//  Created by daxin on 13-11-22.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "BoxManCell.h"

@implementation BoxManCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        animateImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:animateImgView];
        
        //PERSON 2
        NSString* downPath1 = [[NSBundle mainBundle] pathForResource:@"101" ofType:@"png"];
        downImgDefault = [[UIImage alloc] initWithContentsOfFile:downPath1];
        NSString* downPath2 = [[NSBundle mainBundle] pathForResource:@"103" ofType:@"png"];
        UIImage* downImg2 = [[UIImage alloc] initWithContentsOfFile:downPath2];
        NSString* downPath3 = [[NSBundle mainBundle] pathForResource:@"105" ofType:@"png"];
        UIImage* downImg3 = [[UIImage alloc] initWithContentsOfFile:downPath3];
        NSString* downPath4 = [[NSBundle mainBundle] pathForResource:@"107" ofType:@"png"];
        UIImage* downImg4 = [[UIImage alloc] initWithContentsOfFile:downPath4];
        NSString* downPath5 = [[NSBundle mainBundle] pathForResource:@"109" ofType:@"png"];
        UIImage* downImg5 = [[UIImage alloc] initWithContentsOfFile:downPath5];
        downImgArray = [[NSMutableArray alloc] initWithObjects:downImgDefault,downImg2,downImg3,downImg4,downImg5,nil];
        [downImg2 release];
        [downImg3 release];
        [downImg4 release];
        [downImg5 release];
        [animateImgView setAnimationImages:downImgArray];
        [animateImgView setAnimationDuration:1];
        
        
        NSString* upPath1 = [[NSBundle mainBundle] pathForResource:@"134" ofType:@"png"];
        upImgDefault = [[UIImage alloc] initWithContentsOfFile:upPath1];
        NSString* upPath2 = [[NSBundle mainBundle] pathForResource:@"136" ofType:@"png"];
        UIImage* upImg2 = [[UIImage alloc] initWithContentsOfFile:upPath2];
        NSString* upPath3 = [[NSBundle mainBundle] pathForResource:@"138" ofType:@"png"];
        UIImage* upImg3 = [[UIImage alloc] initWithContentsOfFile:upPath3];
        NSString* upPath4 = [[NSBundle mainBundle] pathForResource:@"140" ofType:@"png"];
        UIImage* upImg4 = [[UIImage alloc] initWithContentsOfFile:upPath4];
        NSString* upPath5 = [[NSBundle mainBundle] pathForResource:@"142" ofType:@"png"];
        UIImage* upImg5 = [[UIImage alloc] initWithContentsOfFile:upPath5];
        upImgArray = [[NSMutableArray alloc] initWithObjects:upImgDefault,upImg2,upImg3,upImg4,upImg5, nil];
        [upImg2 release];
        [upImg3 release];
        [upImg4 release];
        [upImg5 release];
        
        NSString* leftPath1 = [[NSBundle mainBundle] pathForResource:@"112" ofType:@"png"];
        leftImgDefault = [[UIImage alloc] initWithContentsOfFile:leftPath1];
        NSString* leftPath2 = [[NSBundle mainBundle] pathForResource:@"114" ofType:@"png"];
        UIImage* leftImg2 = [[UIImage alloc] initWithContentsOfFile:leftPath2];
        NSString* leftPath3 = [[NSBundle mainBundle] pathForResource:@"116" ofType:@"png"];
        UIImage* leftImg3 = [[UIImage alloc] initWithContentsOfFile:leftPath3];
        NSString* leftPath4 = [[NSBundle mainBundle] pathForResource:@"118" ofType:@"png"];
        UIImage* leftImg4 = [[UIImage alloc] initWithContentsOfFile:leftPath4];
        NSString* leftPath5 = [[NSBundle mainBundle] pathForResource:@"120" ofType:@"png"];
        UIImage* leftImg5 = [[UIImage alloc] initWithContentsOfFile:leftPath5];
        leftImgArray = [[NSMutableArray alloc] initWithObjects:leftImgDefault,leftImg2,leftImg3,leftImg4,
                        leftImg5, nil];
        [leftImg2 release];
        [leftImg3 release];
        [leftImg4 release];
        [leftImg5 release];
        
        NSString* rightPath1 = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"png"];
        rightImgDefault = [[UIImage alloc] initWithContentsOfFile:rightPath1];
        NSString* rightPath2 = [[NSBundle mainBundle] pathForResource:@"125" ofType:@"png"];
        UIImage* rightImg2 = [[UIImage alloc] initWithContentsOfFile:rightPath2];
        NSString* rightPath3 = [[NSBundle mainBundle] pathForResource:@"127" ofType:@"png"];
        UIImage* rightImg3 = [[UIImage alloc] initWithContentsOfFile:rightPath3];
        NSString* rightPath4 = [[NSBundle mainBundle] pathForResource:@"129" ofType:@"png"];
        UIImage* rightImg4 = [[UIImage alloc] initWithContentsOfFile:rightPath4];
        NSString* rightPath5 = [[NSBundle mainBundle] pathForResource:@"131" ofType:@"png"];
        UIImage* rightImg5 = [[UIImage alloc] initWithContentsOfFile:rightPath5];
        rightImgArray = [[NSMutableArray alloc] initWithObjects:rightImgDefault,rightImg2,rightImg3,
                         rightImg4,rightImg5, nil];
        [rightImg2 release];
        [rightImg3 release];
        [rightImg4 release];
        [rightImg5 release];
        
        [animateImgView setImage:downImgDefault];
    }
    return self;
}

- (void)startAnimation
{
    if ([animateImgView isAnimating])
    {
        [animateImgView stopAnimating];
    }
    switch (orientation)
    {
        case BoxManOrientationUp:
        {
            [animateImgView setAnimationImages:upImgArray];
            [animateImgView startAnimating];
        }
            break;
            
        case BoxManOrientationRight:
        {
            [animateImgView setAnimationImages:rightImgArray];
            [animateImgView startAnimating];
        }
            break;
            
        case BoxManOrientationLeft:
        {
            [animateImgView setAnimationImages:leftImgArray];
            [animateImgView startAnimating];
        }
            break;
        
        default:
            [animateImgView setAnimationImages:downImgArray];
            [animateImgView startAnimating];
            break;
    }
}

- (void)stopAnimation
{
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:animateImgView selector:@selector(stopAnimating) userInfo:nil repeats:NO];
}

- (void)pauseAnimation
{
    [animateImgView stopAnimating];
    switch (orientation)
    {
        case BoxManOrientationDown:
        {
            [animateImgView setImage:downImgDefault];
        }
            break;
        
        case BoxManOrientationUp:
        {
            [animateImgView setImage:upImgDefault];
        }
            break;
            
        case BoxManOrientationLeft:
        {
            [animateImgView setImage:leftImgDefault];
        }
            break;
        
        case BoxManOrientationRight:
        {
            [animateImgView setImage:rightImgDefault];
        }
            break;
            
        default:
            break;
    }
}

- (void)updateOrientation:(BoxManOrientation) aorientation
{
    orientation = aorientation;
    [animateImgView setAnimationRepeatCount:0];
    [self startAnimation];
}

- (void)dealloc
{
    [leftImgDefault release];
    [rightImgDefault release];
    [upImgDefault release];
    [downImgDefault release];
    
    [upImgArray removeAllObjects];
    [upImgArray release];
    [leftImgArray removeAllObjects];
    [leftImgArray release];
    [downImgArray removeAllObjects];
    [downImgArray release];
    [rightImgArray removeAllObjects];
    [rightImgArray release];
    
    [animateImgView release];
    [super dealloc];
}

@end
