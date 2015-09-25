//
//  Ball.h
//  Ball in Hole
//
//  Created by Majid Moghadam on 11-09-23.
//  Copyright 2011 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "BodyNode.h"
#import "Hole.h"

@interface Ball : BodyNode {
    bool isInHole;
    bool hasBeenHitByChasingEnemy;
    Hole* holeWithBall;
    float ballHoleDistance;
    //CCLabelBMFont *debugPositionLabel;
}
@property (readwrite, nonatomic) bool isInHole;
@property (readwrite, nonatomic) bool hasBeenHitByChasingEnemy;
@property (assign, nonatomic) Hole* holeWithBall;
@property (assign, nonatomic) float ballHoleDistance;
//@property (nonatomic, assign) CCLabelBMFont *debugPositionLabel;

+(id) newBallInWorld:(b2World*)world withPos:(CGPoint)pos;
-(void) applyForceTowardsHoleCenter;
-(float) getBallHoleDistance;
@end
