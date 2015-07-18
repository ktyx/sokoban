//
//  TipAlertView.m
//  DrawSomeThing
//
//  Created by »Æ ´ïöÎ on 4/5/12.
//  Copyright 2012 The9. All rights reserved.
//

#import "CSShareAlertView.h"
#import "WXApi.h"
#import "CSTipAlertView.h"
#import "WeiboSDK.h"
#import <Social/Social.h>
#import "CSTipLabel.h"
#import "CSGlobal.h"
#import "CSCoin.h"

@interface CSShareAlertView(Private)
- (void)authorizeQQ;
- (void)shareMessageToQQ;
- (void)updateGiveCoinState;
@end



@implementation CSShareAlertView
@synthesize tipType;
@synthesize tipLabel;
@synthesize delegate;

@synthesize weiboLabel;
@synthesize qzoneLabel;
@synthesize weixinLabel;
@synthesize friendsLabel;

@synthesize imageForShare;
@synthesize stringForShare;
@synthesize titleLabel;

@synthesize qqCoinLabel;
@synthesize weiboCoinLabel;
@synthesize weixinCoinLabel;
@synthesize pengyouCoinLabel;

@synthesize musicIntroUrl;
@synthesize musicDataUrl;

/*
+ (void)shareText:(NSString*)atext andImage:(UIImage*)aimage
{
    CSShareAlertView* shareView = [[[CSShareAlertView alloc] init] autorelease];
    [shareView setImageForShare:aimage];
    [shareView setStringForShare:atext];
    //[[[UIApplication sharedApplication] keyWindow] addSubview:shareView];
    
	NSArray* viewArray = [[[UIApplication sharedApplication] keyWindow] subviews];
	int viewCount = [viewArray count];
	if (viewCount < 1) return;
	UIView* last2View = [viewArray objectAtIndex:viewCount - 1];
	[last2View addSubview:shareView];
}
 */

+ (void)shareWithTitle:(NSString*)atitle text:(NSString*)atext image:(UIImage*)aimage
{
    /*
    CSShareAlertView* shareView = [[[CSShareAlertView alloc] init] autorelease];
    [shareView setImageForShare:aimage];
    [shareView setStringForShare:atext];
    [shareView.titleLabel setText:atitle];
    
	NSArray* viewArray = [[[UIApplication sharedApplication] keyWindow] subviews];
	int viewCount = [viewArray count];
	if (viewCount < 1) return;
	UIView* last2View = [viewArray objectAtIndex:viewCount - 1];
	[last2View addSubview:shareView];
     */
    [CSShareAlertView shareWithTitle:atitle text:atext image:aimage
                          musicIntro:nil musicData:nil];
}

+ (void)shareWithTitle:(NSString*)atitle text:(NSString*)atext image:(UIImage*)aimage
            musicIntro:(NSString*)aintro musicData:(NSString*)adata
{
    CSShareAlertView* shareView = [[[CSShareAlertView alloc] init] autorelease];
    [shareView setImageForShare:aimage];
    [shareView setStringForShare:atext];
    [shareView.titleLabel setText:atitle];
    [shareView setMusicIntroUrl:aintro];
    [shareView setMusicDataUrl:adata];
    [shareView updateGiveCoinState];
    
	NSArray* viewArray = [[[UIApplication sharedApplication] keyWindow] subviews];
	int viewCount = [viewArray count];
	if (viewCount < 1) return;
	UIView* last2View = [viewArray objectAtIndex:viewCount - 1];
	[last2View addSubview:shareView];
}

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithNibName:@"CSShareAlertView"];
    if (self)
    {
        [weiboLabel setText:CSLOCAL(@"SHARE_WEIBO")];
        [qzoneLabel setText:CSLOCAL(@"SHARE_QZONE")];
        [weixinLabel setText:CSLOCAL(@"SHARE_WEIXIN")];
        [friendsLabel setText:CSLOCAL(@"SHARE_FRIENDS")];
        [titleLabel setText:CSLOCAL(@"SHARE_TITLE")];
    }
    return self;
}

- (void)dealloc {
    [weiboLabel release];
    [qzoneLabel release];
    [weixinLabel release];
    [friendsLabel release];
    [super dealloc];
}

