//
//  MovingBarrier1.h
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-10-01.
//  Copyright 2011 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "BodyNode.h"

@interface MovingBarrier1 : BodyNode {
    
}
+(id) newMovingBarrier1InWorld:(b2World*)world withPos:(CGPoint)pos;
@end
