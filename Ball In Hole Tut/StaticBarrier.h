//
//  StaticBarrier.h
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-22.
//  Copyright 2011 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "BodyNode.h"

@interface StaticBarrier : BodyNode {
    
}
+(id) newStaticBarrierInWorld:(b2World*)world withPos:(CGPoint)pos;
@end
