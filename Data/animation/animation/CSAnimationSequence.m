/*
 Copyright (c) 2013 Katsuma Tanaka
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "CSAnimationSequence.h"

@interface CSAnimationSequence ()

@property (nonatomic, assign) NSUInteger currentGroup;
@property (nonatomic, assign) NSUInteger finishedCount;
//@property (nonatomic, assign) int        countID;

- (void)performNextGroup;
- (void)animationFinished:(CSAnimationItem*)item;

@end

@implementation CSAnimationSequence
@synthesize groups;
@synthesize running;
@synthesize delegate;

+ (id)sequence
{
    return [[[self alloc] init] autorelease];
}

+ (id)sequenceWithAnimationGroups:(NSArray *)groupArray
{
    return [[[self alloc] initWithAnimationGroups:groupArray] autorelease];
}

+ (id)sequenceWithAnimationGroups:(NSArray *)groupArray repeat:(BOOL)repeat
{
    return [[[self alloc] initWithAnimationGroups:groupArray repeat:repeat] autorelease];
}

- (id)init
{
    return [self initWithAnimationGroups:nil repeat:NO];
}

- (id)initWithAnimationGroups:(NSArray *)groupArray
{
    return [self initWithAnimationGroups:groupArray repeat:NO];
}

- (id)initWithAnimationGroups:(NSArray *)groupArray repeat:(BOOL)repeat
{
    self = [super init];
    
    if(self) {
        //self.groups = groups;
        groups = [[NSMutableArray alloc] init];
        [groups addObjectsFromArray:groupArray];
        self.repeat = repeat;
        
        self.running = NO;
    }
    
    return self;
}

- (void)addAnimationGroup:(CSAnimationGroup*)agroup
{
    //NSLog(@"add group:%@",agroup);
    [groups addObject:agroup];
}

- (void)refreshAnimationGroup:(NSArray*)agroups
{
    [groups removeAllObjects];
    [groups addObjectsFromArray:agroups];
    
    self.currentGroup = 0;
    self.finishedCount = 0;
    self.running = NO;
}

- (void)dealloc
{
    [groups removeAllObjects];
    [groups release];
    [super dealloc];
}


#pragma mark -

- (void)start
{
    if (groups.count == 0)
    {
        return;
    }
    if(self.running) return;
    
    self.running = YES;
    
    //self.currentGroup = 0;
    //self.finishedCount = 0;
    
    [self performNextGroup];
}

- (void)stop
{
    self.running = NO;
}

- (void)clear
{
//    self.countID ++;
    
    self.running = NO;
    [groups removeAllObjects];
    self.currentGroup = 0;
    self.finishedCount = 0;
}

- (void)performNextGroup
{
    if(!self.running) return;
    
    if(self.currentGroup >= self.groups.count) {
        //NSLog(@"current group > groups count");
        if(self.repeat) {
            self.running = NO;
            
            [self start];
        }else
        {
            if (delegate && [delegate respondsToSelector:@selector(animationSequenceFinished)] )
            {
                [delegate animationSequenceFinished];
            }
        }
        
        return;
    }
    
    CSAnimationGroup *group = (CSAnimationGroup *)[self.groups objectAtIndex:self.currentGroup];
    //NSLog(@"group  %d item count:%d",self.currentGroup,[[group items] count]);
    
    for(NSInteger i = 0; i < group.items.count; i++) {
        CSAnimationItem *item = (CSAnimationItem *)[group.items objectAtIndex:i];
        
        if(group.waitUntilDone) {
            //NSLog(@"run ani com:%.2f  d:%.2f",item.duration,item.delay);
            [UIView animateWithDuration:item.duration delay:item.delay options:item.options animations:item.animations completion:^(BOOL finished) {
                [self animationFinished:item];
            }];
        } else {
            [UIView animateWithDuration:item.duration delay:item.delay options:item.options animations:item.animations completion:nil];
        }
    }
    
    if(!group.waitUntilDone) {
        self.currentGroup++;
        [self performNextGroup];
    }
}

- (void)animationFinished:(CSAnimationItem*)item
{
    //NSLog(@"### ANI FINISH #### %d",[groups count]);
    
    //此处如何判断一个动画已经被抛弃
    BOOL isValid = NO;
    for (CSAnimationGroup* g in self.groups)
    {
        for (CSAnimationItem* it in [g items])
        {
            if ([it isEqual:item])
            {
                isValid = YES;
                break;
            }
        }
        if (isValid)
        {
            break;
        }
    }
    if (!isValid)
    {
        return;
    }
    
    self.finishedCount++;
    
    CSAnimationGroup *group = (CSAnimationGroup *)[self.groups objectAtIndex:self.currentGroup];
    
    if(self.finishedCount == group.items.count) {
        self.finishedCount = 0;
        
        self.currentGroup++;
        [self performNextGroup];
    }
    if (self.currentGroup == self.groups.count)
    {
        self.running = NO;
    }
}

@end
