//
//  Ball.m
//  Ball in Hole
//
//  Created by Majid Moghadam on 11-09-23.
//  Copyright 2011 All rights reserved.
//

#import "Ball.h"
#import "Helper.h"
#import "Constants.h"

@interface Ball (PrivateMethods)
-(void) createBallInWorld:(b2World*)world withPos:(CGPoint)pos;
@end

@implementation Ball

@synthesize isInHole;
@synthesize holeWithBall;
@synthesize ballHoleDistance;
@synthesize hasBeenHitByChasingEnemy;
//@synthesize debugPositionLabel;

-(id) initWithWorld:(b2World*)world withPos:(CGPoint)pos
{
    if ((self = [super init])) {
        [self createBallInWorld:world withPos:pos];
    }
    [self scheduleUpdate];
    return self;
}

+(id) newBallInWorld:(b2World*)world withPos:(CGPoint)pos
{
    return [[[self alloc] initWithWorld:world withPos:pos] autorelease];
}

-(void) createBallInWorld:(b2World*)world withPos:(CGPoint)pos
{
    //CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = [Helper toMetersFromPixels:pos];
    bodyDef.angularDamping = 0.9;
    
    isInHole = NO;
    hasBeenHitByChasingEnemy = NO;
    
    //NSString* spriteFrameName = @"new_ball.png";
    //CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];
    NSString* spriteFileName = @"new_ball_HD.png";
    //CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:spriteFramName];
    CCSprite* tempSprite = [CCSprite spriteWithFile:spriteFileName];

    
    b2CircleShape shape;
    float radiusInMeters = (tempSprite.contentSize.width / [Helper pixelsToMeterRatio]) * 0.47f;
    shape.m_radius = radiusInMeters;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    fixtureDef.density = 5.0f*CC_CONTENT_SCALE_FACTOR();
    fixtureDef.friction = 0.0f;
    fixtureDef.restitution = 0.4f;
    
    [super createBodyInWorld:world bodyDef:&bodyDef fixtureDef:&fixtureDef spriteName:spriteFileName];
}


-(void) update:(ccTime)delta
{
    if(hasBeenHitByChasingEnemy){
        [self removeSprite];
        [self removeBody];
        
    }
}
 

-(void) applyForceTowardsHoleCenter
{
    b2Vec2 ballPos = body->GetWorldCenter();
    b2Vec2 holePos = self.holeWithBall.body->GetWorldCenter();
    b2Vec2 distanceVector = holePos - ballPos;
    //float speed = self.body->GetLinearVelocity().Length();
    // The gravitational force gets stronger as the body gets closer
    float force = 1.0 / (distanceVector.LengthSquared()); // intensity can be changed to adjust the amount of force
    distanceVector.Normalize();
    b2Vec2 F = force * distanceVector;
    body->ApplyForce(F, body->GetWorldCenter());

}



-(float)getBallHoleDistance{
    ballHoleDistance = 10.0; //some  large initial value.
    if (isInHole) {
        b2Vec2 v1 = self.body->GetWorldCenter();
        b2Vec2 v2 = self.holeWithBall.body->GetWorldCenter();
        b2Vec2 ballHoleDistanceVector = v2 - v1;
        ballHoleDistance = ballHoleDistanceVector.Length();
    }
    return ballHoleDistance;
}

@end
