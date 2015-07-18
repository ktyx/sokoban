//
//  AStarNode.h
//  A*算法节点
//
//  Created by daxin on 13-10-1.
//  Copyright (c) 2013年 daxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AStarNode : NSObject
@property (nonatomic, assign) int     f;
@property (nonatomic, assign) int     g;
@property (nonatomic, assign) int     h;
@property (nonatomic, assign) int     row;
@property (nonatomic, assign) int     column;
@property (nonatomic, retain) AStarNode* fatherNode;
@property (nonatomic, assign) BOOL    blocked;
@property (nonatomic, assign) int     type;
@end
