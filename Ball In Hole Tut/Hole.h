//
//  Hole.h
//  Ball in Hole
//
//  Created by Majid Moghadam on 11-09-23.
//  Copyright 2011 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodyNode.h"
#import "Box2D.h"

@interface Hole : BodyNode {
    bool isOccupied;
    //Ball* occupyingBall;
    float continuousTimeOccupied;
}
@property (readwrite, nonatomic) bool isOccupied;
//@property (nonatomic, retain) Ball* occupyingBall;
@property (readwrite, nonatomic) float continuousTimeOccupied;

+(id) newHoleInWorld:(b2World*)world withPos:(CGPoint)pos;

@end
