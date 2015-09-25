//
//  ChasingEnemy.h
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-24.
//  Copyright 2011 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "BodyNode.h"

@interface ChasingEnemy : BodyNode {
    bool hasCollidedWithBarrier;
    float constantVelocity;
    float currentXvelocity;
    float currentYvelocity;
    float prevXvelocity;
    float prevYvelocity;
}
@property (readwrite, nonatomic) bool hasCollidedWithBarrier;
@property (readwrite, nonatomic) float constantVelocity;
@property (readwrite, nonatomic) float currentXvelocity;
@property (readwrite, nonatomic) float currentYvelocity;
@property (readwrite, nonatomic) float prevXvelocity;
@property (readwrite, nonatomic) float prevYvelocity;
+(id) newChasingEnemyInWorld:(b2World*)world withPos:(CGPoint)pos;

@end
