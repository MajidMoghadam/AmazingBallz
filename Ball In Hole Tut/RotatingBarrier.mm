//
//  RotatingBarrier.m
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-22.
//  Copyright 2011 individual. All rights reserved.
//

#import "RotatingBarrier.h"
#import "Helper.h"
#import "Constants.h"

@interface RotatingBarrier (PrivateMethods)
-(void) createRotatingBarrierInWorld:(b2World*)world withPos:(CGPoint)pos;
@end

@implementation RotatingBarrier

-(id) initWithWorld:(b2World*)world withPos:(CGPoint)pos
{
    if ((self = [super init])) {
        [self createRotatingBarrierInWorld:world withPos:pos];
    }
    //[self scheduleUpdate];
    return self;
}

+(id) newRotatingBarrierInWorld:(b2World*)world withPos:(CGPoint)pos
{
    return [[[self alloc] initWithWorld:world withPos:pos] autorelease];
}

-(void) createRotatingBarrierInWorld:(b2World*)world withPos:(CGPoint)pos
{
    b2BodyDef rotatingBodyDef;
    rotatingBodyDef.type = b2_dynamicBody;
    rotatingBodyDef.position = [Helper toMetersFromPixels:pos];
    
    NSString* spriteFramName = @"black_rectangle_100_HD.png";
    
    b2PolygonShape shape;
    int num = 4;
    b2Vec2 verts[] = {
        b2Vec2((-50.0f/2) / PTM_RATIO, (10.0f/2) / PTM_RATIO),
        b2Vec2((-50.0f/2) / PTM_RATIO, (-10.0f/2) / PTM_RATIO),
        b2Vec2((50.0f/2) / PTM_RATIO, (-10.0f/2) / PTM_RATIO),
        b2Vec2((50.0f/2) / PTM_RATIO, (10.0f/2) / PTM_RATIO)
    };
    // Then call this
    shape.Set(verts, num);
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    fixtureDef.density = 100.0f;//*CC_CONTENT_SCALE_FACTOR();
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

    
    
}

@end
