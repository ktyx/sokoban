//
//  BoxMapCell.h
//  Pushbox
//
//  Created by daxin on 13-10-1.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxMap.h"

@interface BoxMapCell : UIButton


@property (nonatomic, assign) int   row;
@property (nonatomic, assign) int   column;
@property (nonatomic, assign) MapCellType type;

@property (nonatomic, assign) int    f;
@property (nonatomic, assign) int    g;
@property (nonatomic, assign) int    h;
@property (nonatomic, retain) BoxMapCell* fatherCell;
@end
