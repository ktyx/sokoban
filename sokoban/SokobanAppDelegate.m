//
//  SokobanAppDelegate.m
//
//  Created by daxin on 13-6-6.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "SokobanAppDelegate.h"


#import "CSDevice.h"
#import "CSSound.h"
#import "LevelManager.h"
#import "PushBoxMenuController.h"

@implementation SokobanAppDelegate

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //init random number
    srandom([NSDate timeIntervalSinceReferenceDate]);
    
    //init sokoban level data
    [[LevelManager sharedInstance] initialize];
    
    //初始化声音引擎
    [[CSSound sharedInstance] initialize];
    
    if ([CSDevice currentDeviceType] == CSDevice_iPad)
    {
        NSString* versionStr = [[UIDevice currentDevice] systemVersion];
        NSArray* subVersions = [versionStr componentsSeparatedByString:@"."];
        if (subVersions && [subVersions count] > 0)
        {
            NSString* v1Str = [subVersions objectAtIndex:0];
            int vindex = [v1Str intValue];
            if (vindex == 5)
            {
                
            }
        }
    }
    
    
    NSString* language = nil;
    NSArray* languageArray = [NSLocale preferredLanguages];
    if ([languageArray count] > 0)
    {
        language = [languageArray objectAtIndex:0];
    }
    NSLog(@"LAN:%@",language);

    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    NSString* xibStr = [CSDevice univesal_xib:@"PushBoxMenuController"];
    PushBoxMenuController* ctrl = ctrl = [[[PushBoxMenuController alloc] initWithNibName:xibStr bundle:nil] autorelease];
    self.navigationController = [[[CSNavigationController alloc] initWithRootViewController:ctrl] autorelease];
    [self.navigationController setNavigationBarHidden:YES];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
