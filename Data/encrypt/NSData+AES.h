//
//  NSData+AES.h
//  WallpaperData
//
//  Created by daxin on 13-7-24.
//  Copyright (c) 2013年 Cute Screen Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(AES) 
- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密
@end