- (IBAction)close:(id)sender
{
	[super close:sender];
	if (delegate)
	{
		if ([delegate respondsToSelector:@selector(shareAlertViewYesPressed)])
		{
			[delegate shareAlertViewYesPressed];
		}
	}
}


- (IBAction)shareToTwitter:(id)sender
{
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:stringForShare];
        [tweetSheet addImage:imageForShare];
        [tweetSheet addURL:[NSURL URLWithString:KAppAddress]];
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:tweetSheet animated:YES completion:^{
        }];
    }
}

- (IBAction)shareToFacebook:(id)sender
{
    SLComposeViewController *faceSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [faceSheet setInitialText:stringForShare];
    [faceSheet addImage:imageForShare];
    [faceSheet addURL:[NSURL URLWithString:KAppAddress]];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:faceSheet animated:YES completion:^{
    }];
}

- (IBAction)shareToQQ:(id)sender
{
    TencentOAuth* oauth = [[QQSDK sharedInstance] oauth];
    if (![oauth isSessionValid])
    {
        [self authorizeQQ];
    }else
    {
        [self shareMessageToQQ];
    }
}

- (IBAction)shareToWeibo:(id)sender
{
    if ([WeiboSDK isWeiboAppInstalled])
    {
        WBMessageObject* message = [WBMessageObject message];
        message.text = stringForShare;
        WBImageObject* shareImage = [WBImageObject object];
        shareImage.imageData = UIImageJPEGRepresentation(imageForShare, 1.0);
        message.imageObject = shareImage;
        WBSendMessageToWeiboRequest* request = [WBSendMessageToWeiboRequest requestWithMessage:message];
        [WeiboSDK sendRequest:request];
        
        [[CSCoin sharedInstance] setWeiboCoinGot];
        [self updateGiveCoinState];
    }else
    {
        [CSTipAlertView showTip:CSLOCAL(@"NOT_INSTALLED_WEIBO") withTitle:nil];
    }
}

- (IBAction)shareToQzone:(id)sender
{
    TencentOAuth* oauth = [[QQSDK sharedInstance] oauth];
    
     TCAddShareDic *params = [TCAddShareDic dictionary];
     params.paramTitle = @"shareTitle2";
     params.paramComment = @"shareComment";
     params.paramSummary =  @"summary";
     params.paramImages = @"http://img1.gtimg.com/tech/pics/hv1/95/153/847/55115285.jpg";
     params.paramUrl = @"www.qq.com";
     
     if (![oauth addShareWithParams:params])
     {
     //[oauth authorize:permissions inSafari:NO];
         [self authorizeQQ];
         [oauth addShareWithParams:params];
     }else
     {
          [CSTipAlertView showTip:@"complete sharing to QZone" withTitle:nil];
     }
     
//    if ([oauth isSessionValid])
//    {
//        [CSTipAlertView showTip:@"session valid" withTitle:nil];
//    }else
//    {
//        [CSTipAlertView showTip:@"session invalid" withTitle:nil];
//    }
    
    
    /*
    WeiBo_add_pic_t_POST* request = [[WeiBo_add_pic_t_POST alloc] init];
    request.param_pic  = imageForShare;
    request.param_content = kShareText;
    request.param_compatibleflag = @"0x2|0x4|0x8|0x20";
    if( ![oauth sendAPIRequest:request callback:self] )
    {
        [oauth authorize:permissions inSafari:NO];
        [oauth sendAPIRequest:request callback:self];
    }else
    {
        [CSTipAlertView showTip:@"Share success" withTitle:nil];
    }
     */
}

