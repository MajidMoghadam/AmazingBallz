//
//  MovingBarrier1.m
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-10-01.
//  Copyright 2011 individual. All rights reserved.
//

#import "MovingBarrier1.h"
#import "Helper.h"
#import "Constants.h"

@interface MovingBarrier1 (PrivateMethods)
-(void) createMovingBarrier1InWorld:(b2World*)world withPos:(CGPoint)pos;
@end

@implementation MovingBarrier1

-(id) initWithWorld:(b2World*)world withPos:(CGPoint)pos
{
    if ((self = [super init])) {
        
        [self removeSprite];
        [self removeBody];
        
        [self createMovingBarrier1InWorld:world withPos:pos];
    }
    //[self scheduleUpdate];
    return self;
}

+(id) newMovingBarrier1InWorld:(b2World*)world withPos:(CGPoint)pos
{
    return [[[self alloc] initWithWorld:world withPos:pos] autorelease];
}

-(void) createMovingBarrier1InWorld:(b2World*)world withPos:(CGPoint)pos
{
    b2BodyDef bDef;
    bDef.type = b2_dynamicBody;
    bDef.position = [Helper toMetersFromPixels:pos];
    body = world->CreateBody(&bDef);
    
    b2PolygonShape shape;
    const float32 density = 10;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    fixtureDef.friction = 0.9f;
    fixtureDef.restitution = 0.4f;;

    
    shape.SetAsBox(0.5, 0.1,b2Vec2(0/2, 2.41/2), 0);
    body->CreateFixture(&shape, density);
    
    shape.SetAsBox(0.5, 0.1, b2Vec2(0/2, -2.41/2), 0);
    body->CreateFixture(&shape, density);
    
    shape.SetAsBox(0.5, 0.1, b2Vec2(2.41/2, 0/2), 3.1415/2);
    body->CreateFixture(&shape, density);
    
    shape.SetAsBox(0.5, 0.1, b2Vec2(-2.41/2, 0/2), 3.1415/2);
    body->CreateFixture(&shape, density);
    
    shape.SetAsBox(0.5, 0.1, b2Vec2(-1.7/2, 1.7/2), 3.1415/4);
    body->CreateFixture(&shape, density);
    
    shape.SetAsBox(0.5, 0.1, b2Vec2(1.7/2, -1.7/2), 3.1415/4);
    body->CreateFixture(&shape, density);
    
    shape.SetAsBox(0.5, 0.1, b2Vec2(-1.7/2, -1.7/2), -3.1415/4);
    body->CreateFixture(&shape, density);
    
    //NSString* spriteFramName = @"octagon.png";
    //sprite = [CCSprite spriteWithSpriteFrameName:spriteFramName];
    //[self addChild:sprite];
    NSString* spriteFileName = @"octagon_HD.png";
    sprite = [CCSprite spriteWithFile:spriteFileName];
    [self addChild:sprite];
    
    body->SetUserData(self);
    
    
    
    //shape.SetAsBox(1, 0.1, b2Vec2(1.7, 1.7), -3.1415/4);
    //body->CreateFixture(&shape, density);
    
    /*
    b2BodyDef rotatingBodyDef;
    rotatingBodyDef.type = b2_dynamicBody;
    rotatingBodyDef.position = [Helper toMetersFromPixels:pos];
    
    NSString* spriteFramName = @"black_rectangle_100.png";
    
    b2PolygonShape shape;
    int num = 4;
    b2Vec2 verts[] = {
        b2Vec2(-50.0f / PTM_RATIO, 10.0f / PTM_RATIO),
        b2Vec2(-50.0f / PTM_RATIO, -10.0f / PTM_RATIO),
        b2Vec2(50.0f / PTM_RATIO, -10.0f / PTM_RATIO),
        b2Vec2(50.0f / PTM_RATIO, 10.0f / PTM_RATIO)
    };
    // Then call this
    shape.Set(verts, num);
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    fixtureDef.density = 100.0f*CC_CONTENT_SCALE_FACTOR();
    fixtureDef.friction = 0.0f;
    fixtureDef.restitution = 0.4f;
    
    [super createBodyInWorld:world bodyDef:&rotatingBodyDef fixtureDef:&fixtureDef spriteName:spriteFramName];
    
    // create an invisible static body to attach to
    b2BodyDef staticBodyDef;
    staticBodyDef.position = [Helper toMetersFromPixels:pos];
    b2Body* staticBody = world->CreateBody(&staticBodyDef);
    
    b2RevoluteJointDef revJointDef;
    revJointDef.Initialize(staticBody, self->body, staticBody->GetWorldCenter());
    
    revJointDef.enableLimit = false; 
    revJointDef.enableMotor = true; 
    revJointDef.motorSpeed = 0.5; 
    revJointDef.maxMotorTorque = 10.0; 
    world->CreateJoint(&revJointDef);
     */
    
    
    
}

@end
