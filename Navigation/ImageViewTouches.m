//
//  ImageViewTouches.m
//  Navigation
//
//  Created by João Vitor dos Santos Schimmelpfeng on 19/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "ImageViewTouches.h"

@implementation ImageViewTouches

- (id)init
{
    self = [super init];
    if (self)
    {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mover:)];
        
        [self addGestureRecognizer:pan];
        self.userInteractionEnabled = YES;

    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.frame = CGRectMake(self.frame.origin.x - 50, self.frame.origin.y - 50, 200, 200);
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.frame = CGRectMake(self.frame.origin.x + 50, self.frame.origin.y + 50, 100, 100);
}

-(void) mover:(UIPanGestureRecognizer *)pan
{
 self.frame = CGRectMake([pan locationInView:self.superview].x - 50 , [pan locationInView:self.superview].y - 50, 100, 100);
}

@end