//#define BUFFER_SIZE 1024
- (IBAction)shareToWeixin:(id)sender
{
    
    //http://cutescreencai.oss.aliyuncs.com/caige/music/__00000.mp3
    
    if ([WXApi isWXAppInstalled])
    {
        /*
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = CSLOCAL(@"APP_NAME");
        message.description = kShareText;
        [message setThumbImage:imageForShare];
        
        WXAppExtendObject *ext = [WXAppExtendObject object];
        //ext.extInfo = @"<xml>test</xml>";
        ext.url =  KAppAddress;
        
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init] autorelease];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;
        
        BOOL res = [WXApi sendReq:req];
        if (res)
        {
            NSLog(@"send yes");
        }else
        {
            NSLog(@"send failed");
        }
         */
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = CSLOCAL(@"APP_NAME");
        message.description = stringForShare;
        [message setThumbImage:imageForShare];
        
        if (musicDataUrl && [musicDataUrl length] > 0)
        {
            WXMusicObject* mobject = [WXMusicObject object];
            mobject.musicUrl = musicIntroUrl;
            mobject.musicDataUrl = musicDataUrl;
            message.mediaObject = mobject;
        }else
        {
            WXAppExtendObject *ext = [WXAppExtendObject object];
            //ext.extInfo = @"<xml>test</xml>";
            ext.url =  KAppAddress;
            
            message.mediaObject = ext;
        }
        
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init] autorelease];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;
        
        BOOL res = [WXApi sendReq:req];
        if (res)
        {
            NSLog(@"send yes");
            [[CSCoin sharedInstance] setWeixinCoinGot];
            [self updateGiveCoinState];
        }else
        {
            NSLog(@"send failed");
        }
        
    }else
    {
        [CSTipAlertView showTip:CSLOCAL(@"NOT_INSTALLED_WEIXIN") withTitle:@"Tip"];
    }
}


- (IBAction)shareToWeixinFriends:(id)sender
{
    if ([WXApi isWXAppInstalled])
    {
        /*
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = CSLOCAL(@"APP_NAME");
        NSLog(@"TITLE:%@",message.title);
        message.description =  kShareText; 
        [message setThumbImage:imageForShare];
        
        WXAppExtendObject *ext = [WXAppExtendObject object];
        ext.extInfo = @"<xml>test</xml>";
        ext.url = KAppAddress; 
        NSLog(@"URL:%@",ext.url);
        
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneTimeline;
        */
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = CSLOCAL(@"APP_NAME");
        message.description = stringForShare;
        [message setThumbImage:imageForShare];
        
        if (musicDataUrl && [musicDataUrl length] > 0)
        {
            WXMusicObject* mobject = [WXMusicObject object];
            mobject.musicUrl = musicIntroUrl;
            mobject.musicDataUrl = musicDataUrl;
            message.mediaObject = mobject;
        }else
        {
            WXAppExtendObject *ext = [WXAppExtendObject object];
            //ext.extInfo = @"<xml>test</xml>";
            ext.url =  KAppAddress;
            
            message.mediaObject = ext;
        }
        
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init] autorelease];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneTimeline;
        
        BOOL res = [WXApi sendReq:req];
        if (res)
        {
            NSLog(@"send yes");
            [[CSCoin sharedInstance] setPengyouCoinGot];
            [self updateGiveCoinState];
        }else
        {
            NSLog(@"send failed");
        }
    }else
    {
        NSLog(@"4");
        [CSTipAlertView showTip:CSLOCAL(@"NOT_INSTALLED_WEIXIN") withTitle:@"Tip"];
    }
    //[self close];
}

#pragma mark -
#pragma mark TencentLoginDelegate
- (void)tencentDidLogin
{
    NSLog(@"share tentcent did login");
    [self shareMessageToQQ];
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"tencent did not login");
    [CSTipLabel showText:@"cancel to share" atView:self];
}

- (void)tencentDidNotNetWork
{
    NSLog(@"tencent did not network");
    [CSTipAlertView showTip:@"no network, can't share" atView:self];
}

- (void)addShareResponse:(APIResponse*) response
{
    [CSTipLabel showText:@"complete sharing to QQ" atView:self];
}


