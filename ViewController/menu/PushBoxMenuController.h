//
//  PushBoxMenuController.h
//  Pushbox
//
//  Created by daxin on 13-11-16.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelManager.h"
#import "DDPageControl.h"
#import <StoreKit/SKStoreProductViewController.h>
#import "CSSound.h"

#define AMOUNT_PER_ROW      4
#define AMOUNT_PER_COLUMN   4
#define AMOUNT_PER_PAGE     (AMOUNT_PER_ROW * AMOUNT_PER_COLUMN)


@interface PushBoxMenuController : UIViewController<UIScrollViewDelegate,SKStoreProductViewControllerDelegate>
{
    NSMutableArray*     buttonArray;
}

@property (nonatomic, retain) IBOutlet UIScrollView* pageScrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;
@property (nonatomic, retain) IBOutlet UIButton*  voiceButton;

- (IBAction)onMoreApp:(id)sender;
- (IBAction)onRateUs:(id)sender;
- (IBAction)onShop:(id)sender;
- (IBAction)onBackgroundMusic:(id)sender;
- (IBAction)onVoice:(id)sender;
@end
