//
//  CSSound.h
//  BrandGuess
//
//  Created by daxin on 13-8-27.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#define CSSOUND_ISON_KEY  @"CSSOUND_ISON_KEY"
#define CSSOUND_DEFAULT_STATE YES

#define CSBGMUSIC_ISON_KEY @"CSBGMUSIC_ISON_KEY"
#define CSBGMUSIC_DEFAULT_STATE YES

typedef enum {
    CSSoundType_KEY = 0,
    CSSoundType_WIN,
    CSSoundType_ERROR,
    CSSoundType_RIGHT,
}CSSoundType;

@interface CSSound : NSObject<AVAudioPlayerDelegate>
{
    BOOL    on;
   
    SystemSoundID  sid1;
    
    //Background Music
    AVAudioPlayer*  bgMusicPlayer;
    int              bgMusicIndex;
    BOOL             bgMusicOn;
    
    AVAudioPlayer*   voicePlayer1;
}

+ (CSSound*) sharedInstance;
- (void)  initialize;
- (BOOL)  isOn;
- (void)  setON:(BOOL)aon;
- (void)  playSound:(CSSoundType)atype;
- (void)  playFile:(NSString*)filename type:(NSString*)filetype;
- (void)  playBackgroundMusic:(NSString*)filename type:(NSString*)filetype;
- (void)  playBackgroundMusicWithData:(NSData*)mdata;
- (void)  playVoice:(NSString*)filename type:(NSString*)filetype;

//Background Music
- (BOOL) isBackgroundMusicOn;
- (void) setBackgroundMusicOn:(BOOL)ison;
- (NSString*) nextBgMusicPath;
- (void) pauseBgMusic;
- (void) continueBgMusic;
- (void) playBgMusic;

@end