#pragma mark -
#pragma mark QQAPIDelegate
- (void)onReq:(QQBaseReq *)req
{
    NSLog(@"req:%@",req);
    switch (req.type)
    {
        case EGETMESSAGEFROMQQREQTYPE:
        {
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void)onResp:(QQBaseResp *)resp
{
    NSLog(@"resp:%@",resp);
    switch (resp.type)
    {
        case ESENDMESSAGETOQQRESPTYPE:
        {
            SendMessageToQQResp* sendResp = (SendMessageToQQResp*)resp;
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:sendResp.result message:sendResp.errorDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            break;
        }
        default:
        {
            break;
        }
    }
}

#pragma mark -
#pragma mark Private
- (void)authorizeQQ
{
    TencentOAuth* oauth = [[QQSDK sharedInstance] oauth];
    [oauth setSessionDelegate:self];
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            //kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_IDOL,
                            //kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_PIC_T,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            //kOPEN_PERMISSION_DEL_IDOL,
                            //kOPEN_PERMISSION_DEL_T,
                            //kOPEN_PERMISSION_GET_FANSLIST,
                            kOPEN_PERMISSION_GET_IDOLLIST,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_GET_REPOST_LIST,
                            //kOPEN_PERMISSION_LIST_ALBUM,
                            //kOPEN_PERMISSION_UPLOAD_PIC,
                            //kOPEN_PERMISSION_GET_VIP_INFO,
                            //kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            //kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                            kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                            @"upload_pic",
                            @"download_pic",
                            @"get_pic_list",
                            @"delete_pic",
                            @"upload_pic",
                            @"download_pic",
                            @"get_pic_list",
                            @"delete_pic",
                            @"get_pic_thumb",
                            @"upload_music",
                            @"download_music",
                            @"get_music_list",
                            @"delete_music",
                            @"upload_video",
                            @"download_video",
                            @"get_video_list",
                            @"delete_video",
                            @"upload_photo",
                            @"download_photo",
                            @"get_photo_list",
                            @"delete_photo",
                            @"get_photo_thumb",
                            @"check_record",
                            @"create_record",
                            @"delete_record",
                            @"get_record",
                            @"modify_record",
                            @"query_all_record",
                            nil];
    [oauth authorize:permissions inSafari:NO];
    
}

- (void)shareMessageToQQ
{
    NSURL* url = [NSURL URLWithString:KAppAddress];
    NSData* imgData = UIImageJPEGRepresentation(imageForShare, 1.0);
    
  /*
    QQApiNewsObject* img = [QQApiNewsObject objectWithURL:url title:kAppName
                                              description:kShareText
                                         previewImageData:imgData];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
   */
    
    SendMessageToQQReq* qqReq = nil;
    if (musicDataUrl && [musicDataUrl length] > 0)
    {
        NSURL* murl = [NSURL URLWithString:musicDataUrl];
        QQApiAudioObject* audioObject = [QQApiAudioObject objectWithURL:murl title:kAppName description:stringForShare previewImageData:imgData];
        qqReq = [SendMessageToQQReq reqWithContent:audioObject];
        
    }else
    {
        QQApiNewsObject* newsObject = [QQApiNewsObject objectWithURL:url title:kAppName
                                                  description:stringForShare
                                             previewImageData:imgData];
        qqReq = [SendMessageToQQReq reqWithContent:newsObject];
    }
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:qqReq];
    switch (sent)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App Not Registered" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [msgbox show];
            [msgbox release];
            break;
        }
            
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Params Error" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [msgbox show];
            [msgbox release];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            [CSTipAlertView showTip:CSLOCAL(@"NOT_INSTALLED_QQ") withTitle:nil];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API not supported" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [msgbox show];
            [msgbox release];
            break;
        }
        case EQQAPISENDFAILD:
        {
            [CSTipAlertView showTip:CSLOCAL(@"QQ_SEND_FAILED") withTitle:nil];
            break;
        }
            
        case EQQAPISENDSUCESS:
        {
            [[CSCoin sharedInstance] setQQCoinGot];
            [self updateGiveCoinState];
            break;
        }
        default:
            break;
    }
}

- (void)updateGiveCoinState
{
    if ([[CSCoin sharedInstance] isQQCoinGot])
    {
        [self.qqCoinLabel setHidden:YES];
    }
    
    if ([[CSCoin sharedInstance] isWeiboCoinGot])
    {
        [self.weiboCoinLabel setHidden:YES];
    }
    
    if ([[CSCoin sharedInstance] isWeixinCoinGot])
    {
        [self.weixinCoinLabel setHidden:YES];
    }
    
    if ([[CSCoin sharedInstance] isPengyouCoinGot])
    {
        [self.pengyouCoinLabel setHidden:YES];
    }
}
@end
