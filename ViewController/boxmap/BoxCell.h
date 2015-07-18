//
//  BoxCell.h
//  Pushbox
//
//  Created by daxin on 13-11-16.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import "BoxMapCell.h"

@interface BoxCell : BoxMapCell
{
    UIImageView*    tickView;
}

- (void)setBoxPushIntoTarget:(BOOL)isin;
@end
