//
//  TipAlertView.h
//  DrawSomeThing
//
//  Created by »Æ ´ïöÎ on 4/5/12.
//  Copyright 2012 The9. All rights reserved.
//
//  not support for autorotate

#import <UIKit/UIKit.h>
#import "CSAlertView.h"
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/WeiBoAPI.h>
#import <TencentOpenAPI/QQApiInterface.h>
//#import "QQSDK.h"

#define  TipType_Login_Fail	1011

#define kFlauntText     CSLOCAL(@"SNS_FLAUNT_TEXT")
#define kGetHelpText    CSLOCAL(@"SNS_GET_HELP_TEXT")
#define kAppName        CSLOCAL(@"APP_NAME")






@protocol CSShareAlertViewDelegate;
@interface CSShareAlertView : CSAlertView<TencentSessionDelegate, TCAPIRequestDelegate,
QQApiInterfaceDelegate>
{
    
}

//+ (void)showTip:(NSString*)tipText withTitle:(NSString*)titleText;
//+ (void)showTip:(NSString*)tipText withType:(int)aTipType;
//+ (void)showTip:(NSString*)tipText withDelegate:(id<CSShareAlertViewDelegate>)aDelegate;
//
//+ (void)showTip:(NSString*)tipText atView:(UIView*)aview;

//+ (void)shareText:(NSString*)atext andImage:(UIImage*)aimage;
+ (void)shareWithTitle:(NSString*)atitle text:(NSString*)atext image:(UIImage*)aimage;
+ (void)shareWithTitle:(NSString*)atitle text:(NSString*)atext image:(UIImage*)aimage
            musicIntro:(NSString*)aintro musicData:(NSString*)adata;

@property (nonatomic, retain) IBOutlet UILabel*   tipLabel;
@property (nonatomic, assign)	int			tipType;
@property (nonatomic, assign) id<CSShareAlertViewDelegate> delegate;
@property (nonatomic, retain) UIImage* imageForShare;
@property (nonatomic, retain) NSString* stringForShare;
@property (nonatomic, retain) NSString* musicDataUrl;
@property (nonatomic, retain) NSString* musicIntroUrl;
@property (nonatomic, retain) IBOutlet UILabel* titleLabel;

@property (nonatomic, retain) IBOutlet UILabel* qqCoinLabel;
@property (nonatomic, retain) IBOutlet UILabel* weiboCoinLabel;
@property (nonatomic, retain) IBOutlet UILabel* weixinCoinLabel;
@property (nonatomic, retain) IBOutlet UILabel* pengyouCoinLabel;


- (IBAction)shareToTwitter:(id)sender;
- (IBAction)shareToFacebook:(id)sender;
- (IBAction)shareToQQ:(id)sender;
- (IBAction)shareToWeibo:(id)sender;
- (IBAction)shareToQzone:(id)sender;
- (IBAction)shareToWeixin:(id)sender;
- (IBAction)shareToWeixinFriends:(id)sender;

@property (nonatomic, retain) IBOutlet UILabel* weiboLabel;
@property (nonatomic, retain) IBOutlet UILabel* qzoneLabel;
@property (nonatomic, retain) IBOutlet UILabel* weixinLabel;
@property (nonatomic, retain) IBOutlet UILabel* friendsLabel;

@end


@protocol CSShareAlertViewDelegate <NSObject>
- (void) shareAlertViewYesPressed;
- (void) shareAlertViewCancelPressed;
@end