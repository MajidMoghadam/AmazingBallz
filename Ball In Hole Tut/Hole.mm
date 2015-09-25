//
//  Hole.m
//  Ball in Hole
//
//  Created by Majid Moghadam on 11-09-23.
//  Copyright 2011 All rights reserved.
//

#import "Hole.h"
#import "Helper.h"
#import "Constants.h"

@interface Hole (PrivateMethods)
-(void) createHoleInWorld:(b2World*)world withPos:(CGPoint)pos;
@end

@implementation Hole

@synthesize isOccupied;
//@synthesize occupyingBall;
@synthesize continuousTimeOccupied;

-(id) initWithWorld:(b2World*)world withPos:(CGPoint)pos
{
    if ((self = [super init])) {
        [self createHoleInWorld:world withPos:pos];
    }
    return self;
}

+(id) newHoleInWorld:(b2World*)world withPos:(CGPoint)pos
{
    return [[[self alloc] initWithWorld:world withPos:pos] autorelease];
}

-(void) createHoleInWorld:(b2World*)world withPos:(CGPoint)pos
{	
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position = [Helper toMetersFromPixels:pos];
    bodyDef.angularDamping = 0.9;
    
    isOccupied = NO;
    
    //NSString* spriteFramName = @"new_hole_HD.png";
    //CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:spriteFramName];
    NSString* spriteFileName = @"new_hole_HD.png";
    //CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:spriteFramName];
    CCSprite* tempSprite = [CCSprite spriteWithFile:spriteFileName];

    
    b2CircleShape shape;
    float radiusInMeters = (tempSprite.contentSize.width / [Helper pixelsToMeterRatio]) * 0.05f;
    shape.m_radius = radiusInMeters;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    fixtureDef.density = 1.0f*CC_CONTENT_SCALE_FACTOR();
    fixtureDef.friction = 0.0f;
    fixtureDef.restitution = 0.0f;
    fixtureDef.isSensor = true;
    
    [super createBodyInWorld:world bodyDef:&bodyDef fixtureDef:&fixtureDef spriteName:spriteFileName];
}

@end
