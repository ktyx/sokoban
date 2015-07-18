//
//  BoxMenuButton.h
//  Pushbox
//
//  Created by daxin on 13-11-16.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelItem.h"
#define BOX_MENU_BUTTON_WIDTH       65
#define BOX_MENU_BUTTON_HEIGHT      74

#define LEVEL_LABEL_ORIGIN_Y        15
#define LEVEL_LABEL_HEIGHT          32
#define LEVEL_LABEL_FONT_SIZE       26
#define MENU_STAR_SIZE              14

@interface BoxLevelButton : UIButton
{
    UILabel*    levelLabel;
    UIImageView* starView1;
    UIImageView* starView2;
    UIImageView* starView3;
}
- (void)updateWithLevelItem:(LevelItem*)aitem;
@end
