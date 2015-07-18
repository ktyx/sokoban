//
//  PushBoxMenuController.m
//  Pushbox
//
//  Created by daxin on 13-11-16.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "PushBoxMenuController.h"
#import "BoxLevelButton.h"
#import "PushBoxController.h"

@interface PushBoxMenuController ()
- (void)responseToLevelButton:(id)sender;
- (void)updateSoundButton;
@end

@implementation PushBoxMenuController
@synthesize pageScrollView;
@synthesize pageControl;
@synthesize voiceButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    buttonArray = [[NSMutableArray alloc] init];
    int x_offset = 12;
    int y_offset = 15;
    
    for (int i = 0; i < [[LevelManager sharedInstance] totalLevel]; i++)
    {
        LevelItem* item = [[LevelManager sharedInstance] levelItemAtIndex:i];
        int page = floor( i / AMOUNT_PER_PAGE) + 1;
        int row = ceil((i % AMOUNT_PER_PAGE)/ AMOUNT_PER_COLUMN) + 1;
        int col = ceil((i % AMOUNT_PER_PAGE) % AMOUNT_PER_COLUMN)+1;
        CGRect itemRect = CGRectMake((page - 1)*320 + x_offset*col + (col - 1)*BOX_MENU_BUTTON_WIDTH,
                                     y_offset*row + (row - 1)*BOX_MENU_BUTTON_HEIGHT ,
                                     BOX_MENU_BUTTON_WIDTH, BOX_MENU_BUTTON_HEIGHT);
        [item setIsLocked:NO];
        BoxLevelButton* btn = [[BoxLevelButton alloc] initWithFrame:itemRect];
        [btn updateWithLevelItem:item];
        [pageScrollView addSubview:btn];
        [btn setTag:i];
        [btn addTarget:self action:@selector(responseToLevelButton:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArray addObject:btn];
        [btn release];
    }
    
    int pageNum = ceil([[LevelManager sharedInstance] totalLevel] / (AMOUNT_PER_PAGE*1.0) );
    //NSLog(@"page_num:%d total:%d",pageNum,[[LevelManager sharedInstance] totalLevel]);
    CGSize scrollSize = CGSizeMake(pageScrollView.frame.size.width*pageNum, pageScrollView.frame.size.height);
    [pageScrollView setContentSize:scrollSize];
    [pageScrollView setPagingEnabled:YES];
    [pageScrollView setShowsHorizontalScrollIndicator:NO];
    
    int currentPage = [[LevelManager sharedInstance] currentLevel] / AMOUNT_PER_PAGE ;
    int xo = currentPage * pageScrollView.frame.size.width;
    [pageScrollView setContentOffset:CGPointMake(xo, 0)];
    
    [self.pageControl setNumberOfPages:pageNum];
    [self.pageControl setCurrentPage:currentPage];
    
    [self updateSoundButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    for (int i = 0; i <= [[LevelManager sharedInstance] currentLevel]; i ++)
    {
        BoxLevelButton* btn = [buttonArray objectAtIndex:i];
        LevelItem* it = [[LevelManager sharedInstance] levelItemAtIndex:i];
        [btn updateWithLevelItem:it];
    }
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [buttonArray release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIButton 
- (IBAction)onMoreApp:(id)sender
{
    
}

- (IBAction)onRateUs:(id)sender
{
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    if ([CSDevice isSystemVersionLaterThan:6.0])
    {
        NSDictionary *parameters = [NSDictionary dictionaryWithObject:kAppID forKey:SKStoreProductParameterITunesItemIdentifier];
        SKStoreProductViewController* view = [[SKStoreProductViewController alloc] init];
        [view setDelegate:self];
        [view loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError *error)
         {
             
         }];
        [self presentViewController:view animated:YES completion:nil];
        [view release];
    }else
    {
        NSString* url = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", kAppID];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url ]];
    }
}

- (IBAction)onShop:(id)sender
{
    
}

- (IBAction)onBackgroundMusic:(id)sender
{
    
}

- (IBAction)onVoice:(id)sender
{
    if ([[CSSound sharedInstance] isOn])
    {
        [[CSSound sharedInstance] setON:NO];
    }else
    {
        [[CSSound sharedInstance] setON:YES];
    }
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    [self updateSoundButton];
}

- (void)responseToLevelButton:(id)sender
{
    [[CSSound sharedInstance] playSound:CSSoundType_KEY];
    UIButton* btn = (UIButton*)sender;
    int level  = (int)[btn tag];
    PushBoxController* boxController = [[PushBoxController alloc] initWithLevel:level+1];
    [self.navigationController pushViewController:boxController animated:NO];
    [boxController release];
}

- (void)updateSoundButton
{
    if ([[CSSound sharedInstance] isOn])
    {
        UIImage* onImg = [UIImage imageNamed:@"menu_voice"];
        [voiceButton setImage:onImg forState:UIControlStateNormal];
    }else
    {
        UIImage* offImg = [UIImage imageNamed:@"menu_voice_off"];
        [voiceButton setImage:offImg forState:UIControlStateNormal];
    }
}

#pragma mark -
#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = pageScrollView.frame.size.width;
    int page = floor((pageScrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    [pageControl setCurrentPage:page];
}

#pragma mark -
#pragma mark SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
